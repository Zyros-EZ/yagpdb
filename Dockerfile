FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

FROM debian:bookworm-slim

COPY --from=builder /yag /yag

# ✅ Set correct env var that YAGPDB actually looks for
ENV REDIS=redis://default:uRwvXdiZXBexHcKlJHQWmMPqzRebBtIt@interchange.proxy.rlwy.net:27599

EXPOSE 80

# ✅ Directly run without any shell overrides
CMD ["/yag", "-all", "-web", "-pa"]
