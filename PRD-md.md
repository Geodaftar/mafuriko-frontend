# Product Requirement Document (PRD)

## Introduction

### Vision du produit
Mafuriko est une application mobile destinée à la collecte et à la visualisation des alertes d'incidents tels que les inondations, incendies et éboulements à Abidjan. L'application vise à fournir des informations en temps réel pour aider les habitants à rester informés et en sécurité.

### Objectifs du produit
- Faciliter la collecte et la soumission d'alertes par les utilisateurs.
- Offrir une visualisation claire et intuitive des alertes sur une carte.
- Permettre la vérification et l'évaluation des alertes soumises.
- Fournir des informations et des prédictions basées sur les données historiques.

### Portée du produit
Pour sa phase MVP, Mafuriko se concentre sur les incidents (inondations, incendies, effondrements…) se produisant à Abidjan et peut s'étendre à d'autres régions à l'avenir.

### Définition du succès
Le succès de l'application sera mesuré par :
- Le nombre d'utilisateurs actifs
- Le nombre d’alertes (vérifiées) soumises par semaine
- [Plus tard] l’efficacité des prévisions.

## Description du produit

### Fonctionnalités principales
- Inscription et connexion des utilisateurs.
- Soumission et visualisation des alertes.
- Vérification des alertes par la communauté.
- Consultation des annonces officielles et des prévisions.

### Cas d'utilisation
- Un utilisateur souhaite signaler une inondation près de chez lui.
- Un utilisateur veut voir toutes les alertes récentes dans son quartier.
- Un reviewer souhaite confirmer la véracité d'une alerte soumise.

### Backlog

#### En tant qu’utilisateur, je veux m’inscrire sur Mafuriko.
- L'utilisateur peut saisir son nom, email et mot de passe.
- Un email de confirmation est envoyé après l'inscription.
- L'inscription est réussie uniquement si toutes les informations sont valides.

#### En tant qu’utilisateur, je veux me connecter à l’application.
- L'utilisateur peut se connecter avec son email et mot de passe.
- Une notification d'erreur s'affiche si les informations sont incorrectes.
- L'utilisateur est redirigé vers le tableau de bord après une connexion réussie.

#### En tant qu’utilisateur, je veux modifier mon mot de passe (oublié).
- L'utilisateur peut demander une réinitialisation de mot de passe en entrant son email.
- Un lien de réinitialisation est envoyé à l'email fourni.
- L'utilisateur peut définir un nouveau mot de passe via le lien de réinitialisation.

#### En tant qu’utilisateur, je veux accéder à une liste des alertes proches de ma localisation.
- L'utilisateur peut voir une liste des alertes dans un rayon défini autour de sa localisation actuelle.
- Les alertes sont triées par date et heure.
- Chaque alerte affiche des informations de base telles que le type, la date et la distance.

#### En tant qu’utilisateur, je veux accéder à une carte des alertes proches de ma localisation.
- L'utilisateur peut voir une carte interactive affichant les alertes récentes.
- Les alertes sont marquées par des icônes différentes selon leur type.
- L'utilisateur peut cliquer sur une alerte pour voir plus de détails.

#### En tant qu’utilisateur, je veux soumettre une alerte.
- L'utilisateur peut soumettre une alerte en entrant des détails tels que le type d'incident, la description et la localisation.
- L'alerte doit inclure une photo pour être valide.
- L'utilisateur reçoit une confirmation après la soumission réussie de l'alerte.

#### En tant que reviewer, je veux confirmer/signaliser une alerte/emetteur (vote feature).
- Le reviewer peut voter pour confirmer ou signaler une alerte.
- Chaque alerte affiche le nombre de votes de confirmation et de signalement.
- Un seuil de votes déclenche une action automatique (alerte confirmée ou signalée).

#### En tant qu’utilisateur, je veux consulter le score de crédibilité d’une alerte/de l’emetteur.
- Chaque alerte affiche un score de crédibilité basé sur les votes et l'historique de l'emetteur.
- Les utilisateurs peuvent voir l'historique de crédibilité des emetteurs d'alertes.
- Le score de crédibilité est mis à jour en temps réel en fonction des nouvelles interactions.

#### En tant qu’utilisateur, je veux consulter les annonces des sources locales officielles (Sodexam & police secours).
- Les utilisateurs peuvent accéder aux annonces et mises à jour des sources officielles.
- Les annonces sont triées par date et heure.
- Chaque annonce contient des détails tels que la source, la date et le contenu.

#### En tant qu’utilisateur, je souhaite partager une alerte hors de l’application.
- L'utilisateur peut partager une alerte via les réseaux sociaux, email ou SMS.
- Un lien unique est généré pour chaque alerte partagée.
- Les alertes partagées contiennent un résumé et un lien pour plus de détails.

#### En tant qu’utilisateur, je souhaite télécharger une base de données géographique (.gdb) l’historique des alertes.
- L'utilisateur peut télécharger une base de données géographique contenant l'historique des alertes.
- La base de données est mise à jour régulièrement.
- Le téléchargement est disponible dans plusieurs formats, y compris .gdb.

#### En tant qu’utilisateur, je veux consulter des prédictions pour une zone sélectionnée basées sur un historique vérifié.
- L'utilisateur peut sélectionner une zone sur la carte pour voir les prédictions.
- Les prédictions sont basées sur l'historique vérifié des incidents dans la zone.
- Les utilisateurs peuvent voir des graphiques et des analyses des tendances.

#### En tant qu’utilisateur, je veux consulter une heatmap des risques basé sur l’historique vérifié.
- L'utilisateur peut voir une heatmap des risques sur la carte interactive.
- La heatmap est basée sur l'historique vérifié des incidents.
- Les zones de risque sont mises à jour en temps réel.

## Contraintes et considérations

### Limitations techniques
- Nécessité d'une connexion internet pour soumettre et consulter les alertes.
- Gestion de la charge et de la performance pour un grand nombre d'utilisateurs.

### Dépendances
- Intégration avec les services de géolocalisation (Openstreetmap).
- [Plus tard] Accès aux données des sources officielles comme Sodexam et police secours.

## Planification et jalons

### Phases de développement
- Phase 1 : Développement des fonctionnalités de base (inscription, connexion, soumission d'alertes).
- Phase 2 : Développement des fonctionnalités de visualisation (liste et carte des alertes).
- Phase 3 : Intégration des fonctionnalités de vérification (vérification des alertes, scores de crédibilité utilisateurs, scores de crédibilité alerte).
- Phase 4 : Intégration des fonctionnalités d’évaluation des risques par zone (recherches et analyses sur la zone).

### Dates importantes
- Prototype initial : [Date]
- Version bêta : [Date]
- Lancement officiel : [Date]
