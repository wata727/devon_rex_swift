FROM quay.io/actcat/devon_rex_base:1.0.8

ENV DEBIAN_FRONTEND=noninteractive

COPY swift-4.1.3-RELEASE-ubuntu16.04.tar.gz.sig .

# https://swift.org/download
RUN gpg --keyserver hkp://pool.sks-keyservers.net \
        --recv-keys \
        '7463 A81A 4B2E EA1B 551F  FBCF D441 C977 412B 37AD' \
        '1BE1 E29A 084C B305 F397  D62A 9F59 7F4D 21A5 6D5F' \
        'A3BA FD35 56A5 9079 C068  94BD 63BC 1CFE 91D3 06C6' \
        '5E4D F843 FB06 5D7F 7E24  FBA2 EF54 30F0 71E1 B235' \
        '8513 444E 2DA3 6B7C 1659  AF4D 7638 F1FB 2B2B 08C4' && \
    gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift

RUN apt-get update && \
    apt-get install -y clang libpython2.7 libxml2 && \
    rm -rf /var/lib/apt/lists/*

RUN wget --no-verbose https://swift.org/builds/swift-4.1.3-release/ubuntu1604/swift-4.1.3-RELEASE/swift-4.1.3-RELEASE-ubuntu16.04.tar.gz && \
    gpg --verify swift-4.1.3-RELEASE-ubuntu16.04.tar.gz.sig && \
    tar xvf swift-4.1.3-RELEASE-ubuntu16.04.tar.gz && \
    mv swift-4.1.3-RELEASE-ubuntu16.04/usr /usr/local/swift && \
    rm -rf swift-4.1.3-RELEASE-ubuntu16.04.tar.gz swift-4.1.3-RELEASE-ubuntu16.04

RUN apt-get update -y && \
    apt-get install -y language-pack-en && \
    rm -rf /var/lib/apt/lists/* && \
    update-locale en_US.UTF-8

ENV LC_ALL="en_US.UTF-8" \
    LANG="en_US.UTF-8" \
    PATH=/usr/local/swift/bin:$PATH
