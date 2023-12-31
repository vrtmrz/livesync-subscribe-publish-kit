FROM lukechannings/deno:v1.38.3
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl gcc ca-certificates libc6-dev git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN /root/.cargo/bin/cargo install obsidian-export
WORKDIR /app
ARG TARGETARCH
RUN curl -L -o hugo.tar.gz -O "https://github.com/gohugoio/hugo/releases/download/v0.118.2/hugo_extended_0.118.2_linux-$TARGETARCH.tar.gz" 
RUN tar fx hugo.tar.gz

RUN git clone --recursive https://github.com/vrtmrz/hugoconfig-livesync-publisher -b 0.0.2 hugosite
RUN git clone --recursive https://github.com/vrtmrz/livesync-subscribe-publish -b 0.0.4 subscriber

# ADD hugosite ./hugosite
ADD hugo.template.toml ./hugo.template.toml
# ADD subscriber ./subscriber
RUN cd ./subscriber && deno cache main.ts

# ADD Obsidian vault to hugo script
ADD build.sh .
ADD run.sh .

EXPOSE 8080
ENTRYPOINT [ "/bin/sh" ]
CMD [ "/app/run.sh" ]