FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

FROM debian:bookworm-slim

COPY --from=builder /yag /yag

CMD ["sh", "-c", "exec /yag -all -web -exthttps -pa=false -listen :$PORT"]
