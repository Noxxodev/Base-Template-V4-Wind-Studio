# Base Template V4 — Wind Studio (FR)

Base de serveur **FiveM** prête à l'emploi, construite sur **ESX** et l'écosystème **OX**, avec les scripts maison de **Wind Studio**.

💬 Besoin d'aide ? Rejoins le Discord : **https://discord.gg/7SBn6ygS87**

---

## 📦 Contenu

| Dossier | Ressources |
|---|---|
| `[Default]` | chat, cc-chat, bob74_ipl, hardcap, sessionmanager, spawnmanager, yarn, webpack, jsfour-idcard |
| `[ESX]` | es_extended (1.13.4), esx_identity, esx_basicneeds, esx_optionalneeds, esx_status, esx_license, esx_addonaccount, esx_menu_default, esx_notify, cron |
| `[OX]` | oxmysql, ox_lib (3.32.2), ox_target, ox_inventory (2.44.8), ox_fuel, ox_doorlock, illenium-appearance |
| `[HUD]` | hud, loadingscreen |
| `[WIND]` | WS_Core, WS_Admin, WS_F5 |

### Scripts Wind Studio

- **WS_Core** : `/me`, porter un joueur (`/porter`), location de véhicules, météo et heure, téléportations, Cayo Perico, colormap
- **WS_Admin** : menu admin (`/menuadmin`), noclip (`/adminnoclip`)
- **WS_F5** : menu personnel (touche `F5`)

---

## ✅ Prérequis

- [Artifacts FiveM](https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/) récents (avec txAdmin)
- Un serveur **MySQL / MariaDB** (XAMPP, WAMP, Laragon ou celui de ton hébergeur)
- Une clé de licence Cfx.re : https://portal.cfx.re
- Game build **3570** (imposé par `sv_enforceGameBuild`)

---

## 🚀 Installation

1. **Télécharger la base**
   ```bash
   git clone https://github.com/Noxxodev/Base-Template-V4-FR.git
   ```
   ou via *Code → Download ZIP*.

2. **Créer la base de données**
   - Crée une base vide (ex. `template_v4`) avec l'interclassement `utf8mb4_general_ci`.
   - Importe le fichier `template_v4.sql` (via phpMyAdmin, HeidiSQL…).

3. **Configurer `server.cfg`**
   ```cfg
   sv_licenseKey "ta_cle_cfx"
   sv_listingIPOverride "ton_ip"
   set steam_webApiKey "ta_cle_steam"   # optionnel

   # Localhost : remplace XXX par le nom de ta base
   set mysql_connection_string "mysql://root@localhost/XXX?charset=utf8mb4"

   # Hébergeur :
   # set mysql_connection_string "server=;database=;userid=;password="
   ```

4. **Lancer le serveur** avec txAdmin, en pointant sur ce dossier et sur `server.cfg`.
   ⚠️ **OneSync** doit être activé depuis la page des paramètres de txAdmin (et pas dans `server.cfg`).

---

## 🛡️ Se mettre administrateur

Ajoute ton identifiant dans `server.cfg` :
```cfg
add_principal identifier.license:TA_LICENSE group.admin
```
Puis donne-toi le groupe en base de données (colonne `group` de la table `users` → `admin`).

---

## ⌨️ Commandes utiles

| Commande | Description |
|---|---|
| `F5` | Menu personnel |
| `/menuadmin` | Menu administrateur |
| `/adminnoclip` | Noclip |
| `/me <action>` | Affiche une action au-dessus de ta tête |
| `/porter` | Porter un joueur |
| `/id` | Afficher ton ID |
| `/weather`, `/time`, `/morning`, `/noon`, `/evening`, `/night` | Météo et heure |
| `/freezetime`, `/freezeweather`, `/blackout` | Figer l'heure / la météo, blackout |

---

## ⚠️ Sécurité

Ne publie **jamais** ta vraie `sv_licenseKey`, ta clé Steam ou ton mot de passe MySQL sur un dépôt public. Garde-les dans ton `server.cfg` local uniquement.

---

## 🙏 Crédits

- Développé par **Noxxo** — [Wind Studio](https://discord.gg/7SBn6ygS87)
- [ESX Framework](https://github.com/esx-framework), [Overextended](https://github.com/overextended), [illenium-appearance](https://github.com/iLLeniumStudios/illenium-appearance) et leurs contributeurs respectifs
