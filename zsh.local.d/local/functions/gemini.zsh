## gemini
gemini() {
  if [[ $PWD != $CNFILES_DIR_PATH ]]; then
    print "gemini: must be run from within ~/.cnfiles dir" 1>&2
    print "current dir: $PWD" 1>&2
    return 1
  fi

  command gemini "$@"
}
