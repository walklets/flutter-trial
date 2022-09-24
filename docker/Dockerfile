FROM google/dart

ARG DIR="/develop"
WORKDIR ${DIR}

# flutterインストールのためのパッケージをインストール
RUN apt-get update && apt-get install -y \
    unzip \
    cmake \
    ninja-build \
    clang \
    pkg-config \
    libgtk-3-dev \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# flutterをダウンロード
RUN git clone https://github.com/flutter/flutter.git -b stable
ENV PATH $PATH:${DIR}/flutter/bin

ARG DIR="/workspace"
WORKDIR ${DIR}

# flutter webを有効化
RUN flutter precache
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web



