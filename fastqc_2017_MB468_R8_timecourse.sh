#!/bin/bash

set -eou pipefail

if [ $# -ne 1 ]; then
    echo "usage: `basename $0` variables_filename"
    exit 1
fi

source "${0%/*}/$1"

RUNLOG=${FQOUT_DIR}/fastqc_runlog.txt
echo "Run by `whoami` on `date`" > $RUNLOG

for FILE in `find ${DATA_DIR} -name \*.fastq`; do
	echo "*** FASTQC ${FILE} "
	echo FASTQC on ${FILE} >> ${RUNLOG}
	fastqc ${FILE} \
	-o ${FQOUT_DIR} \
	2>> ${RUNLOG}
	
	mv ${FQOUT_DIR}/*.html ${FQHTML_DIR}
	echo Moved to ${FILE}\*.html to ${FQHTML_DIR} >> ${RUNLOG}
done

tar czvf ${FQHTML_DIR}.tar.gz ${FQHTML_DIR}/*

