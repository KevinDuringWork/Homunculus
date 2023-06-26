//> using scala "2.13"
//> using lib "org.typelevel::cats-core:2.9.0"
//> using lib "com.github.samtools:htsjdk:3.0.4"
//> using lib "com.github.tototoshi::scala-csv:1.3.10"
//
import scala.language.postfixOps
import scala.util.control.Breaks._
import cats.implicits._
import com.github.tototoshi.csv.CSVReader
import java.io.File 
import java.net.URL
import sys.process._ 
import scala.jdk.CollectionConverters._
import java.io.{File, InputStreamReader, FileInputStream}
import htsjdk.samtools.reference.IndexedFastaSequenceFile, 
    htsjdk.samtools.reference.FastaSequenceIndex,
    htsjdk.tribble.AbstractFeatureReader,
    htsjdk.variant.variantcontext.VariantContext,
    htsjdk.variant.variantcontext.VariantContextBuilder, 
    htsjdk.variant.variantcontext.GenotypeBuilder,
    htsjdk.variant.variantcontext.Allele,
    htsjdk.variant.variantcontext.writer.Options,
    htsjdk.variant.variantcontext.writer.VariantContextWriterBuilder,
    htsjdk.variant.vcf.VCFCodec,
    htsjdk.variant.vcf.VCFHeader
    /*
    val assemble = (
      "http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch38/reference_genome.fa",
      "http://bioinfo.hpc.cam.ac.uk/downloads/datasets/fasta/grch38/reference_genome.fa.fai"
    )

    val NA12878 = (
      "https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/NA12878_HG001/latest/GRCh38/HG001_GRCh38_1_22_v4.2.1_benchmark.vcf.gz",
      "https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/NA12878_HG001/latest/GRCh38/HG001_GRCh38_1_22_v4.2.1_benchmark.vcf.gz.tbi"
    )

    if (!(new File("GRCh38.genome.fa")).exists()) {
      println("Downloading Assembly")  
      new URL(assemble._1) #> new File("GRCh38.genome.fa") !!
      new URL(assemble._2) #> new File("GRCh38.genome.fa.fai") !!
    }

    if (!(new File("NA12878.GRCh38.vcf.gz")).exists()) {
      println("Downloading NA12878")
      new URL(NA12878._1) #> new File("NA12878.GRCh38.vcf.gz") !! 
      new URL(NA12878._2) #> new File("NA12878.GRCh38.vcf.gz.tbi") !!
    }
    */

    val asm = "GRCh38"
    val output = new java.io.File(s"spike-in-${asm}.vcf.gz")
    if (output.exists) output.delete 

    // Read SPIKE  
    val spike_in = CSVReader.open(new File("spike-in.csv"))
    val spike_in_map = spike_in.all()
        .foldLeft(Map.empty[(String, String), List[String]]) {
            (acc, v) => acc ++ Map(
                ((asm match {
                    case "GRCh38" => s"chr${v(0).trim}"
                    case _ => v(0).trim
                },     
                v(1).trim), v.map(_.trim))
            )
        }
    spike_in.close()

    // Read Assembly
    val assembly = new IndexedFastaSequenceFile(
        new File(s"${asm}.genome.fa"),
        new FastaSequenceIndex(
            new File(s"${asm}.genome.fa.fai")
        )
    )
    
    // Read NA12878 
    val vcf_reader = AbstractFeatureReader.getFeatureReader(
    (new File(s"NA12878.${asm}.vcf.gz")).getAbsolutePath(), new VCFCodec(), true)

    // Write w/ Spike-in 
    val vcf_writer = new VariantContextWriterBuilder()
    .setOutputFile(output)
    .setOutputFileType(VariantContextWriterBuilder.OutputType.BLOCK_COMPRESSED_VCF)
    .unsetOption(Options.INDEX_ON_THE_FLY).build();

    // Spike-In VCF contains the same header as the original VCF 
    vcf_writer.writeHeader(vcf_reader.getHeader.asInstanceOf[VCFHeader])

    // Check if Variant Exists 
    def variant_exists(a:VariantContext, b:Option[VariantContext], op:String ):Map[(String,String), List[String]] = {    
        op match {
            case "before" => 
                spike_in_map.view.filterKeys{
                    case b => (b._1 == a.getContig) && 
                    (b._2.toInt) < a.getStart
                }.toMap
            
            case "after" => 
                spike_in_map.view.filterKeys{
                    case af => (af._1 == a.getContig) && 
                    (af._2.toInt) > a.getStart
                }.toMap
            
            case "equal" => 
                spike_in_map.view.filterKeys{
                    case e => (e._1 == a.getContig) && 
                    (e._2.toInt) == a.getStart
                }.toMap
            
            case "between" | _ =>    
                spike_in_map.view.filterKeys{
                    case k => (k._1.trim == a.getContig) && 
                    (a.getStart until b.get.getStart).contains(k._2.toInt)
                }.toMap
        }
    }

    def write_insert(variant:List[String], a:VariantContext, b:Option[VariantContext], action:String): Unit = {
        val prefix = asm match {
            case "GRCh38" => "chr"
            case _ => ""
        }
        val ref = assembly.getSubsequenceAt(s"chr${variant(0)}", variant(1).toInt, variant(1).toInt).getBaseString()
        
        println(s"[[ SPIKE ]] >> \n")
        println(s"CHROM:${variant(0)} POS:${variant(1)} REF:${ref} ALT:${variant(2)} GT:${variant(3)}")
        
        // build variant from prototype (a) 
        b match {
            case None => println(s"${action.toUpperCase}: ${a.getContig}-${a.getStart}") 
            case Some(v) => println(s"${action.toUpperCase}: ${a.getContig}-${a.getStart} ${v.getContig}-${v.getStart}")    
        }

        // Construct variant context 
        // - Construct Alleles 
        // - Construct Genotype 

        val vc_builder = new VariantContextBuilder(a)
        val ref_alt = List(Allele.create(ref, true),  Allele.create(variant(2))).asJava
        val alleles = variant(3) match {
            case "1/1"     => List(Allele.create(variant(2)), Allele.create(variant(2))).asJava 
            case "0/1" | _ => ref_alt       
        }
        
        println("\n ----- DEBUG (template for spike)  ------") 
        println(a)

        println("\n ----- DEBUG Alleles  ------")
        println(alleles)


        println("\n ----- DEBUG (constructed spike) ----- ")
        val gt_builder = new GenotypeBuilder("HG001", alleles) 
        gt_builder.GQ(700)
        gt_builder.DP(500)
        gt_builder.AD(List(120).toArray)
        gt_builder.attribute("ADALL", "120,120")

        vc_builder.loc(s"${prefix}${variant(0)}", variant(1).toLong, variant(1).toLong) 
        vc_builder.alleles(ref_alt)
        vc_builder.genotypes(List(gt_builder.make).asJava)  
        vc_builder.passFilters() 

        println(vc_builder.make)
        println(vc_builder.getGenotypes())
        println("") 

        vcf_writer.add(vc_builder.make) 
    }


    println("\nWriting to VCF\n==================================")
    for ((variants:Seq[VariantContext], index:Int) <- vcf_reader.iterator.asInstanceOf[java.util.Iterator[VariantContext]].asScala.sliding(2).zipWithIndex) {    
        
        val curr:VariantContext  = variants(0)
        val next:VariantContext  = variants(1)
        val prefix = asm match {
            case "GRCh38" => ""
            case _ => "chr"
        }

        (curr, next, index) match {

            case (curr, next, _) if (curr.getContig != next.getContig) => {
                println(s"Searching: (${prefix}${next.getContig})")
                
                // write curr 
                vcf_writer.add(curr)

                // write all after curr 
                variant_exists(curr, None, "after") foreach {
                    case (key, value) => {
                        write_insert(value, curr, None, "after") 
                    }   
                }

                // write all before next (chromosome) 
                variant_exists(next, None, "before") foreach {
                    case (key, value) => {
                        write_insert(value, curr, None, "before") 
                    }
                }
            }

            case (curr, next, index) if (curr.getContig == next.getContig) => {  
                
                // initial case 
                if (index == 0) {
                    println("Searching: (chr1)")
                    
                    variant_exists(curr, None, "before") foreach {
                        case (key, value) => {
                            write_insert(value, curr, None, "before")
                        }
                    }
                }
                
                val between = variant_exists(curr, Some(next), "between") 
                
                // variant overwritten - ignore if key (chrom, pos) matches 
                between.contains((curr.getContig, curr.getStart.toString)) match {
                    case true  => // do nothing, already written  
                    case false => vcf_writer.add(curr)
                }
                
                // write anything in between current 
                between foreach {
                    case (key, value) => write_insert(value, curr, Some(next), "between")  
                } 

            }

            case (null, _, _) | _  => { 
                // no insertion events to deal with, just transfer the variant as is.  
                vcf_writer.add(curr) 
            }
        }
    }
    vcf_reader.close()
    vcf_writer.close()

