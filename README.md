# Questionnaire Memoire Episodique (HARMORYC)

Application Flet pour le questionnaire de memoire episodique (V2).

## Lancer l'application

Sous Windows:
- (optionnel) lancer `install_dependencies.bat` pour installer Python/venv + dependances
- Double-cliquer sur `run_app.bat`
- Ou `run_app_debug.bat` pour un log plus verbeux

## Raccourcis

- `Ctrl+N`: ouvrir/fermer le panneau de navigation

## Structure des assets

Les images sont lues depuis `assets/Dossier Exemple` (aucune copie n'est faite).
Structure attendue:

- `assets/Dossier Exemple/Salles/Room1 ... Room10`
- `assets/Dossier Exemple/Objets/Objets Familiers (OF)/OF1 ... OF10`
- `assets/Dossier Exemple/Objets/Objets nouveaux (NO)/NO1 ... NO10`
- `assets/Dossier Exemple/Rappel immediat/Salles correctes`
- `assets/Dossier Exemple/Rappel immediat/Salles incorrectes`
- `assets/Dossier Exemple/Etapes IIB/Objets familiers (OF)/OF1/...`
- `assets/Dossier Exemple/Etapes IIB/Nouveaux objets (NO)/NO1/...`

Les images manquantes tombent sur les visuels par defaut dans `assets/`.

## Randomisation

Dans `app.py`, modifier:

```
RANDOM_MODE = "fixed"       # ordre commun a tous
RANDOM_MODE = "per_session" # ordre different a chaque session
```

## Flux V2

- Rappel immediat (RI)
- Etape I: reconnaissance d'objets (OF/NO)
- Etape IIA: choix de la salle (what-where)
- Etape IIB: position spatiale (what-where)
- Etape III: jour / nuit par salle (where-when)
- Etape IV: ordre des salles (seriel)
- Etape V: rappel tardif inverse (correct/incorrect)

Bouton "Je ne sais pas" sur toutes les questions.

## Sessions et JSON

Les sessions sont enregistrees dans `sessions/`.
Le depot ignore les fichiers `sessions/*.json` mais conserve un exemple:
`sessions/example_session.json`.

Le JSON contient:
- `session.scores`: scores par etape
- `session.metrics`: metriques agreges (hits, fausses alarmes, erreurs, etc.)
- `tasks`: reponses detaillees par question

