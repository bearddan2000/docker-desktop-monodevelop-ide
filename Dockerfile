FROM ubuntu:20.04

ENV DISPLAY :0

ENV USERNAME developer

WORKDIR /app

RUN apt update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-transport-https sudo \
    software-properties-common \
    dirmngr gnupg

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && apt-add-repository 'deb https://download.mono-project.com/repo/ubuntu stable-bionic main'

RUN apt update

RUN apt install -yq mono-complete \
    monodevelop \
    msbuild

# create and switch to a user
RUN echo "backus ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && useradd --no-log-init --home-dir /home/$USERNAME --create-home --shell /bin/bash $USERNAME \
    && adduser $USERNAME sudo

USER $USERNAME

WORKDIR /home/$USERNAME

CMD "monodevelop"