---
title: "Probleme lösen"
author: Jacques Mock Schindler
date: 2024-09-04
date-format: DD.MM.YYYY
---

In dieser Einheit geht es darum, sich mit einer ersten Art der
Problemlösung beim Programmieren auseinanderzusetzen.

Die hier vorgeschlagene Vorgehensweise ist simpel. Man nimmt das Problem
und unterteilt es solange in Teilprobleme, bis nur noch einfach zu
lösende Teilprobleme übrigbleiben.

Zur Illustration soll gezeigt werden, wie die Französische Trikolore
gezeichnet werden kann. Wird diese in ihre Einzelteile zerlegt bleiben
drei gleichgrosse nebeneinander angeordnete Rechtecke in den Farben
blau, weiss und rot. Entsprechend muss man die drei Rechtecke zeichnen
und anschliessen nebeneinander anordnen.

Damit Sie das an Ihrem Computer tun können, müssen die folgenden
Vorbereitungsarbeiten erledigt werden (es wird vorausgesetzt, dass alle
Systemeinrichtungsarbeiten aus der 
[Lektion vom 28. August 24](../240828/installationsanleitungen.md)
erfolgreich abgeschlossen sind):

1. Legen Sie im Ordner Informatik einen Unterordner 240904 an.
2. Klicken Sie den neuen Ordner 240904 mit der rechten Maustaste an und
   wählen sie aus dem Kontextmenü weitere Optionen aus. In den weiteren
   Optionen wählen Sie `In Terminal öffnen`.
3. Im neuen Terminal erstellen Sie eine Python Virtual Environment.
   
   ```shell
   ...\240904> python -m venv venv
   ```

4. Starten Sie die Python Virtual Environment.
   
   ```shell
   ...\240904> venv\Scripts\activate
   ```

5. Installieren Sie in dieser Python Virtual Environment die Pakete
   `jupyter` und `pytamaro`.

      
   ```shell
   ...\240904> python -m pip install jupyter pytamaro
   ```

   Dieser Vorgang dauert einige Minuten.

6. Jetzt können Sie unter dem Link
   [Arbeitsblatt](https://colab.research.google.com/github/I-eW-24-28/Script/blob/main/docs/240904/schweizerfahne.ipynb)
   das vorbereitete Jupyter Notebook in den neuen Ordner 240904
   herunterladen.
   
7. Starten Sie Jupyter Notebook

      
   ```shell
   ...\240904> jupyter notebook
   ```
8. Öffnen Sie das Jupyter Notebook mit Doppelklick auf den Dateinamen `schweizerfahne.ipynb`
9. Folgen Sie den Anleitungen im Arbeitsblatt.

Diese Vorgehensweise soll in diesem 
[Arbeitsblatt](https://colab.research.google.com/github/I-eW-24-28/Script/blob/main/docs/240904/schweizerfahne.ipynb)
am Wappen des Kantons Tessin und der Schweizerfahne geübt werden.