##################################################
#'
#' Now we want to read BASH PIPE DATA from STDIN
#' 
##################################################

# if not part of piped stream, readLines() reads from keyboard!
# signal end of keyboard input 
# - via CTRL+Z (windows) 
# - or CRTL+D (linux) and hit ENTER

# unforunately, "stdin()" not working with Rscript !!! ...
# input <- readLines( stdin() )

# Thus:

# open dummy file handler for input stream
inStream <- file("stdin")

# read all data from STDIN into array
input <- readLines( inStream )

# close input stream
close(inStream)

# print array to STDOUT
print(input)

