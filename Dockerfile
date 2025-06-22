FROM node:22-alpine AS builder

WORKDIR /build

RUN apk add --no-cache git && \
git clone https://github.com/journey-ad/Moe-Counter mc && \
apk cache clean

FROM node:22-alpine

WORKDIR /app

COPY --from=builder /build/mc /app

RUN corepack enable && corepack prepare pnpm --activate

RUN pnpm install

RUN pnpm rebuild better-sqlite3

EXPOSE 3000

CMD ["pnpm", "start"]
