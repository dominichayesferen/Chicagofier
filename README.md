# Chicagofier
#### Unofficial fan-made script for transforming a system with the Chicago95 theme (currently only supports Xubuntu)

Chicago95 is an AMAZING theme for XFCE, however its held back by its Terminal-heavy installation procedure for getting the full transformation. This script is a script that transforms an install of XFCE with very little user interaction required, making the whole transformation more noob-friendly to pull off. Additionally, it also includes some patches for the Chicago95 experience, and integrates Chicago95 Plus into the applications menu.

#### Patches to Chicago95:

- The 'No CSD' CSS is enabled for Chicago95 GTK3 (since this installs gtk3-nocsd)
- Chicago95 Plus's storage has been moved to a hidden folder in your Home Folder instead of populating Pictures with its files

#### Requirements

- Xubuntu 18.04 or newer (only tested on Xubuntu 20.04)
- Being logged in as an administrator account (first user's an administrator)

#### Notes

- Firefox will be replaced with Epiphany during installation since Firefox looks bad/unfitting for one (especially in this theme) and two Epiphany fits better in this theme

-----

## Installation

### Step 1

Download Chicagofier from [Releases](https://github.com/dominichayesferen/Chicagofier/releases) (a 'Source Code' download).

### Step 2

Extract the downloaded file with your archive manager (right-click, Extract Here).

### Step 3

Open a Terminal in the current folder.
<img src="screenshots/step1.png" alt="How to open a Terminal"/>

### Step 4

Run the script in the Terminal window (`bash ./chicagofier.sh`)
<img src="screenshots/step2.png" alt="Running chicagofier.sh in Terminal"/>

### Step 5

Leave the Terminal to do its thing. Eventually it'll end up showing the screen shown in the image below.
<img src="screenshots/step4.png" alt="Chicago95 Setup"/>

### Step 6

Go through the Setup process while leaving everything on their defaults.
<img src="screenshots/step5.png" alt="Chicago95 Setup Page 2"/>
<img src="screenshots/step6.png" alt="Chicago95 Setup Page 3"/>

### Step 6

Again, let the installation happen.
<img src="screenshots/step7.png" alt="Chicago95 Setup Installation Process"/>

### Step 7

Once it's done, you'll see this page of Setup, and a Text Editor window. Click 'Finish'.
<img src="screenshots/step8.png" alt="Chicago95 Setup Installation Finished"/>

### Step 8

Your computer will restart. But you're not done yet.
<img src="screenshots/step9.png" alt="Your computer will restart"/>

### Step 9

To finish things off, open the "Chicago95 Post-Install" file on your Desktop, and follow the instructions on there ("XFCE Settings Manager" is the Settings window).

### Step 10

You're done, enjoy Chicago95!

-----

## Screenshots

<img src="screenshots/screen1.png" alt="The Post-Chicagofier Login Screen"/>
<img src="screenshots/screen2.png" alt="Where Chicago95 Plus is"/>

-----

### Code and license
License: GPL-2.0 (check Chicago95's own repository for their own license)