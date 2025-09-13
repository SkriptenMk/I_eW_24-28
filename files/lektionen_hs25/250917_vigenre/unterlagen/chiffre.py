# chiffre.py

import string
import datetime

def shift(key: int) -> dict:
    '''Die Funktion erstellt ein um den Wert key (bzw. key mod) 
    verschobenes Dictionary für lateinische Kleinbuchstaben.'''
    key = key % 26
    
    alphabet = [char for char in string.ascii_lowercase]
    shifted_alphabet = alphabet[key:len(alphabet)] + alphabet[0:key]
    
    table = {}
    
    for i in range(len(alphabet)):
        table[alphabet[i]] = shifted_alphabet[i]
        
    return table

def crypto(text: string, key: int, encrypt:bool=True) -> str:
    table = shift(key)
    result = ''
    for char in text:
        for key, value in table.items():
            if encrypt:
                if char == key:
                    result += value
            else:
                if char == value:
                    result += key
    return result

def text_cleaning(text:str) -> str:
    text = text.lower()
    text = text.replace(' ', '')
    text = text.replace('\n','')
    text = text.replace('ä','ae')
    text = text.replace('ö', 'oe')
    text = text.replace('ü', 'ue')
    text = text.replace('ß', 'ss')
    text = text.replace('«', '')
    text = text.replace('»', '')
    text = text.replace('—', '')
    text = text.replace('̈:', '')
    
    text = [char 
            for char in text
            if char not in string.punctuation]
    text = ''.join(text)
    return text

def text_reader(path: str) -> str:
    with open(path, 'r', encoding='utf-8') as file:
        lines = [line.rstrip() for line in file]
        
    text = ''
    for line in lines:
        text += line
        
    return text

def text_writer(text: str, path:str = ''):
    ouptput_text = ''
    for i in range(len(text)):
        if i % 72 == 0:
            ouptput_text += '\n'
            ouptput_text += text[i]
        else:
            ouptput_text += text[i]
            
    now = datetime.datetime.now()
    date_string = now.strftime("%Y%m%d_%H-%M-%S") + f'.{now.microsecond // 1000:03d}'
    name = f'{date_string}_output.txt'
    
    with open(name, 'w', encoding='utf-8') as file:
        file.write(ouptput_text)
        
def caesar(input_file: str, shift: int, encryption: bool=True) -> None:
    text = text_reader(input_file)
    text = text_cleaning(text)
    text = crypto(text, shift, encryption)
    text_writer(text)
    
def vigenere_chiffre(text: str, key: str, encrypt=True) -> str:
    """
    Implementiert die Vigenère-Verschlüsselung für einen gegebenen Klartext und
    Schlüssel.
    
    Args:
        klartext (str): Der zu verschlüsselnde Text schluessel (str): Das
        Schlüsselwort für die Verschlüsselung
    
    Returns:
        str: Der verschlüsselte Text
    """
    
    # initialisiere den resultierenden Text
    resulting_text = ''
    
    # bestimme die Schlüssellänge für die anschliessende Modulo-Operation
    key_length = len(key)
    
    # itererie über den Eingabetext unter gleichzeitiger Erfassung des Index
    for i, char in enumerate(text):
        # berechne den Zahlwert des Buchstabens aus der ascii Tabelle
        char_no = ord(char) - 97
        key_no = ord(key[i % key_length]) - 97
        
        if encrypt == True:
            # berechne den Zahlwert des verschlüsselten Buchstabens
            ciph_no = (char_no + key_no) % 26
        else:
            # berechne den Zahlwert des entschlüsselten Buchstabens
            ciph_no = (char_no + (26 - key_no)) % 26
            
         # übernehme das Zeichen aufgrund seines Zahlwertes aus der ascii Tabelle  
        ciph = chr(ciph_no + 97)
        
        # füge den Buchstaben am resultierenden Text an
        resulting_text += ciph
    return resulting_text

def vigenere(input_file: str, key: str, encryption: bool=True) -> None:
    text = text_reader(input_file)
    text = text_cleaning(text)
    text = vigenere_chiffre(text, key, encryption)
    text_writer(text)