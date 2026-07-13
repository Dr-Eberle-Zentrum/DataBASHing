
**R** = Programmiersprache zur **Datenauswertung, -verarbeitung und -visualisierung**

-   **Tabellen**-orientiert (Zeile = Datensatz, Spalte = Eigenschaft)
-   mit [**tidyverse**](https://www.tidyverse.org/) Paketen
    -   [**piping**](https://magrittr.tidyverse.org/reference/pipe.html) via **%>%** oder **|>**
        -   verknüpft Kommandos (Verarbeitungsschritte)
            -   Ausgabe des aktuellen calls wird erstes Argument des nächsten
            -   Einfügeposition (oder Wiederholung) im Folgecall mit **.** festlegen
        -   spart Zwischenspeichern in temporären Variablen
        -   liefert lesbare Workflows
        -   abstrahiert von "normaler Programmierung"
    -   [**ggplot2**](https://ggplot2.tidyverse.org/) ermöglicht komplexe und schöne **Visualisierungen**
    -   [**dbplyr**](https://dbplyr.tidyverse.org/) ermöglicht **DB Abfrage O****HNE SQL** mit normaler R Syntax
-   spezifische [Pakete für fachspezifische Datenanalysen](https://cran.r-project.org/web/packages/available_packages_by_name.html) vorhanden

Um R interaktiv in der Konsole zu nutzen, muss der Installationspfad bis zum **bin/** Unterordner in der **PATH** Umgebungsvariable eingetragen sein.

-   In Linux oder Apple Systemen muss meist nichts gemacht werden. Ggf. wenn nötig z.B. die **.bashrc** Profildatei erweitern und ein erweiterte **PATH** Variable via **export** setzen
-   In Windowssystem in den "Systemeinstellungen" mit Knopf "Umgebungsvariablen..." die Variable **Path** ändern (wird in die WSL **PATH** Variable exportiert)

**R**(.exe) = R Konsole in der Kommandozeile öffnen und interaktiv R Programmieren

-   **q()** : schliesst die Konsole
-   **print**("Hallo") : gibt die variable, string, ... aus
-   x **<-** 4+5 : Zuweisungsoperator ("=" geht i.d.R. auch, aber für Argumentzuweisung reserviert)
-   **install.packages**("tidyverse") : installiert zusätzliche Pakete
-   **library**(tidyverse) : lädt **ein** Paket und macht dessen Funktionen verwendbar (tidyverse = Metapaket, sodass mehrere auf einmal geladen werden)
-   **filter**(), **select**(), **arrange**(), **mutate**() : [dplyr](https://dplyr.tidyverse.org/) Tabellenprozessierung
-   Kommandos durch Zeilenumbruch oder "**;**" getrennt
-   siehe [R-01-first-R-steps.R](R-01-first-R-steps.R)

**Rscript** = Kommandozeilentool um R-Skripte in der Kommandozeile auszuführen

-   **--vanilla** : kombinierte Standardargumente für Einzelskriptaufruf
-   **-e** AUSDRUCK : führ den gegeben R-Ausdruck direkt aus und beendet R
    -   `Rscript.exe -e "library(RSQLite); dbCanConnect(RSQLite::SQLite(),'schokolade.db');"`
    -   oder mit eingebundener Shell-Variable `MYDBPATH=$PWD; Rscript.exe -e "library(RSQLite); dbCanConnect(RSQLite::SQLite(),'$MYDBPATH/schokolade.db');"`
-   Skript(datei) selbst kann auch Argumente haben, die nach dem Dateinamen/Ausdruck angegeben werden, zB.`Rscript.exe -e "print('Angegebene Argumente'); print(commandArgs(trailingOnly=TRUE))" Ich wars`
-   Skript SHEBANG = `#!/usr/bin/env Rscript`
-   siehe [R-09-query-DB-script.R](R-09-query-DB-script.R) (All-in-one Beispiel)

**Input/Output**

-   STDOUT:
    -   alle **print()** und **cat()** Ausgaben
    -   alle Einzelvariablenaufrufe
    -   mittels Dummyfilehandler **stdout()** z.B. `write("Hallo", stdout())`
-   STDERR
    -   alle messages und warnings
    -   mittels Dummyfilehandler **stderr()** z.B. `write("Fehler", stderr())`
    -   **stop**("Fehlermeldung") beendet danach das Skript
    -   **warning**("Seltsam") liefert (ausschaltbare) Warnmeldung
-   STDIN
    -   mittels Dummyfilehandler **file("stdin")**
    -   entweder alles auf einmal lesen `input <- readLines(stdin <- file("stdin",blocking = T)); close(stdin)`
    -   oder z.B. zeilenweise bis zur ersten Leerzeile`open(f<- file("stdin", blocking = T));``while(length(line <- readLines(f,n=1)) > 0) { write(line, stderr()) }``close(f)`
-   siehe [R-02-tidy-piping.R](R-02-tidy-piping.R), [R-03-clean-output.R](R-03-clean-output.R), [R-04-read-STDIN.R](R-04-read-STDIN.R)

**Kommandozeilenargumente**

-   **commandArgs**() : liefert aller Argumente in ihrer Reihenfolge (zB für Argumente in fester Reihenfolge
-   [**optparse**](https://github.com/trevorld/r-optparse) Paket generiert und parsed optionale Argumente etc.
-   viele Alternativen vorhanden...
-   siehe [R-05-args-fixed.R](R-05-args-fixed.R), [R-06-args-parsed.R](R-06-args-parsed.R)

**SQLite Datenbankverwendung**

-   mittels [**RSQLite**](https://rsqlite.r-dbi.org/) Packet des [**DBI**](https://dbi.r-dbi.org/) Packetes
    -   **dbConnect**() : DB von Datei laden `dbConnect(RSQLite::SQLite(),"schokolade.db")`
    -   **dbDisconnect**() : DB Verbindung wieder schliessen
    -   **dbGetQuery**() : SQL Abfrage mit Datenrückgabe
-   mittels [**dbplyr**](https://dbplyr.tidyverse.org/) Packet DB Abfrage im R-Stil ohne SQL
    -   **tbl**() : Tabellenauswahl
    -   **filter**(), **select**(), ..., **piping %>%**
    -   dbplyr-Pipe wird intern in SQL Befehl übersetzt
        -   **show_query**() : zeigt generierten SQL Befehl
        -   **collect**() : finale DB Abfrage und Speichern in tibble Container
-   siehe [R-07-DB-access.R](R-07-DB-access.R)

**Visualisierung mittels ggplot2**

-   collagenartige **Vektorgrafik**generierung, d.h. Malreihenfolge wichtig!
-   **ggplot**( TABELLE, **aes**(SPALTE1,SPALTE2,..) ) : startet neue Grafik (leeres Blatt) und legt fest welche Spalten der Tabelle für welche Achse (x,y, ..), Gruppierung, Farbe etc. verwendet werden
-   **"+"** : fügt weitere Bildteile dazu
    -   **geom_point**() : scatter plot
    -   **geom_line**() : line plot
    -   **geom_histogram**()
    -   ...
-   **themes** definieren das Styling z.B. `+ theme_bw()`
-   **ggsave**(DATEINAME) speichert grafik als Datei, Dateityp automatisch basierend auf DATEINAME festgelegt, z.B. `+ ggsave("meinPlot.png"`
-   siehe [R-08-plotting.R](R-08-plotting.R)
