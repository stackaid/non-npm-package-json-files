FROM ubuntu

RUN apt-get update

# curl, jq, sqlite-utils
RUN apt-get -y install curl jq python3 pip
RUN pip install sqlite-utils

# Taskfile
RUN curl -L https://taskfile.dev/install.sh | sh

# Sourcegraph CLI
RUN curl -L https://sourcegraph.com/.api/src-cli/src_linux_amd64 -o /usr/local/bin/src && \
    chmod +x /usr/local/bin/src

# nsq
RUN curl -L https://s3.amazonaws.com/bitly-downloads/nsq/nsq-1.2.1.linux-amd64.go1.16.6.tar.gz \
    -o nsq.tar.gz && \
    tar -zxf nsq.tar.gz -C /usr/local --strip-components=1 && \
    rm nsq.tar.gz

WORKDIR /app
VOLUME /app/data
COPY Taskfile.yaml .

ENTRYPOINT ["task"]
CMD ["-l"]