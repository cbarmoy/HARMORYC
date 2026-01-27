# Questionnaire Memoire Episodique (HARMORYC)

Application Flet pour le questionnaire de memoire episodique (V2).

## Lancer l'application (Windows)

- (optionnel) lancer `install_dependencies.bat` pour installer Python/venv + dependances
- Double-cliquer sur `run_app.bat`

## Build standalone (Windows)

- Lancer `build_standalone.bat`
- L'executable est genere dans `dist/` (un seul .exe si possible)
- Pour l'exe, garder le dossier `assets/` a cote si les images ne sont pas embarquees

## Raccourcis

- `Ctrl+N`: ouvrir/fermer le panneau de navigation

## Structure des assets

Les images sont lues depuis `assets/HARMORYC_VR_images_rappels`.
Structure attendue:

- `assets/HARMORYC_VR_images_rappels/Start_Room/Room1 ... Room10`
- `assets/HARMORYC_VR_images_rappels/Objets/Objets_familiers (OF)/OF1 ... OF10`
- `assets/HARMORYC_VR_images_rappels/Objets/Nouveaux_objets (NO)/NO1 ... NO10`
- `assets/HARMORYC_VR_images_rappels/Rappel_immediat/Salles_correctes`
- `assets/HARMORYC_VR_images_rappels/Rappel_immediat/Salles_incorrectes`
- `assets/HARMORYC_VR_images_rappels/EtapesIIB/OF/OF1/...`
- `assets/HARMORYC_VR_images_rappels/EtapesIIB/NO/NO1/...`
- `assets/HARMORYC_VR_images_rappels/EtapesV/Salles correctes`
- `assets/HARMORYC_VR_images_rappels/EtapesV/Salles incorrectes`

Les images manquantes tombent sur les visuels par defaut dans `assets/`
(logos et images Default_*).

## Randomisation

Dans `app.py`, modifier:

```
RANDOM_MODE = "fixed"       # ordre commun a tous
RANDOM_MODE = "per_session" # ordre different a chaque session
```

## Grille 10 salles (ordre fixe)

Quand on propose 10 salles, l'ordre est fixe:
`r8 r5 r3 r7 r4 / r6 r10 r9 r2 r1`

## Flux V2

- Rappel immediat (RI)
- Etape I: reconnaissance d'objets (OF/NO)
- Etape IIA: choix de la salle (what-where)
- Etape IIB: position spatiale (what-where)
- Etape III: jour / nuit par salle (where-when)
- Etape IV: ordre des salles (seriel)
- Etape V: rappel tardif inverse (correct/incorrect)
- Rappel immediat final (meme logique que RI)

Bouton "Je ne sais pas" sur toutes les questions.

## Sessions et JSON

Les sessions sont enregistrees dans `sessions/`.
Le depot ignore les fichiers `sessions/*.json` mais conserve un exemple:
`sessions/example_session.json`.

Le JSON contient:
- `session.scores`: scores par etape
- `session.metrics`: metriques agreges (hits, fausses alarmes, erreurs, etc.)
- `tasks`: reponses detaillees par question

Quand le sujet ne repond pas, la valeur enregistre est `ne_repond_pas`.

## Requirements

Les dependances sont dans `requirements.txt`.

