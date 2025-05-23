# ========== should only excecute when in the toolbox ================
if [ -f /run/.containerenv ] \
   && [ -f /run/.toolboxenv ]; then

  # Add autocompletion for kubectl CLI
  # https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#enable-shell-autocompletion
  source <(kubectl completion bash)

  # Add autocompletion for flux CLI
  # https://fluxcd.io/flux/cmd/flux_completion_bash/#examples
  # ~/.bashrc or ~/.profile
  command -v flux >/dev/null && . <(flux completion bash)

  export PATH="$HOME/.local/bin:$PATH"
fi

