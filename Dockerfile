FROM golang:1.8.3-alpine3.6 AS binary
RUN apk -U add openssl git

ADD . /go/src/github.com/glehmann/dkz
WORKDIR /go/src/github.com/glehmann/dkz

RUN go get github.com/robfig/glock
RUN glock sync -n < GLOCKFILE
RUN go install

FROM alpine:3.6
MAINTAINER Jason Wilder <mail@jasonwilder.com>

COPY --from=binary /go/bin/dkz /usr/local/bin

ENTRYPOINT ["dkz"]
CMD ["--help"]
