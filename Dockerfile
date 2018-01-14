FROM debian:jessie
MAINTAINER Razvan Crainea <razvan@opensips.org>

USER root
ENV DEBIAN_FRONTEND noninteractive
ARG VERSION=2.2

WORKDIR /usr/local/src

RUN apt-get update -qq && apt-get install -y build-essential \
		git bison flex m4 pkg-config libncurses5-dev rsyslog libmysqlclient-dev libssl-dev mysql-client \
		&& rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/OpenSIPS/opensips.git -b $VERSION opensips_$VERSION
#RUN cd opensips_$VERSION && make all && make install
RUN cd opensips_$VERSION && make all -j4 include_modules="db_mysql" && make install include_modules="db_mysql"

RUN echo -e "local0.* -/var/log/opensips.log\n& stop" > /etc/rsyslog.d/opensips.conf
RUN touch /var/log/opensips.log
RUN rm -rf /usr/local/src/*

EXPOSE 5060/udp

COPY run.sh /run.sh

ENTRYPOINT ["/run.sh"]
