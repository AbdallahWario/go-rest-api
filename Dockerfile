FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod init blog-api && go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]