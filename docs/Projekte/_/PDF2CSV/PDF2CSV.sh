#!/usr/bin/env bash

pdfFile=${1:-../PDF2CSV/FY2023_AR_TableIII.pdf}
tmpFile=$(basename ${pdfFile}).tmp

# get text from pdf and extract lines with numbers
# pdf2ps ${pdfFile} - \
# | ps2ascii \
# | grep -P "\d" \
# > ${tmpFile}
pdftotext -layout ${pdfFile} - \
| grep -P "\d" \
> ${tmpFile}

# get year of report
yearOfReport=$(grep -oPm 1 "(?<=Fiscal Year )\d+" ${tmpFile})

# get string of leading blanks left of country column
leadingBlanks=$(grep -oPm 1 "^\s*(?=Foreign State)" ${tmpFile})
# header of table
tableHeader=$(grep -oPm 1 "Foreign State.*$" ${tmpFile} | sed "s/   */;/g")

# extract lines with
# - no header
# - correct indention
# - starting with upper case letter
# - no "Total" counts
# alter headlines to ensure to be first in sorting order
# sort and unique
# undo headline alteration
# remove komma in numbers
# replace spaces before numbers with semikolon
(
  echo ${tableHeader}
  cat ${tmpFile} \
  | grep -v "Foreign State" \
  | sed "s/^${leadingBlanks}//" \
  | grep -P "^[A-Z]" \
  | grep -vP "(?<!  )Total" \
  | sort \
  | sed "s/,\([0-9]\)/\1/g" \
  | sed "s/ \([0-9-]\)/;\1/g; s/ *;/;/g; s/;-/;0/g"
) > ${yearOfReport}.csv

# cleanup
rm -f ${tmpFile}
