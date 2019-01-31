# kube
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

kube-pod-login() {
  local answer
  local pod_name container_name

  while :; do
    print "context: $(kubectl config current-context)"

    read answer
    case "$answer" in
      *)
        break
        ;;
    esac
  done

  pod_name=(${(f)"$(kubectl get pods --server-print=false | peco --select-1 2>/dev/null | cut -f 1 -d ' ')"})
  container_name=${pod_name%-*-*}

  print "login container: $container_name"
  echo

  kubectl exec -it $pod_name --container $container_name sh
}
