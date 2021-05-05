FROM debian:buster

MAINTAINER danielpmc, <danielpd93@gmail.com>

RUN apt update \
    && apt upgrade -y \
    && apt -y install curl software-properties-common locales git lsb-release ca-certificates apt-transport-https gnupg wget \
    && useradd -d /home/container -m container \
    && apt-get update

    # Grant sudo permissions to container user for commands
RUN apt-get update && \
    apt-get -y install sudo

    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
    
# Install basic software support
RUN apt-get update && \
    apt-get install --yes software-properties-common
    
    # Python 2 & 3
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list \
    && wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add - \
    && apt update \
    && apt install php8.0 php8.0-cgi

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
