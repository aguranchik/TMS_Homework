#!/bin/bash
docker run -d --name my-apache-app -p 8082:80 -v "$PWD":/var/www/html/ ubuntu/apache2:2.4-22.04_betas