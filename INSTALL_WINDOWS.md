# 🪟 GUIDE SPÉCIAL WINDOWS - Installation R + VSCode + Shiny

> **Guide détaillé pour utilisateurs Windows qui n'ont jamais installé R**

## 🎯 **PRÉREQUIS WINDOWS**

- Windows 10/11 
- Droits d'administrateur
- Connexion Internet stable
- 2GB d'espace disque libre

---

## 📥 **ÉTAPE 1 : Installer R (DÉTAILLÉ)**

### **1.1 Téléchargement**
1. Ouvrez votre navigateur (Chrome, Edge, Firefox)
2. Allez sur : **https://cran.r-project.org/bin/windows/base/**
3. Cliquez sur **"Download R 4.5.0 for Windows"** (gros bouton bleu)
4. Le fichier `R-4.5.0-win.exe` se télécharge (environ 80MB)

### **1.2 Installation**
1. **Double-cliquez** sur le fichier téléchargé
2. Si Windows demande "Autoriser cette app ?", cliquez **"Oui"**
3. **Suivez l'assistant :**
   - Langue : **"Français"** ou **"English"**
   - Licence : **"J'accepte"**
   - Dossier d'installation : **Laissez par défaut** `C:\Program Files\R\R-4.5.0`
   - Composants : **Cochez tout**
   - Options de démarrage : **Laissez par défaut**
   - ⚠️ **CRUCIAL :** Cochez **"Add R to PATH"** (si cette option apparaît)
4. Cliquez **"Installer"**
5. Attendez 2-3 minutes
6. Cliquez **"Terminer"**

### **1.3 Vérification**
1. Appuyez sur **`Windows + R`**
2. Tapez **`cmd`** et appuyez sur **Entrée**
3. Tapez **`R --version`** et appuyez sur **Entrée**
4. Vous devriez voir : `R version 4.5.0...`
5. Si erreur "R n'est pas reconnu", voir section Dépannage

---

## 💻 **ÉTAPE 2 : Installer Visual Studio Code**

### **2.1 Téléchargement**
1. Allez sur : **https://code.visualstudio.com/**
2. Cliquez **"Download for Windows"**
3. Le fichier `VSCodeUserSetup-x64-1.x.x.exe` se télécharge

### **2.2 Installation**
1. **Double-cliquez** sur le fichier
2. Acceptez la licence
3. **IMPORTANT :** Cochez ces options :
   - ✅ "Ajouter à PATH"
   - ✅ "Associer les fichiers"
   - ✅ "Ajouter au menu contextuel"
4. Cliquez **"Installer"**
5. Une fois terminé, **laissez VSCode se lancer**

---

## 🔧 **ÉTAPE 3 : Extensions VSCode (CRUCIAL)**

### **3.1 Extension R**
1. Dans VSCode, appuyez sur **`Ctrl + Shift + X`**
2. Dans la barre de recherche, tapez : **"R"**
3. Cherchez **"R Extension for Visual Studio Code"** par **REditorSupport**
4. Cliquez **"Install"**
5. Attendez l'installation (barres de progression)

### **3.2 Extension Shiny**
1. Toujours dans les extensions, tapez : **"Shiny"**
2. Installez **"Shiny - VS Code Extension"**
3. Cliquez **"Install"**

### **3.3 Extension Git (si pas déjà là)**
1. Tapez : **"Git"**
2. Installez l'extension **"Git"** officielle Microsoft

---

## 📁 **ÉTAPE 4 : Récupérer le Projet**

### **4.1 Via Téléchargement Direct**
1. Sur la page GitHub du projet, cliquez **"Code"** → **"Download ZIP"**
2. **Dézippez** dans un dossier simple : `C:\Users\VotreNom\Desktop\Iris_Project\`
3. Dans VSCode : **"File"** → **"Open Folder"** → Sélectionnez le dossier

### **4.2 Via Git (Avancé)**
```bash
# Ouvrir terminal dans VSCode (Ctrl + ù)
git clone [URL_DU_REPOSITORY]
cd Project_R1_Name
```

---

## 📦 **ÉTAPE 5 : Installation Packages R**

### **5.1 Méthode Automatique (Recommandée)**
1. Dans VSCode, ouvrez le fichier **`setup_shiny.R`**
2. **Sélectionnez tout** : `Ctrl + A`
3. **Palette de commandes** : `Ctrl + Shift + P`
4. Tapez : **"R: Run Selection"** et appuyez **Entrée**
5. **ATTENDEZ** 5-15 minutes (première fois)

### **5.2 Si la méthode automatique ne marche pas**
1. Dans VSCode, ouvrez un **nouveau terminal** : `Ctrl + ù`
2. Tapez : **`R`** et appuyez **Entrée**
3. Vous êtes maintenant dans R
4. Copiez-collez **UNE PAR UNE** ces commandes :

```r
install.packages("shiny")
install.packages("shinydashboard")
install.packages("shinyWidgets")
install.packages("DT")
install.packages("plotly")
install.packages("ggplot2")
install.packages("caret")
install.packages("dplyr")
```

---

## 🚀 **ÉTAPE 6 : Lancer l'Application**

### **6.1 Méthode Simple**
1. Dans VSCode, ouvrez le fichier **`app.R`**
2. Cherchez le bouton **"Run"** (▷) en haut à droite
3. Cliquez sur la **petite flèche** à côté
4. Sélectionnez **"Run Shiny App"**
5. **Patientez** 30-60 secondes
6. L'application s'ouvre dans votre navigateur !

---

## 🐛 **DÉPANNAGE WINDOWS**

### **❌ "R n'est pas reconnu"**
**Solutions :**
1. **Redémarrez** votre ordinateur
2. **Ajoutez R au PATH manuellement :**
   - `Windows + R` → `sysdm.cpl` → **Avancé** → **Variables d'environnement**
   - Dans **PATH**, ajoutez : `C:\Program Files\R\R-4.5.0\bin`
3. **Utilisez le chemin complet** dans VSCode :
   - Settings VSCode → `r.rterm.windows` → `C:\Program Files\R\R-4.5.0\bin\R.exe`

### **❌ "Permission denied" lors de l'installation**
1. **Lancez VSCode en tant qu'administrateur**
2. Clic droit sur VSCode → **"Exécuter en tant qu'administrateur"**

### **❌ Extensions ne se chargent pas**
1. **Redémarrez VSCode**
2. `Ctrl + Shift + P` → **"Developer: Reload Window"**

### **❌ Firewall/Antivirus bloque**
1. **Autorisez R et VSCode** dans votre antivirus
2. **Autorisez le port 3838** dans Windows Defender

---

## ✅ **VÉRIFICATION FINALE**

Lancez le script de vérification :
1. Ouvrez **`quick_check.R`** dans VSCode
2. `Ctrl + A` puis `Ctrl + Shift + P` → **"R: Run Selection"**
3. Vous devriez voir tous les ✅

---

## 🎉 **FÉLICITATIONS !**

Si tout fonctionne, vous avez maintenant :
- ✅ R installé et configuré
- ✅ VSCode avec extensions R et Shiny
- ✅ Tous les packages nécessaires
- ✅ Application Shiny fonctionnelle

**Votre environnement de data science est prêt ! 🚀** 