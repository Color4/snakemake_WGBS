SAMPLE_IDS = ["test", "test2"]

rule all: 
    input: 
        expand("bam_files/{FASTQ}.out", FASTQ=SAMPLE_IDS)

rule split: 
    input: 
        expand("{FASTQ}.txt", FASTQ=SAMPLE_IDS)
    output: 
        dynamic("bam_files/{FASTQ}.txt.{PART}") 
    params:
        length=1000
    shell:
        "cat {input} | split -l {params.length} -d - bam_files/{input}."

rule concat: 
    input:
        split_files = dynamic("bam_files/{FASTQ}.txt.{PART}")
    output: 
        "bam_files/{FASTQ}.out"
    shell: 
        "cat {input} > {output}"