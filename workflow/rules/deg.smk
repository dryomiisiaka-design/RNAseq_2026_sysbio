rule deg:
    input:
        counts="results/counts/count_matrix.csv",
        samples="samplesheet.csv"

    output:
        "results/DEG/deg_report.html"

    conda:
        "../envs/deg.yaml"

    script:
        "../scripts/deg.Rmd"