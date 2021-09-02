rule all:
	input:
            expand('results/counts/{sample_name}/abundance.tsv', sample_name=["SRR1039508","SRR1039509"])

rule kallisto_index:
	input: 
	    "data/gencode.v38.transcripts.fa.gz"
	output:
	    "results/gencode.v38.transcripts.idx" 
	shell:
	    """
	    module load snakemake
	    module load kallisto
	    kallisto index -i {input} {output}
	    """

rule kallisto_quant:
	input:
	    r1 = "fastq/{sample_name}_1.fastq.gz",
	    r2 = "fastq/{sample_name}_2.fastq.gz",
	    index = "results/gencode.v38.transcripts.idx"
	output:
	    "results/counts/{sample_name}/abundance.tsv",
	shell:
	    """
	    module load snakemake
            module load kallisto
	    kallisto quant -i {input.index} -o {output} {input.r1} {input.r2}
	    """


