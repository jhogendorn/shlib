# vim: ft=sh
# Set Script Paths {{{

PATH_SCRIPT_NORM="$( cd "$(dirname "$0")" ; pwd -P )"
PATH_SCRIPT="$( cd "$(dirname $(realpath "$0"))" ; pwd -P )"
PATH_BASE_NORM="$( cd $PATH_SCRIPT_NORM/../; pwd -P )"
PATH_BASE="$( cd $PATH_SCRIPT/../; pwd -P )"

# }}}
