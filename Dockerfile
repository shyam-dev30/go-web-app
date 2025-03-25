FROM golang:1.22.5 As builder
WORKDIR /app
COPY main*.go go.mod /app/
RUN go mod tidy 
COPY . .

RUN go build -o app
RUN chmod +x /app
FROM gcr.io/distroless/base
WORKDIR /app
COPY --from=builder /app/ /app
EXPOSE 8080

CMD ["/app/app"]
