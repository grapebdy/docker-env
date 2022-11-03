FROM     ubuntu:18.04

# Configure users
#RUN adduser qqliang
RUN useradd -ms /bin/bash qqliang 

#
ADD resources/etc/bash-completion.tar /tmp/
RUN cp /tmp/bash-completion/* / -rf
RUN rm -fr /tmp/bash-completion

# Update sources.list
ADD resources/apt/sources.list /etc/apt/
RUN apt-get update

# Install software
RUN apt-get install -y git vim dialog ctags pkg-config sudo zip
RUN apt-get install -y openssh-server net-tools iputils-arping iputils-ping

# Compile utils
RUN apt-get install -y make gcc g++ nasm
RUN apt-get install -y gcc-aarch64-linux-gnu gcc-5-aarch64-linux-gnu
RUN update-alternatives  --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-7 7
RUN apt-get install -y bison flex libncurses-dev libssl-dev bc libelf-devel

# Install Kernel header
RUN apt-get install -y linux-headers-$(uname -r)


############################################
# Install Python
RUN apt-get install -y python

# Install opencv
RUN apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev

# Install libusb
RUN apt-get install -y libudev-dev
ADD resources/libusb-1.0.24.tar.gz /tmp/
RUN cd /tmp/libusb-1.0.24/;./autogen.sh;make;make install
RUN rm -rf resources/libusb-1.0.24

# Add other software
#ENV PATH /opt/pcie/bin:/opt/pcie/tools:$PATH
ENV LANG C.UTF-8
#ADD pcie-utils-b6bdfcd-bin.tar.gz /opt/

# Run command
CMD ["source /etc/profile"]

MAINTAINER qqliang<grapebdyl2013@gmail.com>
