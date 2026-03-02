import pandas as pd
import sys

# Snakemake automatically provides input/output
inputs = snakemake.input
output = snakemake.output[0]

dfs = []

for f in inputs:
    df = pd.read_csv(f, sep="\t", comment="#")
    df = df.iloc[:, [0, -1]]
    sample_name = f.split("/")[-1].split(".")[0]
    df.columns = ["Geneid", sample_name]
    dfs.append(df)

merged = dfs[0]

for df in dfs[1:]:
    merged = merged.merge(df, on="Geneid")

merged.to_csv(output, index=False)