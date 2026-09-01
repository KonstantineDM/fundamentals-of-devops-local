FROM node:26

WORKDIR /home/node/app

COPY *.json .

RUN npm i --omit=dev

COPY *.js .
COPY views views

EXPOSE 8080

USER node

CMD [ "npm", "start" ]