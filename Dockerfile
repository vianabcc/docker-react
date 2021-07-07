FROM node:alpine as static_builder

USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./

RUN npm run build

FROM nginx
ARG owner
COPY --from=static_builder --chown=$owner /home/node/app/build /usr/share/nginx/html