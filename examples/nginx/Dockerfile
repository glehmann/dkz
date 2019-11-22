FROM ubuntu:14.04
MAINTAINER Jason Wilder mail@jasonwilder.com

# Install Nginx.
RUN echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main" > /etc/apt/sources.list.d/nginx-stable-trusty.list \
    && echo "deb-src http://ppa.launchpad.net/nginx/stable/ubuntu trusty main" >> /etc/apt/sources.list.d/nginx-stable-trusty.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C \
    && apt-get update && apt-get install -y wget nginx

RUN wget https://github.com/glehmann/dkz/releases/download/v0.0.4/dkz-linux-amd64-v0.0.4.tar.gz \
    && tar -C /usr/local/bin -xvzf dkz-linux-amd64-v0.0.4.tar.gz

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

ADD default.tmpl /etc/nginx/sites-available/default.tmpl

EXPOSE 80

CMD ["dkz", "-template", "/etc/nginx/sites-available/default.tmpl:/etc/nginx/sites-available/default", "-stdout", "/var/log/nginx/access.log", "-stderr", "/var/log/nginx/error.log", "nginx"]
