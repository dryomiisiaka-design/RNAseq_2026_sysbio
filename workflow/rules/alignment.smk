rule hisat2:
    input:
        fastq = f"{config['input_path']}/{{sample}}_filtered.fastq"
    output:
        bam = "results/hisat2/{sample}.bam",
        summary = "results/hisat2/{sample}_summary.txt"
    params:
        index = config["genome_index_dir"]
    threads: 2
    conda:
        "../envs/rnaseq_preprocess.yaml"
    shell:
        """
        hisat2 -p {threads} \
               -x {params.index} \
               -U {input.fastq} \
               --new-summary \
               --summary-file {output.summary} \
        | samtools view -bS - > {output.bam}
        """


rule sort_bam:
    input:
        "results/hisat2/{sample}.bam"
    output:
        "results/hisat2/{sample}.sorted.bam"
    threads: 4
    conda:
        "../envs/rnaseq_preprocess.yaml"
    shell:
        """
        samtools sort -@ {threads} -o {output} {input}
        """


rule index_bam:
    input:
        "results/hisat2/{sample}.sorted.bam"
    output:
        "results/hisat2/{sample}.sorted.bam.bai"
    conda:
        "../envs/rnaseq_preprocess.yaml"
    shell:
        """
        samtools index {input}
        """