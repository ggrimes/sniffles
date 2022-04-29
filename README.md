# sniffles
call svs with sniffles



~~~
nextflow run ggrimes/sniffles   --bam "../../results/minimap2/bam/*_R1.sorted*.{bam,bai}" --reference ../../resources/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa -r 9348feb  -resume -profile eddie
~~~
