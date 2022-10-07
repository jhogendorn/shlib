# vim: ft=sh
# Include Shorthand {{{

# Everyone gets the stdlib regardless
source $XDG_CONFIG_HOME/shlib/stdlib

# scope restricting trick for shopts
all_shlibs=($(
  shopt -s nullglob;
  local all_shlibs;
  all_shlibs=($XDG_CONFIG_HOME/shlib/lib/*.sh);
  all_shlibs=("${all_shlibs[@]%.sh}");
  all_shlibs=("${all_shlibs[@]##*/}");
  echo "${all_shlibs[@]}";
))

# libs specced as an argument to this script
# :(){ . $XDG_CONFIG_HOME/shlib/inc "$@"; };: discoverenv;
# to force no libs call with an unmatcheable pattern like -
arg_shlibs=$@

# default libs if you spec none
default_shlibs=(paths localenv)

# operating set is args, unless none then default
get_shlibs=( "${arg_shlibs[@]:-"${default_shlibs[@]}"}" )

SHLIBS_LOADED=()
used() {
  in-array $SHLIBS_LOADED "${1}"
}

use() {
  libs=($@)
  for r in "${!libs[@]}" ; do
    for i in "${!all_shlibs[@]}" ; do
      lib="${all_shlibs[$i]}"
      rlib="${libs[$r]}"
      #echo "[${lib} : ${rlib}]"
      if [[ $lib =~ $rlib ]]; then
        if [[ ! $(used $lib) ]]; then
          #echo "Loading ${lib}"
          source "${XDG_CONFIG_HOME}/shlib/lib/${lib}.sh"
          SHLIBS_LOADED+=($lib)
        fi
      fi
    done
  done
}

if [[ "${#get_shlibs[@]}" -gt 0 ]]; then
  use $get_shlibs
fi

# }}}
