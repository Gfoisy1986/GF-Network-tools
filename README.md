# **GF‑Fortran-SDK**
Un ensemble d’outils réseau modulaires écrits en **Fortran** avec des **wrappers C**, conçus pour construire des serveurs et clients modernes : TCP, TLS et WebSocket.  
Le projet met l’accent sur une architecture claire, modulaire et extensible, inspirée des environnements de développement simples comme PureBasic, mais avec la puissance et la performance du backend Fortran/C.

---


## 🚀 **Vision du projet**

GF‑Fortran‑SDK a pour ambition de devenir un **écosystème complet** pour développer des applications modernes en Fortran95.  
Le projet dépasse largement la simple notion “d’outils réseau” : il vise à offrir un **SDK modulaire**, clair et extensible, regroupant tout ce dont un développeur Fortran a besoin pour créer des applications réseau, graphiques et interactives.

L’objectif est de fournir :

### 🧱 **Un backend réseau moderne et portable**
- Modules indépendants pour **TCP**, **TLS**, **WebSocket**
- Wrappers C minimalistes pour combler les limites du standard Fortran
- Architecture propre, stable et facile à maintenir

### 🧩 **Une API haut niveau simple et intuitive**
Inspirée de la simplicité de PureBasic, permettant d’écrire :

```fortran
conn = OpenNetworkConnection("example.com", 443, useTLS=.true.)
call SendString(conn, "ping")
reply = ReceiveString(conn)
```

Sans jamais exposer la complexité interne.

### 🎨 **Une future API UI basée sur f90GL**
Pour créer des interfaces graphiques modernes en Fortran :

- Fenêtres  
- Boutons  
- Labels  
- Sliders  
- Layout automatique  
- Intégration directe avec l’API réseau  

### 🌐 **Support futur de protocoles standards**
Le SDK est pensé pour évoluer vers :

- HTTP/HTTPS  
- MQTT  
- CoAP  
- POP3 / SMTP / IMAP  
- Redis / Memcached  
- WebSocket avancé  
- Services cloud  

### 🛠️ **Un environnement complet pour Fortran moderne**
À long terme, GF‑Fortran‑SDK vise à offrir :

- Un **IDE spécialisé** 
- Des **templates de projets** (UI, réseau, agents, outils)  
- Une **documentation claire**  
- Des **exemples complets**  
- Une **API stable** pour construire des applications robustes et performantes  

---



## 📁 **Structure actuelle du projet**
Le dépôt est en cours de restructuration pour séparer clairement les couches :

```
net/        → Backend bas niveau (TCP, TLS, crypto, wrappers C)
ws/         → Serveur & client WebSocket (WSS)
tcp/        → Serveur & client TCP
tcp-tls/    → Serveur & client TCP+TLS
```

Chaque section aura son propre README détaillé plus tard.

---

## 🧩 **État actuel**
- Serveur WebSocket (WSS) fonctionnel  
- Client réseau propre en développement  
- Backend TCP/TLS stable  (nouvelle version en cour)
- Nettoyage et réorganisation du dépôt en cours  
- API haut niveau en réflexion (`OpenNetworkConnection()`, etc.)

---

## 🛠️ **Technologies**
- **Fortran 95+**  
- **C Wrappers** (TCP, TLS, Crypto)  
- **OpenSSL** (TLS, SHA‑1, Base64)  
- **Select()** pour la gestion multi‑clients  
- **WebSocket RFC 6455** (handshake + framing)


---

## Dépendances externes

GF‑Fortran‑SDK nécessite un compilateur Fortran compatible F95 ou supérieur :
- GNU Fortran (recommandé)
- Intel Fortran
- LLVM Flang

---

Guillaume Foisy
