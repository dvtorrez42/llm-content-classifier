FROM jupyter/base-notebook:python-3.10.11

ENV TZ=America/Argentina/Buenos_Aires

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

COPY requirements.txt /tmp/req.txt

#RUN apt-get update \
#    && apt-get install -y git \
#    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip setuptools wheel\
    && pip install -r /tmp/req.txt\
        --disable-pip-version-check \
        --no-cache-dir \
    && rm /tmp/req.txt 

# Uses "robbyrussell" theme (original Oh My Zsh theme), with no plugins
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    # -t robbyrussell \
    -t https://github.com/tobyjamesthomas/pi

    #&& sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
#    -t https://github.com/denysdovhan/spaceship-prompt \
#    -a 'SPACESHIP_PROMPT_ADD_NEWLINE="false"' \
#    -a 'SPACESHIP_PROMPT_SEPARATE_LINE="false"' \
#    -p git \
#    -p ssh-agent \
#    -p https://github.com/zsh-users/zsh-autosuggestions \
#    -p https://github.com/zsh-users/zsh-completions



USER 1000 

#WORKDIR /home/jovyan/work

ENTRYPOINT ["zsh"]

#CMD ["bash"]
#CMD ["jupyter-lab", "--allow-root", "--ip=0.0.0.0", "--no-browser", "--NotebookApp.token=''"]

