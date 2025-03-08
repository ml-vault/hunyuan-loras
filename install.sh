#!/bin/bash

function prepare_venv() {
    # Generate python virtual environment for diffusion-pipe
    python3 -m venv $PYTHON_VENV_PATH
    # Generate python virtual environment for infinite-image-browsing
    python3 -m venv $INFINITE_IMAGE_BROWSING_VENV_PATH
}

function install_packages(){
    # Install diffusion-pipe
    git clone --recurse-submodules https://github.com/tdrussell/diffusion-pipe.git /opt/diffusion-pipe
    git clone https://github.com/ml-vault/sd-webui-infinite-image-browsing /opt/infinite-image-browsing
}

function install_dependencies() {
    $PYTHON_PATH -m pip install -r /opt/requirements.txt
    $PYTHON_PATH -m pip install -r /opt/diffusion-pipe/requirements.txt
    $INFINITE_IMAGE_BROWSING_PYTHON_PATH -m pip install -r /opt/infinite-image-browsing/requirements.txt
}

function build() {
    prepare_venv
    install_packages
    install_dependencies
}

build
