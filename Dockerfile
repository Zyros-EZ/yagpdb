# Use a base image
FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

# Use a smaller base image for the runtime
FROM debian:bookworm-slim

COPY --from=builder /yag /yag

# Expose the required port for YAGPDB (adjust if necessary)
EXPOSE 8080

# Set the Redis URL to point to localhost (since it's running in the container on port 6379)
ENV REDIS=redis://localhost:6379

# Run YAGPDB with the necessary flags
CMD ["/yag", "-all", "-web", "-pa"]
