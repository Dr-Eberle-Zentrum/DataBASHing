## Musterlösung von Martin

Lösung für [Projekt PDF2CSV](../../PDF2CSV) mit zwei Dateien

- `PDF2CSV.sh`
- `extractStats.sh`

### Vorraussetzungen

-   pdftotext
-   grep
-   sed

### [`PDF2CSV.sh`](PDF2CSV.sh)

-   Konvertiert die Zusammenfassung der US Einwanderungsbehörde im PDF-Format in ein CSV-Format
-   Spaltennamen nur teilweise erhalten (da im PDF mehrzeilig)
-   getestet mit den Jahren 2021-2023 (einige frühere Jahre haben leicht andere Dateiformate...)

**Verwendung**

```sh
bash PDF2CSV.sh <PDF-Datei>
# oder
./PDF2CSV.sh <PDF-Datei>
```

**Ausgabe**

-   legt eine Datei `<JAHR>.csv` mit den entsprechenden Daten an
-   Das Jahr wird aus der PDF-Datei aus der Überschrift extrahiert


### [`extractStats.sh`](extractStats.sh)

- Download der Zusammenfassung der US Einwanderungsbehörde der Jahre 2021-2023 im PDF-Format
- Aufruf von `PDF2CSV.sh` für jede Datei
  - `PDF2CSV.sh` muss im gleichen Ordner liegen
- Extraktion der Information für ein gegebenes Land (Standard: "Germany") für alle Jahre

**Verwendung**

```sh
bash extractStats.sh <Land>
# oder
./extractStats.sh <Land>
```
