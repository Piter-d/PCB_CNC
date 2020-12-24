# PCB_CNC

L'idée générale est de graver une plaque de PCB avec une machine CNC de façon industrielle
L'opération se réalise en plusieurs étapes:
- Construction d'une machine cnc avec :
  - Le maximum de matériaux de grande distribution
    - Tiges filetées diamètre 6
    - Tiges carrées en aluminium coté 15mm
    - planche MDF
    - Vis diametre 4 longueur 16mm avec écrous
  - Quelques composants acheté chez Aliexpress
    - Roulement diamètre 6
    - 
  - Les autres pièces ont été dessinées sous sketchup et imprimée avec ma petite Tiertime UP Mini
- Génération de fichiers gerber
  - J'utilise Eagle avec un cam spécifique [fichier CAM](cnc.cam) (créé directement dans Eagle)
- Utilisation de flatCam pour les convertir en gcode
  - J'ai construit un petit script windows pour passer le repertoire courant en parametre [fichier bat](FlatCAM.bat)
  - Et un autre script en tcl pour piloter FlatCAM [fichier flatcam](generic.FlatScript)
  - A la fin il y a un enchainement pour fabriquer une version en 90°
- Gravure avec la CNC en utilisant bCNC
  - (Je n'ai pas réussi a utiliser Candle qui semble plus fluide mais qui se bloque au bout d'un moment sur de gros fichiers)
  - bCNC permet de faire une première mise au point en probe sur l'axe des Z
  - Et ensuite de faire un palpage de surface automatique

## Résultats
Voici un premier résultat en faisant passer une via entre deux grosses pastilles; pas si mal
![plot](png/test1.png)
