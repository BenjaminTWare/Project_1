#!/bin/bash

mkdir -p /var/backup
tar cvvf /var/backup/home.tar ~
cp var/backup/home.tar /var/backup/home.20210423.tar
ls -lah /var/backup >> /var/backup/file_report.txt
free -h >> /var/backup/disk_report.txt 