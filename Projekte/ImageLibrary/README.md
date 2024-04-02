
# Projekt - Bilddateiverarbeitung

Bilddateien sind eine der häufigsten Dateiformate, die im Internet geteilt werden.
Auch in vielen Arbeits- und Forschungsbereichen fallen Bilddateien an, die aufbereitet und geteilt werden müssen.
Hierbei stammen diese häufig aus unterschiedlichen Quellen und sind in unterschiedlichen Formaten gespeichert.
Zudem enthalten Bilddateien oft Metadaten, die Informationen über das Bild und den Autor enthalten.
Derartige Informationen sind i.d.R. im [EXIF-Format](https://de.wikipedia.org/wiki/Exchangeable_Image_File_Format) direkt in der Bilddatei mitgespeichert.


## Aufgabe

Ziel des Projektes ist es, eine gegeben Sammlung von Bildern aufzubereiten und in einer HTML-Datei mit Hilfe von Thumbnails und Metadaten zu präsentieren.


## Schritte

(1) Laden sie sich via `wget` die folgende [Archivdatei](Bilddaten.tar.gz) mit Bilddateien herunter 

Verwenden sie den [`Raw` Link der Datei](https://zapier.com/blog/how-to-download-from-github/) von der GitHub Webseite als URL für den Download.

Packen sie die heruntergeladene Archivdatei mit Hilfe eines Kommandozeilenprogramms in einem Ordner ihrer Wahl aus.

Der darin enthaltene Ordner wird im Folgenden als `Rohsammlung` bezeichnet.

(2) Erstellen sie ein Bash-Skript, das folgende Schritte zur Bilddateiaufarbeitung durchführt:

- Erstellen sie einen Unterordner `Bildsammlung` im gleichen Verzeichnis wie die `Rohsammlung`

Jedes Bild aus der `Rohsammlung` soll in den Unterordner `Bildsammlung` kopiert und anschliessend wie folgt verarbeitet werden.

- Dateiformat via `identify` prüfen (`imagemagick` package) und Dateiendung entsprechend umbenennen (lower case)
- EXIF Daten via `exiftool` bearbeiten ([Tutorial](https://www.baeldung.com/linux/exif-data-read-change))
  - Personalisierte Information (`Artist`, `XPAuthor`, `GPSInfo`, `Software`) entfernen
  - früheste Modifikationszeit/-datum auslesen  ([Hinweis](https://unix.stackexchange.com/questions/84381/how-to-compare-two-dates-in-a-shell))
- Dateinamen nach festem Muster mit Zeitdaten umbenennen: `YYYYMMDD_HHMMSS.[Dateiendung]`
- Thumbnail fester Größe via `convert` (`imagemagick` package) erstellen:
  - Dateityp `JPEG`
  - Dateinamenmuster `YYYYMMDD_HHMMSS.small.jpg` (gleicher Ordner wie Originaldatei, d.h. `Bildsammlung`)
  - maximale Auflösung pro Dimension 100 Pixel (Seitenverhältnis beibehalten)

(3) Erstellen sie ein weiteres Bash-Skript, das folgende Schritte zur HTML-Präsentation durchführt:

Das Skript soll später im Ordner `Bildsammlung` ausgeführt werden.

- erstellen einer HTML Datei `index.html` im aktuellen Ordner
  - Überschrift
  - Tabelle aller Bilddateien im aktuellen Ordner *(ja, ja, HTML-Tabellen sind nicht mehr zeitgemäß, aber hier passend)*
    - Thumbnail + Dateiname anzeigen
    - beides gemeinsam mit Komplettbild verlinken
    - aus EXIF Information Dateigröße und Bildauflösung anzeigen
    - alle Links *OHNE PFADANGABE*, d.h. nur Dateiname
  - eigene Autoreninformationen
  - Datum/Zeitpunkt der Erstellung der HTML-Datei

(4) Dokumentation

- Erstellen sie eine `README.txt` Datei, die ihr Projekt und die erstellten Skripte beschreibt
- Listen sie darin *alle* verwendeten Konsolenprogramme, um die Abhängigkeiten ihrer Skripte zu dokumentieren
- Ergänzen sie ihre zwei Skriptdateien mit hinreichenden Kommentaren, um die Funktionsweise und Arbeitsschritte zu erklären


## Hinweise

Alle Schritte sollen hierbei in Bash-Skripten durchgeführt werden.
Verwenden sie keine manuellen Schritte, um die Daten zu extrahieren bzw. anzupassen.
Ihre Skripte müssen auf einem fremden System lauffähig sein und das gleiche Ergebnis produzieren.


Diese Aufgabenbeschreibung wurde mit Unterstützung von GitHub Copilot erstellt.
