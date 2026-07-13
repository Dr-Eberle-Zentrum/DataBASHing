##################################################
#'
#' Named (optional) command line arguments (arbitrary order)
#' 
##################################################

suppressWarnings(
  suppressPackageStartupMessages({
    library(optparse)
    library(readr)
    library(magrittr) # piping
  })
)


myArgs <- 
  # create an option parser with general tool information message
  # produces automatically the "--help" and "-h" option
  OptionParser( description = "Reads from file or STDIN and prints to STDOUT." ) %>%
  # define file option to parse
  add_option( c("-f","--file"), 
              type="character", 
              default="-", 
              metavar = "filename",
              help = "File to read from or set to '-' to read from STDIN [default].")

# parse and store command line arguments
# prints help message and exits if "--help" or "-h" found among arguments
args <- parse_args(myArgs, args = commandArgs(trailingOnly = T) )

# this is where we want to store the data, i.e. nothing so far
input <- NA

# if file indicates reading from STDIN
if( args$file == "-" ) {
  
  f<-file("stdin")
  input <- readLines(f)
  close(f) 
  
} else {
  
  # else assume first arg == CSV file name
  input <- read_csv( args$file )  # access file argument
  
}

# print output
print( input )
