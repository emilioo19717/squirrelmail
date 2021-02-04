FROM ubuntu:16.04

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y php7.0
RUN apt-get install -y apache2
RUN apt-get install -y squirrelmail
RUN apt-get install -y net-tools
RUN apt-get install -y nano
RUN apt-get install -y libapache2-mod-php7.0

COPY ./squirrelmail.conf /etc/apache2/sites-available/squirrelmail.conf
COPY ./config.php /var/www/html/config.php
COPY ./config.php /etc/squirrelmail/config.php

RUN a2ensite squirrelmail.conf
RUN a2dissite 000-default.conf
RUN a2enmod ssl

ENV TZ=Europe/Budapest
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apache2ctl restart
EXPOSE 80
CMD /usr/sbin/apache2ctl -D FOREGROUND
