FROM nginx:1.27.3
ENV TZ=Asia/Shanghai
RUN apt-get update &&\
    apt-get -y install bash curl unzip wget apache2-utils &&\
    wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb &&\
    dpkg -i cloudflared.deb &&\
    rm -f cloudflared.deb

WORKDIR /app
ARG BAK_VERSION=2.0
RUN curl -L "https://github.com/laboratorys/backup-to-github/releases/download/v${BAK_VERSION}/backup2gh-v${BAK_VERSION}-linux-amd64.tar.gz" -o backup-to-github.tar.gz \
    && tar -xzf backup-to-github.tar.gz \
    && rm backup-to-github.tar.gz \
    && chmod +x backup2gh

RUN curl -L "https://github.com/nezhahq/nezha/releases/latest/download/dashboard-linux-amd64.zip" -o dashboard-linux-amd64.zip \
    && unzip dashboard-linux-amd64.zip \
    && mv dashboard-linux-amd64 dashboard \
    && rm dashboard-linux-amd64.zip \
    && chmod +x dashboard
COPY nginx/default.conf.template /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY configure.sh /app/configure.sh
RUN chmod +x /app/configure.sh

ENTRYPOINT ["bash", "/app/configure.sh"]

