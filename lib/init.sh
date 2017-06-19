# Script Setup {{{

[ -n "$DEBUG" ] && set -x # Print traces when things go wrong in debug mode

set -eu # -e If a command fails, stop execution
        # -u Fail if we try to expand unset variables

# }}}
