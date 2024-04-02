

# Projekt - Datenextraktion aus PDF

Das US Department of State publiziert am Ende jeden Jahres einen Bericht, der die Anzahl der erteilten Einwanderungsvisa nach Herkunftsland für jede Visakategorie auflistet. 
Leider wird die Information zu jedem Fiskaljahr als separate pdf-Datei bereitgestellt. 
Die Originalen Informationen des US Department of State finden Sie [hier](https://travel.state.gov/content/travel/en/legal/visa-law0/visa-statistics/annual-reports.html).
Wenn sie auf ein Fiskaljahr klicken, finden Sie eine Vielzahl von Links zu verschiedenen pdf-Dateien. 
Die relevanten Daten finden sich in *Table III: Immigrant Visas Issued (by Foreign State of Chargeability or Place of Birth): Fiscal Year YYYY*

Ein Beispiel für die pdf-Dateien finden Sie [hier](FY2023_AR_TableIII.pdf).


## Aufgabe

Wir wollen die Informationen aus den pdf-Dateien extrahieren und in einem CSV-Format abspeichern.

Zudem sollen anschließend die Informationen für Deutschland in einer separaten CSV-Ausgabe extrahiert werden.


## Schritte

(1) Laden sie die pdf-Dateien für die Jahre 2021 bis 2023 mit `wget` herunter und speichern sie diese in einem Verzeichnis ihrer Wahl.

(2) Erzeugen sie ein Bash-Skript, welches aus EINER pdf-Datei die Tabelleninformationen in validem CSV-Format abspeichert bzw. ausgibt.
Hierbei ist zu beachten:

- Tabellenkopf muss gelistet sein
- das CSV Format soll ";" als Trennzeichen verwenden
- Verwenden sie `pdf2ps` zusammen mit `ps2ascii` um den Inhalt der pdf-Datei im Textformat zu extrahieren
- Verwenden sie `grep` (ggf. mehrfach) um die relevanten Zeilen zu extrahieren
  - Ignorieren sie
    - Kontinentinformationszeilen
    - Zeilen, die Staatenteile beschreiben, z.B. "Western Sahara
    - Zeilen, die keine Zahlen enthalten
    - Zeilen, die nur die Gesamtsumme enthalten
- Verwenden sie `sed` um die relevanten Informationen in CSV-Format zu konvertieren
- Stellen sie sicher, dass alle erzeugten Zeilen auch die korrekte Anzahl Spalten aufweisen (ggf. mit `awk` prüfen; Zeilen mit falscher Anzahl Spalten ausgeben, Skript ggf. anpassen oder am Ende ggf. ignorieren/entfernen)
- ggf. müssen sie temporäre Dateien erzeugen, um Zwischenschritte zu speichern
  - löschen sie erzeugte temporäre Dateien am Ende des Skripts
- Testen sie ihr Skript mit mindestens einer der heruntergeladenen pdf-Dateien

(3) Schreiben sie ein Auswertungsskript welches

- die `wget` Aufrufe von (1) ausführt
- ihr Skript aus (2) mit Hilfe eines for-loops auf alle drei gedownloadeten pdf-Dateien anwendet
- die Daten für Deutschland extrahiert und *auf der Konsole* ausgibt
  - eine Zeile pro Jahr
  - das Jahr soll in einer führenden Spalte gelistet sein
  - gültiges CSV-Format der Ausgabe (Kopfzeile, Trennzeichen ";")

(4) Generalisierung

- Schreiben sie ihr Skript aus (4) so um, dass es das Land der Wahl als Kommandozeilenargument akzeptiert
- Verwenden sie als Standardwert "Germany"
- Testen sie ihr Skript mit einem weiteren Land ihrer Wahl
- Unterstützen sie auch Länder, die mehrere Wörter im Namen haben, z.B. "United States"

(5) Dokumentation

- Erstellen sie eine `README.txt` Datei, die ihr Projekt und die erstellten Skripte beschreibt
- Listen sie darin *alle* verwendeten Konsolenprogramme, um die Abhängigkeiten ihrer Skripte zu dokumentieren
- Ergänzen sie ihre zwei Skriptdateien mit hinreichenden Kommentaren, um die Funktionsweise und Arbeitsschritte zu erklären

## Hinweise

Alle Schritte sollen hierbei in Bash-Skripten durchgeführt werden.
Verwenden sie keine manuellen Schritte, um die Daten zu extrahieren bzw. anzupassen.
Ihre Skripte müssen auf einem fremden System lauffähig sein und das gleiche Ergebnis produzieren.


Diese Aufgabenbeschreibung wurde mit Unterstützung von GitHub Copilot erstellt.
