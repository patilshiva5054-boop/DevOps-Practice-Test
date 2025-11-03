#!/bin/bash
# -------------------------------------------------------
# Automated Backup System (Fixed Version)
# -------------------------------------------------------


LOG_FILE="./backup.log"
exec > >(tee -a "$LOG_FILE") 2>&1

CONFIG_FILE="./backup.config"

# === Load configuration ===
if [ ! -f "$CONFIG_FILE" ]; then
    echo "⚠️ Config file not found! Using default values."
    BACKUP_DESTINATION="./backups"
    EXCLUDE_PATTERNS=".git,node_modules,.cache"
    DAILY_KEEP=7
else
    source "$CONFIG_FILE"
fi

# === Variables ===
SOURCE_DIR=$1
TIMESTAMP=$(date +%Y-%m-%d-%H%M)
BACKUP_NAME="backup-$TIMESTAMP.tar.gz"
BACKUP_PATH="$BACKUP_DESTINATION/$BACKUP_NAME"
CHECKSUM_FILE="$BACKUP_PATH.md5"
LOG_FILE="./backup.log"

# === Logging ===
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# === Start ===
log "--------------------------------------------"
log "🚀 Starting backup process..."

# === Validations ===
if [ -z "$SOURCE_DIR" ]; then
    log "❌ Error: No source directory specified!"
    log "Usage: ./backup.sh <folder_path>"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    log "❌ Error: Source folder '$SOURCE_DIR' does not exist."
    exit 1
fi

mkdir -p "$BACKUP_DESTINATION"

# === Handle excludes ===
EXCLUDES=()
IFS=',' read -ra EXCLUDE_ARRAY <<< "$EXCLUDE_PATTERNS"
for pattern in "${EXCLUDE_ARRAY[@]}"; do
    EXCLUDES+=(--exclude="$pattern")
done

# === Create backup ===
log "📦 Creating backup of '$SOURCE_DIR'..."
tar -czf "$BACKUP_PATH" "${EXCLUDES[@]}" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")" 2>>"$LOG_FILE"

if [ $? -ne 0 ]; then
    log "❌ Backup failed!"
    exit 1
fi

log "✅ Backup created successfully: $BACKUP_PATH"

# === Create checksum ===
md5sum "$BACKUP_PATH" > "$CHECKSUM_FILE"
log "🔒 Checksum saved: $CHECKSUM_FILE"

# === Verify checksum ===
md5sum -c "$CHECKSUM_FILE" >/dev/null 2>&1
if [ $? -eq 0 ]; then
    log "✅ Checksum verification passed!"
else
    log "❌ Checksum verification failed!"
fi

# === Delete old backups ===
log "🧹 Cleaning backups older than $DAILY_KEEP days..."
find "$BACKUP_DESTINATION" -type f -name "backup-*.tar.gz" -mtime +$DAILY_KEEP -exec bash -c '
    for f; do
        echo "Deleting old backup: $f"
        rm -f "$f" "$f.md5"
    done
' bash {} +

log "🧾 Backup completed successfully!"
log "--------------------------------------------"

CHECKSUM_FILE="$BACKUP_FILE.md5"
md5sum "$BACKUP_FILE" > "$CHECKSUM_FILE"
echo "🔒 Checksum saved to $CHECKSUM_FILE"




# === Create checksum ===
md5sum "$BACKUP_PATH" > "$CHECKSUM_FILE"
echo "🔒 Checksum saved to $CHECKSUM_FILE"

# === Verify checksum ===
if md5sum -c "$CHECKSUM_FILE" >/dev/null 2>&1; then
    echo "✅ Checksum verification passed!"
else
    echo "❌ Checksum verification failed!"
fi


find "$DEST_DIR" -type f -mtime +7 -name "backup-*.tar.gz" -exec rm {} \;
echo "🧹 Deleted backups older than 7 days."
