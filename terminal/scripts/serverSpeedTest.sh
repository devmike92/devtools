#!/bin/bash

# Prueba 10 veces el tiempo de respuesta https de multiples servidores, luego
# obtiene el tiempo promedio y da respuesta lista de mayor a menor tiempo

# Lista de servicios de IP a probar
SERVICES=(
    "ifconfig.me"
    "icanhazip.com"
    "checkip.amazonaws.com"
    "ipecho.net/plain"
    "myexternalip.com/raw"
    "wtfismyip.com/text"
    "ip-api.com/json"
    "api64.ipify.org"
    "ident.me"
    "ip.seeip.org"
)

declare -A RESULTS

echo "Probando servicios de IP..."

# Iterar sobre cada servicio
for SERVICE in "${SERVICES[@]}"; do
    TOTAL_TIME=0
    ATTEMPTS=10  # Número de consultas por servicio

    echo "⏳ Probando $SERVICE..."
    
    # Realizar 10 consultas consecutivas
    for ((i = 1; i <= ATTEMPTS; i++)); do
        START_TIME=$(date +%s.%N)
        curl -s -o /dev/null --connect-timeout 3 "https://$SERVICE"
        END_TIME=$(date +%s.%N)

        # Calcular tiempo en milisegundos
        TIME_MS=$(echo "scale=2; ($END_TIME - $START_TIME) * 1000" | bc)
        TOTAL_TIME=$(echo "$TOTAL_TIME + $TIME_MS" | bc)
    done

    # Calcular promedio de tiempo de respuesta
    AVG_TIME=$(echo "scale=2; $TOTAL_TIME / $ATTEMPTS" | bc)

    # Guardar resultado en el array asociativo
    RESULTS["$SERVICE"]=$AVG_TIME

    echo "✅ Servicio: $SERVICE -> Promedio: ${AVG_TIME} ms"
done

# Ordenar y mostrar resultados de mayor a menor
echo -e "\n🔽 Ranking de servicios por tiempo de respuesta (de mayor a menor):"
for SERVICE in $(printf "%s\n" "${!RESULTS[@]}" | awk '{print $0}' | while read service; do echo "$service ${RESULTS[$service]}"; done | sort -k2 -nr | awk '{print $1}'); do
    echo "🔹 $SERVICE -> ${RESULTS[$SERVICE]} ms"
done
