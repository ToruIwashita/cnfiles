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
  local answer pod_name container_name

  if (( $# )); then
    kubectx $1 >/dev/null 2>&1
  fi

  while :; do
    echo
    print "Selected context: $(kubectl config current-context)"
    print -n 'Please Enter '

    read answer
    case "$answer" in
      *)
        break
        ;;
    esac
  done

  pod_name=(${(f)"$(kubectl get pods --server-print=false | peco --select-1 2>/dev/null | cut -f 1 -d ' ')"})

  if (( ! $#pod_name )); then
    return
  fi

  container_name=${pod_name%-*-*}

  print "Login container: $container_name"
  echo

  kubectl exec -it $pod_name --container $container_name sh
}
