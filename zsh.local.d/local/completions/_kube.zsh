## gcloud
_kube-contexts() {
  compadd $(kubectl config get-contexts --output=name)
}

compdef _kube-contexts kube-pod-login
compdef _kube-contexts kube-use-context
