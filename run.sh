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
    echo "Copying notes from opt"
    cp -r /opt/notes $VOLUME_PATH/notes
else
    echo "Volume already has notes, skipping copy"
fi

# Activate virtual environment
sh $VOLUME_PATH/venv/bin/activate
echo "Virtual environment activated"

# Run Jupyter in background
echo "Jupyter notebook started"

jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --notebook-dir=$VOLUME_PATH/notes
