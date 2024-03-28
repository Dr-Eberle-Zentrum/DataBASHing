
# Projekt - Bilddatenverarbeitung

## Aufgabe

- Bilddaten aufarbeiten
  - check Dateiformat via `identify` (`imagemagick` package) und benenne Dateiendung entsprechend um (lower case)
  - EXIF daten via `exiftool` [tutorial](https://www.baeldung.com/linux/exif-data-read-change)
    - früheste Modifikationszeit (`Date`) auslesen; [Hinweis](https://unix.stackexchange.com/questions/84381/how-to-compare-two-dates-in-a-shell)
    - Dateinamen nach festem Muster mit Zeitdaten umbenennen
    - Personalisierte Information (`Artist`,`XPAuthor`,`GPSInfo`) entfernen
  - Thumbnail fester Größe via `convert` (`imagemagick` package) in unterordner erstellen


- HTML Datei erstellen
  - Überschrift
  - tabelle aller Bilddateien
    - Thumbnail + Dateiname anzeigen
    - beides gemeinsam mit Komplettbild verlinken
    - aus EXIF Information Dateigröße und Bildauflösung anzeigen
  - Autoreninformationen
  - Datum/Zeitpunkt der Erstellung


