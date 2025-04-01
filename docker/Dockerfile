# FROM nvidia/cuda:9.2-cudnn7-devel-ubuntu16.04
FROM nvidia/cuda:11.6.1-cudnn8-devel-ubuntu20.04

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive
RUN export TERM=xterm

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends \
        tzdata \
        rsync \
        htop \
        git \
        libglib2.0-0 libsm6 libxrender1 \
        openssh-server \
        spyder3 \
        python3-pip \
        procps \
        lsb-release

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pip3 install --upgrade pip

# Or your actual UID, GID on Linux if not the default 1000
ARG USERNAME=ola
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support for non-root user
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# RUN apt install -y pylint


# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

COPY requirements.txt /tmp/requirements.txt
RUN pip install --ignore-installed -r /tmp/requirements.txt

RUN pip install millify torchmetrics
EXPOSE 8883

WORKDIR /src
CMD jupyter notebook --port=8883 --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.token=''
