#!/bin/bash

set -eoux pipefail

if [ $# -ne 1 ]; then
    echo "usage: `basename $0` variables_filename"
    exit 1
fi

source "${0%/*}/$1"

# Build Index
# hisat2-build ${REF}.fa ${REF_IDX}

RUNLOG=${ALIGNMENTS_DIR}/alignment_runlog.txt
echo "Run by `whoami` on `date`" > ${RUNLOG}

FLAG=${FLAG_DIR}/alignment_errors.flagstat
echo "Run by `whoami` on `date`" > ${FLAG}

for FILE in `find ${DATA_DIR} -name \*.fastq`; do
	echo $FILE
	PREFIX=`basename ${FILE} .fastq`
	BAM_FILE=${ALIGNMENTS_DIR}/${PREFIX}.sorted.bam

	echo "*** Aligning: ${FILE}"
	echo "Alignment summary ${FILE}" >> ${RUNLOG}
	hisat2 -p 7 -q --phred33 \
	-x ${REF_IDX} \
	-U ${FILE} 2>> ${RUNLOG} \
	| samtools view -bS - | samtools sort -@ 7 - > ${BAM_FILE}

	samtools index ${BAM_FILE}
	samtools flagstat ${BAM_FILE} >> ${FLAG}
	
done
