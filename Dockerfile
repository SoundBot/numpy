FROM python:3.11.0b3-alpine3.15

RUN apk add wget alpine-sdk sudo

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN addgroup appuser abuild

USER appuser
WORKDIR /home/appuser

RUN abuild-keygen -a -i -n

RUN wget https://git.alpinelinux.org/aports/plain/community/py3-numpy/APKBUILD
RUN wget https://git.alpinelinux.org/aports/plain/community/py3-numpy/numpy-1.17.0-musl.patch
RUN wget https://git.alpinelinux.org/aports/plain/community/py3-numpy/site.cfg

# RUN abuild deps
# RUN abuild unpack
# RUN abuild prepare
# RUN abuild -r package

RUN echo "%abuild ALL=(ALL) ALL" > /etc/sudoers.d/abuild
RUN abuild -r
