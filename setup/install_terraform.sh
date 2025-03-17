#!/bin/bash

cd "$HOME/bin"

wget https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_amd64.zip -O "$HOME/bin/terraform_1.10.5_linux_amd64.zip"

echo "Unzipping terraform..."
unzip $HOME/bin/terraform_1.10.5_linux_amd64.zip

echo "Removing the terraform zip file..."
rm $HOME/bin/terraform_1.10.5_linux_amd64.zip