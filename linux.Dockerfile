# escape=`
FROM lacledeslan/steamcmd:linux AS downloader

ARG contentServer=content.lacledeslan.net

RUN echo "Downloading Q-Zandronum 1.4.22 for Linux (amd64)" &&`
        curl -sSL "https://github.com/IgeNiaI/Q-Zandronum/releases/download/1.4.22/Q-Zandronum_1.4.22_Linux_amd64.tar.gz" -o /tmp/q-zandronum.tar.gz &&`
    echo "Validating download against known hash" &&`
        echo "470c41bc6022bd8ec471de71b15b94589068abddd4e4276906c241da08e057a9  /tmp/q-zandronum.tar.gz" | sha256sum -c - &&`
    echo "Extracting Q-Zandronum" &&`
        tar -xzf /tmp/q-zandronum.tar.gz -C /output;

RUN echo "Downloading QC:DE 3.1 Beta 2 Mod Files" &&`
        curl -sSL "http://${contentServer}/fastDownloads/_installers/qcde/QCDE_v3.1_beta2.tar.gz" -o /tmp/QCDE_v3.1_beta2.tar.gz &&`
    echo "Validating download against known hash" &&`
        echo "d805bbec1473f8aab34eae4f4810749085fd508b6b43a2efe03f3e7538824e31  /tmp/QCDE_v3.1_beta2.tar.gz" | sha256sum -c - &&`
    echo "Extracting Q-C:DE wads" &&`
        tar -xzf /tmp/QCDE_v3.1_beta2.tar.gz -C /output;

COPY ./dist /output

FROM debian:trixie-slim

HEALTHCHECK NONE

ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified

ENV LANG=en_US.UTF-8 `
    LANGUAGE=en_US.UTF-8 `
    LC_ALL=en_US.UTF-8

RUN apt-get update &&`
    apt-get install -y `
        ca-certificates locales locales-all libsdl1.2debian whiptail `
        --no-install-recommends --no-install-suggests --no-upgrade &&`
    apt-get clean &&`
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* &&`
    useradd --home /app --gid root --system QCDE &&`
    mkdir --parents /app /app/wads &&`
    chown QCDE:root -R /app;

COPY --chown=QCDE:root --from=downloader /output /app

USER QCDE

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root
