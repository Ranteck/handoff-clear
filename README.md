# handoff-clear

Skill de Claude Code que arma un prompt corto para seguir el trabajo en una sesión nueva, después de un `/clear` o en otro chat.

## Para qué sirve

Las sesiones largas consumen más y, cuando se compactan, pierden las restricciones que solo se dijeron en el chat. Conviene arrancar limpio en cada hito (por ejemplo, al aprobar un intent y pasar a implementarlo) sin perder el hilo. La skill:

1. junta el estado de la sesión: commits o archivos tocados, lo que quedó sin pushear, el avance del plan y lo que se tocó fuera del repo;
2. guarda las decisiones que todavía no estén escritas, según su alcance: de una feature, en su intent (con tu OK si ya está aprobado); de todo el proyecto, en su CLAUDE.md, solo con tu OK; el resto, en la memoria;
3. devuelve un prompt de hasta 250 palabras (más el encargo textual, si no hay intent) que apunta al intent en vez de reescribir la idea, y que le pide a la sesión nueva confirmar objetivo, límites y próximo paso antes de arrancar.

Después hacés `/clear` y pegás el prompt, o le pedís que lo lance en un chat nuevo con `/orca-cli` (requiere Orca).

## Instalación

```sh
git clone https://github.com/Ranteck/handoff-clear.git ~/Proyectos/handoff-clear
ln -s ~/Proyectos/handoff-clear/skills/handoff-clear ~/.claude/skills/handoff-clear
```

Se invoca con `/handoff-clear` o pidiendo "resumen para el clear".

## Licencia

MIT
