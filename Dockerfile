FROM node:22-alpine AS builder

WORKDIR /build

RUN apk add --no-cache git && \
git clone https://github.com/journey-ad/Moe-Counter mc && \
apk cache clean

FROM node:18-alpine

WORKDIR /app

COPY --from=builder /build/mc /app

RUN corepack enable && corepack prepare pnpm@9.15.4 --activate

RUN --mount=type=cache,id=pnpm,target=/root/.local/share/pnpm/store pnpm fetch --frozen-lockfile
RUN --mount=type=cache,id=pnpm,target=/root/.local/share/pnpm/store pnpm install --frozen-lockfile

EXPOSE 3000

CMD ["pnpm", "start"]
