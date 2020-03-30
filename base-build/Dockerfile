FROM docker:18.06.0-ce

ENV JAVA_ALPINE_VERSION 8.222.10-r0
ENV NODE_VERSION 8.14.0-r0

# Update packages
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/main' > /etc/apk/repositories \
    && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/community' >> /etc/apk/repositories \
    && apk upgrade -U -a

# Install Java, Maven, Node, Curl, Git
RUN { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo; \
        echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home \
    && chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
RUN set -x \
    && apk update \
    && apk add --no-cache \
        openjdk8="$JAVA_ALPINE_VERSION" \
        maven \
        curl \
        nodejs="$NODE_VERSION" \
        yarn \
        git \
        python \
        py-pip \
        groff \
        less \
        mailcap \
        chromium \
        nss \
    && [ "$JAVA_HOME" = "$(docker-java-home)" ]

# Install Kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

ENTRYPOINT ["/bin/sh"]
