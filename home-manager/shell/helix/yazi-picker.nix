{ pkgs, ... }:
pkgs.writeShellScriptBin "__yazi_picker" ''
  tmp="$(mktemp -t yazi-picker.XXXXXX)"
  foot -a 'floaterm' yazi --chooser-file "$tmp" 2>/dev/null
  cat -- "$tmp"
  rm -f -- "$tmp"
''
