FROM ubuntu:22.04@sha256:6042500cf4b44023ea1894effe7890666b0c5c7871ed83a97c36c76ae560bb9b	

RUN apt-get update -y && apt-get install -y --no-install-recommends \
        git \
        make \
        perl \
        fonts-font-awesome \
        fonts-ibm-plex \
        python3 \
        python3-pip \
        wget \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    zcat < install-tl-unx.tar.gz | tar xf - && \
    perl ./install-tl-*/install-tl --no-interaction --scheme=minimal && \
    rm -rf ./install-tl-*
RUN tlmgr install collection-langfrench collection-luatex latex-bin memoir xpatch tools booktabs hyperref infwarerr kvoptions mparhack fontspec carlisle pdftexcmds microtype amscls glossaries-extra xkeyval glossaries biblatex pgf pgfplots tikzfill thmtools todonotes siunitx mathtools pdfpages subfiles float caption circuitikz minted fancyvrb upquote csquotes plex epstopdf-pkg pdflscape
RUN fmtutil -sys --all \
    && ln -sf python3 /usr/bin/python \
    && pip install --user --no-cache-dir Pygments==2.17.2

ENV PATH="${PATH}:/root/.local/bin:/usr/local/texlive/2023/bin/x86_64-linux"
