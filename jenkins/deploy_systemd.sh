#!/bin/bash

# Install application to /opt/
sudo rm -r /opt/todo-list
sudo mkdir /opt/todo-list
sudo cp -r . /opt/todo-list

# Generate service file
cat > todo-list.service << EOF 
[Unit]
Description=Todo List

[Service]
User=pythonadm
Environment=SECRET_KEY
Environment=DATABASE_URI
ExecStart=/home/jenkins/startup.sh

[Install]
WantedBy=multi-user.target
EOF

# Move service file to 
sudo chown -R pythonadm:pythonadm /opt/todo-list
sudo cp todo-list.service /etc/systemd/system/todo-list.service

# systemd reload/start/stop
sudo systemctl daemon-reload
sudo systemctl stop todo-list
sudo systemctl start todo-list
