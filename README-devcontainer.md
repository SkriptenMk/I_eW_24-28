Devcontainer für dieses Quarto-Projekt

Diese DevContainer-Konfiguration stellt eine Entwicklungsumgebung bereit, in der Quarto und eine LaTeX-Umgebung (XeLaTeX) installiert sind. Damit kannst du die Website bauen und PDF-Ausgaben erzeugen.

Was ist enthalten
- `.devcontainer/Dockerfile` — baut ein Ubuntu-basiertes Image mit Quarto CLI und einer minimalen TeX-Installation (`xelatex`).
- `.devcontainer/devcontainer.json` — VS Code DevContainer-Konfiguration.

Schnellstart
1. Öffne das Projekt in VS Code.
2. Drücke F1 → `Remote-Containers: Reopen in Container` (oder verwende das grüne Remote-Icon). VS Code baut dann das Image (das erste Mal kann es einige Minuten dauern).

Testen innerhalb des Containers
- Um die Website lokal zu rendern und eine Vorschau zu starten, öffne ein Terminal in VS Code (wird im Container ausgeführt) und führe aus:

```bash
quarto preview
```

- Um die komplette Seite zu rendern (statische Ausgaben in `docs/`):

```bash
quarto render
```

- Für PDF-Ausgabe einer einzelnen Datei:

```bash
quarto render path/to/file.qmd --to pdf
```

Extra: Notebooks/Assets in `docs/` kopieren
-----------------------------------------

Wenn du sicherstellen willst, dass zusätzliche Dateien (z. B. `.ipynb`, `.txt`, `.pdf`)
unter `docs/` landen und über GitHub Pages erreichbar sind, führe nach dem Rendern
das mitgelieferte Kopier‑Script aus. Beispiel (trockenlauf):

```bash
python3 scripts/copy_notebooks_to_docs.py --dry-run --ext ipynb,txt,pdf
```

Wenn der Dry‑Run passt, kopiere tatsächlich:

```bash
python3 scripts/copy_notebooks_to_docs.py --ext ipynb,txt,pdf
```

Du kannst beide Schritte auch in einer Zeile koppeln (die Kopie läuft nur, wenn das Rendern erfolgreich ist):

```bash
quarto render --execute --no-cache && python3 scripts/copy_notebooks_to_docs.py --ext ipynb,txt,pdf
```

Hinweis: Das einfache Kopieren in `docs/` reicht aus, damit der Link in der gerenderten HTML auf die Dateien funktioniert.
Wenn du hingegen möchtest, dass Quarto die `.ipynb` selbst als zusätzliches Output‑Format auflistet (erscheint unter "Other formats"), dann musst du Quarto anweisen, beim Rendern auch `ipynb` als Ausgabe zu erzeugen (z. B. `--to html,ipynb,pdf`).

Nachbearbeitung der Links
-------------------------

Manchmal wandelt Quarto in der gerenderten HTML Verweise auf Notebooks in `.html`-Links um. Wenn du stattdessen möchtest, dass Besucher die originalen `.ipynb`-Dateien herunterladen können, führe nach dem `copy_notebooks_to_docs.py`-Schritt das mitgelieferte Link-Fix-Skript aus (Dry‑Run zuerst prüfen):

```bash
python3 scripts/fix_notebook_links.py --dry-run
```

Wenn die Änderungen passen, ohne `--dry-run` ausführen:

```bash
python3 scripts/fix_notebook_links.py
```

Das Skript sucht in `docs/` nach `.html`-Links und ersetzt sie durch relative Pfade zu vorhandenen `.ipynb`-Dateien im `docs/`-Baum.

Sicherheit: Das Skript ist vorsichtig und ersetzt standardmäßig keine Links, die auf tatsächlich vorhandene HTML-Seiten verweisen. Wenn du dennoch eine Ersetzung erzwingen willst (z. B. weil Quarto eine `.html`-Seite mit demselben Namen generiert hat, du aber stattdessen auf das `.ipynb` verlinken möchtest), verwende die Option `--force`.

```bash
python3 scripts/fix_notebook_links.py --force
```

Hinweis
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
