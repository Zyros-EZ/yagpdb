FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

FROM debian:bookworm-slim

# Copy the compiled binary
COPY --from=builder /yag /yag

# Start the bot and pass run flags manually
EXPOSE 80
ENV REDIS_URL=${REDIS_URL}
CMD ["/yag", "-all", "-web", "-pa"]



