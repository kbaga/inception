# Inception 🐳

## 📖 Description

Inception est un projet visant à mettre en place une infrastructure complète de type **WordPress** en utilisant **Docker** et **Docker Compose**, conformément au sujet Inception de l’école 42.

L’objectif est de concevoir une architecture modulaire, sécurisée et persistante, sans utiliser d’images Docker préconstruites (hors images de base).

---

## 🧱 Architecture

Client (Browser / curl)
|
HTTPS (443)
|
NGINX
|
FastCGI (9000)
|
PHP-FPM (WordPress)
|
TCP (3306)
|
MariaDB


---

## 🧩 Services

### 🔹 NGINX
- Point d’entrée unique de l’infrastructure
- Écoute uniquement sur le port **443 (HTTPS)**
- Gère les certificats SSL auto-signés
- Redirige les requêtes PHP vers PHP-FPM
- Aucun autre port exposé

### 🔹 WordPress
- Fonctionne avec **PHP-FPM**
- Aucun serveur web embarqué
- Configuration automatisée au lancement
- Communique avec MariaDB via un utilisateur dédié

### 🔹 MariaDB
- Base de données utilisée par WordPress
- Données persistées via un volume Docker
- L’utilisateur `root` est sécurisé par **unix_socket**
- WordPress utilise un utilisateur applicatif spécifique

---

## 🔐 Sécurité

- HTTPS obligatoire
- Aucun accès HTTP
- Aucun accès root distant à MariaDB
- Un seul port exposé : **443**
- Réseau Docker privé entre les services

---

## 📂 Volumes

Les données sont persistées via deux volumes Docker :

- `wordpress_data` : fichiers WordPress
- `mariadb_data` : données MariaDB

Les données sont conservées même après un redémarrage des conteneurs.

---

## ⚙️ Variables d’environnement

Les variables sensibles sont définies dans un fichier `.env` :

```env
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=********
MYSQL_ROOT_PASSWORD=********

WP_TITLE=Inception
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=********
WP_ADMIN_EMAIL=admin@example.com

# 🚀 Lancement du projet
Prérequis

Docker

Docker Compose
---
###Commandes
```docker compose build
docker compose up -d
```

## 🌐 Accès au site

Le site WordPress est accessible via l’URL suivante :

https://localhost


> ⚠️ Le certificat SSL est auto-signé.
> Il est normal que le navigateur affiche un avertissement de sécurité lors de la première connexion.
> Il suffit de l’accepter pour accéder au site.

### Accès alternatif

Selon la configuration locale, le site peut également être accessible via :

https://localhost:4443


Cette option est utile pour éviter certains comportements de cache HTTPS (HSTS) des navigateurs.

