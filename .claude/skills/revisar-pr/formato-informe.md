# Formato del informe de revisión

Escribe el informe en Markdown y en español, con estas secciones y en este orden. Si una sección no tiene contenido, escribe «Ninguno» en lugar de quitarla. En las tablas, solo texto corto: lo largo va en los hallazgos.

## Plantilla

```markdown
# Revisión de la PR #<número>: <título>

**Veredicto:** <aprobable / aprobable con cambios / no aprobable>. <Una o dos frases con el motivo.>

## Criterios de aceptación (issue #<número>)

| Criterio                          | Estado                                      | Evidencia                                  |
| --------------------------------- | ------------------------------------------- | ------------------------------------------ |
| <criterio, como está en la issue> | <Se cumple / No se cumple / No verificable> | <`archivo:línea`, check de la CI o commit> |

## Hallazgos

### Errores demostrados

1. **[<Alta / Media / Baja>] <resumen en una línea>**
   - Evidencia: <`archivo:línea`, salida de la CI o commit>
   - Impacto: <qué falla o qué regla se incumple>
   - Comprobación sugerida: <cómo confirmarlo o corregirlo>

### Riesgos sin demostrar

<Mismo formato que los errores. En «Evidencia», lo que hace sospechar el riesgo.>

### Fuera de alcance

- <`archivo`>: <qué cambia y por qué la issue no lo pide>

## Proceso, CI y commits

| Comprobación                  | Estado                                      | Evidencia                      |
| ----------------------------- | ------------------------------------------- | ------------------------------ |
| Rama base `dev`               | <Se cumple / No se cumple>                  | <rama base>                    |
| Formato de la rama            | <Se cumple / No se cumple / No verificable> | <rama de origen>               |
| `Closes #n` en la descripción | <Se cumple / No se cumple>                  | <número de la issue>           |
| CI del último commit          | <Verde / Roja / En curso / Sin CI>          | <cada check con su conclusión> |

| Commit                | Mensaje (primera línea) | commitlint                             |
| --------------------- | ----------------------- | -------------------------------------- |
| <SHA de 7 caracteres> | <mensaje>               | <Pasa / Falla: regla / No verificable> |

## Pendientes de verificar

- <qué no se ha podido comprobar, por qué y cómo comprobarlo>
```

## Veredicto

- **Aprobable**: ningún criterio está como «No se cumple», no hay errores demostrados, el proceso es correcto y la CI no está en rojo.
- **Aprobable con cambios**: ningún criterio está como «No se cumple» ni hay errores demostrados de gravedad alta, pero hay errores de gravedad media o baja, fallos del proceso que se corrigen sin tocar el código (un mensaje de commit, la descripción de la PR) o cambios fuera de alcance.
- **No aprobable**: algún criterio no se cumple, hay un error demostrado de gravedad alta, la CI está en rojo o la PR no va contra `dev`.

Los riesgos sin demostrar y los pendientes no bajan el veredicto. Si alguno es importante, menciónalo en el motivo.

## Gravedad

Ordena los hallazgos de cada apartado de más a menos grave.

- **Alta**: hace que un criterio no se cumpla, rompe la app o la compilación, o expone un secreto.
- **Media**: incumple una regla de CLAUDE.md o del flujo de git, o deja sin cubrir un caso de la issue.
- **Baja**: estilo, nombres o mejoras que no cambian el comportamiento.
