# test snakemake pipeline
import glob


SAMPLE_IDS = ["test"]

# rule all: 
# 	input: 
# 		expand("bam_files/{FASTQ}.out", FASTQ=SAMPLE_IDS)


# rule split: 
# 	input: 
# 		expand("{FASTQ}.txt", FASTQ=SAMPLE_IDS)
# 	output: 
# 		"bam_files/{FASTQ}."
# 	shell:
# 		"cat {input} | split -l 1000 -d - {output}."


# rule concat: 
# 	input:
# 		split_files = glob.glob("bam_files/{FASTQ}.*")
# 	output: 
# 		"bam_files/{FASTQ}.out"
# 	shell: 
# 		"cat {input} > {output}"

SPLIT_OUT="split-out"
LINES_PER_FILE="100"
MAP_IM_OUT="map-out"

rule all: 
	input: "test2.out"

rule split_all:
    input: dynamic(SPLIT_OUT + "/test.txt.split.{splitid}")

rule split1:
    input: "test.txt"
    params: lines_per_file=str(LINES_PER_FILE), out_dir=SPLIT_OUT
    output: dynamic(SPLIT_OUT + "/test.txt.split.{splitid}")
    shell: """
    mkdir -p {params.out_dir}
    split -d -l {params.lines_per_file} {input[0]} {params.out_dir}/test.txt.split.
    """

rule output: 
	input: "test2.txt"
	output: "test2.out"
	shell: """
	touch {output}
	"""






