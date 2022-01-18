FROM node:16-alpine AS angular_docker

RUN npm install -g @angular/cli

ADD angular_heroku_project /app
WORKDIR /app
RUN npm install

ARG PRODUCTION
ENV PRODUCTION=$PRODUCTION
ADD scripts/docker/ng_build.sh ng_build.sh
RUN ls
RUN sh ng_build.sh

FROM heroku/heroku:20 AS heroku_project

RUN apt-get update \
  && apt-get install -y maven apache2 \
  && apt-get clean \
  && rm -Rf /var/lib/apt/lists/*
  
RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf
RUN mkdir /app

WORKDIR /app

ADD pom.xml /app
# RUN mvn dependency:resolve

ADD . /app

ARG PRODUCTION
ENV PRODUCTION=$PRODUCTION
RUN sh scripts/docker/mvn_if_production.sh

CMD mvn spring-boot:run

