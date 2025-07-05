---
title: Erforderliche Systemeinrichtungen
author: Jacques Mock Schindler
date: 2024-08-28
date-format: DD.MM.YYYY
---

Im Unterricht im obligatorischen Fach Informatik werden wir Programme in
der Programmiersprache Python schreiben. Damit dies möglich ist, müssen
Sie an Ihrem Computer ein paar Vorbereitungsarbeiten vornehmen.

## Installation von Python

Als erstes müssen Sie die Programmiersprache Python auf Ihrem Computer
verfügbar machen.
[Hier finden Sie eine entsprechende Anleitung.](../anleitungen/python.md)

## Einrichten einer virtuellen Arbeitsumgebung

Es ist gute Praxis, Python Programme in einer virtuellen Arbeitsumgebung
zu schreiben und auszuführen.
[Eine Beschreibung, wie das geht, finden Sie hier.](../anleitungen/anleitung_venv.md) 

## Editor zum erstellen von Python Programmen

Grundsätzlich können Sie Python Programme in einem beliebigen Texteditor
erstellen. Um Ihnen die Arbeit etwas zu erleichtern verwenden wir im
Unterricht [Visual Studio Code](../anleitungen/vs_code.md).

## Jupyter Notebooks zum erstellen von Python Programmen

Damit Sie Ihre Pythonprogramme einfach mit den nötigen Notizen versehen
können und allenfalls auch ausdrucken, verwenden wir im Unterricht
sogenannte [Jupyter Notebooks](https://jupyter.org/). Wie Sie das für VS
Code vorbereiten,
[wird hier erklärt](../anleitungen/jupyter.md).

## Arbeitsumgebung in der lokalen Ordnerstruktur

Ich gehe davon aus, dass Sie die Dateien für die Schule grundsätzlich
folgendermassen organisiert haben:

```sh
+---Schule
    +---BG
    +---Chemie
    +---Deutsch
    +---Englisch
    +---Franzoesisch
    +---Geographie
    +---Geschichte
    +---Informatik
    ¦   +---Einfuehrung
    +---Klassenstunde
    +---Mathematik
    +---Musik
    +---PPP
```

Für das erstellen der verlangten Python Virtual Environment wechseln Sie
jeweils in den Ordner `Schule>Informatik>Einfuehrung`.