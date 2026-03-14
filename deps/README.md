# GF‑Fortran‑SDK (deps/)

### Dépendances externes --  External Dependencies


<details>
  <summary>🇫🇷 Version Française</summary>
  
# Dépendances externes — GF‑Fortran‑SDK

Ce répertoire contient toutes les **bibliothèques tierces** intégrées au  
**GF‑Fortran‑SDK**, afin d’offrir une expérience de développement complète,  
multiplateforme et sans installation externe.

L’objectif est simple :  
➡️ **aucune dépendance à installer pour l’utilisateur final**  
➡️ **des versions stables et contrôlées**  
➡️ **des builds reproductibles sur toutes les plateformes**

---

## 📚 Dépendances incluses

### ✔ 1. OpenSSL (TLS & Cryptographie)  
Dossier : `deps/openssl/`

Utilisé pour :

- Communications TLS sécurisées  
- Gestion des certificats  
- Fonctions cryptographiques (SHA, AES, RSA, etc.)

Contenu :

- `bin/` → DLL / SO / DYLIB  
- `lib/` → bibliothèques statiques et d’importation  
- `include/` → en-têtes publics OpenSSL  

Version : **OpenSSL 3.5.x LTS (support jusqu’en 2030)**  
Licence : **Apache 2.0 + OpenSSL Exception**  
Voir : `deps/openssl/LICENSE`

---

### ✔ 2. f90GL (Bindings Fortran pour OpenGL)  
Dossier : `deps/f90gl/`

Utilisé pour :

- Rendu graphique  
- Visualisation  
- Modules UI futurs du SDK

Contenu :

- `bin/`  
- `lib/`  
- `include/`  

Licence : incluse dans `deps/f90gl/LICENSE`

---

## 🧱 Pourquoi intégrer les dépendances ?

- Builds reproductibles  
- Aucun prérequis externe  
- Comportement identique sur toutes les plateformes  
- Simplification maximale pour les utilisateurs du SDK  
- Contrôle total des versions et de l’ABI

---

## 🛠️ Scripts de compilation

Le SDK inclut des scripts permettant de reconstruire les dépendances depuis les sources :

- `build_openssl_windows.ps1`  
- `build_openssl_linux.sh`  
- *(optionnel)* scripts de build pour f90GL

Ces scripts téléchargent, compilent et installent les bibliothèques dans  
`deps/<librairie>/<plateforme>/`.

---

## 📁 Structure du répertoire

```
deps/
 ├── openssl/
 │    ├── windows/
 │    ├── linux/
 │    └── macos/   (optionnel)
 └── f90gl/
      ├── windows/
      ├── linux/
      └── macos/   (optionnel)
```

Chaque plateforme contient :

- `bin/`  
- `lib/`  
- `include/`

---

## 🤝 Crédits

Toutes les bibliothèques tierces appartiennent à leurs auteurs respectifs.  
Le GF‑Fortran‑SDK ne modifie pas leur code source et les redistribue uniquement  
pour offrir un SDK complet et prêt à l’emploi.

Veuillez consulter les fichiers LICENSE de chaque dépendance pour plus d’informations.

</details>


---


<details>
  <summary>🇬🇧 English Version</summary>

# External Dependencies — GF‑Fortran‑SDK

This directory contains all **third‑party libraries** bundled with the  
**GF‑Fortran‑SDK**, providing a fully self‑contained, cross‑platform development  
environment.

The goal is simple:  
➡️ **no external installation required**  
➡️ **stable, controlled versions**  
➡️ **reproducible builds across all platforms**

---

## 📚 Included Dependencies

### ✔ 1. OpenSSL (TLS & Cryptography)  
Folder: `deps/openssl/`

Used for:

- Secure TLS communication  
- Certificate handling  
- Cryptographic primitives (SHA, AES, RSA, etc.)

Contents:

- `bin/` → DLL / SO / DYLIB  
- `lib/` → static and import libraries  
- `include/` → OpenSSL public headers  

Version: **OpenSSL 3.5.x LTS (supported until 2030)**  
License: **Apache 2.0 + OpenSSL Exception**  
See: `deps/openssl/LICENSE`

---

### ✔ 2. f90GL (Fortran OpenGL Bindings)  
Folder: `deps/f90gl/`

Used for:

- Graphics rendering  
- Visualization  
- Future UI modules in the SDK

Contents:

- `bin/`  
- `lib/`  
- `include/`  

License: included in `deps/f90gl/LICENSE`

---

## 🧱 Why bundle dependencies?

- Reproducible builds  
- Zero external requirements  
- Identical behavior across platforms  
- Simplified onboarding for SDK users  
- Full control over versions and ABI stability

---

## 🛠️ Build Scripts

The SDK includes helper scripts to rebuild dependencies from source:

- `build_openssl_windows.ps1`  
- `build_openssl_linux.sh`  
- *(optional)* f90GL build scripts

These scripts download, compile, and install the libraries into  
`deps/<library>/<platform>/`.

---

## 📁 Directory Structure

```
deps/
 ├── openssl/
 │    ├── windows/
 │    ├── linux/
 │    └── macos/   (optional)
 └── f90gl/
      ├── windows/
      ├── linux/
      └── macos/   (optional)
```

Each platform folder contains:

- `bin/`  
- `lib/`  
- `include/`

---

## 🤝 Credits

All third‑party libraries included here are the property of their respective  
authors and maintainers. GF‑Fortran‑SDK does not modify their source code and  
redistributes them solely to provide a complete, ready‑to‑use SDK.

Please refer to each dependency’s LICENSE file for details.

</details>
