#!/usr/bin/env bash

echo
echo -----------------------------
echo Trident TF2 Instance - Docker
echo -----------------------------
echo

validate_install () {
    echo Validating install...
    ./tf2server validate
}

update () {
    echo Checking for server updates...
    ./tf2server update
    validate_install
}

install () {
    echo Installing TF2...
    echo

    install_tf2
    install_sourcemod
}

install_tf2 () {
    printf "%s\n" Y Y $GSLT_TOKEN Y Y | ./tf2server install
    
    echo Validating install...
    validate_install
}

install_sourcemod () {
    echo Installing SourceMod...

    # Extract and copy sourcemod.
    cd /home/tf2server/serverfiles/tf
    wget -qO- https://mms.alliedmods.net/mmsdrop/1.10/mmsource-1.10.7-git971-linux.tar.gz | tar xvzf -
    wget -qO- https://sm.alliedmods.net/smdrop/1.10/sourcemod-1.10.0-git6454-linux.tar.gz | tar xvzf -   
}

echo Checking internet connection...
ping 1.1.1.1 -c 4

if [ -d "serverfiles/tf" ] 
then
    update
else
    echo No installation detected!
    install
fi

cd /home/tf2server
./start
