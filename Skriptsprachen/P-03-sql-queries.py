# -----------------------------------------------------------------------------
# SQL-Abfragen an die Schoko-Datenbank schicken und Ergebnisse ausgeben
# -----------------------------------------------------------------------------

import sqlite3
db = sqlite3.connect("schokolade.db")

# Eine Abfrage mit der Funktion execute() liefert einen sog. Cursor,
# der das Durchlaufen des Abfrageergebnisses ermöglicht.
# Holen wir uns mal die ersten 10 Companies aus der Datenbank:
result = db.execute("select * from company limit 10")

# Alle Cursor-Funktionen gibt es hier: https://docs.python.org/3/library/sqlite3.html#cursor-objects
# Mehrere Varianten das Ergebnis zu durchlaufen:

print("Variante 1: Schleife")
for row in result:
    # row ist ein sog. Tupel, d.h. eine unveränderliche Liste der Werte einer Zeile des Ergebnisses:
    print(row)

# Hier sind wir jetzt am Ende des Cursors angelangt, er wird uns keine neuen Ergebnisse mehr liefern.
# Daher erstellen wir den Cursor nochmal:
result = db.execute("select * from company limit 10")
print("Variante 2: fetchone()")
# Wenn man nur eine einzige Zeile sehen will
first_row = result.fetchone()
# Die entsprechende Spalte gibt man über deren 0-basierten Index aus:
# 0 = id, 1 = name, 2 = country
# Um den Namen auszugeben:
print(first_row[1])

print("Variante 3: fetchmany(n)")
result = db.execute("select * from company limit 10")
# Wenn man eine bestimmte Anzahl Zeilen auf einmal holen will, z.B. erste 5 Zeilen:
rows = result.fetchmany(5)
print(rows)

print("Variante 4: fetchall()")
result = db.execute("select * from company limit 10")
# Wenn man das gesamte Ergebnis in Form einer Zeilenliste kriegen will:
print(result.fetchall())

db.close()