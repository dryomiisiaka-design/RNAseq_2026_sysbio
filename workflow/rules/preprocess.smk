rule fastp:
    input:
        raw = f"{config['input_path']}/{{sample}}_raw.fastq"
    output:
        filtered = f"{config['input_path']}/{{sample}}_filtered.fastq",
        html = "results/fastp/{sample}_fastp.html",
        json = "results/fastp/{sample}_fastp.json"
    conda:
        "../envs/rnaseq_preprocess.yaml"
    shell:
        """
        fastp \
        -i {input.raw} \
        -o {output.filtered} \
        -h {output.html} \
        -j {output.json}
        """