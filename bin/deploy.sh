#!/bin/bash

ssh r_priv "rm -rf /var/www/matdobek.com"
scp -r ./ r_priv:/var/www/matdobek.com
