#!/bin/bash

echo "Setting up the NVIDIA GPU drivers.."

set -e  # Exit immediately if any command exits with a non-zero status

script_base_dir=$(dirname "$(readlink -f "$0")")
touch "$script_base_dir/nvidia_gpu.log"

( # this is used for log redirection

stage_1() {
  echo "Running stage 1..."

  # https://docs.fedoraproject.org/en-US/fedora-silverblue/tips-and-tricks/#_enabling_rpm_fusion_repos
  rpm-ostree install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    || { echo "Failed to install RPM Fusion repos"; exit 1; }

  toolbox run -c injinity sudo dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    || { echo "Failed to install RPM Fusion repos in toolbox"; exit 1; }

  toolbox run -c injinity sudo dnf update -y \
    || { echo "Failed to update packages in toolbox"; exit 1; }
  toolbox run -c injinity sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda \
    || { echo "Failed to install NVIDIA drivers in toolbox"; exit 1; }
}

stage_2() {
  echo "Running stage 2..."

  # https://docs.fedoraproject.org/en-US/fedora-silverblue/tips-and-tricks/#_enabling_rpm_fusion_repos
  rpm-ostree update -y \
    --uninstall rpmfusion-free-release \
    --uninstall rpmfusion-nonfree-release \
    --install rpmfusion-free-release \
    --install rpmfusion-nonfree-release \
    || { echo "Failed to update RPM Fusion repos"; exit 1; }
}

stage_3() {
  echo "Running stage 3..."

  # https://docs.fedoraproject.org/en-US/fedora-silverblue/troubleshooting/#_using_nvidia_drivers
  rpm-ostree install -y akmod-nvidia xorg-x11-drv-nvidia-cuda \
    || { echo "Failed to install NVIDIA drivers"; exit 1; }
  rpm-ostree kargs \
    --append=rd.driver.blacklist=nouveau \
    --append=modprobe.blacklist=nouveau \
    --append=nvidia-drm.modeset=1 \
   || { echo "Failed to update kernel command line"; exit 1; }
}

stage_4() {
  echo "Running stage 4..."

  # Get the driver version in X-X-X format
  DRIVER_VERSION=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader | sed 's/\./-/g')
  if [ -z "$DRIVER_VERSION" ]; then
    echo "Failed to get NVIDIA driver version"
    exit 1
  fi

  flatpak install -y org.freedesktop.Platform.GL.nvidia-"$DRIVER_VERSION" \
    || { echo "Failed to install Flatpak GL platform for NVIDIA"; exit 1; }
  flatpak install -y org.freedesktop.Platform.GL32.nvidia-"$DRIVER_VERSION" \
    || { echo "Failed to install Flatpak GL32 platform for NVIDIA"; exit 1; }
}

# Add a line to .bashrc to execute the script after restart
add_to_bashrc() {
    bashrc_path="$HOME/.bashrc"
    script_path="$(readlink -f "$0")"
    script_line="bash $script_path"

    if ! grep -Fxq "$script_line" "$bashrc_path"; then
        echo "$script_line" >> "$bashrc_path"
        echo "Line added to .bashrc to execute the script after restart."
    else
        echo "Line already exists in \`.bashrc\`."
    fi
}

remove_from_bashrc() {
    bashrc_path="$HOME/.bashrc"
    script_path="$(readlink -f "$0")"
    script_line="bash $script_path"
    # Its important to escape the `/` for `sed`
    escaped_script_line="bash ${script_path//\//\\/}"

    if grep -Fxq "$script_line" "$bashrc_path"; then
        sed -i "/$escaped_script_line/d" "$bashrc_path"
        echo "Line removed from \`.bashrc\`."
    else
        echo "Line not found in \`.bashrc\`."
    fi
}

stage=$(cat "$script_base_dir/nvidia_gpu_stage.tmp" 2>/dev/null || echo 1)
case $stage in
    1)
        add_to_bashrc

        stage_1 || exit 1

        echo 2 > "$script_base_dir/nvidia_gpu_stage.tmp"
        reboot
        ;;
    2)
        stage_2 || exit 1

        echo 3 > "$script_base_dir/nvidia_gpu_stage.tmp"
        reboot
        ;;
    3)
        stage_3 || exit 1

        echo 4 > "$script_base_dir/nvidia_gpu_stage.tmp"
        reboot
        ;;
    4)
        stage_4 || exit 1

        echo 5 > "$script_base_dir/nvidia_gpu_stage.tmp"
        remove_from_bashrc || exit 1
        rm "$script_base_dir/nvidia_gpu_stage.tmp"
        ;;
    *)
        echo "Invalid stage number."
        ;;
esac

) > "$script_base_dir/nvidia_gpu.log" 2>&1  # this is used for log redirection

