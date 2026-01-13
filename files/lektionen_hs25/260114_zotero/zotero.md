# Managing a Bibliography with Zotero

Zotero calls itself a personal research assistant. For high school
students, it is a tool to for managing citations in their texts. In
addition, Zotero can act as an e-reader with useful note-taking
functions. 

## Zotero Installation and Set-Up

To use Zotero's full functionality, an optional Zotero account must be
set up. This can be done on the 
[Zotero](https://www.zotero.org/user/register) website. If you plan to
use Zotero for purposes other than strictly private ones, use your school or
business email address respectively. The user profile allows multiple email
addresses. This means that you can keep your database if you leave your
current organisation.

After setting up your optional personal account, you can download and
install the [Zotero Desktop Client](https://www.zotero.org/download/).
On the same website you see the possibility to install the Zotero
connector plugin for your browser. This plugin is not strictly
necessary but it simplifies the collection of sources in your database. 

As soon Zotero is installed on your computer, your installation can be
linked to your Zotero account (Edit > Settings, Sync Tab).

In the Markdown -- Pandoc-Workflow you need the
[BetterBibTeX](https://retorque.re/zotero-better-bibtex/)
plugin. The Plugin can be downloaded from ist [GitHub
Repository](https://github.com/retorquere/zotero-better-bibtex/releases/latest).
To install the downloaded `.xpi` file, go to Tools > Plugins, Cogwheel >
Install Plugin From File... After you have installed the plugin, you may
delete the `.xpi` file.


## Einträge in Zotero erstellen und organisieren {#sec-zotero_entry}

Wie Einträge in Zotero erfasst werden, wird auf der Website von Zotero
ausführlich beschrieben. An dieser Stelle darf daher auf die dortigen
[Erklärungen](https://www.zotero.org/support/adding_items_to_zotero)
verwiesen werden. Das gleiche gilt für die
[Organisation](https://www.zotero.org/support/collections_and_tags) der
eigenen Bibliothek. 

## Erstellen einer Bibliographie Datei für den Markdown -- Pandoc-Workflow

Die für das jeweilige Projekt erforderlichen Einträge in Zotero werden
sinnvollerweise in einer Sammlung zusammengefasst. Diese Sammlung kann dann
in eine `.bib` Datei exportiert werden. Dazu ist das Kontextmenü der
Sammlung mit Rechtsklick zu öffnen. Anschliessend ist der Menüpunkt
'Sammlung Exportieren' auszuwählen. In der sich öffnenden Dialogbox ist
Better BibLaTeX als Format auszuwählen. Sinnvollerweise werden die beiden
Optionen 'Halte aktuell' und 'Hintergrund-Export' ausgewählt. Die erste
Option sorgt dafür, dass Änderungen in Zotero-Einträgen automatisch in die
`.bib` Datei geschrieben werden, die zweite verhindert, dass der Export
einfriert.  
Standardmässig erhält die so erstellte `.bib` Datei den Namen der
Sammlung. Der Name kann während des Erstellens noch angepasst werden.
Falls der Name nachträglich angepasst wird, ist nicht sichergestellt,
dass die automatische Aktualisierung weiterhin funktioniert. Falls man dem
Automatismus nicht vertraut, kann die `.bib` Datei nach jeder Änderung
manuell neu aus Zotero exportiert werden.