FROM ubuntu:22.04@sha256:6042500cf4b44023ea1894effe7890666b0c5c7871ed83a97c36c76ae560bb9b	

RUN apt-get update && apt-get install -y \
        git=2.34.1 \
        make=4.3-4.1 \
        perl=5.34.0 \
        fonts-font-awesome=5.0.10 \
        python3=3.10.4 \
        python3-pip=22.0.2 \
        && rm -rf /var/lib/apt/lists/*

RUN pushd /tmp && \
    wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    zcat < install-tl-unx.tar.gz | tar xf - && \
    pushd install-tl-* && \
    perl ./install-tl --no-interaction

ENV PATH="${PATH}:/usr/local/texlive/2023/bin/x86_64-linux"

RUN fmtutil -sys --all \
    && ln -sf python3 /usr/bin/python \
    && pip install --user --no-cache-dir Pygments==2.17.2
