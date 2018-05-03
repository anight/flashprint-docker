FROM ubuntu:16.04

COPY dist /dist

RUN apt-get update
RUN apt-get install -y libudev-dev libqt5gui5 libqt5core5a libqt5opengl5 libqt5network5 libqt5xml5 libglu1

RUN dpkg -i /dist/20180330181621_276.deb
RUN apt-get install -f

ARG user="n/a"
ARG group="n/a"
ARG uid="n/a"
ARG gid="n/a"
ARG video_gid="n/a"
ARG audio_gid="n/a"

RUN groupmod -g ${gid} ${group}
RUN userdel www-data
RUN groupmod -g ${video_gid} video
RUN groupmod -g ${audio_gid} audio
RUN useradd -m -u ${uid} -g ${group} -G ${video_gid},${audio_gid} ${user}

USER ${user}
ENV HOME /home/${user}

CMD /usr/share/FlashPrint/FlashPrint
