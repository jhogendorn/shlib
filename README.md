# shellsnips

Useful snippets for shell scripting.

## Color

Variables for easy script colorization

### References

- [cxyokk/color.sh](https://github.com/cxyokk/color.sh/blob/master/terminal-control.sh)

## Discover Env

Figure out where our script resides and calculate a working directory relative
to that location (typically the directory above, ie `./bin/../`)

[`dirname "$0"`](http://explainshell.com/explain?cmd=dirname)
[`pwd -P`](http://explainshell.com/explain?cmd=pwd+-P)

## Init

Set sane defaults at the beginning of any given script.

[`set -x`](http://explainshell.com/explain?cmd=set+-x)
[`set -eu`](http://explainshell.com/explain?cmd=set+-e)

### References

- [Writing robust shell scripts](http://www.davidpashley.com/articles/writing-robust-shell-scripts/)
- [Shell error handling](https://www.turnkeylinux.org/blog/shell-error-handling)

## Persistent Sudo

Ask for sudo, and keep that permission alive to the end
of script execution

### References

- [Mathiasbynens .osx script](https://github.com/mathiasbynens/dotfiles/blob/master/.osx)

## Prettyprint

Printy print output functions

## Trap

Ensure that we exit cleanly and propagate signals correctly
when the script fails. Attempt to fire a `_cleanup` function
when exiting so the script can cleanup any temp files

### Explanation

noop;

### References

- [Shell error handling](https://www.turnkeylinux.org/blog/shell-error-handling)
- [Proper handling of SIGINT/SIGQUIT](http://www.cons.org/cracauer/sigint.html)

