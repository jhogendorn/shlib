# Ensure clean exits {{{

_finish () {
  if [ -n "$(type -t _cleanup)" ] && [ "$(type -t _cleanup)" = function ]; then
    _cleanup
  fi

  # Propagate the exit signal correctly
  if [ $sig != EXIT ]
  then
      trap - $sig EXIT
      kill -s $sig $$
  fi

  exit
}
export -f _finish

trap _finish INT TERM EXIT

# }}}
