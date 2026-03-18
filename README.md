
<p align="center">
  <img src="assets/gf-netstack.png" width="640">
</p>



## En cours de développement...  Currently in development...

---

<details>
  <summary>🇫🇷 Version Française</summary>

 
### SDK moderne, modulaire et extensible pour Fortran95 & Purebasic


## 📚 Table des matières
- [Introduction](#-introduction)
- [Architecture](#-architecture)
  - [Serveur TLS (C)](#serveur-tls-c)
  - [Client TLS (C)](#client-tls-c)
  - [Wrapper PureBasic](#wrapper-purebasic)
  - [Protocole JSON](#protocole-json)
- [Framing JSON](#-framing-json)
- [Exemples PureBasic](#-exemples-purebasic)
- [Sécurité](#-sécurité)
- [Fonctionnalités actuelles](#-fonctionnalités-actuelles)
- [Prochaines étapes](#-prochaines-étapes)
- [Structure du projet](#-structure-du-projet)

---

## 🔐 Introduction
TLSv2 est une couche de communication sécurisée basée sur :

- TLS (OpenSSL)  
- Un framing JSON robuste (4 bytes length + payload UTF‑8)  
- Un wrapper C stable  
- Des bindings PureBasic fonctionnels  
- Une architecture prête pour Fortran, Lua, PB, C, etc.

Objectif : fournir une base solide pour créer des protocoles applicatifs (commandes, messages, tables) sans se battre avec TLS ou les buffers.

---

## 🧱 Architecture

### Serveur TLS (C)
- Non‑bloquant  
- Multi‑clients  
- Basé sur `select()`  
- Handshake TLS automatique  
- Callbacks vers PB/C :  
  - `on_client_connected`  
  - `on_client_disconnected`  
  - `on_json_received`  

### Client TLS (C)
- Bloquant (simple et fiable)  
- `tlsv2_client_send_json()`  
- `tlsv2_client_recv_json()`  
- Parfait pour PB, Fortran, Lua, etc.

### Wrapper PureBasic
- Import direct du `.so/.dll/.dylib`  
- Callbacks PB → C  
- Fonctions client et serveur exposées  
- `ReceiveJSON()` sécurisé (UTF‑8, null‑terminated)

### Protocole JSON
Types supportés :

| Type | Description |
|------|-------------|
| `"text"` | Messages texte |
| `"command"` | Commandes (PING → PONG) |
| `"table"` | Réponses structurées (ex: SELECT_ALL) |

---

## 📡 Framing JSON
Format des messages :

```
[4 bytes length][JSON UTF‑8 payload]
```

- Longueur = uint32 big‑endian  
- JSON UTF‑8 propre  
- Compatible avec tous les langages

---

## 🧪 Exemples PureBasic

### Serveur PB
- Reçoit JSON  
- Dispatch selon `"type"`  
- Répond automatiquement  
- Exemples : TEXT, PING/PONG, TABLE

### Client PB
- Envoie TEXT → reçoit réponse  
- Envoie PING → reçoit PONG  
- Envoie TABLE → reçoit données structurées  
- `ReceiveJSON()` bloque jusqu’à réception complète

---

## 🔒 Sécurité
- TLS 1.2+ via OpenSSL  
- Certificat PEM + clé privée  
- Fermeture propre (SSL_shutdown)

---

## ✔ Fonctionnalités actuelles
- Serveur TLS multi‑clients  
- Client TLS stable  
- Framing JSON robuste  
- PureBasic serveur + client  
- PING/PONG  
- TEXT → reply  
- TABLE → données structurées  
- Buffers synchronisés (65536 bytes)  
- Aucun crash, aucune corruption mémoire  
- `.gitattributes` propre  

---

## 🚧 Prochaines étapes
- Bindings Fortran  
- Module PB “TLSv2Client”  
- Authentification  
- Gestion d’erreurs JSON  
- Intégration SQLite réelle  
- Documentation bilingue complète  



---

## 🧰 Command‑Line Interface (CLI)   (Ne fonctione pas en ce moment...)
J’ai écrit un petit script Lua pour simplifier les tâches courantes du SDK.
Il fonctionne de manière identique sur Windows, Linux et macOS.

### ▶️ Utilisation

Windows:

.\gf.ps1


Linux & macOS:

./gf.sh


### ▶️ Test rapide

```bash
./gf.sh hello
```
Résultat :  Hello from the unified GF CLI!

Ce test permet simplement de vérifier que tout fonctionne correctement.


### ⚙️ Commandes principales

* 🔍 Vérifier l’environnement

```bash
./gf.sh doctor
```

→ Vérifie les dépendances, l’environnement et l’état global du SDK.


* 🆕 Créer un nouveau module/projet

```bash
./gf.sh new @ARG
```

→ Crée un nouveau module ou projet nommé @ARG.


* 🏗️ Compiler un module

```bash
./gf.sh build @ARG
```

→ Compile @ARG.


* 🧹 Nettoyer les fichiers générés

```bash
./gf.sh clean @ARG
```

→ Supprime les fichiers générés pour @ARG.


* Démarrée l'apllication

```bash
./gf.sh run @ARG
```

→ Démarre l'application @ARG.

---



</details>

---

<details>
  <summary>🇬🇧 English Version</summary>

### SDK modern, modular and extensible for Fortran95 & Purebasic 


## 📚 Table of Contents
- [Introduction](#-introduction-1)
- [Architecture](#-architecture-1)
  - [TLS Server (C)](#tls-server-c)
  - [TLS Client (C)](#tls-client-c)
  - [PureBasic Wrapper](#purebasic-wrapper)
  - [JSON Protocol](#json-protocol)
- [JSON Framing](#-json-framing)
- [PureBasic Examples](#-purebasic-examples)
- [Security](#-security)
- [Current Features](#-current-features)
- [Next Steps](#-next-steps)
- [Project Structure](#-project-structure)

---

## 🔐 Introduction
TLSv2 is a secure communication layer built on:

- TLS (OpenSSL)  
- Robust JSON framing (4 bytes length + UTF‑8 payload)  
- A clean and stable C wrapper  
- Functional PureBasic bindings  
- A design ready for Fortran, Lua, PB, C, and more

Goal: provide a solid foundation for application‑level protocols without fighting TLS or buffer management.

---

## 🧱 Architecture

### TLS Server (C)
- Non‑blocking  
- Multi‑client  
- `select()` based  
- Automatic TLS handshake  
- Callbacks to PB/C:  
  - `on_client_connected`  
  - `on_client_disconnected`  
  - `on_json_received`  

### TLS Client (C)
- Blocking (simple and reliable)  
- `tlsv2_client_send_json()`  
- `tlsv2_client_recv_json()`  
- Ideal for PB, Fortran, Lua, etc.

### PureBasic Wrapper
- Direct import of `.so/.dll/.dylib`  
- PB → C callbacks  
- Exposes client and server functions  
- Safe `ReceiveJSON()` (UTF‑8, null‑terminated)

### JSON Protocol
Supported types:

| Type | Description |
|------|-------------|
| `"text"` | Simple text messages |
| `"command"` | Commands (PING → PONG) |
| `"table"` | Structured responses (e.g., SELECT_ALL) |

---

## 📡 JSON Framing
Each message is encoded as:

```
[4 bytes length][JSON UTF‑8 payload]
```

- Length = uint32 big‑endian  
- Clean UTF‑8 JSON  
- Compatible with any language

---

## 🧪 PureBasic Examples

### PB Server
- Receives JSON  
- Dispatches based on `"type"`  
- Automatically replies  
- Examples: TEXT, PING/PONG, TABLE

### PB Client
- Sends TEXT → receives reply  
- Sends PING → receives PONG  
- Sends TABLE → receives structured data  
- `ReceiveJSON()` blocks until full message is received

---

## 🔒 Security
- TLS 1.2+ via OpenSSL  
- PEM certificate + private key  
- Clean shutdown (SSL_shutdown)

---

## ✔ Current Features
- Multi‑client TLS server  
- Stable TLS client  
- Robust JSON framing  
- PureBasic server + client  
- PING/PONG  
- TEXT → reply  
- TABLE → structured data  
- Synchronized buffers (65536 bytes)  
- No crashes, no memory corruption  
- Clean `.gitattributes`  

---

## 🚧 Next Steps
- Fortran bindings  
- PB “TLSv2Client” module  
- Authentication  
- Standardized JSON error handling  
- Real SQLite integration  
- Full bilingual documentation  


---


## 🧰 Command‑Line Interface (CLI)  (Not working at this time...)
I wrote a small Lua script to simplify common SDK tasks.
It behaves the same on Windows, Linux, and macOS.

### ▶️ Usage

Windows:

.\gf.ps1


Linux & macOS:

./gf.sh



### ▶️ Quick Test

```bash
./gf.sh hello
```

Result:  Hello from the unified GF CLI!

This simple test ensures everything is working correctly.

### ⚙️ Main Commands

* 🔍 Check the environment

```bash
./gf.sh doctor
```

→ Checks dependencies, the environment, and the overall state of the SDK.


* 🆕 Create a new module/project

```bash
./gf.sh new @ARG
```

→ Creates a new module or project named @ARG.

* 🏗️ Build a module

```bash
./gf.sh build @ARG
```

→ Builds @ARG.

* 🧹 Clean generated files

```bash
./gf.sh clean @ARG
```

→ Removes generated files for @ARG.

* ▶️ Run the application

```bash
./gf.sh run @ARG
```

→ Starts the application @ARG.

---


</details>


---

## 👤 Auteur  /  Author

* Guillaume Foisy  

* Passionné par la modernisation de l’écosystème Fortran95 & Purebasic

* Dedicated to modernizing the Fortran95 & Purebasic ecosystem
