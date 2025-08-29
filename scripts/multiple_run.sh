#!/bin/bash
counter=0

mkdir -p ~/ngresults

for tarball in ~/*.tar.gz
do
    id=$(basename $tarball .tar.gz)
    if [ ! -d $id ]
    then
        mkdir $id
        tar -xzvf $tarball -C $id
        cd $id
        ls 2>/dev/null -Ub1 -- *.fasta | sed 's/.fasta//g' > samples.txt
        cd
    fi
    if [ $counter -eq 0 ]
    then
        snakemake --snakefile ngpipe/Snakefile \
            --config workdir=/home/ubuntu/ngp$id \
            contig_dir=/home/ubuntu/$id \
            samples=/home/ubuntu/$id/samples.txt \
            mlst_db=/home/ubuntu/data/ngono/mlst_database \
            update_db=true \
            shutdown=none \
            --cores 16
        counter=1
    else
        snakemake --snakefile ngpipe/Snakefile \
            --config workdir=/home/ubuntu/ngp$id \
            contig_dir=/home/ubuntu/$id \
            samples=/home/ubuntu/$id/samples.txt \
            mlst_db=/home/ubuntu/data/ngono/mlst_database \
            update_db=false \
            shutdown=none \
            --cores 16
    fi
    cd ngp$id
    tar -czvf ng$id"results.tar.gz" tables.xlsx results.tsv ngstar.log rplf.log qclog.tsv mst.svg step4_abricate step3_typing step1_qc multiqc_report database.log summary.tsv
    mv ng$id"results.tar.gz" ~/ngresults/ng$id"results.tar.gz"
    cd
    # rm -r $id ngp$id $tarball
done

# sudo shutdown -h 0