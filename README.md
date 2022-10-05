# PapaLouisGBA
Tentative d'écriture d'un jeu pour la GameBoy Advance de Nintendo

## How to

Pour compiler le jeu, il est nécessaire d'avoit installé `devkitpro`, selon [ce tutoriel](https://devkitpro.org/wiki/Getting_Started).

On peut alors compiler un projet d'exemple, comme [celui-ci](https://gbadev.org/demos.php?showinfo=323), avec les commandes suivantes, comme présenté dans [ce guide](https://www.reinterpretcast.com/writing-a-game-boy-advance-game):

```shell
# cross-compilation
arm-none-eabi-gcc -c main.c -mthumb-interwork -mthumb -O2 -o main.o
# link des fichiers
arm-none-eabi-gcc main.o -mthumb-interwork -mthumb -specs=gba.specs -o main.elf
# strip des informations non-nécessaires
arm-none-eabi-objcopy -v -O binary main.elf main.gba
# fix de la ROM
gbafix main.gba
```

On peut alors lancer la ROM dans un émulateur comme [mGBA](https://mgba.io/)

Si la compilation a fonctionné, le fichier `.gba` devrait être accepté et exécuté par l'émulateur.