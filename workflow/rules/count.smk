rule count:
    input:
        sorted_bam = "results/hisat2/{sample}.sorted.bam",
        gtf = config["gtf_file"]
    output:
        counts = "results/counts/{sample}.featureCounts.txt",
        summary = "results/counts/{sample}.featureCounts.txt.summary"
    threads: 4
    conda:
        "../envs/rnaseq_preprocess.yaml"
    shell:
        """
        featureCounts \
            -t exon -g gene_id \
            -T {threads} \
            -a {input.gtf} \
            -o {output.counts} \
            {input.sorted_bam}
        """