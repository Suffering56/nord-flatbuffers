FROM debian:latest

#INSTALL COMMON TOOLS
RUN apt update \
	&& apt-get install --yes mc \
    && apt-get install --yes wget \
    && apt-get install --yes git

#INSTALL CMAKE
RUN cd /home \
    && wget https://github.com/Kitware/CMake/releases/download/v3.25.3/cmake-3.25.3-linux-x86_64.tar.gz  \
    && tar -xf cmake-3.25.3-linux-x86_64.tar.gz \
    && mv cmake-3.25.3-linux-x86_64 cmake \
    && rm cmake-3.25.3-linux-x86_64.tar.gz

#INSTALL GCC (C++ compiler)
RUN apt install --yes build-essential

#COPY FLATBUFFER SOURCES INTO CONTAINER
COPY ./ /home/flatbuffers/