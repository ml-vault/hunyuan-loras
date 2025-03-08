FROM runpod/pytorch:2.1.1-py3.10-cuda12.1.1-devel-ubuntu22.04

ENV PYTHON_VENV_PATH=/opt/venv
ENV PYTHON_PATH=/opt/venv/bin/python3
ENV INFINITE_IMAGE_BROWSING_VENV_PATH=/opt/infinite-image-browsing-venv
ENV INFINITE_IMAGE_BROWSING_PYTHON_PATH=/opt/infinite-image-browsing-venv/bin/python3

WORKDIR /workspace
COPY *.sh /opt/
RUN chmod +x /opt/*.sh
COPY requirements.txt /opt/
RUN /opt/install.sh

CMD ["/opt/run.sh"]
