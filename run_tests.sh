#!/bin/bash

# Define el esquema y el destino de tu proyecto
SCHEME="RecipesApp"
DESTINATION="platform=iOS Simulator,name=iPhone 16,OS=latest" # Ajusta según tu simulador

# Mensaje inicial de carga
echo -n "Ejecutando pruebas"

# Crear un proceso en segundo plano para el loader
{
    while kill -0 $! 2>/dev/null; do
        for i in "" "." ".." "..."; do
            echo -ne "\rEjecutando pruebas$i"  # Usar \r para sobrescribir la línea
            sleep 1
        done
    done
} &

# Ejecuta las pruebas
RESULT=$(xcodebuild -scheme "$SCHEME" -destination "$DESTINATION" test | xcpretty)

# Termina el proceso del loader
kill $! 2>/dev/null

# Extrae el número de pruebas pasadas y fallidas
PASSED=$(echo "$RESULT" | grep -E "passed" | awk '{print $1}' | tail -n 1)
FAILED=$(echo "$RESULT" | grep -E "failed" | awk '{print $1}' | tail -n 1)

# Muestra los resultados
echo -e "\nPruebas pasadas: ${PASSED:-0}"
echo "Pruebas fallidas: ${FAILED:-0}"
