init-ssh-agent() {
  eval `ssh-agent` && ssh-add ~/.ssh/id_rsa
}
init-ssh-agent

## `python3 -m venv .venv`
#if [[ -d .venv ]]; then
#  source .venv/bin/activate
#fi
