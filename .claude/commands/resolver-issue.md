---
description: Resuelve una issue de GitHub siguiendo el flujo del proyecto
argument-hint: '[numero-issue]'
disable-model-invocation: true
allowed-tools: Bash(git branch --show-current)
---

Rama actual: !`git branch --show-current`

Resuelve la issue #$ARGUMENTS de `dblanco-galfor/proyecto_curso` siguiendo la sección «Flujo de trabajo con git» de CLAUDE.md. Haz los pasos en orden.

1. Lee la issue #$ARGUMENTS por el MCP de GitHub, con sus comentarios. Si alguna de sus dependencias («Depende de #n») sigue abierta, para y dime cuál.
2. Crea desde `dev` actualizada la rama `<tipo>/$ARGUMENTS-<descripción-breve>` (`feature`, `fix`, `chore` o `docs`) y propón un plan: qué archivos cambias y cómo cubres cada criterio de aceptación. Espera mi aprobación antes de tocar el código.
3. Haz el cambio y ejecuta `npm run check`. Si falla, corrígelo hasta que pase.
4. Comprueba los criterios de aceptación uno a uno: para cada uno, di si se cumple y cómo lo has comprobado. Si alguno no se cumple, vuelve al paso 3.
5. Valida el mensaje del commit pasándolo completo por la entrada estándar a `npx commitlint --extends @commitlint/config-conventional`. Usa `--extends` porque todavía no existe `commitlint.config.cjs`; seguirá funcionando cuando exista. Si no sale con 0, corrige el mensaje y vuelve a validarlo. Después haz el commit con ese mismo mensaje.
6. Sube la rama y abre la PR contra `dev` por el MCP de GitHub. En la descripción pon `Closes #$ARGUMENTS` y la lista de criterios de aceptación. No la fusiones.
