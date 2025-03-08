#!/bin/bash

echo "pod started"
VOLUME_PATH=/workspace

# Setup ssh
function setup_ssh() {
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
}


# Setup virtual environment
function setup_venv() {
    # Copy venv from opt if volume has no venv
    if [ ! -d "$VOLUME_PATH/venv" ]; then
        cp -r /opt/venv $VOLUME_PATH/venv
    else
        echo "Volume already has venv, skipping copy"
    fi

    # Check if the activation command is already in .bashrc
    if ! grep -q "source $VOLUME_PATH/venv/bin/activate" ~/.bashrc; then
        echo "source $VOLUME_PATH/venv/bin/activate" >> ~/.bashrc
    fi
    echo "Virtual environment activated"
}

# Copy notes to volume if not exists
function setup_notes() {
    if [ ! -d "$VOLUME_PATH/notes" ]; then
        echo "Copying notes from opt"
        cp -r /opt/notes $VOLUME_PATH/notes
    else
        echo "Volume already has notes, skipping copy"
    fi
}

#==============================================
# Start jupyter lab
#==============================================
function start(){
    if [[ $JUPYTER_PASSWORD ]]
    then
        cd /
        $PYTHON_PATH -m jupyter lab --allow-root --no-browser --port=8888 --ip=* --ServerApp.terminado_settings='{"shell_command":["/bin/bash"]}' --ServerApp.token=$JUPYTER_PASSWORD --ServerApp.allow_origin=* --ServerApp.preferred_dir=/workspace/notes
        echo "Jupyter lab started"
    else
        sleep infinity
    fi
}

function start_infinite_image_browsing(){
    cd /
    $INFINITE_IMAGE_BROWSING_PYTHON_PATH /opt/ai-dock/infinite-browser/app.py --host 0.0.0.0 --port 7888
    echo "Infinite image browsing started"
}


#==============================================
# Run
#==============================================
setup_ssh
setup_venv
setup_notes
start 2>&1
start_infinite_image_browsing 2>&1
