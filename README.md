# SHLIB

SHell LIBrary provides composable snippets for usage in shell scripts.

Not meant as a user interactive shell loaded extension like zsh plugins etc.
The point is to give standard tooling for shell scripting that makes it a bit
saner and DRY to manage.

Primarily for user environments where you're scripting tools, but quite useful
for extending CI environments.

## Goals

It's aimed typically at bash scripting, not super concerned about portability
or POSIX compliance etc, but if we can widen its support thats good but not a
strict goal.

Might be a path in the future to 'bake' scripts so rather than relying on shlib
being in the deployed environment you can write your script, compile in the libs
and have a single baked file. Maybe even tree shake unused things.

## Usage

### Environment

`git clone` shlib somewhere, typically into `.config/shlib`.

Optionally: symlink `inc` as `shlib` somewhere on your `$PATH`.

### Bootstrap

Your scripts should start with:

```
#!/usr/bin/env bash       # Use the bash on path
# vim: ft=sh              # Vim modeline
:(){ . shlib "$@"; };:;   # Bootstrap shlib with default libs (paths, localenv)
```

If you didn't symlink `inc` swap `shlib` for `path/to/shlib/inc`

The bootstrap can take a set of patterns for libs:
```
:(){ . shlib "$@"; };: paths pprint trap;
```

Because it supports patterns, `\*` is valid for all libs, and `-` will match no libs

Once bootstrapped, script has use of `use` and `used`, as well as functions defined in `stdlib`

```
use pprint
use trap init
use \*
```

Libs are included FIFO.

# Stdlib

Language fills for shorthands. IE, give things like `in-array` etc. If its super generic, or shlib itself
relies on it, it goes in stdlib, otherwise it goes in a separate lib.

# Libs

NAME | Description
---- | -----------
color | Variables for easy script colorisation, from [cxyokk/color.sh](https://github.com/cxyokk/color.sh/blob/master/terminal-control.sh)
paths | Provides `PATH_` variables to find relative files to the script, parent folder (ie where the script is in `./bin`), and execution context.
localenv | source a `.env` file thats adjacent to your scripts for shared vars
init | Script default things, `set -e` and similar.
pprint | Pretty print output functions
trap | Trap signals, trigger cleanup functions
persistentsudo | Ensure the script is running with sudo, keep those elevated perms for the rest of execution

### References

- [ExplainShell](http://explainshell.com/explain?cmd=)
- [Writing robust shell scripts](http://www.davidpashley.com/articles/writing-robust-shell-scripts/)
- [Shell error handling](https://www.turnkeylinux.org/blog/shell-error-handling)
- [Mathiasbynens .osx script](https://github.com/mathiasbynens/dotfiles/blob/master/.osx)
- [Shell error handling](https://www.turnkeylinux.org/blog/shell-error-handling)
- [Proper handling of SIGINT/SIGQUIT](http://www.cons.org/cracauer/sigint.html)
