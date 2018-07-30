watch-kube-cn() {
  watch -c "echo '# context'; kubectx; echo; echo '# namespace'; kubens"
}

watch-kube-pods() {
  watch -c "echo 'context: $(kubectl config current-context)'; echo; kubectl get pods"
}
