FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

FROM debian:bookworm-slim

COPY --from=builder /yag /yag

EXPOSE 80

CMD ["sh", "-c", "exec /yag -all -web -pa -redis 'redis://default:uRwvXdiZXBexHcKlJHQWmMPqzRebBtIt@interchange.proxy.rlwy.net:27599'"]
