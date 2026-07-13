# -----------------------------------------------------------------------------
# Visualisierung einer Abfrage als Balkendiagramm
# -----------------------------------------------------------------------------

import sqlite3
db = sqlite3.connect("schokolade.db")

# Top-10 Origins nach Durchschnittsrating und mind. 3 Ratings
# (mehrzeilige Strings in Python umschließt man in dreifache Anführungszeichen)
result = db.execute("""
    select bean_origin, avg(rating) 
    from review 
    group by 1 
    having count(*) >= 3
    order by 2 desc
    limit 10
""")

# Balkendiagramm plotten, am einfachsten mit pandas
import pandas
# Tabelle aus dem Abfrageergebnis erstellen
table = pandas.DataFrame(result, columns=["Origin", "Rating"])
# Als horizontales Balkendiagram ("barh") plotten
diagram = table.plot(kind="barh", x="Origin", y="Rating", legend=None, title="Top 10 Origins by Average Rating")
# Bei horizontales Balkendiagramm ist y-Achse umgekehrt, also invertieren:
diagram.invert_yaxis()

# Wir können das Bild auch speichern in eine Datei:
# Dafür benötigen wir:
import matplotlib
# Um Achsenbeschriftungen nicht abzuschneiden, rufen wir auf:
matplotlib.pyplot.tight_layout()
# Dann speichern wir das Diagramm in eine Datei...
matplotlib.pyplot.savefig("origin_ratings.png")

# ... und zeigen sie im Image-Viewer an (wird in Ubuntu unter Windows nicht angezeigt werden)
matplotlib.pyplot.show()

db.close()