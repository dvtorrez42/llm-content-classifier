FROM jupyter/base-notebook:python-3.10.11

ENV TZ=America/Argentina/Buenos_Aires

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root



#RUN apt-get update \
#    && apt-get install -y git \
#    && rm -rf /var/lib/apt/lists/*

# Install in the default python3 environment
RUN pip install --no-cache-dir 'flake8' && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install from the requirements.txt file
COPY requirements.txt /tmp/req.txt
RUN pip install \
        --no-cache-dir \
        --requirement /tmp/req.txt && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" \
    && rm /tmp/req.txt 
#RUN pip install --upgrade pip setuptools wheel\
#    && pip install -r /tmp/req.txt\
#        --disable-pip-version-check \
#        --no-cache-dir \
#    && rm /tmp/req.txt 

# Uses "Pi" theme
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    # -t robbyrussell \
    -t https://github.com/tobyjamesthomas/pi

USER 1000 

#WORKDIR /home/jovyan/work

ENTRYPOINT ["zsh"]

#CMD ["bash"]
#CMD ["jupyter-lab", "--allow-root", "--ip=0.0.0.0", "--no-browser", "--NotebookApp.token=''"]

