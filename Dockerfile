FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

FROM debian:bookworm-slim

COPY --from=builder /yag /yag

# 🔧 Create the script that injects REDIS_URL
RUN echo '#!/bin/sh\nexport REDIS_URL="redis://default:uRwvXdiZXBexHcKlJHQWmMPqzRebBtIt@interchange.proxy.rlwy.net:27599"\nexec /yag -all -web -pa' > /entrypoint.sh && chmod +x /entrypoint.sh

EXPOSE 80

# 🚀 This tells Docker to actually use the script!
ENTRYPOINT ["/entrypoint.sh"]
