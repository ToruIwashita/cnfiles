# kube
watch-kube-cn() {
  watch -c "echo '# context'; kubectx; echo; echo '# namespace'; kubens"
}

watch-kube-pods() {
  watch -c "echo '# context'; kubectl config current-context; echo; kubectl get pods"
}

watch-kube-pods-top() {
  watch -c "echo '# context'; kubectl config current-context; echo; kubectl top pod"
}

show-k8s-tool-versions() {
  print '# kubectl'
  kubectl version

  echo

  print '# helm'
  helm version
}

kube-pod-login() {
  local answer pod_name container_name login_shell

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

  pod_name=(${(f)"$(kubectl get pods --server-print=false | tail -n +2  | cut -f 1 -d ' ' | peco --select-1 2>/dev/null)"})

  if (( ! $#pod_name )); then
    return
  fi

  container_name=$(kubectl get pods $pod_name --output=json | jq -r '.spec.containers[].name' | peco --select-1 2>/dev/null)

  if [[ $(kubectl exec -it $pod_name --container $container_name which bash 2>/dev/null) ]]; then
    login_shell=bash
  else
    login_shell=sh
  fi

  echo

  print "kubectl exec -it $pod_name --container $container_name $login_shell"
  kubectl exec -it $pod_name --container $container_name $login_shell
}
