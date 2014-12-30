#!/bin/bash
## ######################################
## SAMPLE CONFIG
##
## export MAIL_URL="smtp://mail.free.fr"
## export MONGO_URL="mongodb://login:password@server:27017/meteor"
## export ROOT_URL="http://meteor.webetic.org"
## ######################################

export ROOT_URL="http://localhost"
export METEOR_SETTINGS="$(cat config/settings.development.json)"
export PORT="3000"
export MAIL_URL="smtp://mail.orange.fr"

