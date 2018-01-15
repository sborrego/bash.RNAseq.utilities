#!/bin/bash

set -euxo pipefail

if [ $# -ne 1 ]; then
    echo "usage: `basename $0` variables_filename"
    exit 1
fi

source "${0%/*}/$1"

RUNLOG=${TRIM_DATA_DIR}/trim_runlog.txt
echo "Run by `whoami` on `date`" > $RUNLOG


for FILE in `find ${DATA_DIR} -name \*.fastq`; do
	echo ${FILE}
	PREFIX=`basename $FILE .fastq`
	TRIM_FILE=${TRIM_DATA_DIR}/${PREFIX}_trim.fastq

	TRIMMER="ILLUMINACLIP:${SE_ADAPTER_DIR}:2:30:10 LEADING:3 TRAILING:1 SLIDINGWINDOW:4:15 MINLEN:36"
	
	echo "*** Trimming ${FILE}"
	echo Trim Summary for ${FILE} >> ${RUNLOG}
	trimmomatic SE -phred33 -threads 7 \
	${FILE} \
	${TRIM_FILE} \
	${TRIMMER} \
	2>> ${RUNLOG}

done


# LEADING:<quality>
# quality: Specifies the minimum quality required to keep a base.
# TRAILING:<quality>
# quality: Specifies the minimum quality required to keep a base.

# - Remove Illumina adapters provided in the TruSeq3-PE.fa file (provided). Initially
# Trimmomatic will look for seed matches (16 bases) allowing maximally 2
# mismatches. These seeds will be extended and clipped if in the case of paired end
# reads a score of 30 is reached (about 50 bases), or in the case of single ended reads a
# score of 10, (about 17 bases).
# - Remove leading low quality or N bases (below quality 3)
# - Remove trailing low quality or N bases (below quality 3)
# - Scan the read with a 4-base wide sliding window, cutting when the average quality per
# base drops below 15
# - Drop reads which are less than 36 bases long after these steps
