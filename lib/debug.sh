# Provide debug tools {{{

# should go in a generic stdlib file
variable-is-set() {
    declare -p "$1" &>/dev/null
}

DEBUG=${DEBUG:-0}

LEVELS=(fatal error warn info debug trace)
export LOG_LEVELS=(fatal error warn info debug trace)
export LOG_LEVELS_LOOKUP=("fatal"=0 "error"=1 "warn"=2 "info"=3 "debug"=4 "trace"=5)
export LOG_LEVELS_DEFAULT="info"

# We want something that does this equivalent in a shorthand:
#[[ $DEBUG -gte $LOG_LEVELS_LOOKUP["debug"] ]] printf "ARG: %s\n" "${SHLIBS[@]}"
# ie: debug "My debug message which has evaluated items: %s" "${EVALUATED_VARIABLE}"
#
# - need to support pprint or not (use inc function for libloaded)
# - trace level should set -x
# - support doing timestamps and differential time from last line
# - support easy way of wrapping commands output for formatting
# - env var LOG=info or something? or LOG_INFO set. Overload DEBUG to pick levels?
#   - DEBUG separate can basically pop everything straight to trace?
#   - how to set timestamp and or diffs on?
#   - prefix scripts, ie 
#     - ts tsdiff debug myscript
#     - ts log warn myscript.
#     - v warn,ts,diff,plain myscript
#     - v --warn --ts --diff --plain myscript

dlog() {
  # Default loglevel is fatal
  level="debug"
  # Check dlog was called with a level, otherwise assume debug.
  if [[ " ${LEVELS[*]} " =~ " ${1} " ]]; then
    level=${1}
    shift
  fi
  # Get the rest of args as the log message
  msg="$@"
  # The default logger engine is echo
  logger="echo $level"
  # If we have the PPRINT library, try to use a pprint function as the logger.
  if [[ variable-is-set PPRINT ]] \
  && [ -n "$(type -t $level)" ] \
  && [ "$(type -t $level)" = function ]; \
    then
      logger=$level
    fi
  fi

  # From most to least severe, check our invoc is 
  for l in "${!LEVELS[@]}" ; do
    ll=$LEVELS[$l]
    if [[ $l -lte $DEBUG ]] && [[ "${ll}" == "${level}" ]]; then
      $logger $msg
    fi
  done
}
export -f dlog

# }}}
