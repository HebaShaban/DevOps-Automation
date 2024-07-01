#!/bin/bash
# Create users Devo, Testo, Prodo
sudo useradd Devo
sudo useradd Testo
sudo useradd Prodo

# Create group deployG
sudo groupadd deployG

# Add users to deployG group
sudo usermod -aG deployG Devo
sudo usermod -aG deployG Testo
sudo usermod -aG deployG Prodo
