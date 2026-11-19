<img width="1920" height="1080" alt="Capture d’écran 5" src="https://github.com/user-attachments/assets/2c88f3d3-2ab7-47b3-8b8f-482e67da4749" />
<img width="1920" height="1080" alt="Capture d’écran 4" src="https://github.com/user-attachments/assets/32d90036-5fb6-4922-a409-3efaa745d683" />
<img width="1920" height="1080" alt="Capture d’écran 3" src="https://github.com/user-attachments/assets/5f3529ac-a5ee-4920-b67d-ba44baae94c8" />
<img width="1920" height="1080" alt="Capture d’écran 1" src="https://github.com/user-attachments/assets/1307c31c-4b07-4895-95d6-5297f28a6e7b" />
<img width="1920" height="1080" alt="Capture d’écran 2" src="https://github.com/user-attachments/assets/9ee3c130-c072-4e37-b7e2-34da12076dba" />
# cv_flutter_steve

Application Flutter de présentation d’un CV, de la famille et des coordonnées.
L’application est entièrement côté client : la connexion est une démonstration
locale, sans serveur, compte utilisateur ni stockage des identifiants.

## Fonctionnalités

- Écran de connexion avec validation des champs et mot de passe masqué.
- Page CV : profil, formation, expériences et projets, compétences, langues et
  centres d’intérêt.
- Page Famille : liste d’exemples à remplacer par les personnes de votre
  famille.
- Page Contact : e-mail, téléphone, adresse et liens sociaux. Les actions
  e-mail, téléphone et liens ouvrent l’application correspondante si elle est
  disponible.
- Navigation entre les pages et bouton de déconnexion.

Les informations affichées (notamment les coordonnées et les exemples de
famille) sont des données de démonstration. Personnalisez-les dans
`lib/main.dart` avant de partager l’application. La photo de profil fournie se
trouve dans `assets/images/profile.jpeg`.

## Lancer l’application

```bash
flutter pub get
flutter run
```

Pour ouvrir la démonstration, entrez n’importe quel identifiant et mot de passe
non vides. Ces champs ne sont ni vérifiés contre un serveur ni conservés.

## Captures d’écran

Ajoutez ici une capture d’écran de chacune des pages avant de remettre ou de
publier le projet :

| Connexion | CV | Famille | Contact |
|---|---|---|---|
| À capturer | À capturer | À capturer | À capturer |

## Tests

```bash
flutter test
```
