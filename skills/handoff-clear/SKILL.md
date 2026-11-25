---
name: handoff-clear
description: Usar cuando el usuario pide un traspaso o handoff ("resumen para el clear", "voy a hacer clear", "pasame el contexto", "prompt para la sesión nueva"), cuando se aprueba un intent y la implementación sigue en otra sesión, o cuando se cierra una tarea grande y conviene arrancar limpio.
---

# Traspaso a una sesión nueva

La sesión nueva carga sola CLAUDE.md y la memoria; `intent/` y git, no. El prompt lleva solo lo que se perdería.

## Pasos

1. **Juntar el estado, sin pedírselo al usuario:**
   - los commits de la sesión y lo que quedó sin commitear o sin pushear; sin repo git, los archivos creados o modificados;
   - el registro de avance del plan activo, si existe;
   - lo que se tocó fuera del repo (tareas, registros, documentos), con la hora de la última actualización;
   - las decisiones o restricciones del usuario que no estén escritas: guardarlas primero según su alcance (intent de la feature, instrucciones del proyecto o globales, o memoria), con OK del usuario antes de editar instrucciones o un intent aprobado.
2. **Escribir el prompt,** con un máximo de 250 palabras sin contar el encargo citado, y en este orden:
   - una línea con el proyecto, la rama si hay git y la skill de proceso que hay que usar;
   - **Leer primero:** solo la ruta del intent vigente o, si no hay, el encargo del usuario citado textual. Es la única descripción de la idea en el prompt.
   - **Estado:** qué quedó hecho, con el rango de commits o los archivos tocados, y si está pusheado; si hay una orquestación en curso, cómo retomarla (en Orca, `run-use --id <run>`) y qué workers siguen pendientes; si hay supervisor, la línea que indica la skill `supervisar`;
   - **Fuera del repo:** solo lo que cambió en la sesión;
   - **Lo próximo:** la tarea siguiente y cómo arrancarla;
   - **Pendientes:** solo los que no están en un archivo, o dónde están;
   - **Al arrancar:** "Antes de planear o delegar, devolvé en tres líneas el objetivo, los límites y el próximo paso. Preguntá solo si falta algo o hay contradicciones." Si hay una orquestación en curso, sumá antes: "Retomala y revisá su bandeja; no crees otra ni relances workers."
3. **Abrirlo en una pestaña nueva de Orca** con `/orca-cli`: `terminal create` (no `agent launch`, que no elige perfil) en la carpeta del proyecto, con el comando del perfil de Claude que diga el usuario (si no lo dijo, preguntalo) más `--effort` con el nivel que tus instrucciones fijan para el rol de la sesión nueva. Pasale el prompt desde un archivo temporal, con las comillas simples como único envoltorio de `--command`, para que lo expanda la pestaña: `--command '<comando> -- "$(cat <archivo>)"'`. Después cerrá esta pestaña con `orca terminal close --terminal "$ORCA_TERMINAL_HANDLE" --tab`, como última acción y solo con la prueba de que la nueva tomó el trabajo: esperá `orca terminal wait --terminal <nueva> --for tui-idle`; si había orquestación, la nueva la retoma con `run-use --id <run>` y así esta pestaña la suelta: corré `orca orchestration run-current` acá, en la vieja, y cerrala solo cuando dé `none` (si sigue dando el run, no cierres y avisá); si no, `orca terminal read --terminal <nueva>` tiene que mostrar sus tres líneas. Para `/clear` en este chat o sin Orca, entregalo en un solo bloque de código con: "Pegalo después de `/clear` o en un chat nuevo."

## Reglas

- Nada de secretos ni datos personales: el prompt se pega en un chat.
- Hechos, no relato: commits, estados y archivos, no lo que se fue probando.
- Lo que quedó a medias va primero en "Lo próximo", con el motivo.
- Lo que no se verificó en la sesión se dice así ("tareas sin revisar en esta sesión"), no se supone.
