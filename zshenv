init-ssh-agent() {
  eval `ssh-agent` && ssh-add ~/.ssh/id_rsa
}
init-ssh-agent
