#!/usr/bin/env bash

docker pull "${FROM}:${ODOO_VERSION}-base"
docker pull "${FROM}:${ODOO_VERSION}-devops"
