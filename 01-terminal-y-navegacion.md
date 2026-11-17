# Terminal y navegación

## Terminales virtuales

Ctrl + Alt + F1 a F6 para cambiar de consola de texto. El escritorio gráfico suele estar en F1 o F2.

En VMware el anfitrión se come la combinación: Ctrl + Alt + Espacio, soltar, y después la tecla F.

## Apagar y reiniciar

```bash
sudo shutdown -h now            # apagar ya
sudo shutdown -h 22:00          # apagar a las 22
sudo shutdown -r now            # reiniciar
sudo shutdown -h +10 "Mensaje"  # en 10 min, avisando a los usuarios
sudo shutdown -c                # cancelar
sudo reboot / sudo poweroff     # atajos
```

Si hay una sesión gráfica abierta, `sudo reboot` puede negarse ("Operation inhibited..."). Se fuerza con:

```bash
sudo systemctl reboot -i
```

## Moverse

```bash
whereis gcc     # dónde está el programa, el código y el man
pwd             # dónde estoy
cd /usr/bin     # ir a una ruta
cd ..           # subir un nivel
cd -            # volver al directorio anterior
cd /            # a la raíz
cd ~            # a mi carpeta personal (cd solo hace lo mismo)
```

`/` raíz, `..` arriba, `-` donde estaba antes, `~` mi carpeta, `.` acá.

Ruta absoluta: empieza en `/` y anda desde cualquier lado (`cat /home/student/prueba.txt`).
Ruta relativa: depende de dónde estoy parado (`cat prueba.txt`, `ls ../`).

### Pila de directorios

`cd -` recuerda uno solo. `pushd` / `popd` recuerdan varios (el último que entra es el primero que sale).

```bash
cd ~
pushd /etc       # voy a /etc y guarda ~
pushd /usr/bin   # voy a /usr/bin y guarda /etc
dirs -v          # ver la pila numerada
popd             # vuelvo a /etc
popd             # vuelvo a ~
```

## Ver qué hay

```bash
ls -la          # todo, con ocultos y detalle (permisos, dueño, tamaño, fecha)
ls -li          # con número de inodo
tree -L 2       # árbol de 2 niveles (sudo apt install tree)
tree -d         # solo carpetas
df -h           # espacio libre por disco
```

Ojo: si copiás comandos del material del curso, a veces viene la raya larga (`—`) en lugar del guion (`-`) y da error.

## Ver archivos

```bash
cat notas.txt         # todo de una (para archivos cortos)
tac notas.txt         # al revés, desde la última línea
less archivo          # paginado. /texto busca, n siguiente, q sale
head -n 5 archivo     # primeras líneas (10 por defecto)
tail -15 archivo      # últimas líneas
tail -f /var/log/syslog   # sigue el log en vivo, Ctrl+C para salir
```

`more` es el paginador viejo. "less is more": `less` hace lo mismo y más.

## Enlaces

```bash
touch archivo1
ln archivo1 archivo2      # duro: otro nombre para el mismo archivo (mismo inodo)
ln -s archivo1 archivo3   # suave: un acceso directo a la ruta
ls -li archivo*
```

- Duro: si borro el original sigue andando. No sirve para carpetas ni entre particiones.
- Suave: si borro o muevo el original queda roto. Sirve para carpetas. En `ls -l` se ve `archivo3 -> archivo1`.

El duro es otro nombre del mismo archivo, el suave es un cartel que dice dónde está.

---
[Volver al índice](README.md)
