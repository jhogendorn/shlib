# Ensure clean exits {{{

_trap () {
  sig=${1} ; shift

  if [ -n "$(type -t _cleanup)" ] && [ "$(type -t _cleanup)" = function ]; then
    _cleanup
  fi

  # Propagate the exit signal correctly
  if [ $sig != EXIT ]
  then
      trap '' EXIT # some shells will call exit after INT handler
      kill -s $sig $$ # ensure the script ends with the right signal
  fi

  exit $?
}

_trap_init() {
  func="$1" ; shift
  for sig in "$@" ; do
    #echo "trapping $sig"
    trap "$func $sig" "$sig"
  done
}

_trap_init _trap INT TERM EXIT

# }}}
