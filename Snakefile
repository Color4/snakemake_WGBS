# test snakemake pipeline
import glob


SAMPLE_IDS = ["test"]

rule all: 
	input: 
		expand("bam_files/{FASTQ}.out", FASTQ=SAMPLE_IDS)


rule split: 
	input: 
		expand("{FASTQ}.txt", FASTQ=SAMPLE_IDS)
	threads: 
		4
	output: 
		"bam_files/{FASTQ}"
	shell: 
		"awk '{filename = "{ouput}." int((NR-1)/10000) ".fq"; print >> filename}' {input}"


rule concat: 
	input:
		expand("bam_files/{FASTQ}.fq", FASTQ=SAMPLE_IDS)

	output: 
		"bam_files/{FASTQ}.out"
	shell: 
		"cat {input} > {output}"
