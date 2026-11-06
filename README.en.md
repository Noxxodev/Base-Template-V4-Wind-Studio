# Base Template V4 — Wind Studio (FR)

<p align="center">
  <a href="README.md"><img src="https://img.shields.io/badge/Langue-Français-blue?style=for-the-badge" alt="Français"></a>
  <a href="README.en.md"><img src="https://img.shields.io/badge/Language-English-red?style=for-the-badge" alt="English"></a>
</p>

Ready-to-use **FiveM** server base, built on **ESX** and the **OX** ecosystem, with **Wind Studio**'s custom scripts.

> ℹ️ This base is configured in **French** (`esx:locale "fr"`). An English version of the base is available here: **[Base-Template-V4-EN](https://github.com/Noxxodev/Base-Template-V4-EN)**.

💬 Need help? Join the Discord: **https://discord.gg/7SBn6ygS87**

---

## 📦 Content

| Folder | Resources |
|---|---|
| `[Default]` | chat, cc-chat, bob74_ipl, hardcap, sessionmanager, spawnmanager, yarn, webpack, jsfour-idcard |
| `[ESX]` | es_extended (1.13.4), esx_identity, esx_basicneeds, esx_optionalneeds, esx_status, esx_license, esx_addonaccount, esx_menu_default, esx_notify, cron |
| `[OX]` | oxmysql (2.14.3), ox_lib (3.42.1), cfxlua-require, ox_target (1.18.1), ox_inventory (2.48.1), ox_fuel (1.5.4), ox_doorlock (1.23.0), illenium-appearance |
| `[HUD]` | hud, loadingscreen |
| `[WIND]` | WS_Core, WS_Admin, WS_F5 |

### Wind Studio scripts

- **WS_Core**: `/me`, carry a player (`/porter`), vehicle rental, weather and time, teleports, Cayo Perico, colormap
- **WS_Admin**: admin menu (`/menuadmin`), noclip (`/adminnoclip`)
- **WS_F5**: personal menu (`F5` key)

---

## ✅ Requirements

- Recent [FiveM artifacts](https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/) (with txAdmin)
- A **MySQL / MariaDB** server (XAMPP, WAMP, Laragon or your host's)
- A Cfx.re license key: https://portal.cfx.re
- Game build **3570** (enforced by `sv_enforceGameBuild`)

---

## 🚀 Installation

1. **Download the base**
   ```bash
   git clone https://github.com/Noxxodev/Base-Template-V4-FR.git
   ```
   or via *Code → Download ZIP*.

2. **Create the database**
   - Create an empty database (e.g. `template_v4`) with the `utf8mb4_general_ci` collation.
   - Import the `template_v4.sql` file (via phpMyAdmin, HeidiSQL…).

3. **Configure `server.cfg`**
   ```cfg
   sv_licenseKey "your_cfx_key"
   sv_listingIPOverride "your_ip"
   set steam_webApiKey "your_steam_key"   # optional

   # Localhost: replace XXX with your database name
   set mysql_connection_string "mysql://root@localhost/XXX?charset=utf8mb4"

   # Hosting provider:
   # set mysql_connection_string "server=;database=;userid=;password="
   ```

4. **Start the server** with txAdmin, pointing to this folder and to `server.cfg`.
   ⚠️ **OneSync** must be enabled from the txAdmin settings page (not in `server.cfg`).

---

## 🌍 Language / Translation

The base ships in **French**, but every script can switch to **English** by changing 3 lines in `server.cfg`:

```cfg
## Langue / Language ( "fr" or "en" )
setr esx:locale "en"                    # ESX + WIND scripts (WS_Core, WS_Admin, WS_F5)
setr ox:locale "en"                     # ox_lib, ox_inventory, ox_target, ox_fuel, ox_doorlock
setr illenium-appearance:locale "en"    # illenium-appearance
```

Then restart the server.

### Where the translations are

| Script | Language files | Setting |
|---|---|---|
| es_extended, esx_identity, esx_basicneeds, esx_optionalneeds | `locales/fr.lua`, `locales/en.lua` | `esx:locale` |
| WS_Core, WS_Admin, WS_F5 | `locales/fr.lua`, `locales/en.lua` | `esx:locale` |
| ox_lib, ox_inventory, ox_target, ox_fuel, ox_doorlock | `locales/fr.json`, `locales/en.json` | `ox:locale` |
| illenium-appearance | `locales/fr.lua`, `locales/en.lua` | `illenium-appearance:locale` |

> 💡 With ox_lib, each player can also pick their own language in the ox_lib settings menu. `ox:locale` sets the default language.

### Adding a new language (e.g. Spanish)

1. In the script's `locales` folder, copy `en.lua` to `es.lua`.
2. Change the first line: `Locales['en'] = {` → `Locales['es'] = {` (for ESX files using `return { ... }`, nothing to change).
3. Translate only the text on the right of the `=`. **Do not change the keys** (`['menu_title']`) or the `%s`, which get replaced by a value (ID, name, time…).
4. Set `setr esx:locale "es"` in `server.cfg`.

If a translation is missing, the script automatically falls back to French, then English.

### Texts to edit by hand

A few texts do not go through a language file:

- **WS_Core config** (`[WIND]/WS_Core/config.lua`): blip names, interaction titles and rental vehicle descriptions, teleport destinations.
- **Loading screen**: `[HUD]/loadingscreen/html/index.html` ("Press Space to stop the music").
- **ID card** (jsfour-idcard): titles are part of the images in `html/assets/images`.

---

## 🛡️ Making yourself admin

Add your identifier to `server.cfg`:
```cfg
add_principal identifier.license:YOUR_LICENSE group.admin
```
Then give yourself the group in the database (`group` column of the `users` table → `admin`).

---

## ⌨️ Useful commands

| Command | Description |
|---|---|
| `F5` | Personal menu |
| `/menuadmin` | Admin menu |
| `/adminnoclip` | Noclip |
| `/me <action>` | Displays an action above your head |
| `/porter` | Carry a player |
| `/id` | Show your ID |
| `/weather`, `/time`, `/morning`, `/noon`, `/evening`, `/night` | Weather and time |
| `/freezetime`, `/freezeweather`, `/blackout` | Freeze time / weather, blackout |

---

## ⚠️ Security

**Never** publish your real `sv_licenseKey`, Steam key or MySQL password on a public repository. Keep them only in your local `server.cfg`.

---

## 🙏 Credits

- Developed by **Noxxo** — [Wind Studio](https://discord.gg/7SBn6ygS87)
- [ESX Framework](https://github.com/esx-framework), [Overextended](https://github.com/overextended), [illenium-appearance](https://github.com/iLLeniumStudios/illenium-appearance) and their respective contributors
