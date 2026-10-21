---
name: revisar-pr
description: Revisa una pull request de este repositorio cuando se pide revisarla o validarla, por número o la de la rama actual. Comprueba los criterios de aceptación de la issue que cierra, las reglas de CLAUDE.md, el flujo de git, los commits y la CI, y devuelve un informe con veredicto sin publicar nada en GitHub. No la uses para explicar código, revisar cambios que no están en una PR ni resolver issues (para eso está /resolver-issue).
argument-hint: '[numero-pr]'
context: fork
allowed-tools: Read, Grep, Glob, Bash(git diff *), Bash(git log *), Bash(npx commitlint *), mcp__github__pull_request_read, mcp__github__list_pull_requests, mcp__github__issue_read, mcp__github__get_file_contents, mcp__github__get_commit, mcp__github__actions_list, mcp__github__get_job_logs
---

Revisa una pull request de `dblanco-galfor/proyecto_curso` y devuelve un informe. No ves la conversación que te ha llamado: todo lo que necesitas está aquí, en CLAUDE.md y en GitHub.

- PR pedida: `$ARGUMENTS`
- Commit y referencias locales: !`git log -1 --format='%H %D'`

Si no se ha pedido un número, revisa la PR abierta cuya rama de origen es la rama local (la que sigue a `HEAD ->`). Búscala con `mcp__github__list_pull_requests` y `head` = `dblanco-galfor:<rama>`. Si no hay ninguna, para y dilo.

## Límites

Solo lees e informas. No comentas en la PR, no la apruebas, no pides cambios, no la fusionas, no editas archivos y no haces push ni `git fetch`. Si crees que algo debería publicarse en GitHub, dilo en el informe: lo decide la conversación principal.

Ejecuta `git` y `npx commitlint` con la herramienta Bash, que es la que tiene esos comandos preaprobados.

## Procedimiento

1. Lee la PR con `mcp__github__pull_request_read`:
   - `get`: título, descripción, ramas base y de origen, y SHA de la cabeza.
   - `get_commits`, `get_files` y `get_diff`.
   - `get_check_runs` y `get_status`: estado de la CI del último commit. Si un check ha fallado, localiza su ejecución con `mcp__github__actions_list` y lee solo el final del log de los jobs fallidos con `mcp__github__get_job_logs` (`failed_only`, `return_content` y `tail_lines`).
   - Busca `Closes #n` en la descripción y lee esa issue, con sus comentarios, con `mcp__github__issue_read`.
2. Lee el CLAUDE.md de la rama base con `mcp__github__get_file_contents` (`ref` = rama base), no el local, que puede ser de otra rama. Aplica las reglas que afectan a los archivos cambiados y cita la sección de cada una en lugar de copiarla. Si una regla que necesitas no está, no la supongas: márcala como no verificable.
3. Para cada criterio de aceptación de la issue, decide si se cumple, no se cumple o no se puede verificar, y da la evidencia: `archivo:línea`, salida de la CI o commit. Lo que solo se ve ejecutando la app (aspecto visual, interacción) es no verificable, salvo que la PR aporte pruebas.
4. Comprueba el proceso según la sección «Flujo de trabajo con git» de CLAUDE.md:
   - La rama base es `dev`.
   - La rama de origen sigue el formato de esa sección y lleva el número de la issue de `Closes #n`.
   - La descripción incluye `Closes #n`.
   - Cada commit de `get_commits` pasa `npx commitlint --extends @commitlint/config-conventional --from <sha>~1 --to <sha>`. `--extends` hace falta mientras no exista `commitlint.config.cjs`. Si git no encuentra el commit en local, ese commit es no verificable.
   - La CI del último commit está en verde. Si no hay checks, el estado es «sin CI», no verde.
5. Señala los cambios que la issue no pide. Si la descripción de la PR los justifica, dilo, pero siguen fuera de alcance.
6. Separa los errores demostrados, con evidencia que los muestra, de los riesgos sin demostrar. Cada hallazgo necesita evidencia que puedas citar; si no la tienes, como mucho es un pendiente. No inventes hallazgos: si no hay defectos, dilo.
7. Lee la plantilla [formato-informe.md](formato-informe.md), en `.claude/skills/revisar-pr/`, y devuelve el informe con ese formato. El informe es tu única respuesta.

## Evidencia

- Cita líneas de la cabeza de la PR. Léelas con `mcp__github__get_file_contents` y `ref` = `refs/pull/<número>/head`. Usa Read, Grep, Glob o `git diff` en local solo si el commit local coincide con el SHA de la cabeza de la PR.
- Abrevia los SHA a 7 caracteres.
