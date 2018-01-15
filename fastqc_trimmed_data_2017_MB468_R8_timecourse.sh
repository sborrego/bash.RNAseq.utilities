#!/bin/bash

set -euxo pipefail

if [ $# -ne 1 ]; then
    echo "usage: `basename $0` variables_filename"
    exit 1
fi

source "${0%/*}/$1"

RUNLOG=${FQOUT_DIR}/trim_fastqc_runlog.txt
echo "Run by `whoami` on `date`" > ${RUNLOG}

for FILE in `find ${TRIM_DATA_DIR} -name \*.fastq`; do
	echo "*** FASTQC ${FILE}"
	echo FASTQC summary of ${FILE} >> ${RUNLOG}
	fastqc $FILE \
	-o ${FQOUT_DIR} \
	2>> ${RUNLOG}
	
	mv ${FQOUT_DIR}/*.html ${FQHTML_TRIM_DIR}
	echo Moved \*.html to ${FQHTML_TRIM_DIR} >> ${RUNLOG}
done

tar czvf ${FQHTML_TRIM_DIR}.tar.gz ${FQHTML_TRIM_DIR}/*

## figure out how to send zip file to local machine when complete
