# 🧠 Projet d’Infrastructure IT avec Proxmox, VPN, NFS et Bases de Données

Ce projet a pour objectif de moderniser l’infrastructure numérique** de l’institut Plaiaundi, en proposant un environnement technique **innovant et résilient**. Réalisé dans le cadre de ma formation ASIR, il sert de démonstration pour des journées portes ouvertes et met en valeur mes compétences en administration système et réseau.

---

## ⚙️ Technologies & Outils

- **Hyperviseur :** Proxmox VE (KVM + LXC)  
- **VPN :** OpenVPN (PKI, Diffie–Hellman, TLS-Auth, AES-256-GCM)  
- **Partage de fichiers :** NFS (exports.conf, montage automatique via fstab)  
- **Base de données :** MySQL/MariaDB (modélisation ER, normalisation, backups)  
- **Automatisation :** Bash, Ansible, scripts de déploiement et maintenance  
- **Web & Transformation :** HTML/CSS, XSLT & XML → génération de pages HTML  

---

## 📚 Architecture & Composants clés

1. **Proxmox VE**  
   - Installation et configuration initiale sur serveur dédié. VLANs isolées pour diffusion en classes ASIR
2. **Machines virtuelles**  
   - Serveur VPN (OpenVPN)  
   - Serveur NFS pour partage de dossiers professeurs/étudiants  
   - Serveur de base de données MySQL/MariaDB  
   - VM Xubuntu légères pour accès clients  
3. **Réseau & Sécurité**  
   - VLAN 10/20, ACLs, NAT et iptables-persistent pour redirection des ports (SSH, NFS, HTTP/S, VPN).
4. **Configuration VPN**  
   - PKI avec Easy-RSA, certificats client/server, push des routes DNS.
5. **Partage NFS**  
   - Exports configurés pour professeurs et étudiants, permissions POSIX et montage automatique.
6. **Base de données**  
   - Modèle entité-relation (1NF–3NF), sauvegarde via `mysqldump`, export CSV/XML, contrôle d’accès par rôles et IP.
7. **Génération Web**  
   - Transformation XML → HTML par XSLT pour publication des tables (Professeurs, Étudiants, Notes).



---

## 📝 Remarques

> Ce prototype a été conçu **à des fins pédagogiques**, toutes les configurations sont manuelles et documentées dans le [PDF joint](finalDocument.pdf). 

---

## 🧑‍💻 Auteurs

Ce projet a été réalisé par **Iñaki Spinardi et Oliver Ramajo**.


