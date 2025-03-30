FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

FROM debian:bookworm-slim

# Copy binary
COPY --from=builder /yag /yag

# Use Railway's REDIS_URL and rename it at runtime
RUN echo '#!/bin/sh\nexport REDIS="$REDIS_URL"\nexec /yag -all -web -pa' > /entrypoint.sh && chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
