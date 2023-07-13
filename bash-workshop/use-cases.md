
# Anwendungsbeispiele

Im Folgenden wollen wir einige Anwendungsbeispiele zeigen, bei denen die Shell zum Einsatz kommt.


- [**Tabellarische Daten verarbeiten**](#tabellarische-daten-verarbeiten)
  - [Tabellen "untereinander hängen"](#use-case---tabellen-untereinander-h%C3%A4ngen)
  - [Tabellen "spaltenweise erweitern"](#use-case---tabellen-spaltenweise-erweitern)
  - [Alle `.csv` Dateien nach der zweiten Spalte sortieren und wieder abspeichern](#use-case---alle-csv-dateien-nach-der-zweiten-spalte-sortieren-und-wieder-abspeichern)
- [**Textverarbeitung**](#textverarbeitung)
  - [Schnelle Suche welche Datei einen bestimmten Eintrag hat](#use-case---schnelle-suche-welche-datei-einen-bestimmten-eintrag-hat)
  - [Vorkommen von Textmustern zählen](#use-case---vorkommen-von-textmustern-z%C3%A4hlen)
  - [XML Dokumente vereinen - z.B. `.rdf` Dateien für Zotero](#use-case---xml-dokumente-vereinen---zb-rdf-dateien-f%C3%BCr-zotero)
- [**Archivierung**](#archivierung)
  - [Dateien sichern und vorhandene mit Zeitstempel backupen](#use-case---dateien-sichern-und-vorhandene-mit-zeitstempel-backupen)


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

## Textverarbeitung

Die `.rdf` Dateien, die im Folgenden verwendet werden, können sie [hier als `rdf-example.tar.gz`](rdf-example.tar.gz) zusammengefasst herunterladen.

Oder mittels folgenden Befehlen:

```sh
# Archivdatei downloaden
curl -O https://raw.githubusercontent.com/Dr-Eberle-Zentrum/DataBASHing/bash-workshop/bash-workshop/rdf-example.tar.gz
# Dateien aus Archivdatei auspacken
tar -xzf rdf-example.tar.gz
```

Am Ende sollten folgende Dateien im Ordner vorliegen (mittels `ls` geprüft):

```sh
# ls Ausgabe nach "curl" und "tar" Aufruf in vormals leerem Verzeichnis
items_1.rdf  items_2.rdf  items_3.rdf  items_4.rdf  rdf-example.tar.gz
```


### Use case - Schnelle Suche welche Datei einen bestimmten Eintrag hat

Wir haben eine große Anzahl an Dateien und wissen derzeit nicht, in welcher eine bestimmte Information abgespeichert ist.
Allerdings wissen wir ein zu unserer Information passendes Schlagwort, welches in der entsprechenden Datei enthalten ist.

Konkret haben wir mehrere Bibliographiedateien im `.rdf` Format und suchen die Datei, welche die Bibliographiedaten für den Autor mit Nachnamen "Park" enthält.
Nun könnten wir die Dateien nacheinander öffnen und nach dem Begriff suchen, oder wir verwenden `grep`, das Zaubertool zur Textsuche.

```sh
grep Park *.rdf
```

liefert

```sh
items_2.rdf:          <foaf:surname>Park</foaf:surname>
items_4.rdf:  <dcterms:abstract>Introd [...] Exploring Parker 2.0 / Andrew Prescott [...]
```

Zwar haben wir damit unsere Suche erfolgreich beendet und wissen, dass `items_2.rdf` den gewünschten Eintrag enthält, aber wir sehen schon, das unser Suchmuster `Park` doch recht unspezifisch war, da es auch die Datei `items_4.rdf` liefert, da diese eine Zeile mit dem Wort `Parker` besitzt.
Hier kommen nun *reguläre Ausdrücke* ins Spiel, welche der Zweck für `grep` sind.

```sh
# mit word boundaries --> immer noch Wortlokalisation in anderem Kontext möglich !!!
grep -P "\bPark\b" *.rdf
# mit flankierenden XML tags (aber Platz für Leerzeichen) für möglichst konkreten Treffer
grep -P "<foaf:surname>\s*Park\s*</foaf:surname>" *.rdf
```

Hierbei sorgt `-P` dafür, dass die `Perl`-spezifische Erweiterung regulärer Ausdrücke verwendet wird.
Ansonsten wird nur ein eingeschränktes RegEx Vokabular (BRE) verstanden oder mit `-E` "erweiterte" reguläre Ausdrücke (ERE).

Auch kann man die Ausgabe von `grep` sehr gut steuern.
So können wir zum Beispiel auch den Vornamen des Fundes ausgeben, indem wir mit `-A1` die nachfolgende Zeile eines jeden Fundes mitliefern lassen.

```sh
grep -A1 -P "<foaf:surname>\s*Park\s*</foaf:surname>" *.rdf
```

liefert

```sh
items_2.rdf:    <foaf:surname>Park</foaf:surname>
items_2.rdf-    <foaf:givenName>David W. [Hrsg.]</foaf:givenName>
```

was es uns ermöglicht, den Fund zu verifizieren.


### Use case - Vorkommen von Textmustern zählen

Nun könnte es uns interessieren, wieviele Einträge denn nun eigentlich in den jeweiligen Bibliographiedateien abgespeichert sind.
Auch hier kann uns `grep` direkt helfen, indem wir die `<bib` tags der Dateien zählen.

```sh
grep -c "<bib" *.rdf
```

liefert

```sh
items_1.rdf:40
items_2.rdf:29
items_3.rdf:29
items_4.rdf:29
```



### Use case - XML Dokumente vereinen - z.B. `.rdf` Dateien für Zotero

Neben dem [Vereinen von tabellarischen Daten](#use-case---tabellen-untereinander-h%C3%A4ngen) kommt es auch häufig vor, dass strukturierte Daten, wie zum Beispiel XML Dokumente, zusammengefasst werden müssen.
Ein Anwendungfall wäre zum Beispiel das *Vereinen von Bibliographiedaten im `.rdf` Format*, um diese gebündelt in Zotero zu importieren.

Solche `.rdf` Dateien starten z.B. wie folgt:

```xml
<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns:z="http://www.zotero.org/namespaces/export#"
 xmlns:dcterms="http://purl.org/dc/terms/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:bib="http://purl.org/net/biblio#"
 xmlns:vcard="http://nwalsh.com/rdf/vCard#"
 xmlns:foaf="http://xmlns.com/foaf/0.1/"
 xmlns:prism="http://prismstandard.org/namespaces/1.2/basic/">
    <bib:Book rdf:about="urn:isbn:3-518-12679-2%20978-3-518-12679-0">
        [...gekürzt...]
    </bib:Book>
</rdf:RDF>
```

Um derartige Dateien zu vereinen, müssen wir eine gültige XML Struktur beibehalten, sprich das allumschliessende `<rdfRDF [...]>` + `</rdf:RDF>` tag darf nur einmal im Dokument vorkommen und muss alle `<bib..> .. </bib..>` Teile umschliessen.

Wenn wir davon ausgehen, dass alle `.rdf` Dateien gleich strukturiert sind, sprich *alle die gleichen 9 ersten Zeilen* haben, dann können wir (analog zur Vereinigung von `.csv` Dateien mit Kopfzeilen) die ersten und letzten Zeilen explizit behandeln und mit folgendem kleinen Skript alle `.rdf` Dateien im aktuellen Verzeichnis zusammenführen.

```sh
(
# wir benötigen eine Datei, um Kopf und Fussbereich zu extrahieren
# und picken uns hier einfach die lexikographisch erste Datei der Liste
first=$(ls -AU *.rdf | head -n 1)
# Kopfausgabe = erste 9 Zeilen (einmal) ausgeben
head -n 9 "$first"
# für alle .rdf Dateien nun einzeln nur deren Einträge ausgeben
for file in *.rdf
do
  # Ausgabe des Dateiinhaltes OHNE Kopfzeilen (ab 10. Zeile) und OHNE letzte Zeile
  tail -n +10 "$file" | head -n -1
done
# letzte Zeile (einmal) ausgeben
echo $(tail -n 1 "$first")
# alles zusammengefasst en bloc abspeichern
) > gesammelte-daten.rdf 
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

*Hinweis:* Für komplexere Archivierungsaufgaben, z.B. für die Sicherung auf andere Rechner etc., steht das leistungsstarke Programm `rsync` zur Verfügung, welches wir hier aber nicht näher beleuchten.

