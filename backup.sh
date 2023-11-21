#!/usr/bin/env bash

BACKUP_DATETIME=$(date +"%Y-%m-%d--%H-%M-%S")
BACKUP_HOSTNAME=$(hostname)
BACKUP_FILENAME="${BACKUP_DATETIME}-backup-${BACKUP_HOSTNAME}.tar.gz"

cd

tar -czvf $BACKUP_FILENAME \
	./Desktop \
	./Documents \
	./Downloads \
	./Pictures \
	./Projects
