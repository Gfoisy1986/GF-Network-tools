# Headers & API Interfaces  
*GF‑Fortran‑SDK*

Ce répertoire contient les **interfaces publiques**, les **modules d’en-tête** et les **définitions d’API** exposées par le GF‑Fortran‑SDK.  
Il s’agit de la couche contractuelle du SDK : tout ce qui est nécessaire pour utiliser les fonctionnalités (réseau, UI, protocoles, outils, wrappers C, etc.) sans exposer l’implémentation interne.

---

## 🎯 Rôle du dossier

- Centraliser les **interfaces stables** du SDK  
- Offrir une **API cohérente et documentée** pour les développeurs Fortran  
- Séparer clairement **l’implémentation** (`src/`) de **l’exposition publique** (`include/`)  
- Préparer la base pour une **distribution multi‑plateforme** (headers + modules précompilés)  
- Servir de point d’entrée pour les IDE, outils externes et futurs bindings

---





