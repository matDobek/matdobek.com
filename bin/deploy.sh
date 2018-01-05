#!/bin/bash

scp -r ./assets/ r_priv:/var/www/matdobek.com/assets/
scp ./index.html r_priv:/var/www/matdobek.com/index.html
