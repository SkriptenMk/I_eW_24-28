# References in Plain Text Writing (Markdown)

Three additional files are required to insert references in Markdown
files: 

* a file for information about the text format (`.yaml`),
* a file for bibliographical information (`. bib`), and
* a file for display format of the bibliographical information (`.bib`).

Out of these three files only the one containing text format information
has to be created manually.
Zotero will create the `.bib` file and the `.csl` file can be downloaded
from the [Zotero Style Repository](https://www.zotero.org/styles).


## Text Format File (.yaml)

The `.yaml` file controls both the styling of the text and the output
format. The file can be given any name. Because the file is responsible
for the formatting of the text in this tutorial the file is
called `format.yaml`. The following listing shows an example that uses
both a `.bib` file and a `.csl` file.


```yaml
# input and output
input-files:
  - my-text.md  # there can be more files
  # - second_part.md
  # - thrid_part.md
output-file: output.pdf

# basic settings
from: markdown
to: pdf
# lualatex is better for special characters
pdf-engine: lualatex # or xelatex, pdflatex

# activate citeproc - responsible for loading the bibliography
citeproc: true

table-of-contents: true

# variables und metadata
variables:
  lang: en # for Switzerland: de-CH
  lof: true
  lot: true
  number-sections: true
  header-includes:
    - \setcounter{secnumdepth}{3}
    - \setcounter{tocdepth}{3}

metadata:
  title: "Title of the Documnt"
  author: "Authors Name"
  date: "Today"
  bibliography: bibliography.bib
  csl: chicago-notes-bibliography-access-dates.csl
  link-citations: true
```

Hier die Erklärungen zu den einzelnen Einträgen in dieser
Konfigurationsdatei:

* `input-files` Hier werden alle Dateien erfasst, welche in das finale
  Ausgabedokument einfliessen sollen. Die einzelnen Dateien werden wie
  in der Vorlage angedeutet untereinander als Aufzählung aufgelistet.
* `output-file` Mit diesem Schlüssel wird der Pfad zur Ausgabedatei
  mit deren Namen erfasst.
* `from` ist der Schlüssel für das Format der `input-files`.
* `to` ist der Schlüssel für das Format des `output-file`.
* `pdf-engine` legt fest, mit welchem Programm das Markdown Dokument in
  eine PDF Datei umgewandelt wird. Aktuell ist `lualatex` die modernste
  Variante. `lualatex` unterstützt Schweizerische Umlaute und Akzente
  sehr gut. Aus diesem Grund wurde hier `lualatex` ausgewählt.
* `citeproc` ist das Programm, dass für die Übernahme der
  bibliographischen Angaben verantwortlich ist. Mit dem Wert `true` wird
  dessen Verwendung aktiviert.
* `table-of-contents` aktiviert, wenn der Wert `true` ist, die
  Erstellung eines Inhaltsverzeichnisses.
* `variables` stellt die Details für die Darstellung des
  Ausgabedokuments zur Verfügung.
* `lang` ist die Variabel zur Speicherung der Sprache des
  Ausgabedokuments. Indem sie hier auf `de-CH` gesetzt wird, werden die
  typographischen Besonderheiten der Deutschschweiz berücksichtigt.
* `lof` erstellt ein Abbildungsverzeichnis.
* `lot` erstellt ein Tabellenverzeichnis.
* `number-sections` nummeriert die Titel ihrer Hierarchiestufe gemäss.
* `header-includes` ermöglicht es, LaTeX Formatierungsbefehle zu
  verwenden. 
* `- \setcounter{secnumdepth}{3}` ist eine LaTeX Formatierung, die dafür
  sorgt, dass Titel nur über drei Hierarchieebenen hinweg nummeriert
  werden. 
* `- \setcounter{tocdepth}{3}` ist eine LaTeX Formatierung, welche nur
  Titel bis zur dritten Hierarchieebene ins Inhaltsverzeichnis
  aufgenommen werden.
* `metadata` speichert die inhaltlichen Eckwerte für das Dokument.
* `title` ist jener Titel, der auf dem Deckblatt abgedruckt wird.
* `author` ist der Name des Autors.
* `date` ist das Datum. Für Dokumente, welche ein PDF als Ausgabeformat
  haben, kann auch der Befehl \today verwendet werden. Dieser liest bei
  der Konvertierung von Markdown zu PDF das aktuelle Systemdatum aus.
* `bibliography` gibt den Pfad zur Datei mit den bibliographischen
  Angaben an.
* `csl` gibt den Pfad zur Datei mit dem gewählten Zitierstil an.

Weitere Konfigurationsmöglichkeiten für die Konvertierung in ein PDF
finden sich [Pandoc User Guide](https://pandoc.org/MANUAL.html).

## Bibliographische Angaben

Das Dokument mit den bibliographischen Angaben kann Zotero automatisch
erstellen. Trotzdem wird hier ein Beispiel eines Eintrags in diesem
Dokument erklärt. Das Dokument für das Beispiel heist
`bibliography.bib`.

```bib
@book{healy2020,
  title = {The {{Plain Person}}'s {{Guide}} to {{Plain Text Social Science}}},
  author = {Healy, Kieran},
  year = 2020,
  }
```

Der Eintrag bezieht sich auf ein Buch (`@book`). Unmittelbar auf diesen
Identifikator folgt nach der geschweiften Klammer der Zitierschlüssel
(`healy2020`). Dieser wird von Zotero grundsätzlich automatisch
vergeben, kann aber auch manuell festgelegt werden. Anschliessend folgen
Zeile für Zeile die notwendigen bibliographischen Angaben als Schlüssel
\- Werte Paare.

## Zitierstil

Der Zitierstil wird in einem Dokument mit der Endung `.csl` definiert.
Die Abkürzung csl steht für Citation Style Language und ist eine Form
von [xml](https://de.wikipedia.org/wiki/Extensible_Markup_Language).
Grundsätzlich ist es möglich, eigene csl Definitionen zu verfassen. Das
[Zotero Style Repository](https://www.zotero.org/styles) stellt jedoch
die gängigsten Zitierstile zur Verfügung. 

## Einfügen von Referenzen in Markdown

Um Referenzen aus dem Bibliographie Dokument in den Markdown Text zu
übernehmen, verwendet man den Zitierschlüssel. Eingefügt wird er mit
`[@zitierschlüssel]`. Soll die Referenz mit einer Seitenzahl versehen
werden, wird der Eintrag folgendermassen ergänzt: `[@zitierschlüssel,
25]`. Sollen in der gleichen Referenz mehrere Belege angeführt werden,
sieht die Syntax folgendermassen aus : `[@zitierschlüssel1, 25;
@zitierschlüssel2, 33]`.

Die Zitierschlüssel braucht man nicht auswendig zu wissen. Die Zotero
Einträge zeigen sie als obersten Eintrag zu jedem erfassten Werk an.

## Erstellen des PDF mit Referenzen

Sofern ein entsprechendes Konfigurationsdokument (`.yaml`) erstellt
worden ist, kann das PDF mit dem Aufruf

```bash
pandoc -d format.yaml
```

erstellt werden.
