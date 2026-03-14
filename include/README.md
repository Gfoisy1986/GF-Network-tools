# GF‑Fortran‑SDK — Interfaces Publiques

Ce répertoire contient les interfaces publiques du SDK : modules Fortran, définitions d’API et en‑têtes exposés aux utilisateurs.  

Il s’agit de la couche contractuelle du SDK : tout ce qui est nécessaire pour utiliser les fonctionnalités du SDK sans exposer l’implémentation interne.

---

## 🎯 Rôle du dossier

- Centraliser les **interfaces stables** du SDK  
- Offrir une **API Fortran moderne**, cohérente et documentée  
- Séparer clairement l’implémentation (`src/`) de l’exposition publique (`include/`)  
- Servir de point d’entrée pour les développeurs, IDE, outils externes et futurs bindings  
- Préparer la base pour une distribution multiplateforme (modules précompilés)

---

## 📌 Ce que vous trouverez ici

- Modules Fortran publics  
- Interfaces stables et versionnées  
- Types, constantes et signatures destinées aux utilisateurs  
- API “new‑gen” du SDK (haut niveau ou intermédiaire selon les besoins)

---

## 🚫 Ce que vous ne trouverez pas ici

- Implémentation interne  
- Wrappers C  
- FFI Fortran  
- Code expérimental ou instable  
- Démos ou prototypes (`src/core/`)

---

## 🧭 Comment utiliser

Les utilisateurs importent simplement les modules exposés ici :

```fortran
use gf_sdk_network
use gf_sdk_ui
use gf_sdk_core
```

Ces modules sont garantis stables et portables sur toutes les plateformes supportées.

---

## 🧱 Relation avec le reste du SDK


deps/                 # Dépendances natives (non public)
src/
  wrappers/           # C & Fortran FFI (interne)
  modules/            # Logique Fortran intermédiaire
  api/                # API haut niveau
  core/               # Démos internes / prototypes
include/              # API publique Fortran (ce dossier)
examples/             # Exemples simples pour les utilisateurs


Ce dossier représente la **face publique officielle** du SDK.

