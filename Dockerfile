FROM node:16

RUN npm install -g @angular/cli

ADD AngularElasticSearch /app
WORKDIR /app
RUN npm install

RUN ng build

RUN echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-7.x.list
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -

RUN apt-get update && apt-get install -y elasticsearch && \
    apt-get clean && rm -Rf /var/lib/apt/lists/*

CMD ng serve --host 0.0.0.0
