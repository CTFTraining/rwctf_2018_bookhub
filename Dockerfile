FROM python:3.6-alpine3.8

MAINTAINER Virink <virink@outlook.com>
LABEL CHALLENGE="Real World CTF 2018 BookHub"
# MD5 ("Real World CTF 2018 BookHub") = 378d0265d46a10d2f6d99ea199fb39d4

ENV SECRET_KEY="designed_and_built_by_phith0n" \
    LC_ALL="en_US.UTF-8" \
    LANG="en_US.UTF-8" \
    FLASK_APP="/app/app.py" \
    FLASK_DEBUG="1" \
    DATABASE_URL="sqlite:////app/data.db" \
    REDIS_URL="redis://127.0.0.1:6379/0"

ADD src /app

RUN echo "http://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories && \
    \
    apk add --no-cache --virtual gcc make && \
    apk add --no-cache sqlite redis libc-dev linux-headers && \
    \
    pip install -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com -U -r /app/requirements.txt && \
    \
    mv /app/flag /flag_378d0265d46a10d2f6d99ea199fb39d4 && \
    \
    chmod -R 755 /app && \
    \
    cd /app && flask db upgrade && \
    \
    mv /app/run.sh /run.sh && chmod +x /run.sh && chmod 777 /app/data.db && \
    \
    rm -f /tmp/requirements.txt && \
    rm -rf /etc/apk/*

EXPOSE 8000

WORKDIR /app

CMD ["/run.sh"]