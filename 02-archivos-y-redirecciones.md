# Archivos y redirecciones

## Crear, mover, borrar

```bash
touch notas.txt              # archivo vacío (si existe, le cambia la fecha)
touch -t 202612241200 a.txt  # fecha a mano: AAAAMMDDhhmm
mkdir -p proyecto/src        # -p crea las carpetas intermedias
mv notas.txt apuntes.txt     # renombrar
mv apuntes.txt carpeta/      # mover
rm -i archivo                # borrar preguntando
rmdir carpeta                # solo si está vacía
rm -rf carpeta               # todo, sin preguntar
```

No hay papelera. Lo que se borra con `rm` no vuelve.

`rm -rf` es el más peligroso: mirar la ruta con `ls` antes. Si borra algo protegido (por ejemplo los objetos de una carpeta `.git`), `rm -r` pregunta archivo por archivo y `-f` se lo saltea.

## stdin, stdout, stderr

Cada programa tiene 3 canales: 0 entrada (teclado), 1 salida (pantalla), 2 errores (pantalla).

```bash
ls > lista.txt                   # salida a archivo (lo pisa)
date >> registro.txt             # agrega al final
wc -l < prueba.txt               # entrada desde archivo
find / -name x 2> errores.txt    # solo los errores
find / -name x 2>/dev/null       # tirar los errores
ls /tmp /noexiste > todo.txt 2>&1    # salida y errores juntos
ls ~ /noexiste &> todo.txt       # lo mismo, atajo de bash
ls -l | less                     # tubería
ls -l | tee lista.txt            # pantalla y archivo a la vez
```

- `>` es lo mismo que `1>`.
- En `2>&1` importa el orden: `> archivo 2>&1` anda, `2>&1 > archivo` deja los errores en pantalla.
- `>` crea (o vacía) el archivo **antes** de correr el comando. Si el comando falla, el archivo queda igual, vacío. Me pasó en el lab de patch: escribí `dif` en vez de `diff` y el parche quedó en 0 bytes.

## Resultado del último comando

```bash
echo $?    # 0 = salió bien, otro número = error
```

En `diff`, 0 significa que no hay diferencias y 1 que sí hay.

---
[Volver al índice](README.md)
