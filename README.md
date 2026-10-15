# handoff-clear

Skill de Claude Code que arma un prompt corto de traspaso antes de un `/clear`.

## Para qué sirve

En las sesiones largas, cada respuesta reenvía todo el historial y el consumo sube mucho. Conviene cerrar cada tarea con `/clear` y arrancar limpio, pero sin perder el hilo. La skill:

1. junta el estado de la sesión: los commits, lo que quedó sin pushear, el ledger del plan y lo que se tocó afuera del repo;
2. guarda en la memoria o en `intent/` las decisiones que todavía no estén escritas;
3. devuelve un prompt de hasta 250 palabras, en un bloque de código, con solo lo que se perdería con el `/clear`. Lo que la sesión nueva carga sola (CLAUDE.md, la memoria y git) no se repite.

Después hacés `/clear` y pegás el prompt. La skill no puede ejecutar `/clear` por vos: es un comando del cliente.

## Instalación

```sh
git clone https://github.com/Ranteck/handoff-clear.git ~/Proyectos/handoff-clear
ln -s ~/Proyectos/handoff-clear/skills/handoff-clear ~/.claude/skills/handoff-clear
```

Se invoca con `/handoff-clear` o pidiendo "resumen para el clear".

## Licencia

MIT
