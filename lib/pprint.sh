# Define print library {{{

info () {
  printf "  [ \033[00;34m..\033[0m ] $1\n"
}
export -f info

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1 "
}
export -f user

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}
export -f success

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
}
export -f fail

status () {
  # for use with return codes
  # status $? "My Message"
  case $1 in
    0)
      success "$2"
      ;;
    *)
      fail "$2"
      ;;
  esac
}
export -f status

# }}}

