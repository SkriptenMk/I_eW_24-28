# Devcontainer für dieses Quarto-Projekt

Um unabhängig von lokalen Installation zu sein, wurde eine devcontainer eingerichtet.<br>
Der Devcontainer wird als Docker Container gestartet.<br>
Das Projektverzeichnis wird in den Container ge-mounted.<br>
Beim Öffnen des Projektes mit VSCode, schlägt VSCode vor, den Devcontainer zu starten.<br>
Man arbeitet dann im lokalen Verzeichnis, hat aber über den Devcontainer die Tools für das Projekt zur Verfügung.

**Alle notwendigen Dateien wurden unter intensiver Nutzung mit KI generiert, nicht alles ist vollständig reviewed und plausibilisiert. Bei den ersten Durchläufen, hat es aber funktioniert**

Will man ohne Devcontainer arbeiten, so kann man das Projekt öffnen, ohne den Devcontainer zu starten.<br>
Dann nutzt man die selber lokal installierten Tools.

## Kurzanleitung

Das ist nur eine kurze Anleitung.<br>
Die Details sind weiter unten erklärt.

Alle Befehle im Terminal von VSCode ausführen.

```bash
#Preview starten, um während der Entwicklung die Seite im Browser zu sehen
quarto preview

# Seite auf github publizieren, folgende Schritte sind notwendig:
# ----------------------------
# 1. Render nach docs
quarto render

# 2. weitere Dateien nach docs kopieren (Dateien zum Download)
python3 scripts/copy_notebooks_to_docs.py --ext ipynb,txt,pdf

# 3. Links auf `.ipynb`-Dateien fixen (Quarto ersetzt diese durch html links)
#Achtung im Zusammenhang mit preview funktioniert das nicht, da preview Seite erst rendert, wenn sie im Browser geöffnet wird.
python3 scripts/fix_notebook_links.py

# Weitere Möglichkeiten...

# Beispiele, wenn nur eine Datei ge-rendert werden soll
quarto render index.qmd --execute --no-cache
quarto render files/lektionen_hs25/251105_symetricencryption/symetricencryption.qmd --execute --no-cache
quarto render files/lektionen_hs25/251105_symetricencryption/chapter/xor_encryption.ipynb --execute --no-cache

```

## Details zum Devcontainer

Diese DevContainer-Konfiguration stellt eine Entwicklungsumgebung bereit, in der Quarto und eine LaTeX-Umgebung (XeLaTeX) installiert sind. Damit kannst du die Website bauen und PDF-Ausgaben erzeugen.<br>
Weiter ist eine Phython Umgebung vorhanden, so dass die Jupiterlabs des Projektes ausgeführt werden können.

### Dateien für den Devcontainer

- `.devcontainer/Dockerfile` 
    — baut ein Ubuntu-basiertes Image mit Quarto CLI und einer minimalen TeX-Installation (`xelatex`).
- `.devcontainer/devcontainer.json` 
    — VS Code DevContainer-Konfiguration.

### Container starten

Schnellstart
1. Öffne das Projekt in VS Code.
2. Drücke F1 → `Remote-Containers: Reopen in Container` (oder verwende das grüne Remote-Icon). VS Code baut dann das Image (das erste Mal kann es einige Minuten dauern).

## Quarto rendern

Quarto rendert die Daten aus dem Verzeichns _files: in das Verzeichnis _docs_.<br>
Pusht man das Projekt auf github, so wird das Verzeichnis docs via githubpages publiziert.<br>
https://skriptenmk.github.io/I_eW_24-28/

Auswahl von Befehlen für Quarto

- Terminal in VS-Code öffnen und Befehl eingeben

**Um die Website lokal rendern und eine Vorschau zu starten:**

```bash
quarto preview
```

**Um die komplette Seite zu rendern (statische Ausgaben in `docs/`):**

```bash
quarto render
```

**Für PDF-Ausgabe einer einzelnen Datei**

```bash
quarto render path/to/file.qmd --to pdf
```

## Extra: Notebooks/Assets in `docs/` kopieren

Wenn du sicherstellen willst, dass zusätzliche Dateien (z. B. `.ipynb`, `.txt`, `.pdf`)
unter `docs/` landen und über GitHub Pages erreichbar sind, führe nach dem Rendern
das mitgelieferte Kopier‑Script aus. 

**Trockenlauf, ohne wirklich zu kopieren**

```bash
python3 scripts/copy_notebooks_to_docs.py --dry-run --ext ipynb,txt,pdf
```

**Kopieren ausführen**

```bash
python3 scripts/copy_notebooks_to_docs.py --ext ipynb,txt,pdf
```

**Zuerst Trockenlauf, dann kopieren**

Du kannst beide Schritte auch in einer Zeile koppeln (die Kopie läuft nur, wenn das Rendern erfolgreich ist):

```bash
quarto render --execute --no-cache && python3 scripts/copy_notebooks_to_docs.py --ext ipynb,txt,pdf
```

## Nachbearbeitung der Links

Das ein bisschen ein Hack (habe in der Kürze noch keine besser Lösung).

Manchmal wandelt Quarto in der gerenderten HTML Verweise auf Notebooks in `.html`-Links um.<br>
Aufgefallen ist mir das bei `.ipynb`-Dateien.<br>
Die Links haben aber die Idee die orginalen `.ipynb`-Dateien als Link zur Verfügung zu stellen.<br>
Dazu dient das folgende Script `copy_notebooks_to_docs.py`.<br>

Das Skript sucht in `docs/` nach `.html`-Links und ersetzt sie durch relative Pfade zu vorhandenen `.ipynb`-Dateien im `docs/`-Baum.

Sicherheit: Das Skript ist vorsichtig und ersetzt standardmäßig keine Links, die auf tatsächlich vorhandene HTML-Seiten verweisen. Wenn du dennoch eine Ersetzung erzwingen willst (z. B. weil Quarto eine `.html`-Seite mit demselben Namen generiert hat, du aber stattdessen auf das `.ipynb` verlinken möchtest), verwende die Option `--force`.

**Dry Run**

```bash
python3 scripts/fix_notebook_links.py --dry-run
```

**Fix ausführen**

```bash
python3 scripts/fix_notebook_links.py
```

**force**

```bash
python3 scripts/fix_notebook_links.py --force
```

## Hinweis

- Wenn du zusätzliche LaTeX-Pakete benötigst, kann es nötig sein, das Dockerfile zu erweitern (z. B. `texlive-pictures`, `texlive-lang-german` usw.).
- Die DevContainer-Konfiguration legt das Arbeitsverzeichnis unter `/workspace` und verwendet den Benutzer `vscode`.

Manueller Docker-Build (optional)

Wenn du VS Code nicht verwenden möchtest, kannst du das Image manuell bauen und einen Container starten:

```bash
# aus dem Ordner .devcontainer (ein Verzeichnis höher als das Projekt-Root)
docker build -t quarto-devcontainer -f .devcontainer/Dockerfile ..

docker run --rm -it \
	-v "$(pwd):/workspace" \
	-w /workspace \
	quarto-devcontainer bash
```

Im Container kannst du dann `quarto render` oder `quarto preview` ausführen.
