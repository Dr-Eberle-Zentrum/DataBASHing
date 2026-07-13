#!/usr/bin/env Rscript --vanilla

###########################################
#' reads a white-space separated list of
#' bean origins and queries a given 
#' SQLite database
###########################################

suppressWarnings(
 suppressPackageStartupMessages({
    library(argparser) # parsing command line arguments
    library(DBI)    # Funktionen zum Umgang mit Datenbanken 
    library(RSQLite) # SQLite Treiber ==> datenbankspezifisch! (zB RMySQL fuer MySQL-DB)
    library(dplyr)  # fuer %>%  Piping und Datenprozessierung
    library(stringr) # text manipulation
    library(readr) # file access
 })
)

argList <- 
  # task of the script
  arg_parser("Reads bean origins from STDIN and queries a given SQLite DB") %>%
  # list (named) arguments
  argparser::add_argument("--file", 
                          help="SQLite DB file", 
                          default="schokolade.db",
                          short="-f") %>%
  argparser::add_argument("--table", 
                          help="name of the table to query", 
                          default="review",
                          short="-t") %>%
  argparser::add_argument("--columns", 
                          help="comma-separaed list of column names to print (* = all)", 
                          default="*",
                          short="-c") %>%
  argparser::add_argument("--no-header", 
                          help="output no header information", 
                          short="-n",
                          flag = T) 

# parse given arguments 
args <- parse_args( argList )

# print help if needed
if (args$help) {
  print( args )
  quit(save="no") # exit execution of this script (without error code)
}

# sanity checking of input
if (!dbCanConnect(RSQLite::SQLite(), args$file)) {
  # error message and script end
  stop(paste("Cannot open SQLite DB from file '",args$file,"'",sep=""))
}

# open DB connection
myDB <- dbConnect(RSQLite::SQLite(), args$file)

# check if table is available
if (!args$table %in% dbListTables(myDB)) {
  stop(paste("Given table '",args$table,"' is not available within the DB"))
}

# read ALL lines from STDIN into variable
open(f<- file("stdin", blocking = T));


# create empty data container to be filled
myData <- tibble()

# query db for each line of input

# (A) reading STDIN line-by-line
# while(length(line <- readLines(f,n=1)) > 0) { # line wise reading

# (B) reading all lines of STDIN in one go and store in container
input <- readLines(f)
for( line in input ) { # element wise container traversal
  # query the DB
  myDB %>%
    # Tabelle der DB auswaehlen
    tbl(args$table) %>%
    filter( bean_origin == line) %>%
    collect() %>%
    # append already stored data
    bind_rows( myData ) ->
    # overwrite old data
    myData
}
close(f)


# close DB connection
dbDisconnect(myDB)

# select columns
if (args$col != "*") {
  # decompose and clean columns
  myCols <- str_split(args$col,",",simplify = T) %>%
              str_remove_all("^\\s*|\\s*$")
  # TODO: check column sanity (not done here)
  # reduce columns
  myData <- select(myData, myCols)
}

# CSV formatting of the data 
format_csv(myData, col_names = !args$no_header) %>% 
  cat() # print data to STDOUT


  