
**Python** ist eine sog. "**general purpose**" Programmiersprache, d.h. man kann damit eigentlich alles machen ;-)

-   Am häufigsten verwendet für Datenanalyse, Datenvisualisierung, und viele wissenschaftliche Rechenaufgaben wie Machine Learning, KI, usw.
-   Für jeden erdenklichen Verwendungszweck gibt es **[Pakete](https://pypi.org/)**, die den Funktionsumfang erweitern, und die man in das Programm importieren kann
-   Wir hantieren heute mit folgenden Paketen:
    -   [**sys**](https://docs.python.org/3/library/sys.html): Systemfunktionalität
    -   [**sqlite3**](https://docs.python.org/3/library/sqlite3.html): Anbindung an SQLite Datenbanken
    -   [**os**](https://docs.python.org/3/library/os.html): Betriebssystem-Funktionen
    -   [**pandas**](https://pandas.pydata.org/): Tabellenbasierte Datenanalyse
    -   [**csv**](https://docs.python.org/3/library/csv.html): CSV-Dateien verarbeiten
    -   [**matplotlib**](https://matplotlib.org/): Diagramme und Visualisierungen
    -   [**argparse**](https://docs.python.org/3/library/argparse.html): Kommandozeilenargumente verarbeiten

  
Das Programm **python3** ist in Ubuntu bereits installiert (in Windows **python.exe**, muss [installiert](https://www.python.org/downloads/windows/) werden) bietet:

-   **Interaktive Konsole**: wenn python3 ohne Argumente aufgerufen wird. Beenden mit `exit()` oder Strg+D
-   **Scriptausführung**: wenn als Argument ein Python-Script (Datei mit Endung .py) übergeben wird. Shebang ist `#!/usr/bin/env python`

Diese **Grundfuktionalitäten** sowie **Standard- und Fehlerausgabe** mit `print()` sind im Script [P-01-basics.py](P-01-basics.py) demonstriert.

Verbindung zu **SQLite-Datenbanken** kann mit dem Paket sqlite3 aufgenommen werden:

-   [P-02-db-fuellen.py](P-02-db-fuellen.py) zeigt, wie eine leere Datenbank mit den Schokoladen-**CSV-Dateien gefüllt** wird
-   [P-03-sql-queries.py](P-03-sql-queries.py) zeigt, wie **SQL-Abfragen** an eine SQLite-Datenbank gestellt werden, und welche Möglichkeiten es gibt, die Abfrageergebnisse zu "Durchlaufen".
-   [P-04-csv-out.py](P-04-csv-out.py) zeigt, wie wir das Paket **csv** nutzen, um **Abfrageergebnisse CSV-formatiert** auf die Standardausgabe für Weiterverarbeitung schreiben
-   [P-05-viz.py](P-05-viz.py) zeigt, wie wir Abfrageergebnisse in einen DataFrame des Pakets **pandas** laden und dann mit Funktionen des Pakets **matplotlib Diagramme auf Grundlage der Abfrageergebnisse** anzeigen und in Bilddateien speichern können.

Für **Standardeingabe** bietet das Paket **sys** Möglichkeiten zum zeilenweisen Einlesen (entweder gepipte oder händisch eingegebene Daten) mit `sys.stdin.readlines()` - dies ist in [P-06-stdin.py](P-06-stdin.py) erläutert.  
  
**Kommandozeilenargumente** werden definiert und interpretiert mit dem Paket **argparse**. Dies ist in [P-07-db-analyze.py](P-07-db-analyze.py) ersichtlich - in diesem Skript werden Datenbankabfragen gesteuert über Kommandozeilenargumente. 
Ein Beispielaufruf, der für die in der Datei `origins.txt` gelisteten Länder die jeweils durchschnittlichen Ratings berechnet und das Ergebnis CSV-formatiert in die Datei `ergebnis.csv` speichert:  
  
`$ cat origins.txt | python3 P-07-db-analyze.py --ratings avg schokolade.db > ergebnis.csv`  
  
**Alle Scripts und Hilfsdateien finden Sie in diesem Ordner!**
