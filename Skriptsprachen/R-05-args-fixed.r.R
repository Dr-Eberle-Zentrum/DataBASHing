##################################################
#'
#' Unnamed command line arguments (order matters)
#' 
##################################################

# store command line arguments, if given
args <- commandArgs(trailingOnly = T)

# this is where we want to store the data, i.e. nothing so far
input <- NA

# if no args, read from STDIN
if( length(args) == 0 ) {
  
  f<-file("stdin")
  input <- readLines(f)
  close(f) 
  
} else {
  
  # else assume first arg == CSV file name
  suppressMessages({
    library(readr) 
    input <- read_csv( args[1] )  # access first argument
  })
  
}

# print output
print( input )
