# Creating a Custom Service

This outlines the steps to create and manage a custom service on a Linux system using systemd.

## Steps to Create a Service

1. Create a script:
   - Place your script in `~/.myservices/`
   - Make it executable: `chmod +x ~/.myservices/your_script.sh`

2. Create a service file:
   - Create a .service file in `/etc/systemd/system/`
   - Example: `sudo nano /etc/systemd/system/your_service.service`

3. Configure the service file:
   ```
   [Unit]
   Description=Your Service Description
   After=network.target

   [Service]
   User=your_username
   ExecStart=/home/your_username/.myservices/your_script.sh

   [Install]
   WantedBy=multi-user.target
   ```

4. Reload systemd:
   ```
   sudo systemctl daemon-reload
   ```

5. Enable the service:
   ```
   sudo systemctl enable your_service.service
   ```

6. Start the service:
   ```
   sudo systemctl start your_service.service
   ```

## Managing Your Service

- Check status: `sudo systemctl status your_service.service`
- Stop service: `sudo systemctl stop your_service.service`
- Restart service: `sudo systemctl restart your_service.service`
- Disable service: `sudo systemctl disable your_service.service`

## Viewing Logs

To view service logs:
```
journalctl -u your_service.service
```

Replace `your_username`, `your_script.sh`, and `your_service` with your actual username, script name, and service name respectively.
