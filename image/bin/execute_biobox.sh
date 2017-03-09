#!/bin/bash  

set -o errexit
set -o nounset
set -o xtrace

READS=$(biobox_args.sh 'select(has("fastq")) | .fastq | map(.value) | join(" ")')

DATABASE=$(biobox_args.sh 'select(has("database")) | .database | .value ')

CACHE=$(biobox_args.sh 'select(has("cache")) | .cache | .value ')

CMD=$(fetch_task_from_taskfile.sh ${TASKFILE} $1)

if [[ $CACHE = "" ]]; 
then
	INPUT_TEMP=$(mktemp -d)
else 
	INPUT_TEMP=$CACHE
fi

INPUT_DIR="${INPUT_TEMP}/Quickr"

if [ ! -d "${INPUT_DIR}" ]; then
	mkdir ${INPUT_DIR} 
fi

FASTQ_INPUT="$CACHE/combined.fq"
cat $READS > $FASTQ_INPUT
FASTA_INPUT="$CACHE/input.fa"
CAMI_OUT="$OUTPUT/out.profile"
HMMER_OUT="$CACHE/nhmmer.out"
HMMER_LIB="$CACHE/nhmmer.tlb"

QUIKR_DATABASES="${PREFIX}data"
STOCKHOLM="${PREFIX}data/RF00177.stockholm"

seqtk seq -a $FASTQ_INPUT > $FASTA_INPUT  
eval $CMD

cat << EOF > ${OUTPUT}/biobox.yaml
version: 1.0.0
arguments:
    profiling:
      - path: ${CAMI_OUT}
        value: bioboxes.org:/profling:0.9
EOF
