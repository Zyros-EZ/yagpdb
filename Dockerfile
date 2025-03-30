FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

FROM debian:bookworm-slim

COPY --from=builder /yag /yag

# Create entrypoint that exports REDIS from REDIS_URL
RUN echo '#!/bin/sh\nexport REDIS="$REDIS_URL"\nexec /yag -all -web -pa' > /entrypoint.sh && chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
