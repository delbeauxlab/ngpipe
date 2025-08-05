#!/bin/bash

tarcount=$(ls 2>/dev/null -Ub1 -- ~/*.tar.gz | wc -l)
cores=$(( 16/$tarcount ))

for tarball in ~/*.tar.gz
do
    id=$(basename $tarball .tar.gz)
    tar -xzvf $tarball
    ls 2>/dev/null -Ub1 -- $id/*.fasta > $id/sample.txt
    tmux new-session -d -s "$id"
    tmux send-keys -t "$id" "conda activate ngpipe" Enter
    tmux send-keys -t "$id" "snakemake --snakefile ngpipe/Snakefile --config workdir=/home/ubuntu/ngp$id contig_dir=/home/ubuntu/$id samples=/home/ubuntu/$id/samples.txt mlst_db=/home/ubuntu/data/ngono/mlst_database shutdown=multiple --cores $cores" Enter
done