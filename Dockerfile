FROM golang:1.21 as builder

WORKDIR /app

COPY . .

WORKDIR /app/yagpdb

RUN go build -o /yag .

FROM debian:bullseye-slim

COPY --from=builder /yag /yag

ENV DATABASE_URL=$DATABASE_URL
ENV REDIS=$REDIS
ENV DISCORD_TOKEN=$DISCORD_TOKEN
ENV CLIENT_ID=$CLIENT_ID
ENV BOT_PREFIX=$BOT_PREFIX
ENV OWNER=$OWNER

CMD ["/yag"]
