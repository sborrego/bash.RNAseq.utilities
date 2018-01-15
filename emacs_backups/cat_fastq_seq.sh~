#!/bin/bash

# Exit this script on any error.
set -euxo pipefail

if [ $# -ne 3 ]; then
    echo "usage: `basename $0` variables_filename nstart_seq nend_seq"
    exit 1
fi

source ${0%/*}/$1

RUNLOG=${DATA_DIR}/runlog.txt
echo "Run by `whoami` on `date`" > $RUNLOG

SAMPLES=${DATA_DIR}/sample_list.txt
echo "SAMPLE INFO" > ${SAMPLES}

for ID in `seq $2 $3`; do
    FILE_ID=`printf P%0.2d $ID`
    echo "*** Combo $FILE_ID is up!"
    echo concatenate ${ORG_DATA_DIR}/*${FILE_ID}*.txt.gz >> $RUNLOG
    zcat ${ORG_DATA_DIR}/*${FILE_ID}*.txt.gz > ${DATA_DIR}/combined_${FILE_ID}.fastq
    echo combined_${FILE_ID}.fastq >> ${SAMPLES}
    cat ${DATA_DIR}/combined_${FILE_ID}.fastq | wc -l  >> ${SAMPLES}
done
