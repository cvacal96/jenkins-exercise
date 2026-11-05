FROM node:24-alpine

RUN mkdir -p /home/app

COPY package.json package-lock.json /home/app/

RUN npm install

COPY ./app /home/app

WORKDIR /home/app
EXPOSE 3000

CMD ["node", "index.js"]
