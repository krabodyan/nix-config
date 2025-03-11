{pkgs, ...}:
pkgs.writeShellScriptBin "__yazi_picker" ''
  dir="$PWD"
  if [ -n "$1" ]; then
   dir="$1"
  fi
  tmp="$(mktemp -t yazi-picker.XXXXXX)"
  foot -a 'floaterm' yazi "$dir" --chooser-file "$tmp" 2>/dev/null
  cat -- "$tmp"
  rm -f -- "$tmp"
''
