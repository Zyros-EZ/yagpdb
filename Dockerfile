FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

FROM debian:bookworm-slim

COPY --from=builder /yag /yag

EXPOSE 80

ENV REDIS=redis://default:uRwvXdiZXBexHcKlJHQWmMPqzRebBtIt@interchange.proxy.rlwy.net:27599

CMD ["/yag", "-all", "-web", "-pa"]
