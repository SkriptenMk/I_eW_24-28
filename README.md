# Quarto Website — Kurzanleitung zum Rendern

Dieses Repository enthält Kursmaterialien als Quarto-Website.<br/>
Kurze Anleitung, wie du die Seite lokal renderst.<br/>
Es gibt eine vorbereitete DevContainer-Umgebung, die alle notwendigen Tools beinhaltet.

## Übersicht
- Quarto-Quellen: `*.qmd`, `*.md` (Root und `files/`, `lektionen_*`)
- Site-Output: `docs/` (wird durch `quarto render` erzeugt)

## Empfohlen: Mit VS Code DevContainer
1. In VS Code das Projekt öffnen.
2. F1: `Dev Containers: Rebuild and Reopen in Container` (erstes Mal oder nach Dockerfile-Änderungen).
3. Öffne ein Terminal in VS Code (läuft nun im Container).
4. Prüfen, ob Quarto installiert ist:

```bash
quarto --version
```

5. Live-Preview (entwickeln):

```bash
quarto preview
```

6. Statisches Site-Build (produktiv):

```bash
quarto render
# Ausgabe landet in `docs/` (siehe `_quarto.yml`)
```

weitere Dateien nach docs kopieren (zBsp Dateien zum Download)

```bash
python3 scripts/copy_notebooks_to_docs.py --ext ipynb,txt,pdf
````

Links auf `.ipynb`-Dateien fixen (Quarto ersetzt diese durch html links... wieso auch immer...)<br/>
Achtung im Zusammenhang mit preview funktioniert das nicht, da preview Seite erst rendert, wenn sie im Browser geöffnet wird... und logisch wieder html links drin sind...

```bash
python3 scripts/fix_notebook_links.py
```


Hinweis: Die DevContainer-Dockerfile pinnt eine Quarto-Version und lädt automatisch das passende .deb für die Container-Architektur (amd64/arm64). Wenn du die Dockerfile änderst, rebuild den Container.

## Alternative: Manuell per Docker (ohne VS Code)
Im Ordner `.devcontainer` existiert ein Dockerfile. Beispiel (aus `.devcontainer/`):

```bash
# docker build -t quarto-devcontainer -f .devcontainer/Dockerfile ..
# docker run --rm -it -v "$(pwd):/workspace" -w /workspace quarto-devcontainer bash
```

Danach im Container die oben genannten `quarto`-Befehle ausführen.

## Troubleshooting
- `quarto: command not found`: Container nicht neu gebaut / Quarto nicht installiert — Rebuild des DevContainer oder manuelle Installation im Container.
- `Invalid archive signature` beim Installieren einer `.deb`: Download war beschädigt (404/HTML). Lösche `/tmp/quarto.deb` und lade die richtige Asset-URL herunter (DevContainer benutzt eine gepinnte Version).
- PDF/LaTeX-Fehler: Fehlende LaTeX-Pakete. Ergänze die Dockerfile um zusätzliche `texlive-...` Pakete (z. B. `texlive-lang-german`, `texlive-pictures`) und rebuild den Container.
