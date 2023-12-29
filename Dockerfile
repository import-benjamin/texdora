FROM ubuntu:22.04@sha256:6042500cf4b44023ea1894effe7890666b0c5c7871ed83a97c36c76ae560bb9b	

RUN apt-get update -y && apt-get install -y --no-install-recommends \
        git \
        make \
        perl \
        fonts-font-awesome \
        python3 \
        python3-pip \
        && rm -rf /var/lib/apt/lists/*

RUN cd/tmp && \
    wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    zcat < install-tl-unx.tar.gz | tar xf - && \
    cd install-tl-* && \
    perl ./install-tl --no-interaction

ENV PATH="${PATH}:/usr/local/texlive/2023/bin/x86_64-linux"

RUN fmtutil -sys --all \
    && ln -sf python3 /usr/bin/python \
    && pip install --user --no-cache-dir Pygments==2.17.2
