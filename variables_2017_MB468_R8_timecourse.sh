#!/bin/bash
set -euo pipefail

# Change experiment name
export EXP_NAME=2017_MB468_R8_timecourse
# Change root dir if necessary
export ROOT_DIR=/home/stacey/hd2
export SUB_DIR=${ROOT_DIR}/RNASEQ
# Change location of reference genome
export REF_DIR=${ROOT_DIR}/ref_genomes
# Change to indexed reference genome.
# Options: sacCer3, ercc92, hg38, hg38_ercc92
export GENOME=hg38_ercc92
export GTF=hg38_ercc92_anno

export REF=${REF_DIR}/${GENOME}
export REF_IDX=${REF}/${GENOME}
export REF_GTF=${REF_DIR}/${GTF}/${GTF}.gtf

export EXP_DIR=${SUB_DIR}/${EXP_NAME}
export ORG_DATA_DIR=${EXP_DIR}/original_data
export DATA_DIR=${EXP_DIR}/data
export ALIGNMENTS_DIR=${EXP_DIR}/alignments
export FLAG_DIR=${ALIGNMENTS_DIR}/flag
export COUNTS_DIR=${EXP_DIR}/counts
export DE_DIR=${EXP_DIR}/DE_analysis

export FQOUT_DIR=${EXP_DIR}/fqout
export FQHTML_DIR=${FQOUT_DIR}/fqhtml
export FQHTML_TRIM_DIR=${FQOUT_DIR}/fqhtml_trim

export TRIM_DATA_DIR=${EXP_DIR}/trim_data
export SE_ADAPTER_DIR=/home/stacey/miniconda3/pkgs/trimmomatic-0.36-5/share/trimmomatic-0.36-5/adapters/TruSeq2-SE.fa
export PE_ADAPTER_DIR=/home/stacey/miniconda3/pkgs/trimmomatic-0.36-5/share/trimmomatic-0.36-5/adapters/TruSeq2-PE.fa
export TRIM_ALIGNMENTS_DIR=${EXP_DIR}/trim_alignments
export TRIM_COUNTS_DIR=${EXP_DIR}/trim_counts
export TRIM_FLAG_DIR=${TRIM_ALIGNMENTS_DIR}/trim_flag

export COUNT_OUT=${COUNTS_DIR}/counts
export TRIM_COUNT_OUT=${TRIM_COUNTS_DIR}/trim_counts

mkdir -p ${DATA_DIR}
mkdir -p ${ALIGNMENTS_DIR}
mkdir -p ${COUNTS_DIR}
mkdir -p ${FLAG_DIR}
mkdir -p ${DE_DIR}

mkdir -p ${FQOUT_DIR}
mkdir -p ${FQHTML_DIR}
mkdir -p ${FQHTML_TRIM_DIR}

mkdir -p ${TRIM_DATA_DIR}
mkdir -p ${TRIM_ALIGNMENTS_DIR}
mkdir -p ${TRIM_COUNTS_DIR}
mkdir -p ${TRIM_FLAG_DIR}
