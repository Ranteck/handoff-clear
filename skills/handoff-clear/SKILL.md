---
name: handoff-clear
description: Arma un prompt corto de traspaso para que Denis lo copie, haga /clear y lo pegue en la sesión nueva sin perder el hilo. Usar cuando Denis diga "resumen para el clear", "handoff", "voy a hacer clear", "pasame el contexto", "prompt para la sesión nueva", o cuando se cierra un issue o una tarea grande y conviene arrancar limpio (el consumo sube mucho con contexto largo).
---

# Traspaso antes de /clear

Esta skill no puede ejecutar `/clear`: es un comando que tipea Denis. Lo que hace es dejarle un prompt listo para pegar después.

La sesión nueva ya carga sola CLAUDE.md, la memoria, `intent/` y el historial de git. El prompt **no repite eso**: solo lleva lo que se perdería con el `/clear`.

## Pasos

1. **Juntar el estado de la sesión, sin pedírselo a Denis:**
   - `git log --oneline` de lo hecho en la sesión, y si hay algo sin commitear o sin pushear (`git status -sb`);
   - el ledger del plan activo (`.superpowers/sdd/<plan>/progress.md`), si existe;
   - lo que se tocó afuera del repo: Daily, Taskflow, Límites de Claude y artifacts, con la hora de la última actualización;
   - decisiones de Denis de esta sesión que todavía no estén escritas en un archivo o en la memoria. Si hay alguna, guardarla primero donde corresponde (memoria o `intent/`), no solo en el prompt.
2. **Escribir el prompt,** con un máximo de 250 palabras y en este orden:
   - una línea con el proyecto, la rama y la skill de proceso que hay que usar (por ejemplo `/ai-native-sdlc`);
   - **Estado:** qué quedó hecho, con el rango de commits y si está pusheado o no;
   - **Fuera del repo:** el estado de las cards, la Daily o el registro, solo si cambiaron en la sesión;
   - **Lo próximo:** la tarea siguiente y cómo arrancarla (plan mode y aprobación, si toca código);
   - **Pendientes y hallazgos abiertos:** solo los que no están ya en un archivo, o una línea que diga dónde están.
3. **Devolverlo en un solo bloque de código**, listo para copiar. Debajo, una línea: "Hacé `/clear` y pegá esto." Si Denis viene informando el % de uso, recordarle que en la sesión nueva diga a qué hora arrancó la ventana.

## Reglas

- Nada de secretos, tokens ni datos personales de candidatos en el prompt: se pega en el chat.
- Hechos, no relato: commits, estados y archivos, no lo que se fue probando.
- Si algo quedó a medias (un commit sin hacer, una card sin cargar), va primero en "Lo próximo", con el motivo.
- No inventar el estado de lo que no se verificó en la sesión: si no se sabe, decirlo ("Taskflow sin revisar en esta sesión").
