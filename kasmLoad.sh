#!/bin/bash

cd /tmp
curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.16.0.a1d5b7.tar.gz
tar -xf kasm_release_1.16.0.a1d5b7.tar.gz
sudo bash kasm_release/install.sh