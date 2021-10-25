
FROM golang:1.17-alpine AS build
ENV GO111MODULE=on

WORKDIR /go/src/app
COPY . .

#COPY go.mod ./
#COPY go.sum ./
COPY . .
RUN go mod download

COPY *.go ./

RUN go build -o /docker-gs-ping

##
## Deploy
##
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /docker-gs-ping /docker-gs-ping

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/docker-gs-ping"]

# Run the web service on container startup.
#CMD ["/docker-gs-ping"]

