FROM ubuntu:18.04

ENV NODE_URL https://nodejs.org/dist/v11.12.0/node-v11.12.0-linux-x64.tar.xz
ENV GO_URL https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz
ENV TASK_URL https://taskfile.dev/install.sh

# Install tools necessary for installing everything else
RUN apt-get update
RUN apt-get install -y curl xz-utils

# Install Node
RUN curl $NODE_URL -o node.tar.xz
RUN mkdir /usr/local/node
RUN tar -C /usr/local/node --strip-components=1 -xvf node.tar.xz
RUN ln -s /usr/local/node/bin/node /usr/bin/node
RUN ln -s /usr/local/node/bin/npm /usr/bin/npm

# Install Go
RUN curl $GO_URL -o go.tar.gz
RUN tar -C /usr/local/ -xvf go.tar.gz
RUN ln -s /usr/local/go/bin/go /usr/bin/go

# Install Task
RUN mkdir /usr/local/task
RUN cd /usr/local/task && curl -sL $TASK_URL | sh
RUN ln -s /usr/local/task/bin/task /usr/bin/task

# Install AWS CLI
RUN apt-get install -y python3 python3-pip
RUN pip3 install awscli --upgrade

# Install other tools
RUN apt-get install -y mysql-client jq ssh git
RUN apt-get install -y python2.7
RUN ln -s /usr/bin/python2.7 /usr/bin/python
RUN apt-get install g++ build-essential
