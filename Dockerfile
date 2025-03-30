# Build stage
FROM golang:1.23 AS builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

# Runtime stage
FROM debian:bookworm-slim

COPY --from=builder /yag /yag

# Optional: expose port 80
EXPOSE 80

# Final startup command using CMD only
CMD sh -c 'echo "REDIS is $REDIS" && exec /yag -all -web -pa'
