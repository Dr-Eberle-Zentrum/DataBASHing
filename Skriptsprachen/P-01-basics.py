# -----------------------------------------------------------------------------
# Grundlegendes zu Python: Variablen, Ausgabe, Konsole
# -----------------------------------------------------------------------------

# Ausgabe auf Standardausgabe STDOUT
print("Hello World!")

# Mehrteilige Ausgabe, getrennt durch Leerzeichen
print("Die Lottozahlen:", 23, 1, 34, 41, 2, 9)

# Selbstgewähltes Trennzeichen durch Argument "sep"
print(21, 1, 2022, sep=".")

# Für Ausgabe auf STDERR (Fehler, Warnungen, etc.) muss man das Paket "sys" importieren...
import sys

# ... und dann die Ausgabe in das File sys.stderr umleiten
print("Uiuiui, da is was gewaltig schiefgegangen!", file=sys.stderr)

# Variablen einen Wert zuweisen
x = 5
y = 3 * x - 2
print(x, y)

# Python-Konsole beenden mit Strg+D oder Befehl:
exit()
