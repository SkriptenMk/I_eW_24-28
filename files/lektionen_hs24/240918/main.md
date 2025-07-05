---
title: "Wiederholungen in Python"
author: Jacques Mock Schindler
date: 2024-09-18
date-format: DD.MM.YYYY
---


Eine Stärke von Computerprogrammen ist die wiederholte Ausführung von
Anweisungen. Viele Programmiersprachen stellen dafür ein Konstrukt mit
dem Namen 'For-Schleife' zur Verfügung. Eine 'For-Schleife' funktioniert
unabhängig von einer konkreten Programmiersprache folgendermassen:

```
FÜR variable VON startwert BIS endwert [MIT schrittweite]
    Anweisungen
ENDE FÜR
```

Übersetzt nach Python sieht das so aus:

```python
for i in range(n):
    do...
```

`startwert BIS endwert [MIT schrittweite]` wird dabei durch `range(n)`
ausgedrückt. Dabei ist `n` der Endwert. Gezählt wird bis zum aber ohne
den Endwert. Startwert und Schrittweite haben 
Vorgabewerte. Der Vorgabewert für den Start ist `0`, derjenige der
Schrittweite `1`. Weil `range()` diese vorgegebenen Werte hat, müssen
diese nicht explizit angegeben werden. Wenn der Startwert abweichend vom
Vorgabewert festgelegt werden soll, kann dieser explizit angegeben
werden. Der Aufruf von `range()` sieht dann so aus:

```python
range(startwert, endwert)
```

Falls eine von `1` abweichende Schrittweite festgelegt werden soll
lautet der Aufruf

```python
range(startwert, endwert, schrittweite)
```

In diesem Fall müssen neben dem Endwert sowohl der Startwert und die
Schrittweite angegeben werden. Andernfalls kann nicht zwischen den
einzelnen Angaben zu Endwert, Startwert und Schrittweite unterschieden
werden. 

Im hier verlinkten
[Arbeitsblatt](https://colab.research.google.com/github/I-eW-24-28/Script/blob/main/docs/240918/for_loop.ipynb)
finden Sie ein paar Übungen zu Python For-Schleifen. 