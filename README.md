# PapaLouisGBA
Tentative d'écriture d'un jeu pour la GameBoy Advance de Nintendo

## How to

Pour compiler le jeu, il est nécessaire d'avoit installé `devkitpro`, selon [ce tutoriel](https://devkitpro.org/wiki/Getting_Started).

On peut alors compiler un projet d'exemple, comme [celui-ci](https://gbadev.org/demos.php?showinfo=323), avec les commandes suivantes, comme présenté dans [ce guide](https://www.reinterpretcast.com/writing-a-game-boy-advance-game):

```shell
# cross-compilation
arm-none-eabi-gcc -c my_file.c -mthumb-interwork -mthumb -O2 -o my_file.o
# link des fichiers
arm-none-eabi-gcc my_file.o -mthumb-interwork -mthumb -specs=gba.specs -o my_file.elf
# strip des informations non-nécessaires
arm-none-eabi-objcopy -v -O binary my_file.elf my_file.gba
# fix de la ROM
gbafix my_file.gba
```

Ou alors utiliser la commande `make` pour effectuer automatiquement les actions ci-dessus.

On peut alors lancer la ROM dans un émulateur comme [mGBA](https://mgba.io/).

Si la compilation a fonctionné, le fichier `.gba` devrait être accepté et exécuté par l'émulateur.
