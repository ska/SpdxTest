#!/bin/bash
WORK_FOLDER="./.tmp/"

echo "START"
src_file=$1
if [ ! -f ${src_file} ]
then
    echo "SRC file not found: ${src_file}"
    exit 1
fi 

echo "Clean previous files"
rm -rf ${WORK_FOLDER} "../NEW_${1}"

echo "Untar file $src_file"
mkdir ${WORK_FOLDER}
tar -xf $src_file -C ${WORK_FOLDER}

echo "Convert files in folder ${WORK_FOLDER}"
( /usr/bin/env python3 ./convert-spdx-licenses.py ${WORK_FOLDER} )

echo "Create new tar archive"
cd ${WORK_FOLDER}
tar  -cf "../NEW_${src_file}" *.json
cd -

echo "Clean temp files"
rm -rf ${WORK_FOLDER}

echo "END"
