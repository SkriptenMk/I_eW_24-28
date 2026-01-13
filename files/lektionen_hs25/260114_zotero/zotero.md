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


## Create and organise Zotero entries {#sec-zotero_entry}

How to create new entries in Zotero is well explained on the Zotero
Website. Therefore, here just the link to the tutorial for 
[adding entries](https://www.zotero.org/support/adding_items_to_zotero)
and the 
[organisation of the entries](https://www.zotero.org/support/collections_and_tags)
respectively.

For entries from Zotero to be readable in texts, they must be referenced
using the citation key. The exact syntax for this is explained in
@sec-citation_key_syntax. Zotero creates a standard key for each entry. However,
this can be difficult to remember. It is therefore advisable to define
the citation key yourself.

To do this, enter the 'Key–Value' pair 'citation key: own_key' in the
'Extra' field of the entry's metadata. The citation key defined in this
way is saved when you exit the 'Extra' field.  
The simplest citation key is probably `authorYYYY`, where `YYYY` stands
for the four-digit year.  

## Create a `.bib` file for the Markdown -- Pandoc-workflow



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