# -----------------------------------------------------------------------------
# Anlegen der Scholoaden-SQLite-Datenbank mit den CSV-Dateien
# -----------------------------------------------------------------------------

# Paket sqlite3 importieren
# Falls scheitert, in der Bash tippen: 
# pip3 install sqlite3
import sqlite3

# Falls schokolade.db bereits existiert, löschen wir diese, da wir sie neu füllen wollen
import os
if os.path.isfile("schokolade.db"): os.unlink("schokolade.db")

# Datenbank öffnen bzw. erzeugen falls noch nicht existiert
# (Um eine In-Memory Datenbank ohne Datei zu erstellen, Dateiname ":memory:" verwenden)
db = sqlite3.connect("schokolade.db")

# Um CSV Dateien in Tabellen zu importierten, nutzen wir das Paket pandas...
import pandas
# ... lesen die CSV-Datei in eine Pandas-Tabelle (genannt DataFrame)...
csv = pandas.read_csv("company.csv")
# ...und senden diese Tabelle an die Datenbank
csv.to_sql("company", db, index=False)

# das gleiche mit review, abgekürzt:
pandas.read_csv("review.csv").to_sql("review", db, index=False)

# Nun ist unsere Datenbank gefüllt!
# Nicht vergessen, Datenbankverbindung zu schließen!
db.close()