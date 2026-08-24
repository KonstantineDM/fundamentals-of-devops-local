FROM oven/bun:1

WORKDIR /home/node/app

COPY package.json bun.lock .

RUN bun install --frozen-lockfile

COPY *.js .

EXPOSE 8080
USER bun

CMD [ "bun", "start" ]