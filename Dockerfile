FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

FROM debian:bookworm-slim

# Copy the compiled binary
COPY --from=builder /yag /yag

# Set environment variables (make sure Redis and Database are passed in correctly)
ENV DATABASE_URL=${DATABASE_URL}
ENV REDIS=${REDIS}    # This will point to your Redis instance
ENV DISCORD_TOKEN=${DISCORD_TOKEN}
ENV CLIENT_ID=${CLIENT_ID}
ENV BOT_PREFIX=${BOT_PREFIX}
ENV OWNER=${OWNER}

# Start the bot and pass run flags manually
CMD ["/yag", "-all"]
