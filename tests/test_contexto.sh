#!/usr/bin/env bash
# Verifica que contexto use el último mensaje del modelo de la sesión, ignorando subagentes.
set -u
dir="$(cd "$(dirname "$0")" && pwd)"
script="$dir/../skills/handoff-clear/scripts/contexto"
fail=0
got=$(CLAUDE_CONFIG_DIR="$dir/fixtures" CLAUDE_CODE_SESSION_ID=sesion-1 python3 "$script")
[ "$got" = "31 %" ] || { echo "FAIL: esperaba '31 %', salió '$got'"; fail=1; }
CLAUDE_CONFIG_DIR="$dir/fixtures" CLAUDE_CODE_SESSION_ID=no-existe python3 "$script" >/dev/null 2>&1 \
  && { echo "FAIL: sin transcript tenía que fallar"; fail=1; }
[ $fail = 0 ] && echo "OK"
exit $fail
