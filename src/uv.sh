# Resolve the uv binary for the Alfred script boxes.
#
# Alfred starts scripts with a minimal PATH, so Homebrew's uv (/opt/homebrew/bin)
# is not on it. Look for uv on PATH, then in the usual install locations.
# Sourced by every script box; leaves the result in $uv_bin.

uv_bin=""
for candidate in "$(command -v uv)" /opt/homebrew/bin/uv /usr/local/bin/uv "$HOME/.local/bin/uv"; do
  if [[ -f $candidate && -x $candidate ]]; then
    uv_bin=$candidate
    break
  fi
done

if [[ ! -f $uv_bin || ! -x $uv_bin ]]; then
  print -r -- '{"items":[{"title":"uv not found","subtitle":"Install uv (Homebrew: brew install uv) or put it on your PATH","valid":false}]}'
  exit 0
fi
