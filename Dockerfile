FROM ros:noetic

# install apt deps
RUN apt-get update && \
    apt-get install -y git libgflags-dev libpopt-dev \
        libgoogle-glog-dev liblua5.1-0-dev \
        libboost-all-dev libqt5websockets5-dev \
        python-is-python3 libeigen3-dev sudo \
        bash-completion vim screen tree python-is-python3 python3-pip psmisc \
        inetutils-ping inetutils-telnet inetutils-traceroute inetutils-tools \
        iproute2 links

# install ros apt deps
RUN apt-get install -y ros-noetic-tf ros-noetic-angles
# RUN rosdep init && rosdep update

ARG HOST_UID
RUN useradd dev -m -s /bin/bash -u $HOST_UID -G sudo
USER dev
WORKDIR /home/dev
RUN rosdep update