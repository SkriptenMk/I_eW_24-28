# References in Plain Text Writing (Markdown)

Three additional files are required to insert references in Markdown
files: 

* a file for information about the text format (`.yaml`),
* a file for bibliographical information (`. bib`), and
* a file for display format of the bibliographical information (`.csl`).

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
  # - third_part.md
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
  lof: true
  lot: true
  number-sections: true
  header-includes:
    - \setcounter{secnumdepth}{3}
    - \setcounter{tocdepth}{3}

metadata:
  title: "Title of the Document"
  author: "Author's Name"
  lang: en # for Swizterland: de-CH
  date: "Today"
  bibliography: bibliography.bib
  csl: chicago-notes-bibliography-access-dates.csl
  link-citations: true
```

The followoing list provides explanations for the entries in the
configuration file:

* `input-files` A list of the files to be included in the final output. As
  shown in the example the different files are listed one below the
  other. 
* `output-file` This key sets the path to the output file.
* `from` This is the key of the file format of the `input-files`.
* `to` This is the key of the file format of the `output-file`.
* `pdf-engine` sets the pdf-engine responsible for the conversion from
  Markdown to PDF. `lualatex` is chosen for its ability to handle Swiss
  umlaute. 
* `citeproc` is the software responsible to handle the bibliographic
  information. The value `true` activates the software.
* `table-of-contents` If `true` there will be a table of contents.
* `variables` bundles the details for the display of the output file.
* `lof` creates a list of figures.
* `lot` creates a list of tables.
* `number-sections` numbers the sections according to their hierarchical
  position.
* `header-includes` This key allows the inclusion of LaTeX commands.
* `- \setcounter{secnumdepth}{3}` This numbers sections down to the
  third level.
* `- \setcounter{tocdepth}{3}` This excludes sections below the third
  level from the table of contents.
* `metadata` bundles the metadata of the file.
* `title` The title for the front matter.
* `author` The author's name. Multiple authors can be provided as a
  list (analogue to the input files).
* `lang` is the variable to store the language settings. For Swiss
  German documents it has to be set to `de-CH`. This observes the Swiss
  German typographical conventions.
* `date` The Date.
* `bibliography` Stores the path to the bibliography (`.bib`) file. It
  has to be the name chosen for the `.bib` file.
* `csl` Stores the path to the `.csl` file.

For additional configurations check the [Pandoc User
Guide](https://pandoc.org/MANUAL.html). 

## Bibliographic Information

Zotero will create the file `bibliography.bib` automatically.
Nevertheless, there is an example entry from the file `bibliography.bib`
below. 

```bib
@book{healy2020,
  title = {The {{Plain Person}}'s {{Guide}} to {{Plain Text Social Science}}},
  author = {Healy, Kieran},
  year = 2020,
  }
```

This entry represents a book, hence the `@book` key. The citation key
can be found immediately after the curly bracket. Zotero assigns this
key arbitrarily. However, it is possible to set a citation key
at will. The details are explained in the [Zotero tutorial](../260114_zotero/zotero.md#sec-zotero_entry).

## Citation Style

The `.csl` (Citation Style Language) file defines the citation
style. The `.csl` format is a variant of the
[xml](https://en.wikipedia.org/wiki/XML) language. Even if it is
possible to write a csl definition from scratch it is far easier to
download a style from the [Zotero Style
Repository](https://www.zotero.org/styles). 


## Setting references in Markdown {#sec-citation_key_syntax}

To transfer references from the `.bib` file into the Markdown text,
use the citation key (`[@citation_key]`). If you want to include page numbers
in your reference, add them to the citation key (`[@citation_key, 25]`).
If you need to include multiple authors in one reference, you can
combine multiple citation keys (`[@citation_key_1, 25; @citation_key_2, 33]`).

There is no need to memorise the citation keys as Zotero displays
them as the first item in the metadata.

## Creating a PDF containing references

If there exists a `.yaml` file, the pdf can be created with the


```bash
pandoc -d format.yaml
```

command. The command must be executed from the same directory in which he
`format.yaml` file is located.
