FROM python:3.11.0b3-alpine3.15

RUN apk add wget alpine-sdk sudo
RUN apk add cython
    gfortran
    libbsd-dev
    openblas-dev
    py3-nose
    py3-setuptools
    python3-dev

RUN python3 -m pip install cython

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN addgroup appuser abuild

RUN echo "%abuild ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/abuild

USER appuser
WORKDIR /home/appuser

RUN abuild-keygen -a -i -n

COPY APKBUILD APKBUILD
RUN wget https://git.alpinelinux.org/aports/plain/community/py3-numpy/numpy-1.17.0-musl.patch
RUN wget https://git.alpinelinux.org/aports/plain/community/py3-numpy/site.cfg

RUN abuild checksum && abuild -r
