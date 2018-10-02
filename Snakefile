SAMPLE_IDS = ["test"]

rule all: 
    input: 
        expand("bam_files/{FASTQ}.out", FASTQ=SAMPLE_IDS)


rule split: 
    input: 
        "{FASTQ}.txt"
    output: 
        dynamic("bam_files/{FASTQ}.{PART}")
    params:
        length=1000
    shell:
        "cat {input} | split -l {params.length} -d - bam_files/{FASTQ}."


rule concat: 
    input:
        split_files = dynamic("bam_files/{FASTQ}.{PART}")
    output: 
        "bam_files/{FASTQ}.out"
    shell: 
        "cat {input} > {output}"