#!/usr/bin/env bash
# Hook PostToolUse de Claude Code: formatea con Prettier el archivo que acaban de escribir Edit o Write.
# Sale con 2 si Prettier falla, para que Claude reciba el motivo por stderr.
set -u

# Lee el JSON del hook de la entrada estándar y saca tool_input.file_path (sin jq).
if ! file_path=$(node -e '
  const input = require("fs").readFileSync(0, "utf8");
  process.stdout.write(JSON.parse(input).tool_input?.file_path ?? "");
'); then
  echo "formatear.sh: no se pudo leer la entrada del hook con node." >&2
  exit 2
fi

if [ -z "$file_path" ]; then
  exit 0
fi

# Desde la raíz del proyecto, npx usa el Prettier de node_modules y no descarga otro.
cd "${CLAUDE_PROJECT_DIR:-.}" || exit 2

if ! output=$(npx prettier --write --ignore-unknown --no-color "$file_path" 2>&1); then
  echo "formatear.sh: Prettier no pudo formatear $file_path:" >&2
  echo "$output" >&2
  exit 2
fi
