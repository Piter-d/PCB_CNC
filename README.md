# PCB_CNC

L'idée générale est de graver une plaque de PCB avec une machine CNC de façon industrielle
L'opération se réalise en plusieurs étapes:
- Génération de fichiers gerber
  - J'utilise Eagle
- Utilisation de flatCam pour les convertir en gcode
- Gravure avec la CNC en utilisant bCNC
  - (Je n'ai pas réussi a utiliser Candle qui semble plus fluide mais qui se bloque au bout d'un moment sur de gros fichiers)
