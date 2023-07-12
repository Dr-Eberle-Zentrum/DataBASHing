
# Anwendungsbeispiele

Im Folgenden wollen wir einige Anwendungsbeispiele zeigen, bei denen die Shell zum Einsatz kommt.


- [**Tabellarische Daten verarbeiten**](#tabellarische-daten-verarbeiten)
  - [Tabellen "untereinander hängen"](#use-case---tabellen-untereinander-h%C3%A4ngen)
  - [Tabellen "spaltenweise erweitern"](#use-case---tabellen-spaltenweise-erweitern)
  - [Alle `.csv` Dateien nach der zweiten Spalte sortieren und wieder abspeichern](#use-case---alle-csv-dateien-nach-der-zweiten-spalte-sortieren-und-wieder-abspeichern)



## Tabellarische Daten verarbeiten

Wir haben mehrere Tabellen als `.csv` Dateien vorliegen und wollen deren Inhalte in eine neue Tabelle vereinigen bzw. diese en bloc verarbeiten.

### Use case - Tabellen "untereinander hängen"

Da unsere Tabellen z.B. die gleiche Struktur haben, also gleiche Spaltenordnung, wollen wir unsere Tabellen insgesamt aneinander hängen.

```sh
# Liste von Einzeldateien
cat x.csv y.csv z.csv > gesamt.csv
# mit wildcards
cat daten-*.csv > daten-gesamt.csv
```

Hierbei ist jedoch zu beachten, dass etwaige Tabellenköpfe (Zeile mit Spaltennamen) nun mehrfach vorkommt.
Um das zu umgehen, können wir die Ausgabe in zwei Arbeitsschritte auftrennen und deren Ausgaben in eine Datei zusammenfassen.

```sh
# Befehlsgruppe anlegen
(
  # Kopfzeile aus einer Datei extrahieren und ausgeben
  head -n 1 x.csv;
  # alle Dateien OHNE Kopfzeile nacheinander ausgeben
  tail --lines=+2 -q ?.csv
# Befehlsgruppe schliessen und Ausgabe in Datei bündeln
) > Daten-gesamt.csv
```

### Use case - Tabellen "spaltenweise erweitern"

Nun haben wir Tabellen, die z.B. die gleiche Zeilenanzahl aufweisen und in jeweiligen Zeilen Teilinformationen (Spalten) beinhalten.
Hier möchten wir ggf. die Spalten aus mehreren Tabellendateien in eine neue Tabelle vereinigen.

```sh
# "horizontales Zusammenkleben" von zwei Tabellen
paste -d";" erste-spalten.csv naechste-spalten.csv > gesamt.csv
```

### Use case - Alle `.csv` Dateien nach der zweiten Spalte sortieren und wieder abspeichern

Wir haben mehrere Tabellen im `.csv` Format, benötigen diese aber in sortierter Form.
Um manuelles Bearbeiten zu vermeiden können wir folgendes tun.

```sh
# über alle .csv Dateien iterieren, d.h. für jede das Folgende tun
for f in *.csv; do
  # Datei umbenennen, damit Dateiname für Zieldatei wieder zur Verfügung steht
  mv $f sicherheitskopie;
  # Datei sortieren und wieder unter Originalnamen abspeichern
  sort -t";" -k2 sicherheitskopie > $f
  # Sicherheitskopie löschen
  rm -f sicherheitskopie
done
```

Auch hier müssen wir ggf. um das Problem "herumarbeiten", dass Tabellenköpfe nicht als erste Zeile erhalten bleiben, sondern alle Zeilen gleichberechtigt sortiert werden.
Aber auch hier hilft uns der Trick von oben, d.h. zweistufiges Arbeiten.


```sh
# über alle .csv Dateien iterieren, d.h. für jede das Folgende tun
for f in *.csv; do
  # Datei umbenennen, damit Dateiname für Zieldatei wieder zur Verfügung steht
  mv $f sicherheitskopie;
  # Befehlsgruppe starten
  (
    # Tabellenkopf ausgeben
    head -n 1 sicherheitskopie;
    # Datei sortieren, aber erste Zeile weglassen 
    tail --lines=+2 sicherheitskopie | sort -t";" -k2 
  # Ausgaben zusammenführen und wieder unter Originalnamen abspeichern
  ) > $f
  # Sicherheitskopie löschen
  rm -f sicherheitskopie
done
```

## Archivierung

### Use case - Dateien sichern und vorhandene mit Zeitstempel backupen

Wir haben einen Satz an Dateien, welcher wiederkehrend in einem bestimmten Verzeichnis gesichert werden soll.
Im Zielverzeichnis sollen die aktuellen Dateien mit gleichem Namen beibehalten werden, weil dort auch andere Mitarbeiter auf diese zugreifen.
Allerdings sollen vorhandene Dateien mit dem Zeitstempel der Sicherung beibehalten werden, um die Nachvollziehbarkeit der Datenänderung zu gewährleisten.

Dies ist schon mit einem "einfachen" Kopiebefehl zu bewerkstelligen:

```sh
cp -b -S .stand-$(date +%y%m%d-%X) *-geteilte-Daten-*.xml /mnt/c/gemeinsameDateien/
```

Hierbei sorgen wir mit `-b` dafür, das vorhandene Dateien im Zielverzeichnis gebackuped werden, d.h. vorher umbenannt werden, bevor eine gleichnamige Datei ins Zielverzeichnis kopiert wird.

Der Dateiname wird dabei mit dem nach `-S` angegebenen Suffix ergänzt. 
Diese ist in diesem Fall `.stand-ZEITSTEMPEL`, wobei der Zeitstempel mittels `date` Befehl automatisch bestimmt und angehangen wird. 
Das Format des Zeitstempels (hier "JahrMonatTag-Zeit") ist detailliert mittels `date` einstellbar.
