# Fedora Workstation Setup
Scripts and instructions for setting up Fedora Silverblue

## Prerequisites

- Fresh Fedora Silverblue installation  
[official guide](https://docs.fedoraproject.org/en-US/fedora/latest/preparing-boot-media/#_fedora_media_writer)  
***(make sure to choose `Fedora Silverblue` in the media writer)***
- GitHub ssh-key setup  
[instructions](https://github.com/injinity/instructions/blob/main/gtihub_ssh_auth/README.md)

## How to use

- Clone this repository  
`git clone git@github.com:injinity/fedora-workstation-setup.git`
- Change directory to the cloned repository  
  `cd fedora-workstation-setup`
- Allow the script to execute  
  `chmod +x fedora-workstation-setup.sh`
- Run script  
  - If you have a nvidia gpu  
    `./fedora-workstation-setup.sh +nvidia_gpu_drivers`
  - Else just simply run  
    `./fedora-workstation-setup.sh`

## Some of the things this script does
- Installs nvidia drivers on os-level, flatpak-level and toolbox-level
- Prepares the toolbox environment for gaming on Lutris
- Sets the mouse scroll direction to natural
- Hides Firefox (installed by default on Fedora)
- Installs and sets Brave as the default browser
- Installs some basic apps like:
  - Flatseal (for flatpak permission management)
  - Signal (messaging)
  - Intelij Idea CE (Development IDE)
  - Steam
  - Lutris (on toolbox)
  - Brave

## There is a problem with this script, or I want it to do more
In this case feel free to just open an issue in this repo on GitHub 
or just create a pull request with the changes to the script you want to see.