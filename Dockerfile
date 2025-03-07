FROM runpod/pytorch:2.1.1-py3.10-cuda12.1.1-devel-ubuntu22.04

WORKDIR /opt

# pytorch to 2.5.1
RUN pip install torch==2.5.1

# Generate python virtual environment
RUN python3 -m venv /opt/venv

# Activate virtual environment
RUN source /opt/venv/bin/activate

# Install diffusion-pipe
RUN git clone --recurse-submodules https://github.com/tdrussell/diffusion-pipe.git /opt/diffusion-pipe

# Install requirements
RUN pip install -r /opt/diffusion-pipe/requirements.txt

WORKDIR /workspace
COPY run.sh /workspace/run.sh

CMD ["/workspace/run.sh"]
