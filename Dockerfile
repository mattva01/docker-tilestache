FROM python:2.7-onbuild
ENV MAPNIK_DOWNLOAD_URL http://mapnik.s3.amazonaws.com/dist/v2.2.0/mapnik-v2.2.0.tar.bz2

# Install mapnik dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
          libproj-dev \
          #gdal-bin \
          libboost-dev \
          libboost-system-dev \
          libboost-regex-dev \
          libboost-filesystem-dev \
          libboost-thread-dev \
          libicu-dev \
    && rm -rf /var/lib/apt/lists/*
RUN curl -sSL "$MAPNIK_DOWNLOAD_URL" -o mapnik.tar.bz2 \
         && mkdir -p /usr/src/mapnik \
         && tar xvfj mapnik.tar.bz2 -C /usr/src/mapnik/ --strip-components=1 
         && rm mapnik.tar.bz2 \
         && cd /usr/src/mapnik/ \ 
         && ./configure \ 
         && make \
         && make install \
         && rm -r /usr/src/mapnik
