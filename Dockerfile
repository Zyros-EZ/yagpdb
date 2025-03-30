FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag

FROM debian:bookworm-slim
COPY --from=builder /yag /yag

ENV DATABASE_URL=$DATABASE_URL
ENV REDIS=$REDIS
ENV DISCORD_TOKEN=$DISCORD_TOKEN
ENV CLIENT_ID=$CLIENT_ID
ENV BOT_PREFIX=$BOT_PREFIX
ENV OWNER=$OWNER

CMD ["/yag", "-all"]
