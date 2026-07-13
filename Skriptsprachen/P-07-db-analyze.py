# -----------------------------------------------------------------------------
# Behandlung von Kommandozeilen-Argumenten in Python-Programmen
#
# Erwartet über STDIN eine Liste von Bean Origins (1 pro Zeile).
#
# Als Argument --rating kann angegeben werden, welche Berechnung für die 
# Ratings gemacht werden soll (möglich sind: "count", "avg", "min", "max").
# Falls nichts übergeben wird, soll "count" berechnet werden.
#
# Wenn die Option --header übergeben wurde, so wird eine Kopfzeile ausgegeben.
# 
# Als einziges verpflichtenes Argument wird der Dateiname der Schoko-Datenbank
# erwartet.
#
# Als Output wird ein CSV ausgegeben, in dem pro Origin aus dem STDIN die 
# das Ergebnis der entsprehende Berechnung in der 2. Spalte angegeben wird.
# -----------------------------------------------------------------------------

# Kommandozeilen-Argumente parst man mit dem Paket argparse
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("--ratings", choices=["count", "avg", "min", "max"], default="count", help="Calculation to perform on ratings")
parser.add_argument("--header", action="store_true", help="Output CSV header line")
parser.add_argument("file", help="SQLite database file")
args = parser.parse_args()

# Zunächst lesen wir die Liste der Origins von STDIN
import sys
origins = sys.stdin.read().strip().splitlines()
if len(origins) == 0:
    print("Error: No origins provided!", file=sys.stderr)
    exit()

# Für CSV-Ausgabe brauchen wir das Paket "csv"
import csv
out = csv.writer(sys.stdout, lineterminator='\n')

# Kopfzeile hinzufügen falls gefordert
if args.header:
    out.writerow(("origin", args.ratings))

# Verbinden zur angegebenen SQLite-Datenbank
import sqlite3
db = sqlite3.connect(args.file)

# Alle origins durchlaufen und jeweils eine Zeile mit der gewählten Berechnung generieren
for origin in origins: 
    # f vor dem String führt dazu dass Variablen in geschwungenen Klammern direkt eingefügt werden
    # ? in der SQL Query steht für einen Parameter, der dann beim Aufruf von execute() übergeben wird
    # Direktes einfügen des Origin in den Abfragestring soll man keinesfalls machen (warum? Google mal "SQL Injection")
    sql_query = f"select bean_origin, {args.ratings}(rating) from review where bean_origin = ? group by 1"
    result = db.execute(sql_query, [origin])
    row = result.fetchone()
    # Falls es zu einem Origin gar keine Ratings gibt, wird eine leere Zeile zurückgegeben, die wollen wir nat. nicht ausgeben
    if not row: 
        print("Warning: Unknown origin", origin, file=sys.stderr)
    else:
        out.writerow(row)

# Finito
db.close()