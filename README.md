# france

http://panneaux.github.io/france

tous les panneaux de France :-)

## pour ajouter une nouvelle collection

### sous Windows

prérequis :

- il faut avoir l'utilitaire convert.exe de la suite [imagemagick](https://imagemagick.org/script/download.php). Pour l'installer : https://imagemagick.org/download/binaries/ImageMagick-7.0.10-14-Q16-x64-dll.exe



- githubDesktop : https://desktop.github.com/

A l'installation d'imagemagick, cocher la case "install legacy utilities" pour installer convert.exe

<img src=imagemagick.png height=300>

Modifier/vérifier le path pour qu'il intègre `C:\Program Files\ImageMagick-7.0.6-Q16\`

Sous windows 10 :
``
Paramètres > Système > Informations système > Paramètres système avancés > Variables d'environnement > Path
``

Window a son propre utilitaire convert. Celui d'ImageMagick doit être en premier
```
$ where convert
c:\Program Files\ImageMagick-7.0.6-Q16\convert.exe
c:\Windows\System32\convert.exe
```

On suppose que :

- vous avez cloné le site via Github Desktop dans un dossier `C:\Users\nom.prenom\Documents\GitHub\france`

- Vous conservez vos photos originales dans un répertoire sur votre bureau, par exemple : `C:\Users\nom.prenom\Documents\GitHub\france\sources`

- Vous chargez un jeu de photos dans ce dossier `sources`, au sein d'un dossier `aisne`

Pour que les chose sfonctionnent correctement, il faut mettre toutes les photos en portrait dans le répertoire `aisne` et toutes les photos en paysage dans le répertoire `aisne/landscape`

![landscape](landscape.png)


Ouvrez un explorateur Windows depuis le dossier `C:\Users\nom.prenom\Documents\GitHub\france` et lancez un invité de commande msdos depuis ce dossier :

![inviteMSDOS](inviteMSDOS.png)
```
traitement.bat sources/aisne AB 02-Aisne
```
celà va créer toutes les images 800x600 et les miniatures au bon endroit

![images](images.png)

Ensuite il faut aller dans GitHub Desktop, saisir un résumé, faire `commit to master` et `push origin`

![publication](publication.png)

Pour finir, il faut mettre à jour le fichier du menu de navigation 

[_data/navigation.yml](_data/navigation.yml)

par exemple, si l'on crée le département du Rhone, il faudrait faire passer le menu de :
```
- title: A-B
  url: "/AB"
  side: left
  dropdown:
  - title: "Aisne"
    url: "/AB/02-aisne"
```

à :

```
- title: A-B
  url: "/AB"
  side: left
  dropdown:
  - title: "Aisne"
    url: "/AB/02-aisne"
- title: M-R
  url: "/MR"
  side: left
  dropdown:
  - title: "Rhône"
    url: "/MR/69-rhone"
```

en supposant que l'on ait réalisé la génération des images avec la commande :

```
traitement.bat sources/rhone MR 69-Rhone
```


## pour faire fonctionner le site en local (facultatif)

il faut avoir jekyll : https://blog.smarchal.com/jekyll-sous-windows

```
jekyll serve --config _config.yml,_config_dev.yml
```
