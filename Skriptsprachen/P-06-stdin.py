# -----------------------------------------------------------------------------
# Lesen von der Standardeingabe STDIN
# -----------------------------------------------------------------------------

# Dafür benötigt man das Paket sys
import sys

# Zeilen lesen
lines = sys.stdin.readlines()

# Zählen die Anzahl der gelesenen Zeilen mit der eingebauten Funktion len()
count = len(lines)

# Ausgabe die Anzahl der gelesenen Zeilen
print("Received", count, "lines!")