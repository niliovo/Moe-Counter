FROM node:20-alpine AS builder

WORKDIR /build

RUN apk add --no-cache git && \
git clone https://github.com/journey-ad/Moe-Counter mc && \
cd mc && \
sed -i "s#16.x#20.x#g" package.json && \
sed -i "s#5.13.23#8.8.3#g" package.json && \
npm install -g yarn --force && \
yarn install --no-cache && \
npm cache clean --force && \
yarn cache clean && \
apk cache clean

FROM node:20-alpine

WORKDIR /app

COPY --from=builder /build/mc /app

EXPOSE 3000

CMD ["yarn", "start"]
