
#!/bin/bash

# Obtener la lista de archivos modificados (excluyendo eliminados)
FILES=$(git status -s | awk '$1 != "D" {print $2}')

# Verificar si hay archivos modificados
if [ -z "$FILES" ]; then
  echo "No hay archivos modificados para hacer commit."
  exit 1
fi

# Iterar sobre cada archivo modificado
for file in $FILES; do
  echo "Mensaje para $file:"
  read msg  # Leer el mensaje del usuario
  
  # Agregar y commitear el archivo con el mensaje personalizado
  git add "$file"
  git commit -m "$msg" -- "$file"
done

echo "Commits completados."
