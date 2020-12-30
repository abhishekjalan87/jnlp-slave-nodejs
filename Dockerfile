FROM jenkins/inbound-agent:latest-jdk11

USER root
RUN apt-get update && \
    apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable" && \
    apt-get update && \
    apt-get -y install docker-ce 
RUN usermod -a -G docker jenkins

##Install Sentry CLI
RUN curl -sL https://sentry.io/get-cli/ | bash
RUN sentry-cli --version

##Install AWS CLI
RUN apt-get install -y awscli 
RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y build-essential gettext-base
RUN apt-get install -y nodejs yarn
RUN apt-get install -y gcc
RUN apt-get install -y make
RUN apt-get install -y cmake
USER jenkins