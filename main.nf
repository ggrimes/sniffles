nextflow.enable.dsl=2

//parameters
params.bam="*.bam"
params.ref="ref.fa"
params.threads = 4

log.info """\
  bam:        $params.bam
  reference:  $params.reference
  """.stripIndent()

//sniffles https://github.com/fritzsedlazeck/Sniffles
process SNIFFLES {
 tag "$samplename"
 publishDir "results", mode:"copy"
 cpus params.threads
 memory '32 GB'


  input:

  tuple val(samplename),path(bam)
  path reference

  output:
  path("*.vcf")
  
  script:
  """
  sniffles -i ${bam} -v ${samplename}.sniffles2.vcf --non-germline --threads $task.cpus -output-rnames
  """
}

bam_ch = channel.fromFilePairs(params.bam,checkIfFileExits: true,size:1)
reference_ch = file(params.reference,checkIfFileExits: true)
bam_ch.view()

workflow {
  SNIFFLES(bam_ch,reference_ch)
}
