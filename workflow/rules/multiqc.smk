samples = config["samples"]

rule multiqc:
    input:
        fastqc = expand("results/fastqc/{sample}_{stage}_fastqc.zip",
                        sample=config["samples"],
                        stage=["raw","filtered"]),
        fastp = expand("results/fastp/{sample}_fastp.json",
                       sample=config["samples"]),
        hisat = expand("results/hisat2/{sample}_summary.txt",
                       sample=config["samples"]),
        featureCounts = expand("results/counts/{sample}.featureCounts.txt.summary",
                               sample=config["samples"])
    output:
        report = "results/multiqc/multiqc_report.html",
        outdir = directory("results/multiqc/")
    conda:
        "../envs/multiqc.yaml"
    params:
        extra = config["multiqc_extra"]
    shell:
        """
        multiqc \
            {params.extra} \
            --outdir {output.outdir} \
            --filename multiqc_report \
            results/
        """