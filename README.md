# Workstation
Scripts and instructions for setting up your workstation 

## Contents
TODO

## Prerequisites
- Fresh Fedora Silverblue or Windows WSL Fedora installation
[official guide](https://docs.fedoraproject.org/en-US/fedora/latest/preparing-boot-media/#_fedora_media_writer) (Fedora Silverblue)
***(make sure to choose `Fedora Silverblue` in the media writer)***
[WSL guide](https://github.com/injinity/instructions/blob/main/windows_wsl_fedora/README.md) (Windows WSL)

- GitHub ssh-key setup  
[instructions](https://github.com/injinity/instructions/blob/main/gtihub_ssh_auth/README.md)

## Usage

Clone this repository  
```
git clone git@github.com:injinity/workstation.git
```
Change directory to the cloned repository  
```
cd workstation/
```
Allow the script to execute  
```
chmod +x install.sh
```
Run script  
  - If you have a nvidia gpu  
    `./install.sh --nvidia`
  - If you run on wsl2
    `./install.sh --no-gaming --no-neovim --no-browser`
  - Else just simply run  
    `./install.sh`

## Options
More fined grained controll may come in the future.

### Common
General apps and changes to the os.
To not apply those changes use the `--no-common` option on the install script.

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
To not apply those changes use the `--no-injinity` option on the install script.

__Content__
- Install kubectl in the toolbox
- Install flux CLI in the toolbox
- Set up flux CLI command autocompletion in the toolbox
- Set up kubectl CLI command autocompletion in the toolbox
- Set up remote kubectl and flux connection to kube cluster
- Set up local Injinity VPS host domains like 'master-node-0'
- Add VPS connection scripts to ~/Nodes folder

### Neovim
Sets up a inhouse neovim config
To not apply those changes use the `--no-neovim` option on the install script.

__Content__
- Install flatpak runtimes for rust java and web development
- Install NerdFonts (fonts supporting emojis) to the terminal 
- Install Neovim (Text Editor/IDE)
- Install custom neovim config

## Contributing
Feel free to just open an issue in this repo on GitHub 
or just create a pull request with the changes to the script you want to see.

