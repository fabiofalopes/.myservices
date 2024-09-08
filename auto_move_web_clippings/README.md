# Auto Move Web Clippings

This script automatically moves files and folders from a source directory to a destination directory, typically used for moving web clippings from a download folder to an Obsidian vault.

## Features

- Monitors a source directory for new files and folders
- Waits for files to finish downloading before moving
- Safely moves files and folders, preserving structure
- Handles multiple files and nested directories
- Removes empty directories in the source after moving

## Prerequisites

- Linux system with bash shell
- `inotify-tools` package installed
- `rsync` package installed

To install prerequisites on Debian-based systems:

```bash
sudo apt-get update
sudo apt-get install inotify-tools rsync
```

## Configuration

Edit the script to set your source and destination directories:

```bash
SRC_DIR="$HOME/Downloads/webClippingsMarkDownload"
DEST_DIR="$HOME/obsidian_vault/webClippingsMarkDownload"
```

## Usage

1. Place the script in `~/.myservices/auto_move_web_clippings.sh`
2. Make it executable:
   ```bash
   chmod +x ~/.myservices/auto_move_web_clippings.sh
   ```
3. Create a systemd service file:
   ```bash
   sudo nano /etc/systemd/system/auto_move_web_clippings.service
   ```
   Add the following content:
   ```
   [Unit]
   Description=Auto Move Web Clippings
   After=network.target

   [Service]
   User=your_username
   ExecStart=/home/your_username/.myservices/auto_move_web_clippings.sh

   [Install]
   WantedBy=multi-user.target
   ```
4. Enable and start the service:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable auto_move_web_clippings.service
   sudo systemctl start auto_move_web_clippings.service
   ```

## Monitoring

To check the status of the service:
```bash
sudo systemctl status auto_move_web_clippings.service
```

To view logs:
```bash
journalctl -u auto_move_web_clippings.service
```

## Troubleshooting

If files aren't moving:
1. Check that the source and destination paths are correct
2. Ensure the script has permission to read from the source and write to the destination
3. Verify that inotify-tools and rsync are installed
4. Check the system logs for any error messages
