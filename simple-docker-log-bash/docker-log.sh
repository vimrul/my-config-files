LOG_FILE="/path/to/file.log"

mkdir -p "$(dirname "$LOG_FILE")"

while true; do
    CONTAINER_ID=$(docker ps -qf "name=^/${CONTAINER_NAME}$")

    if [ -n "$CONTAINER_ID" ]; then
        echo "[INFO] Logging from container $CONTAINER_NAME (ID: $CONTAINER_ID)" >> "$LOG_FILE"
        docker logs -f "$CONTAINER_ID" >> "$LOG_FILE" 2>&1
        echo "[WARN] Log stream ended. Waiting for container to restart..." >> "$LOG_FILE"
    else
        echo "[WARN] Container $CONTAINER_NAME not running. Retrying in 5s..." >> "$LOG_FILE"
        sleep 5
    fi

    sleep 2
done
