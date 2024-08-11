FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Inspired by https://mike42.me/blog/2021-08-a-first-look-at-programmable-logic

# Install all packages
RUN dpkg --add-architecture i386

# Add contrib for ttf-mscorefonts-installer
RUN sed -i'.bak' 's/$/ contrib/' /etc/apt/sources.list

RUN apt-get -y update && \
    apt-get -y install curl unzip patch sudo ttf-mscorefonts-installer fontconfig && \
    apt-get -y install wine winetricks wine32:i386

WORKDIR /wincupl

RUN curl -o /tmp/awincupl.exe.zip https://ww1.microchip.com/downloads/en/DeviceDoc/awincupl.exe.zip && \
    unzip /tmp/awincupl.exe.zip

COPY create_prefix.sh /wincupl/create_prefix.sh
COPY user.reg.diff    /wincupl/user.reg.diff
COPY awincupl.iss     /wincupl/awincupl.iss

RUN cd /wincupl && ./create_prefix.sh

# Clean up
RUN rm -rf /var/lib/apt/lists/* && \
    apt-get -y autoremove

ENV WINEDEBUG=-all
ENV WINEPREFIX=/root/.wine
ENV WINEARCH=win32
