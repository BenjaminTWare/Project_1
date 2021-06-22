#!/bin/bash

rm -rf /tmp/* 
rm -rf /var/tmp/*

apt clear -y

rm -rf /home/sysadmin/.cache/thumbnails
rm -rf /home/instructor/.cache/thumbnails
rm -rf /home/student/.cache/thumbnails
rm -rf /root/.cache/thumbnails
