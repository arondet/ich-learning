#!/bin/bash

# Ввод адреса от пользователя
read -p "Введите адрес для пинга: " HOST

FAIL_COUNT=0
MAX_FAILS=3

echo "Начинаем пинговать $HOST..."

while true; do
    # Выполняем один пинг и получаем время
    RESULT=$(ping -c 1 -W 1 "$HOST" 2>&1)
    SUCCESS=$?

    if [ $SUCCESS -ne 0 ]; then
        FAIL_COUNT=$((FAIL_COUNT + 1))
        echo "$(date +"%H:%M:%S") - Пинг не удался! Попытка $FAIL_COUNT из $MAX_FAILS"

        if [ $FAIL_COUNT -ge $MAX_FAILS ]; then
            echo "ВНИМАНИЕ: $MAX_FAILS последовательных неудачных пинга к $HOST!"
            FAIL_COUNT=0
        fi
    else
        # Извлекаем время пинга
        PING_TIME=$(echo "$RESULT" | grep "time=" | awk -F'time=' '{print $2}' | awk '{print $1}')
        FAIL_COUNT=0

        echo "$(date +"%H:%M:%S") - Пинг $HOST: ${PING_TIME} мс"

        # Проверяем превышает ли время 100ms
        if [ ! -z "$PING_TIME" ]; then
            CHECK=$(echo "$PING_TIME > 100" | bc 2>/dev/null)
            if [ "$CHECK" = "1" ]; then
                echo "ВНИМАНИЕ: Время пинга ${PING_TIME}мс превышает 100мс!"
            fi
        fi
    fi

    sleep 1
done
