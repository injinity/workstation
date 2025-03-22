# Fedora Workstation Setup
Scripts and instructions for setting up Fedora Silverblue

## Prerequisites

- Fresh Fedora Silverblue installation  
[official guide](https://docs.fedoraproject.org/en-US/fedora/latest/preparing-boot-media/#_fedora_media_writer)  
***(make sure to choose `Fedora Silverblue` in the media writer)***
- GitHub ssh-key setup  
[instructions](https://github.com/injinity/instructions/blob/main/gtihub_ssh_auth/README.md)

## How to use

Clone this repository  
```
git clone git@github.com:injinity/fedora-workstation-setup.git
```
Change directory to the cloned repository  
```
cd fedora-workstation-setup
```
Allow the script to execute  
```
chmod +x fedora-workstation-setup.sh
```
Run script  
  - If you have a nvidia gpu  
    `./fedora-workstation-setup.sh --nvidia`
  - Else just simply run  
    `./fedora-workstation-setup.sh`

## Options
More fined grained controll may come in the future.

### General
General apps and changes to the os.
To not apply those changes use the `--no-general` option on the install script.

__Content__
- scroll wheel direction set to "natural"
- install signal flatpak
- install flatseal flatpak

### Browser
Browser related changes.
To not apply those changes use the `--no-browser` option on the install script.

__Content__
- Hide default browser (Firefox)
- Install Brave browser flatpak
- Set Brave as the default browser

### Programming
Sets up the os for programming.
To not apply those changes use the `--no-programming` option on the install script.

__Content__
- Install Intelij Idea IDE flatpak
- Configure git (version controll)
    - Set the default branch name to main
- Install flatpak runtimes for rust java and web development
- Install NerdFonts (fonts supporting emojis) to the terminal 
- Install Neovim (Text Editor/IDE)

### Gaming
Sets up the os for gaming.
To not apply those changes use the `--no-gaming` option on the install script.

__Content__
- Install Steam
- Install Lutris in the toolbox
- Export the Lutris desktop file to be usable from the host 

### Nvidia
!!!ATTENTION!!!
This option will restart your pc up to 4 times (gracefully) this is necessary as we are working with a immutable/atomic OS. 
Sets up the nvidia gpu drivers.
As this is not something any system can use you have to opt in instead of opt out like for the other options.
To apply those changes use the `--nvidia` option on the install script.

__Content__
- Install the driver on the host os 
- Install the driver on toolbox
- Install the driver on flatpak 

### Injinity
Sets up the system for work with the Injinity platform

__Content__
- Install kubectl in the toolbox
- Install flux CLI in the toolbox
- Set up flux CLI command autocompletion

## There is a problem with this script, or I want it to do more
In this case feel free to just open an issue in this repo on GitHub 
or just create a pull request with the changes to the script you want to see.
