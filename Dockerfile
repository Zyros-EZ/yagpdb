FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

FROM debian:bookworm-slim

# Copy built binary
COPY --from=builder /yag /yag

# Create entrypoint shell to inject Redis URL properly
RUN echo '#!/bin/sh\nexec /yag -all -web -pa -redis "$REDIS_URL"' > /entrypoint.sh && chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
