########################################
# Merge featureCounts outputs
########################################
rule merge_counts:
    input:
        expand(
            "results/counts/{sample}.featureCounts.txt",
            sample=samples
        )
    output:
        "results/counts/count_matrix.csv"
    conda:
        "../envs/rnaseq_preprocess.yaml"
    script:
        "../scripts/merge_featurecounts.py"