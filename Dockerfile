FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

FROM debian:bookworm-slim

COPY --from=builder /yag /yag

# Inject REDIS env var for the app (no -redis flag!)
ENV REDIS=redis://default:uRwvXdiZXBexHcKlJHQWmMPqzRebBtIt@interchange.proxy.rlwy.net:27599

EXPOSE 80

CMD ["/yag", "-all", "-web", "-pa"]
