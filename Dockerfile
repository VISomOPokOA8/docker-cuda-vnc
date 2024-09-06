FROM nvidia/cuda:12.6.0-cudnn-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=root
ENV RESOLUTION=1920x1080

RUN apt update && apt install -y --no-install-recommends \
    vim git openssh-client sudo ubuntu-desktop gnome-shell-extensions \
    libglew-dev libassimp-dev libboost-all-dev libgtk-3-dev libopencv-dev libglfw3-dev libavdevice-dev libavcodec-dev libeigen3-dev libxxf86vm-dev libembree-dev \
    xfce4 xfce4-goodies tightvncserver dbus-x11 xfonts-base \
    && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN systemctl set-default graphical

RUN mkdir /root/.vnc \
    && echo "020701" | vncpasswd -f > /root/.vnc/passwd \
    && chmod 600 /root/.vnc/passwd
RUN touch /root/.Xauthority
EXPOSE 5929
WORKDIR /app
COPY start-vnc.sh start-vnc.sh
RUN chmod +x start-vnc.sh
RUN ls -a /app