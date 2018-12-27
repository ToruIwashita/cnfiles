watch-kube-cn() {
  watch -c "echo '# context'; kubectx; echo; echo '# namespace'; kubens"
}

watch-kube-pods() {
  watch -c "echo '# context'; kubectl config current-context; echo; kubectl get pods --server-print=false"
}

show-k8s-tool-versions() {
  print '# kubectl'
  kubectl version

  echo

  print '# helm'
  helm version
}
