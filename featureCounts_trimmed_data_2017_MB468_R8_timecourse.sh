#!/bin/bash

set -eoux pipefail

if [ $# -ne 1 ]; then
    echo "usage: `basename $0` variables_filename"
    exit 1
fi

source "${0%/*}/$1"

RUNLOG=${TRIM_COUNTS_DIR}/trim_counts_runlog.txt
echo "Run by `whoami` on `date`" > ${RUNLOG}

echo "*** Counting features with: ${REF_GTF}"
echo "*** Counting features with: ${REF_GTF}" >> ${RUNLOG}
featureCounts -T 7 -g gene_name -a ${REF_GTF}  -o ${TRIM_COUNT_OUT}.txt \
${TRIM_ALIGNMENTS_DIR}/*.bam 2>> ${RUNLOG}

# -p paired end, excluded is single read samples
# -T thread number
# -a <string> name of the annotation file
# -g <string> attribute type used to group feature

# Generate a file with only Geneid (col 1) and sample (col 7-31) columns
cat ${TRIM_COUNT_OUT}.txt | cut -f 1,7-31 > ${TRIM_COUNTS_DIR}/trim_simple_counts.txt
