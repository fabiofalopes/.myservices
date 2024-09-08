#!/bin/bash

# Define source and destination directories
SRC_DIR="$HOME/Downloads/webClippingsMarkDownload"
DEST_DIR="$HOME/obsidian_vault/webClippingsMarkDownload"

# Function to safely move files and folders
safe_move() {
    local source="$1"
    local dest="$2"

    # Wait for the file to stabilize (no changes for 1 second)
    while true; do
        sleep 1
        if [[ $(find "$source" -type f -mmin -0.016) == "" ]]; then
            break
        fi
    done

    # Use rsync to safely copy files and folders
    rsync -av --remove-source-files "$source" "$dest"

    # Remove empty directories in source
    find "$SRC_DIR" -type d -empty -delete
}

# Main loop
while true; do
    # Wait for create or move events in the source directory
    inotifywait -e create,move,close_write -q -r "$SRC_DIR"

    # Process each item in the source directory
    for item in "$SRC_DIR"/*; do
        if [ -e "$item" ]; then
            safe_move "$item" "$DEST_DIR"
            echo "Moved: $item to $DEST_DIR at $(date)"
        fi
    done
done
