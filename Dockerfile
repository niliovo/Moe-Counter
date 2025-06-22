FROM node:22-alpine AS builder

WORKDIR /build

RUN apk add --no-cache git && \
git clone https://github.com/journey-ad/Moe-Counter mc && \
cd mc && \
npm install -g pnpm --force && \
pnpm fetch --frozen-lockfile && \
pnpm install --frozen-lockfile && \
apk cache clean

FROM node:22-alpine

WORKDIR /app

COPY --from=builder /build/mc /app

RUN npm install -g pnpm --force

EXPOSE 3000

CMD ["pnpm", "start"]
