#!/bin/bash

LOG_FILE="/var/log/application.log"
ARCHIVE_DIR="/var/log/archive"
RETENTION_DAYS=5
MAX_SIZE_MB=500

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "$(date) - Log file not found: $LOG_FILE"
    exit 0
fi

# Get log file size in MB
FILE_SIZE_MB=$(du -m "$LOG_FILE" | cut -f1)

# If file is smaller than 500MB, nothing to do
if [ "$FILE_SIZE_MB" -lt "$MAX_SIZE_MB" ]; then
    echo "$(date) - Log file size is ${FILE_SIZE_MB}MB, no rotation needed"
    exit 0
fi

# Make sure archive directory exists
mkdir -p "$ARCHIVE_DIR"

TIMESTAMP=$(date +"%Y%m%d%H%M%S")

# Archive the log
cp "$LOG_FILE" "$ARCHIVE_DIR/application.log.$TIMESTAMP"

# Clear active log so app keeps writing
> "$LOG_FILE"

# Compress archived file
gzip "$ARCHIVE_DIR/application.log.$TIMESTAMP"

# Remove archived logs older than 5 days
find "$ARCHIVE_DIR" -name "*.gz" -mtime +$RETENTION_DAYS -delete

echo "$(date) - Log rotated and old logs cleaned up"