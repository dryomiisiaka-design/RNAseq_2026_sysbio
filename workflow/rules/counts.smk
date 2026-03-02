rule counts:
    input:
        bam="results/alignment/{sample}.bam",
        gtf="resources/annotation/Mus_musculus.GRCm39.109.gtf"
    output:
        "results/counts/{sample}.txt"
    shell:
        """
        featureCounts \
            -T 1 \
            -t exon \
            -g gene_id \
            -a {input.gtf} \
            -o {output} \
            {input.bam}
        """
