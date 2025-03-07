#! /bin/bash


VOLUME_PATH=/workspace

# Copy venv from opt if volume has no venv
if [ ! -d "$VOLUME_PATH/venv" ]; then
    cp -r /opt/venv $VOLUME_PATH/venv
else
    echo "Volume already has venv, skipping copy"
fi

# Copy notes that not exists
if [ ! -d "$VOLUME_PATH/notes" ]; then
    cp -r /opt/notes $VOLUME_PATH/notes
else
    echo "Volume already has notes, skipping copy"
fi

# Activate virtual environment
source $VOLUME_PATH/venv/bin/activate

# Run pod
runpod
