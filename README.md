# PCB_CNC

**<u>Avertissement :</u>** Je ne suis qu'un amateur, l'électronique n'est pas mon métier. Il est donc probable que ce que je présente ci-dessous puisse être réalisé de façon plus simple ou mieux optimisée. 

**Pourquoi ce post :**

Utilisateur des services de gravure de circuit imprimé en Chine (j'en ai utilisé plusieurs différents), j'ai eu envie de réaliser une chaine de fabrication qui me permette de graver un circuit en une heure

**Avantages de faire fabriquer des circuits en Chine**

-  Prix avantageux (pour une petite vingtaine d'euros on peut avoir une dizaine de circuits imprimés)
- Accessibilité du double face, voire 4
- Finesse de la gravure
- Finition du circuit imprimé (et facilité de soudure)
- Génial pour des petites séries

**Inconvénients de faire fabriquer des circuits en Chine**

- Délais de réalisation (pour garder un prix faible). Pour moi, environ 1 mois
- Quasi obligation d'acheter les circuits par 10 (prix identique)

**J'ai eu envie de faire quelque chose de différent qui me permette de tout faire moi-même.**

Avantage d'utiliser une chaine de fabrication maison

- Rapidité de réalisation d'un circuit (pas de transport)
- Possibilité de faire un seul exemplaire
- Le plaisir de construire

**Inconvénient d'utiliser une chaine de fabrication maison**

- Il faut avoir un peu de matériel (une CNC, ...)
- La finesse de gravure est très faible. J'arrive uniquement à faire une piste qui passe entre deux pastilles :-)
- La qualité du circuit et l'importance de soigner les soudures (difficile de ressouder sans décoller les pastilles)



Après ces considérations, ...

L'idée générale est de graver une plaque de PCB avec une machine CNC de façon industrielle
L'opération se réalise en plusieurs étapes:

- **Construction d'une machine cnc avec :**
  
  - Le maximum de matériaux de grande distribution
    - Tiges filetées diamètre 6
    - Tiges carrées en aluminium coté 15mm
    - planche MDF
    - Vis diamètre 4 longueur 16mm avec écrous
    - Une dremel de base
    
  - Quelques composants achetés chez Aliexpress
    - Roulement diamètre 6
    - 5 x TB6560 (contrôleurs de moteurs pas à pas)
    - 5 x NEMA 17 (2A)
    - 1 x ESP32 (que je n'utilse pas en WiFi car chez moi ça ne marche pas très bien)
    - 1 relai pour démarrer la Dremel automatiquement
    
  - Deux bobines de PLA d'un kg achetées chez Amazon 
  
  - Des éléments de récupération (ou que j'avais déjà)
    - 1 x Alimentation 12V 10A
    - 2 x STEPDOWN DC (1 configuré en 3,3V et l'autre en 5V)
    - 1 x STEPDOWN + 1 BC557 pour alimenter le ventilateur
    
  - Les autres pièces ont été dessinées sous sketchup et imprimées avec ma petite Tiertime UP Mini
  
  - Bref, un peu moins de 100€ investis et une table CNC plutôt de bonne facture pour ce rapport qualité/prix. C'est un point très important pour la précision des circuits imprimés réalisés
  
  - Une photo (pas très bien prise de ma CNC)
  
    ![image-20201227112703543](png/image-20201227112703543.png)
  
    
  
  - Si cela intéresse quelqu'un, je pourrai faire un tutorial sur ce sujet quand j'aurai le temps. On peut voir ma lime et ma brosse à dents ;-)
  
- **Génération de fichiers gerber**

  - J'utilise Eagle v 9.6.2 avec un cam spécifique [fichier CAM](cnc.cam) (créé directement dans Eagle)

  - ![image-20201227102011485](png/image-20201227102011485.png)

    Vous pouvez remarquer que dans le menu "advanced", j'ai coché "Mirror"

    ![image-20201227102415574](png/image-20201227102415574.png)

    ![image-20201227102502753](png/image-20201227102502753.png)

    ![image-20201227102614193](png/image-20201227102614193.png)

  - Mes paramètres Eagle sont

    - Clearance = 0.05mm (dans le menu Edit/Design rules/Clearance pour tous les paramètres)

      ![image-20201227102938547](png/image-20201227102938547.png)

      ![image-20201227103023867](png/image-20201227103023867.png)

    - Création de net spécifiques (dans le menu Edit/Net classes)

      ![image-20201227103233804](png/image-20201227103233804.png)

      - "CNC_data" avec Clearance=0.05mm, Width=0.56mm) pour que ça passe exactement entre les grosses pastilles
      - "CNC_power" avec Clearance=0.05mm
      - Et évidemment, il faut que les objets aient comme propriété de NetClass la bonne valeur

  - Exemple de board

    ![image-20201227103726477](png/image-20201227103726477.png)

    Les grosses pastilles sont celles qui sont en bas. Vous remarquez que les pistes CNC_data passent exactement entre les grosses pastilles (ex: avec D2)

  - En lançant File/CAM Processor.../Load Job File/Open CAM File/cnc.cam et en cliquant sur "Process Job" (avec les confirmations), on obtient dans le répertoire CNC les fichiers

    ``````bash
    $ ls -lrt
    -rw-r--r-- 1 Pierre Aucun    8908 27 déc.  10:46 dessous.gbr
    -rw-r--r-- 1 Pierre Aucun   82987 27 déc.  10:46 texte.gbr
    -rw-r--r-- 1 Pierre Aucun   19814 27 déc.  10:46 dimension.gbr
    -rw-r--r-- 1 Pierre Aucun     592 27 déc.  10:46 gerber_job.gbrjob
    -rw-r--r-- 1 Pierre Aucun    1252 27 déc.  10:46 drill.xln
    ``````

    Ces fichiers sont les fichiers gerber utilisés par la section suivante avec flatCam

- **Utilisation de flatCam pour les convertir en gcode**
  
  - La version que j'utilise est la 8.993 BETA 64bit (la version suivante ne semble pas interpréter le script tcl comme je le veux)
  
  - J'ai construit un petit script windows pour passer le répertoire courant en paramètre [fichier bat](FlatCAM.bat) car je ne savais pas faire autrement
  
  - Et un autre script en tcl pour piloter FlatCAM [fichier flatcam](generic.FlatScript)
  
  - A la fin il y a un enchainement pour fabriquer une version en 90°
  
  - La syntaxe est : FlatCAM 0.1 qui génère tous les fichiers avec une pointe de 0,1 et un maïs de 0,5 dans deux fichiers séparés
  
  - Un exemple de ce qui est généré
  
    ![image-20201227105128755](png/image-20201227105128755.png)
  
    Et voici la liste des fichiers générés
  
    ``````bash
    $ ls -lrt
    -rw-r--r-- 1 Pierre Aucun    8908 27 déc.  10:46 dessous.gbr
    -rw-r--r-- 1 Pierre Aucun   82987 27 déc.  10:46 texte.gbr
    -rw-r--r-- 1 Pierre Aucun   19814 27 déc.  10:46 dimension.gbr
    -rw-r--r-- 1 Pierre Aucun     592 27 déc.  10:46 gerber_job.gbrjob
    -rw-r--r-- 1 Pierre Aucun    1252 27 déc.  10:46 drill.xln
    -rw-r--r-- 1 Pierre Aucun  195693 27 déc.  10:50 isolate.nc
    -rw-r--r-- 1 Pierre Aucun  595575 27 déc.  10:50 drill_and_cut.nc
    -rw-r--r-- 1 Pierre Aucun  791256 27 déc.  10:50 complet.nc
    ``````
  
    Il y a 3 nouveaux fichiers en gcode dont
  
    - isolate.nc permet de graver avec une fraise de 0.1
  
    - drill_and_cut.nc permet de graver avec une fraise maïs de 0.5
  
- **Gravure avec la CNC en utilisant bCNC**
  
  - (Je n'ai pas réussi a utiliser Candle qui semble plus fluide mais qui se bloque au bout d'un moment sur de gros fichiers)
  - bCNC permet de faire une première mise au point en probe sur l'axe des Z
  - Et ensuite de faire un palpage de surface automatique avant de lancer l'impression
  - Je lance en premier isolation.nc avec une pointe 60° 0,1mm puis drill_and_cut.nc avec un maïs de 0,5mm. Entre les deux étapes, je change la fraise et je refais uniquement un probe Z en position X0Y0.
  - A la fin de la gravure, la pièce se détache très facilement. Avec une lime métal, je passe un coup léger sur les fixations. Et avec une lime à ongle multi-face, je brosse légèrement le circuit et enfin avec un petit coup de brosse à dents, j'élimine toutes les poussières.

## Résultats
Voici un premier résultat en faisant passer une via entre deux grosses pastilles. On repère un petit point à chaque descente de la fraise, mais rien de grave (peut être un défaut dans le script TCL)
![plot](png/test1.png)

Pour le test suivant, un peu plus complet, on voit que les pad trop petits ne sont pas très bien découpés. J'utiliserai donc des pad plus grands

![plot](png/arduino_nrf.png)
