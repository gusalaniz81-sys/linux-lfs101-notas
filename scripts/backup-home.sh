#!/bin/bash
# Backup de la carpeta personal con tar + gzip.
# Lo armé a partir del lab 10.3 del curso.
#
# Uso:  ./backup-home.sh [carpeta_destino] [cantidad_a_guardar]
# Ej:   ./backup-home.sh /var/tmp/backups 5

DESTINO="${1:-/var/tmp/backups}"
GUARDAR="${2:-5}"
FECHA=$(date +%Y-%m-%d_%H%M)
ARCHIVO="$DESTINO/home-$USER-$FECHA.tar.gz"

# no tiene sentido guardar el backup adentro de lo que estoy respaldando
case "$DESTINO" in
    "$HOME"|"$HOME"/*)
        echo "El destino no puede estar dentro de $HOME"
        exit 1
        ;;
esac

mkdir -p "$DESTINO" || exit 1

# /tmp en mi Ubuntu es tmpfs (RAM), aviso por las dudas
if [ "$(df --output=fstype "$DESTINO" | tail -1)" = "tmpfs" ]; then
    echo "Ojo: $DESTINO está en RAM (tmpfs) y se borra al reiniciar."
fi

# espacio: el home sin comprimir tiene que entrar, para ir a lo seguro
NECESITO=$(du -sk --exclude=.cache "$HOME" 2>/dev/null | cut -f1)
LIBRE=$(df -k --output=avail "$DESTINO" | tail -1)
if [ "$NECESITO" -gt "$LIBRE" ]; then
    echo "No hay espacio: necesito ${NECESITO}K y hay ${LIBRE}K libres."
    exit 1
fi

echo "Respaldando $HOME en $ARCHIVO ..."

# .cache se regenera solo, no vale la pena guardarlo
# los sockets tar los saltea con un aviso, los silencio
tar czf "$ARCHIVO" --exclude=./.cache --warning=no-file-ignored -C "$HOME" .
ESTADO=$?

# tar devuelve 1 si algún archivo cambió mientras lo copiaba (pasa con el navegador abierto)
# eso no es un error grave, el backup igual sirve
if [ $ESTADO -gt 1 ]; then
    echo "Falló tar (código $ESTADO). Borro el archivo incompleto."
    rm -f "$ARCHIVO"
    exit 1
fi

# probar que se puede leer
if ! tar tzf "$ARCHIVO" > /dev/null; then
    echo "El backup está dañado."
    exit 1
fi

chmod 600 "$ARCHIVO"    # lleva credenciales e historial, que lo lea solo yo

echo "Listo: $(du -h "$ARCHIVO" | cut -f1)"

# dejar solo los últimos N backups
ls -1t "$DESTINO"/home-"$USER"-*.tar.gz 2>/dev/null | tail -n +$((GUARDAR + 1)) | while read -r viejo; do
    echo "Borro backup viejo: $viejo"
    rm -f "$viejo"
done
