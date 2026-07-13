# -----------------------------------------------------------------------------
# Ausgabe einer Datenbankabfrage als CSV
# -----------------------------------------------------------------------------

import sqlite3
db = sqlite3.connect("schokolade.db")

# Alle Schoko-Namen und Bohnen aus Vietnam
result = db.execute("select bar_name, cocoa_pct from review where bean_origin = 'Vietnam'")

# Ausgabe als CSV entweder mit pandas DataFrame
#import pandas
#print(pandas.DataFrame(result).to_csv(header=False, index=False))

# ... oder mit dem Paket "csv" auf sys.stdout schreiben
import csv, sys
csv.writer(sys.stdout, lineterminator="\n").writerows(result)