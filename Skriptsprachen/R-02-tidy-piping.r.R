
library(tidyverse)

##################################################
#'
#' Guess what's going on here ... 
#' 
#' and what is the expected output?
#' 
#' (you might need to check the CSV file header)
#' 
##################################################

read_csv("review.csv") %>%
  filter( bean_origin %in% c("Togo","India") ) %>%
  left_join(  read_csv("company.csv"), 
              by=c("company_id"="id") ) %>%
  select( country, bean_origin ) %>%
  group_by(country, bean_origin) %>%
    summarise( num_chocs = n() ) %>%
  ungroup() %>%
  relocate( country, num_chocs, bean_origin) %>%
  rename("company_country" = country)

# ... write_csv(), visualize, further analyse, ...
