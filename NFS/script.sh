#!/bin/bash


#Creacion de grupos con GID específicos
echo "Creando grupos..."
sudo groupadd -g 2000 profesores
sudo groupadd -g 2001 alumnos


# Creacion de usuarios con UID específicos y asignarlos a los grupos
echo "Creando usuarios..."
sudo useradd -u 2000 -g profesores profesor1
sudo useradd -u 2001 -g profesores profesor2 
sudo useradd -u 2002 -g alumnos alumno1_1ASIR3
sudo useradd -u 2003 -g alumnos alumno2_1ASIR3
sudo useradd -u 2004 -g alumnos alumno1_2ASIR3
sudo useradd -u 2005 -g alumnos alumno2_2ASIR3
# Asignar contraseñas a los usuarios
echo "Asignando contraseñas..."
echo "profesor1:profesor1" | sudo chpasswd
echo "profesor2:profesor2" | sudo chpasswd
echo "alumno1_1ASIR3:alumno1" | sudo chpasswd
echo "alumno2_1ASIR3:alumno2" | sudo chpasswd
echo "alumno1_2ASIR3:alumno3" | sudo chpasswd
echo "alumno2_2ASIR3:alumno4" | sudo chpasswd


# Creacion estructura de carpetas
echo "Creando estructura de carpetas..."
sudo mkdir -p /mnt/nfs/1ASIR3/profesores
sudo mkdir -p /mnt/nfs/1ASIR3/alumnos/apuntes
sudo mkdir -p /mnt/nfs/1ASIR3/alumnos/alumno1
sudo mkdir -p /mnt/nfs/1ASIR3/alumnos/alumno2


sudo mkdir -p /mnt/nfs/2ASIR3/profesores
sudo mkdir -p /mnt/nfs/2ASIR3/alumnos/apuntes
sudo mkdir -p /mnt/nfs/2ASIR3/alumnos/alumno1
sudo mkdir -p /mnt/nfs/2ASIR3/alumnos/alumno2


# Asignar permisos a las carpetas
echo "Asignando permisos..."


# Carpeta profesores
sudo chown -R profesor1:profesores /mnt/nfs/1ASIR3/profesores
sudo chown -R profesor2:profesores /mnt/nfs/2ASIR3/profesores
sudo chmod 770 /mnt/nfs/1ASIR3/profesores
sudo chmod 770 /mnt/nfs/2ASIR3/profesores


# Carpeta apuntes
sudo chown -R profesor1:profesores /mnt/nfs/1ASIR3/alumnos/apuntes
sudo chown -R profesor2:profesores /mnt/nfs/2ASIR3/alumnos/apuntes
sudo chmod 770 /mnt/nfs/1ASIR3/alumnos/apuntes
sudo chmod 770 /mnt/nfs/2ASIR3/alumnos/apuntes
sudo setfacl -m g:alumnos:rx /mnt/nfs/1ASIR3/alumnos/apuntes
sudo setfacl -m g:alumnos:rx /mnt/nfs/2ASIR3/alumnos/apuntes


# Carpetas personales de alumnos
sudo chown -R alumno1_1ASIR3:profesores /mnt/nfs/1ASIR3/alumnos/alumno1
sudo chown -R alumno2_1ASIR3:profesores /mnt/nfs/1ASIR3/alumnos/alumno2
sudo chown -R alumno1_2ASIR3:profesores /mnt/nfs/2ASIR3/alumnos/alumno1
sudo chown -R alumno2_2ASIR3:profesores /mnt/nfs/2ASIR3/alumnos/alumno2
sudo chmod 770 /mnt/nfs/1ASIR3/alumnos/alumno1
sudo chmod 770 /mnt/nfs/1ASIR3/alumnos/alumno2
sudo chmod 770 /mnt/nfs/2ASIR3/alumnos/alumno1
sudo chmod 770 /mnt/nfs/2ASIR3/alumnos/alumno2


# Configurar NFS
echo "Configurando NFS..."
sudo bash -c 'echo "/mnt/nfs/1ASIR3 10.10.14.0/24(rw,sync,no_subtree_checkno_,no_all_squash)" >> /etc/exports'
sudo bash -c 'echo "/mnt/nfs/2ASIR3 10.10.15.0/24(rw,sync,no_subtree_check,no_all_squash)" >> /etc/exports'


# Reiniciar el servicio NFS
echo "Reiniciando el servicio NFS..."
sudo systemctl restart nfs-kernel-server


# Verificar la configuración
echo "Verificando la configuración..."
sudo exportfs -v


echo "¡Yeah buddy, configuración completada!"
