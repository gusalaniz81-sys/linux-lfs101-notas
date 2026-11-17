# Buscar archivos y comodines

## locate

```bash
locate zip | grep bin    # todo lo que tenga "zip" y además "bin"
sudo updatedb            # actualizar la base
locate -i myfile         # sin distinguir mayúsculas
```

Es rápido porque busca en una base de datos, no en el disco. La base se actualiza una vez por día: un archivo recién creado no aparece hasta correr `sudo updatedb`. Si no está: `sudo apt install plocate`.

## find

Recorre el disco en el momento. Más lento, pero siempre al día.

```bash
find /usr -name gcc               # archivos y carpetas
find /usr -type d -name gcc       # solo carpetas
find /usr -type f -name gcc       # solo archivos
find /usr -type l -name gcc       # solo enlaces
find ~ -iname "myfile*"           # sin mayúsculas
find / -name algo 2>/dev/null     # sin los errores de permisos
```

`/usr/bin/gcc` no sale con `-type f` porque es un enlace a la versión instalada (`gcc -> gcc-13`).

Por fecha y tamaño:

```bash
find ~ -mtime -1          # modificados en las últimas 24 h
find / -ctime 3           # cambio de estado hace exactamente 3 días
find / -size 0            # vacíos
find ~ -size +10M         # más de 10 MB
```

`3` exacto, `-3` menos de, `+3` más de. `-mtime` contenido, `-ctime` estado (permisos, dueño), `-atime` acceso. Tamaños: `c` bytes, `k`, `M`, `G`.

Hacer algo con lo que encuentra:

```bash
find ~ -size +10M -exec ls -lh {} ';'
find -name "*.swp" -ok rm {} ';'     # -ok pregunta antes de cada uno
```

`{}` es cada archivo encontrado y `';'` cierra el comando. Antes de un `-exec rm`, correr el mismo find sin el `-exec` para ver qué borraría.

## Comodines

```bash
ls ?1.txt       # ? = un carácter
ls *.txt        # * = cualquier cosa
ls [adf]*       # empieza con a, d o f
ls [!adf]*      # no empieza con a, d ni f
ls archivo[1-3].txt
```

Distinguen mayúsculas y `*` no incluye los ocultos. Antes de `rm *.log`, probar con `ls *.log`.

Ejercicio del curso, archivos de 5 letras que empiezan con g y cuya segunda letra no está entre a y m:

```bash
ls /usr/bin/g[!a-m]???
```

---
[Volver al índice](README.md)
