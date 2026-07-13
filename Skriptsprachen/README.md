

# Skriptsprachen in der Shell

- [R session](R-session.md)
- [Python session](Python-session.md)

# Diskussionspunkte

- ? Wie führe ich ein Script aus?
  - `PATH` Variable
  - WSL: .exe Problem > Wrapper in `~/bin`
- ? Interaktion mit der Shell
  - `STDIN`, `STDOUT`, `STDERR`
  - `exit` value
- ? Parameterübergabe
  - Fixed order vs. Argument parser
- ? Wann ist mein Tool "pipe-ready"?
  - optionales `STDIN > STDOUT` setup statt file-only
- ? Was wird nun wichtig?
  - Input check, Fehlermeldungen
  - Doku *OHNE* ins Script zu schauen
