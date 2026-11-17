# Apuntes de Linux

Mis notas del curso **Introducción a Linux (LFS101x)** de la Linux Foundation en edX, que estoy haciendo en noviembre de 2026 mientras curso la Tecnicatura en Sistemas en la UTN.

Practico en una VM con Ubuntu 26.04 sobre VMware. Lo que anoto es lo que probé, incluidos los errores que me fueron saliendo, porque de esos me acuerdo más.

## Temas

1. [Terminal y navegación](01-terminal-y-navegacion.md)
2. [Archivos y redirecciones](02-archivos-y-redirecciones.md)
3. [Buscar archivos y comodines](03-buscar-y-comodines.md)
4. [Paquetes y ayuda](04-paquetes-y-ayuda.md)
5. [Directorios del sistema](05-directorios-del-sistema.md)
6. [Montaje, fstab y NFS](06-montaje-y-nfs.md)
7. [diff, diff3 y patch](07-diff-y-patch.md)
8. [Backups y compresión](08-backups-y-compresion.md)

## Scripts

- [`backup-home.sh`](scripts/backup-home.sh): backup de la carpeta personal con tar + gzip, armado a partir del lab 10.3.
  - Le pone fecha y hora al nombre del archivo.
  - Revisa que haya espacio antes de empezar y no deja guardar el backup dentro del home.
  - Avisa si el destino está en RAM (`tmpfs`).
  - Excluye `.cache`, prueba que el archivo se pueda leer y le pone permisos 600.
  - Guarda los últimos N y borra los más viejos.

```bash
chmod +x scripts/backup-home.sh
./scripts/backup-home.sh /var/tmp/backups 5
```

## Pendiente

- Seguir con los capítulos que faltan del curso.
- Programar el backup con cron.
