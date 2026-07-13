
library(DBI)    # Funktionen zum Umgang mit Datenbanken 
library(RSQLite) # SQLite Treiber ==> datenbankspezifisch! (zB RMySQL fuer MySQL-DB)
library(dplyr)  # fuer %>%  Piping und Datenprozessierung
library(ggplot2) # plotting
library(ggpubr) # statistics annotation

# working directory auf Skriptpfad setzen, für Dateizugriff!

##############  STANDARD WORKFLOW  ####################

# Datenbankverbindung oeffnen
dbChoc <- dbConnect(drv   = RSQLite::SQLite(), # Treiber muss zur DB passen!
                    dbname   = "schokolade.db") 
# dbname kann auch URL oder Pfad zu DB-Datei sein
# oder Name einer neu zu erstellenden DB

# join both tables
left_join( 
    tbl(dbChoc,"review"),
    tbl(dbChoc,"company"), 
    by=c("company_id"="id")
  ) %>%
  # show_query() 
  ggplot( aes(cocoa_pct, rating)) + 
  geom_count() + # point size ~ number of points
  # fit regression model
  stat_smooth(method="lm", formula = "y~x") + # fit and plot linear model
  # regression model parameters and evaluation
  stat_cor(label.y = 5) + # Pearson's Rho and p value
  stat_regline_equation(label.y = 4, col="blue")

# Verbindung schließen !!!
dbDisconnect(dbChoc) 

