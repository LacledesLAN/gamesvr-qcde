# escape=`
FROM lacledeslan/steamcmd:linux AS downloader

ARG contentServer=content.lacledeslan.net

RUN echo "Downloading Q-Zandronum 1.4.20 for Linux (amd64)" &&`
        curl -sSL "https://github.com/IgeNiaI/Q-Zandronum/releases/download/1.4.20/Q-Zandronum_1.4.20_Linux_amd64.tar.gz" -o /tmp/q-zandronum.tar.gz &&`
    echo "Validating download against known hash" &&`
        echo "de7e9c61a5b6d1237deb419e9fc4f33162446752a28eda6c17a236df9939530a  /tmp/q-zandronum.tar.gz" | sha256sum -c - &&`
    echo "Extracting Q-Zandronum" &&`
        tar -xzf /tmp/q-zandronum.tar.gz -C /output;

RUN echo "Downloading QC:DE 3.0 Mod Files" &&`
    curl -sSL "http://${contentServer}/fastDownloads/_installers/qcde/QCDE_v3.0.zip" -o /tmp/qcde.zip &&`
echo "Validating download against known hash" &&`
    echo "9dd89a5bbf7880e08b93005e8e3375896c2949e153bd987faccf4f2eedb0d013  /tmp/qcde.zip" | sha256sum -c - &&`
echo "Extracting QC:DE" &&`
    mkdir --parents /output/wads &&`
    unzip /tmp/qcde.zip -d /output/wads;

COPY ./dist /output

FROM debian:trixie-slim

HEALTHCHECK NONE

ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified

ENV DOOMWADDIR=/app/wads `
    LANG=en_US.UTF-8 `
    LANGUAGE=en_US.UTF-8 `
    LC_ALL=en_US.UTF-8

RUN apt-get update &&`
    apt-get install -y `
        ca-certificates locales locales-all libsdl1.2debian whiptail `
        --no-install-recommends --no-install-suggests --no-upgrade &&`
    apt-get clean &&`
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* &&`
    useradd --home /app --gid root --system QCDE &&`
    mkdir --parents /app /app/logs /app/wads &&`
    chown QCDE:root -R /app;

COPY --chown=QCDE:root --from=downloader /output /app

USER QCDE

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root
