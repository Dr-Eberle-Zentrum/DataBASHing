##################################################
#'
#' Let's reduce the output to nice CSV format
#' 
##################################################

# ignore version warnings
suppressWarnings(
  # ignore information about loaded packages etc.
  suppressPackageStartupMessages({
    library(readr)
    library(dplyr)
  })
)


  
# ignore additional messages about column type of read data, etc.
read_csv("review.csv", show_col_types=F) %>%
  filter( bean_origin %in% c("Togo","India") ) %>%
  left_join(  read_csv("company.csv", show_col_types=F), 
              by=c("company_id"="id") ) %>%
  select( country, bean_origin ) %>%
  group_by(country, bean_origin) %>%
  summarise( num_chocs = n(), .groups = "drop" ) %>%
  relocate( country, num_chocs, bean_origin) %>%
  rename("company_country" = country) %>%
  
  # write to STDOUT via dummy file handle
  write_csv( stdout() )
