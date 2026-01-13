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

For each project, you must compile all the relevant Zotero entries into
a collection. This collection can then be exported as a .bib file. To do
so, right-click on the collection and select 'Export Collection' from
the context menu. In the dialogue box, select 'Better BibLaTeX' as the
export format. Furthermore, select the "Keep Updated" and "Background
Export" options. The first option keeps your .bib file up to date, while
the second prevents the export process from freezing.   
The standard name of the generated .bib file is the name of the
collection. During the export setup, you can choose an arbitrary name
for the .bib file. However, renaming the file after the export setup may
break the update process. In any case, if you do not trust the automatic
update process, you can export the collection again at any time. 
