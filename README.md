# GestionMagasin

GestionMagasin est une application Flutter de gestion de magasin conçue pour aider les utilisateurs à gérer efficacement leurs clients, commandes, produits et tâches. Cette application cible principalement les petites et moyennes entreprises souhaitant digitaliser et simplifier la gestion de leur magasin.

## Fonctionnalités principales

- Gestion des clients : ajout, modification, suppression et consultation des informations clients.
- Gestion des commandes : création, suivi et gestion des commandes.
- Gestion des produits : gestion du catalogue de produits avec détails et images.
- Gestion des tâches : organisation et suivi des tâches liées à la gestion du magasin.

## Technologies et dépendances

Cette application utilise les technologies et dépendances suivantes :

- Flutter SDK
- GetX pour la gestion de l'état et la navigation
- HTTP pour les requêtes réseau
- Shared Preferences pour le stockage local
- Path pour la gestion des chemins de fichiers
- Lottie pour les animations
- Cached Network Image pour la gestion des images en cache
- Dartz pour la programmation fonctionnelle
- XML pour le traitement XML

## Structure du projet

- `lib/` : Contient le code source Dart de l'application.
  - `bindings/` : Gestion des dépendances avec GetX.
  - `controller/` : Contrôleurs pour la logique métier.
  - `core/` : Classes utilitaires, constantes, fonctions, services, et middleware.
  - `data/` : Sources de données, modèles, et accès aux données distantes et statiques.
  - `view/` : Écrans et widgets de l'interface utilisateur.
  - `routes.dart` : Définition des routes de navigation.
  - `main.dart` : Point d'entrée de l'application.
- `android/` et `ios/` : Code natif pour les plateformes Android et iOS.
- `assets/` : Ressources statiques comme les images, polices, et animations Lottie.
- `test/` : Tests unitaires et widget tests.
- `web/` : Fichiers pour la version web de l'application.

## Prérequis

- Avoir installé le [Flutter SDK](https://flutter.dev/docs/get-started/install).
- Avoir un éditeur compatible Flutter (ex: VSCode, Android Studio).
- Un appareil ou émulateur Android/iOS pour exécuter l'application.

## Installation

1. Clonez ce dépôt :
   ```bash
   git clone <url-du-depot>
   ```
2. Accédez au répertoire du projet :
   ```bash
   cd endyear_2025_gr01_mobileapp
   ```
3. Installez les dépendances :
   ```bash
   flutter pub get
   ```

## Lancer l'application

Pour lancer l'application sur un appareil connecté ou un émulateur, exécutez :
```bash
flutter run
```

## Utilisation

- L'application démarre sur l'écran de connexion.
- Après authentification, vous accédez à l'écran principal avec accès aux clients, commandes, produits et tâches.
- Naviguez via le menu pour gérer les différentes entités.

## Contribution

Les contributions sont les bienvenues. Veuillez ouvrir une issue ou soumettre une pull request pour proposer des améliorations ou corriger des bugs.

## Support

Pour toute question ou problème, veuillez contacter l'équipe de développement ou ouvrir une issue sur le dépôt.
