#!/bin/bash

# run in the kallisto folder for this project on biowulf2:
# /parikhpp/git/kallisto

mkdir -p 00log

module load snakemake || exit 1

sbcmd="sbatch --cpus-per-task={threads} \
--mem={cluster.mem} \
--time={cluster.time} \
--partition={cluster.partition} \
--output={cluster.output} \
--error={cluster.error} \
{cluster.extra}"


snakemake -s snakefile \
-pr --local-cores 2 --jobs 500 \
--cluster-config cluster.json \
--cluster "$sbcmd"  --latency-wait 120 --rerun-incomplete \
-k --restart-times 0 \
--resources parallel=4 # don't transfer more than n fastq at at time from trek
