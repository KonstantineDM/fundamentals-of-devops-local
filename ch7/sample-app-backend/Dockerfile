FROM node:26

WORKDIR /home/node/app

COPY *.json .

RUN npm i --omit=dev

COPY *.js .

EXPOSE 3000

USER node

CMD [ "npm", "start" ]