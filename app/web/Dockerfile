FROM node:18.18.2-alpine

WORKDIR /web-aggregator-web

COPY . .

RUN yarn install

EXPOSE 3000

CMD ["yarn", "start"]

#run only web with:
# docker container run -p 3000:3000 web-aggregator:latest
