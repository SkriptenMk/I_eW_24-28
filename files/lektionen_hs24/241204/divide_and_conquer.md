---
title: Rekursion
author: Jacques Mock Schindler
date: 2024-12-04
date-format: DD.MM.YYYY
---

Bevor ein etwas effizienterer Sortieralgorithmus als selection sort besprochen
werden kann, muss ein weiteres Programmierverfahren eingeführt werden: Die
Rekursion. Man spricht in diesem Zusammenhang gelegentlich auch von *divide and
conquer* (teile und herrsche).

Die Möglichkeiten und Grenzen der Rekursion soll mit Hilfe dreier Beispiele

* der Berechnung der Summe einer Sequenz aufsteigender Zahlen,
* der Berechnung des Produkts einer Sequenz aufsteigender Zahlen ($n!$) sowie
* der Fibonacci Zahlenfolge

aufgezeigt werden.

Wie Rekursion im Allgemeinen funktioniert, kann mit der folgenden
Kindergeschichte aufgezeigt werden:

>Es isch e mal en Maa gsi, de hät en hole Zah gha. I dem Zah häts es
>Truckli gha und i däm Truckli häts es Briefli gha. I dem Briefli isch
>gstande, es isch e mal en Maa gsi, de hät en hole Zah gha. I dem Zah
>häts es Truckli gha und id däm Truckli häts es Briefli gha...

Rekursive Funktionen sind entsprechend Funktionen, die sich selber
aufrufen. 

Hier geht es zu einem 
<a
href="https://github.com/I-eW-24-28/Script/blob/main/docs/241204/anwendungsuebung_rekursion.ipynb"tar
get="_blank">Arbeitsblatt zu den rekursiven Funktionen</a>.  
Die Musterlösung des Arbeitsblattes ist hier
<a href="https://colab.research.google.com/github/I-eW-24-28/Script/blob/main/docs/241204/musterloesung_anwendungsuebung_rekursion.ipynb" target="_blank">verlinkt</a>.