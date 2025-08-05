#!/bin/bash

tarcount=$(ls 2>/dev/null -Ub1 -- ~/*.tar.gz | wc -l)
cores=$(( 16/$tarcount ))

for tarball in ~/*.tar.gz
do
    id=$(basename $tarball .tar.gz)
    tar -xzvf $tarball
    ls 2>/dev/null -Ub1 -- $id/*.fasta > $id/sample.txt
    tmux new-session -d -s "$id"
    tmux send-keys -t "$id" "snakemake --snakefile ngpipe/Snakefile --config workdir=ngp$id contig_dir=$id samples=$id/samples.txt shutdown=multiple --cores $cores" Enter
done