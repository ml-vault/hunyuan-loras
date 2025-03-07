#!/bin/bash

echo "pod started"

if [[ $PUBLIC_KEY ]]
then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    cd ~/.ssh
    echo $PUBLIC_KEY >> authorized_keys
    chmod 700 -R ~/.ssh
    cd /
    service ssh start
fi

VOLUME_PATH=/workspace

# Copy venv from opt if volume has no venv
if [ ! -d "$VOLUME_PATH/venv" ]; then
    cp -r /opt/venv $VOLUME_PATH/venv
else
    echo "Volume already has venv, skipping copy"
fi

# Copy notes that not exists
if [ ! -d "$VOLUME_PATH/notes" ]; then
    echo "Copying notes from opt"
    cp -r /opt/notes $VOLUME_PATH/notes
else
    echo "Volume already has notes, skipping copy"
fi

# Activate virtual environment
sh $VOLUME_PATH/venv/bin/activate
echo "Virtual environment activated"


if [[ $JUPYTER_PASSWORD ]]
then
    cd /
    jupyter lab --allow-root --no-browser --port=8888 --ip=* --ServerApp.terminado_settings='{"shell_command":["/bin/bash"]}' --ServerApp.token=$JUPYTER_PASSWORD --ServerApp.allow_origin=* --ServerApp.preferred_dir=/workspace
else
    sleep infinity
fi
