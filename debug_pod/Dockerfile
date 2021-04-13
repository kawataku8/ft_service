FROM alpine

RUN apk update
RUN apk add vim

#ftpクライアントのインストール
RUN apk add lftp
COPY .lftprc /root/.lftprc

CMD tail -f /dev/null
