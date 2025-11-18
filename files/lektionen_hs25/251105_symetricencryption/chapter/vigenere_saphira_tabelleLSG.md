# LSG: Vigenère-Tabelle und Entschlüsselung

## Gegebene Daten

**Geheimtext:**

    shcaminacwalrskdxlavrxuckmznwssyithwntpmjswicsmsefvtyivnveguezrv

**Schlüssel:**

    saphira

------------------------------------------------------------------------

## Schritt 1 -- Prinzip der Tabelle

Die Tabelle hat: - **Zeilen** = Schlüsselbuchstaben (`A–Z`) -
**Spalten** = Klartextbuchstaben (`A–Z`) - **Zellen** = resultierender
**Geheimtextbuchstabe**

Beim **Entschlüsseln** suchen wir: 1. In der **Zeile des Schlüssels**
nach dem Geheimtextbuchstaben.\
2. Die **Spaltenüberschrift** verrät den **Klartextbuchstaben**.

------------------------------------------------------------------------

## Schritt 2 -- Beispiel mit den ersten 10 Buchstaben

  ------------------------------------------------------------------------------------
  Position   Geheimtext   Schlüssel      Zeile         Spalte (Klartext  Gefundener
                          (wiederholt)   (Schlüssel)   → gesucht)        Klartext
  ---------- ------------ -------------- ------------- ----------------- -------------
  1          s            s              Zeile S       Spalte E → ergibt e
                                                       S beim            
                                                       Verschlüsseln     

  2          h            a              Zeile A       Spalte H          i

  3          c            p              Zeile P       Spalte C          e

  4          a            h              Zeile H       Spalte A          n

  5          m            i              Zeile I       Spalte M          e

  6          i            r              Zeile R       Spalte I          s

  7          n            a              Zeile A       Spalte N          c

  8          a            s              Zeile S       Spalte A          h

  9          c            a              Zeile A       Spalte C          i

  10         w            p              Zeile P       Spalte W          c
  ------------------------------------------------------------------------------------

➡️ ergibt bereits: **eineschic...**

------------------------------------------------------------------------

## Schritt 3 -- Tabula Recta (Ausschnitt)

  ---------------------------------------------------------------------------------------------------------------
          A   B   C   D   E   F   G   H   I   J   K   L   M   N   O   P   Q   R   S   T   U   V   W   X   Y   Z
  ------- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  **A**   A   B   C   D   E   F   G   H   I   J   K   L   M   N   O   P   Q   R   S   T   U   V   W   X   Y   Z

  **S**   S   T   U   V   W   X   Y   Z   A   B   C   D   E   F   G   H   I   J   K   L   M   N   O   P   Q   R

  **A**   A   B   C   D   E   F   G   H   I   J   K   L   M   N   O   P   Q   R   S   T   U   V   W   X   Y   Z

  **P**   P   Q   R   S   T   U   V   W   X   Y   Z   A   B   C   D   E   F   G   H   I   J   K   L   M   N   O

  **H**   H   I   J   K   L   M   N   O   P   Q   R   S   T   U   V   W   X   Y   Z   A   B   C   D   E   F   G

  **I**   I   J   K   L   M   N   O   P   Q   R   S   T   U   V   W   X   Y   Z   A   B   C   D   E   F   G   H

  **R**   R   S   T   U   V   W   X   Y   Z   A   B   C   D   E   F   G   H   I   J   K   L   M   N   O   P   Q
  ---------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

## Schritt 4 -- Ergebnis (komplett)

**Entschlüsselter Text:**

    eineschicksalhafteweltvollermagieunddunklermaechte

------------------------------------------------------------------------

Erstellt aus dem Schlüssel **"saphira"** und dem Geheimtext oben.
