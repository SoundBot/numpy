FROM python:3.11.0b3-alpine3.15

RUN apk add wget alpine-sdk

RUN wget https://git.alpinelinux.org/aports/plain/community/py3-numpy/APKBUILD
RUN wget https://git.alpinelinux.org/aports/plain/community/py3-numpy/numpy-1.17.0-musl.patch
RUN wget https://git.alpinelinux.org/aports/plain/community/py3-numpy/site.cfg

RUN abuild-keygen -a -i
