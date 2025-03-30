FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

FROM debian:bookworm-slim

COPY --from=builder /yag /yag

# Set correct Redis URL using ENV
ENV REDIS=redis://default:uRwvXdiZXBexHcKlJHQWmMPqzRebBtIt@interchange.proxy.rlwy.net:27599

EXPOSE 80

# Start with env explicitly passed to the process
ENTRYPOINT ["/bin/sh", "-c", "REDIS=$REDIS exec /yag -all -web -pa"]
