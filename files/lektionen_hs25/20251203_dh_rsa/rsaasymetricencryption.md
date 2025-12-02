---
title: "16 RSA Asymetrische Verschlüsselung"
date: 2025-12-03
date-format: DD.MM.YYYY
author: "Peter Rutschmann"
---

# Asymetrische Verschlüsselung

## Unterschied Symetrische und Asymetrische Verschlüsselung

Bei der symetrischen Verschlüsselung verwenden Sender und Empfänger den gleichen Schlüssel zum Ver- und Entschlüsseln der Nachricht.<br/>
Beispiel: AES, DES, 3DES
<br/><br/>
Bei der asymetrischen Verschlüsselung verwenden Sender und Empfänger ein Schlüsselpaar, bestehend aus einem öffentlichen und einem privaten Schlüssel.<br/>
Beispiel: RSA

---

> ### Aufgabe Symetrische und Asymetrische Verschlüsselung
> - Schauen Sie sich dieses Video zum Unterschied zwischen symetrischer und asymetrischer Verschlüsselung an.<br/>
>      - [https://www.youtube.com/watch?v=QFjlwsAL9BY](https://www.youtube.com/watch?v=QFjlwsAL9BY)
><br/><br/>
> - Erklären Sie Ihrem Lernpartner die beiden Verfahren.

---

> ### Aufgabe: Anwenden der Asymetrischen Verschlüsselung
> - Ausgangslage: Alice hat ein Schlüsselpaar aus einem privaten und einen public Schlüssel erstellt.
> - Stichworte: Public Key, Private Key, Verschlüsseln, Entschlüsseln, Signieren, Signatur überprüfen<br/><br/>
> - Fall 1: Bob will Alice eine geheime Nachricht senden.<br/>
>   - Erklären Sie Ihrem Lernpartner, wie Bob die Nachricht verschlüsselt und wie Alice die Nachricht wieder entschlüsselt.<br/><br/>
> - Fall 2: Alice will Bob eine Nachricht senden, die Bob eindeutig als von Alice stammend erkennen kann.<br/>
>   - Erklären Sie Ihrem Lernpartner, wie Alice die Nachricht signiert und wie Bob die Signatur überprüft.
><br/><br/>
> - Fall 3: Eve kennt den public key von Alice.<br/>
>   - Erklären Sie Ihrem Lernpartner, welche der beiden Fälle Eve damit nutzen kann. 
><br/><br/>
> - Fall 4: Bob und Alice möchten sich geheime Nachrichten zusenden. <br/>
>   - Erklären Sie Ihrem Lernpartner, welche die beiden vorgehen müssen.

---

## RAS - Asymetrische Verschlüsselung

RSA (Rivest-Shamir-Adleman) ist ein weit verbreitetes asymetrisches Kryptosystem, das auf der mathematischen Schwierigkeit basiert, grosse Zahlen in ihre Primfaktoren zu zerlegen.
Es wurde 1977 von Ron Rivest, Adi Shamir und Leonard Adleman entwickelt und ist eines der ersten praktischen Public-Key-Kryptosysteme.

## RAS - das Prinzip

Das Prinzip von RAS zeigt dieses Arbeitsblatt.<br/>
Laden Sie es herunter und lösen Sie es zusammen mit der Lehrperson.

<a href="https://skriptenmk.github.io/I_eW_24-28/files/lektionen_hs25/251203_dh_rsa/chapter/RSARechnen.pdf" 
   download="RASRechnen.pdf">
   Das Prinzip von RSA
</a>

---

## RAS - praktische Anwendung

> ### Aufgabe: Anwenden der RSA Asymetrischen Verschlüsselung
> - Sie finden unter diesem Link eine Online-Version für die RAS Verschlüsseltung: [https://www.devglan.com/online-tools/rsa-encryption-decryption](https://www.devglan.com/online-tools/rsa-encryption-decryption)<br/><br/>
> - Aufgabe 1)
>     - Die Lehrperson hat eine Nachricht für alle Lernenden verschlüsselt.
>     - Entschlüsseln Sie die Nachricht mit dem public key der Lehrperson.
>     - Key-Size: 1024bit
>     - Public-Key: <br/>
<a href="https://skriptenmk.github.io/I_eW_24-28/files/lektionen_hs25/251203_dh_rsa/chapter/public.pem" 
   download="public-key">
   RSA Public Key Lehrperson
</a>
>     - Verschlüsselte Nachricht (Base64): 
tjeyUglifabTTrXGNm5Qw3R7QUau0SIXsPAI8FziCVoknpMCRY63C+uI4y6JlOnfvFvKBW3jG/iAe4hAVvbnYwE3uzI3GdOmFrcvfekWETNyylHYCZYuttyn7z6XILcIWA/811hswnGpwacjw0atWMmoIcSNoK8SmnyhhrSJLCg=
>     - Encryption Algorithmus: RSA
<br/><br/>
> - Aufgabe 2)
>     - Erstellen Sie selber einen Schlüsselpaar (public und private key) mit einem Key-Size von 1024bit.<br/>
>     - Tauschen Sie den Public-Key mit Ihrem Lernpartner aus. (und umgekehrt)
>     - Verschlüsseln Sie eine Nachricht und geben Sie die verschlüsselte Nachricht an Ihren Lernpartner weiter. Er soll die Nachricht entschlüsseln. (und umgekehrt)