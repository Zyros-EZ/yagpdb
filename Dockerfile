FROM golang:1.23 as builder

WORKDIR /app
COPY . .

WORKDIR /app/cmd/yagpdb
RUN go build -o /yag .

FROM debian:bookworm-slim

COPY --from=builder /yag /yag

EXPOSE 80

ENTRYPOINT ["/yag"]
CMD sh -c 'echo "REDIS is $REDIS" && exec /yag -all -web -pa'

