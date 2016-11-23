#!/bin/sh

service ssh restart
apache2ctl -D FOREGROUND
