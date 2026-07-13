
library(DBI)    # Funktionen zum Umgang mit Datenbanken 
library(RSQLite) # SQLite Treiber ==> datenbankspezifisch! (zB RMySQL fuer MySQL-DB)
library(dplyr)  # fuer %>%  Piping und Datenprozessierung
library(ggplot2) # Plotting

# working directory auf Skriptpfad setzen, für Dateizugriff!

##############  STANDARD WORKFLOW  ####################

# Datenbankverbindung oeffnen
dbChoc <- dbConnect(drv   = RSQLite::SQLite(), # Treiber muss zur DB passen!
                 dbname   = "schokolade.db") 
                # dbname kann auch URL oder Pfad zu DB-Datei sein
                # oder Name einer neu zu erstellenden DB

# Abfragen + DB-Manipulation 
# (hier die verfuegbaren Tabellen abfragen)
dbListTables(dbChoc)
# [1] "company" "review"

# Verbindung schließen !!!
dbDisconnect(dbChoc) 


##############  SCHOKOLADE SELBER MACHEN  ####################

# neue leere IN-MEMORY Datenbank (keine Datei) erzeugen
dbChoc <- dbConnect(drv      = RSQLite::SQLite(), 
                    dbname   = ":memory:") 

# Datentabellen aus CSV-Dateien erzeugen und fuellen
library(readr)
dbWriteTable( dbChoc, name="company", read_csv("company.csv")) 
dbWriteTable( dbChoc, name="review", read_csv("review.csv")) 

# ... ABFRAGEN
dbListTables(dbChoc)

# Verbindung schließen !!!
dbDisconnect(dbChoc) 


##############  SCHOKOLADENZUGRIFF  ####################

# Datenbankverbindung oeffnen
dbChoc <- dbConnect(drv      = RSQLite::SQLite(), 
                    dbname   = "schokolade.db") 

########  SQL ABFRAGEN (DBI) ##########

# Schokoladen aus Vietnam 
dbChoc %>% 
  dbGetQuery("select bar_name from review where bean_origin = 'Vietnam'") %>%
  # Abfrageergebnis direkt weiterverarbeiten
  arrange(bar_name) %>%
  unique()

# Ergebnisse in Bloecken abholen (zB bei grossen Tabellen)
dbChoc %>% 
  dbSendQuery("select bar_name from review where bean_origin = 'Vietnam'") ->
  lastQuery

# holt "erstmal" nur die ersten 5 ab
dbFetch(lastQuery,n=5)
# und die naechsten 5
dbFetch(lastQuery,n=5)

# ...
while(!dbHasCompleted(lastQuery)){
  dbFetch(lastQuery, n = 5) %>% nrow() %>% print()
}

########  ABFRAGEN OHNE SQL (DBPLYR)  #########


dbChoc %>%
  # Tabelle der DB auswaehlen
  tbl("review") %>%
  # ab hier normale dplyr Syntax
  filter( bean_origin == "Vietnam" ) %>%
  select( bar_name ) %>%
  head(n=5)

# dplyr-pipe wird intern in SQL uebersetzt
dbChoc %>%
  # Tabelle der DB auswaehlen
  tbl("review") %>%
  # ab hier normale dplyr Syntax, aber immer noch "in-DB"-Operationen
  filter( bean_origin == "Vietnam" ) %>%
  select( bar_name ) %>%
  head(n=5) %>%
  # SQL call generieren
  show_query() 

# zur Wweiterverarbeitung am Ende mit "collect()" in data.frame speichern
dbChoc %>%
  # Tabelle der DB auswaehlen
  tbl("review") %>%
  # ab hier normale dplyr Syntax, aber immer noch "in-DB"-Operationen
  filter( bean_origin == "Vietnam" ) %>%
  select( bar_name ) %>%
  head(n=5) %>%
  # ab hier wirklich lokales R-Objekt (tibble) zur normalen Weiterverarbeitung
  collect()

# Verbindung schließen 
dbDisconnect(dbChoc) 
