# Install Intelij IDEA CE
flatpak install -y com.jetbrains.IntelliJ-IDEA-Community

# Set the default git branch to main globally
git config --global init.defaultBranch main

# ============================================ Install Neovim ===========================================================
flatpak install -y \
  org.freedesktop.Sdk.Extension.rust-stable \
  org.freedesktop.Sdk.Extension.node20 \
  org.freedesktop.Sdk.Extension.openjdk21 \
  io.neovim.nvim

# C++ tools like cmake, gcc etc. seem to be available by default so no need to add them here
flatpak override \
  --user \
  --env=FLATPAK_ENABLE_SDK_EXT=rust-stable,node20,openjdk21 \
  io.neovim.nvim

# Install nerd font to see icons in neovim
font_directory="$HOME/.local/share/fonts/JetBrainsMono"
mkdir -p "$font_directory"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d "$font_directory"
fc-cache -fv
rm JetBrainsMono.zip

# Set the font in gnome-terminal
# Iterate through the list
# The "| grep :" is necessary because when someone plays with profiles in their terminal 
# then special profiles are created like "list" "default" etc.
terminal_profile_list=$(dconf list /org/gnome/terminal/legacy/profiles:/ | grep :)
for profile in $terminal_profile_list; do
    # Remove the leading ':' and trailing '/'
    profile_id=${profile#:}
    profile_id=${profile_id%/}

    dconf write "/org/gnome/terminal/legacy/profiles:/:$profile_id/use-system-font" false
    dconf write "/org/gnome/terminal/legacy/profiles:/:$profile_id/font" "'JetBrainsMono Nerd Font 15'"
done

# Define the source and target directories
source_dir="$HOME/.var/apps/io.neovim.nvim/config/nvim"
target_dir="$HOME/.config/nvim"

# Create the source directory if it doesn't exist
mkdir -p "$(dirname "$source_dir")"

# Create the target directory if it doesn't exist
mkdir -p "$(dirname "$target_dir")"

# Create the symbolic link
ln -s "$source_dir" "$target_dir"

echo "alias nvim=\"flatpak run io.neovim.nvim\"" >> "$HOME/.bashrc"
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim

# ============================================ Install Neovim ===========================================================
