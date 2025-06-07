#!/bin/bash

# Definir variables
PROXMOX_IP="10.10.13.202"
SERVER_IP="10.10.16.2"

# Habilitar el reenvío de paquetes
echo "Habilitando el reenvío de paquetes..."
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -w net.ipv4.ip_forward=1

# Limpiar reglas previas
iptables -t nat -F
iptables -F

# Configurar NAT (masquerade) para permitir tráfico entre VLANs
iptables -t nat -A POSTROUTING -o vmbr0 -j MASQUERADE

# Redirigir puertos de Proxmox a la máquina del servidor
# HTTP (80)
iptables -t nat -A PREROUTING -p tcp --dport 80 -d $PROXMOX_IP -j DNAT --to-destination $SERVER_IP:80
iptables -A FORWARD -p tcp -d $SERVER_IP --dport 80 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# HTTPS (443)
iptables -t nat -A PREROUTING -p tcp --dport 443 -d $PROXMOX_IP -j DNAT --to-destination $SERVER_IP:443
iptables -A FORWARD -p tcp -d $SERVER_IP --dport 443 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# SSH (22)
iptables -t nat -A PREROUTING -p tcp --dport 2222 -d $PROXMOX_IP -j DNAT --to-destination $SERVER_IP:22
iptables -A FORWARD -p tcp -d $SERVER_IP --dport 22 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# OpenVPN (1194/udp)
sudo iptables -t nat -A PREROUTING -i vmbr0 -p udp --dport 1194 -j DNAT --to-destination 10.10.16.2:1194

# Bloquear trafico entre VLAN 10 y VLAN 20
iptables -A FORWARD -i vmbr0.10 -o vmbr0.20 -j DROP
iptables -A FORWARD -i vmbr0.20 -o vmbr0.10 -j DROP

# Guardar reglas para que persistan tras reinicio
#apt install -y iptables-persistent
#netfilter-persistent save

# Mostrar reglas aplicadas
iptables -t nat -L -n -v
echo "Reglas aplicadas correctamente."

