#!/usr/bin/env bash

country=${1:-Germany}

# PDF in URL
pdfToDownload=(
  "/FY2023AnnualReport/FY2023_AR_TableIII.pdf"
  "/FY2022AnnualReport/FY22_TableIII.pdf"
  "/FY2021AnnualReport/FY21_TableIII.pdf"
)

# download and processing to YEAR.csv
for pdfFile in "${pdfToDownload[@]}"; do
  fileName=$(basename ${pdfFile})
  # check if file is missing
  if [ ! -f ${fileName} ]; then
    # download
    wget "https://travel.state.gov/content/dam/visas/Statistics/AnnualReports/${pdfFile}"
  fi
  # create YEAR.csv
  bash ./PDF2CSV.sh ${fileName}
done

# final extraction of country information
grep "${country}" ????.csv | sed "s/\.csv:/;/"


