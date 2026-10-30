---
name: handoff-clear
description: Usar cuando el usuario pide un traspaso o handoff ("resumen para el clear", "voy a hacer clear", "pasame el contexto", "prompt para la sesión nueva"), cuando se aprueba un intent y la implementación sigue en otra sesión, o cuando se cierra una tarea grande y conviene arrancar limpio.
---

# Traspaso a una sesión nueva

La sesión nueva carga sola CLAUDE.md y la memoria; `intent/` y git, no. El prompt lleva solo lo que se perdería y dice qué leer primero, sin copiarlo.

## Pasos

1. **Juntar el estado, sin pedírselo al usuario:**
   - los commits de la sesión y lo que quedó sin commitear o sin pushear; sin repo git, los archivos creados o modificados;
   - el registro de avance del plan activo, si existe;
   - lo que se tocó fuera del repo (tareas, registros, documentos), con la hora de la última actualización;
   - las decisiones o restricciones del usuario que no estén escritas: guardarlas primero según su alcance. De una feature, en su intent (con OK del usuario si ya está aprobado); de todo el proyecto, en su CLAUDE.md, solo con OK del usuario; el resto, en la memoria.
2. **Escribir el prompt,** con un máximo de 250 palabras sin contar el encargo citado, y en este orden:
   - una línea con el proyecto, la rama si hay git y la skill de proceso que hay que usar;
   - **Leer primero:** solo la ruta del intent vigente o, si no hay, el encargo del usuario citado textual. Es la única descripción de la idea en el prompt.
   - **Estado:** qué quedó hecho, con el rango de commits o los archivos tocados, y si está pusheado; si hay una orquestación en curso, cómo retomarla (en Orca, `run-use --id <run>`) y qué workers siguen pendientes;
   - **Fuera del repo:** solo lo que cambió en la sesión;
   - **Lo próximo:** la tarea siguiente y cómo arrancarla;
   - **Pendientes:** solo los que no están en un archivo, o dónde están;
   - **Al arrancar:** "Antes de planear o delegar, devolvé en tres líneas el objetivo, los límites y el próximo paso. Preguntá solo si falta algo o hay contradicciones." Si hay una orquestación en curso, sumá antes: "Retomala y revisá su bandeja; no crees otra ni relances workers."
3. **Entregarlo en un solo bloque de código.** Si el usuario pide abrir un chat nuevo, lanzalo con `/orca-cli` y ese prompt. Si no, debajo: "Pegalo después de `/clear` o en un chat nuevo."

## Reglas

- Nada de secretos, tokens ni datos personales: el prompt se pega en un chat.
- Hechos, no relato: commits, estados y archivos, no lo que se fue probando.
- Lo que quedó a medias va primero en "Lo próximo", con el motivo.
- Lo que no se verificó en la sesión se dice así ("tareas sin revisar en esta sesión"), no se supone.
