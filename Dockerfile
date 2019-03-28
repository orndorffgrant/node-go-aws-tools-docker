FROM ubuntu:18.04

SHELL ["/bin/bash", "-c"]

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
RUN echo "export PATH=/usr/local/node/bin:\$PATH" >> ~/.bashrc

# Install Go
RUN curl $GO_URL -o go.tar.gz
RUN tar -C /usr/local/ -xvf go.tar.gz
RUN echo "export PATH=/usr/local/go/bin:\$PATH" >> ~/.bashrc

# Install Task
RUN mkdir /usr/local/task
RUN cd /usr/local/task && curl -sL $TASK_URL | sh
RUN echo "export PATH=/usr/local/task/bin:\$PATH" >> ~/.bashrc

# Install AWS CLI
RUN apt-get install -y python3 python3-pip
RUN pip3 install awscli --upgrade

# Install other tools
RUN apt-get install -y mysql-client jq ssh

ENTRYPOINT ["/bin/bash"]
