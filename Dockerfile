#
#FROM golang:1.17-alpine AS build
#ENV GO111MODULE=on
#
#WORKDIR /go/src/app
##COPY . .
#
#COPY go.mod ./
#COPY go.sum ./
#COPY . .
#RUN go mod download
#
#COPY *.go ./
#
#RUN go build -o /instagram
#
###
### Deploy
###
#FROM gcr.io/distroless/base-debian10
#
#WORKDIR /
#
#COPY --from=build /instagram /instagram
#
#EXPOSE 8080
#
#USER nonroot:nonroot
#
#ENTRYPOINT ["/instagram"]
#
## Run the web service on container startup.
##CMD ["/instagram"]


# syntax=docker/dockerfile:1

##
## Build
##
FROM golang:1.17-alpine AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

ENV CGO_ENABLED=0
RUN   go build -o /instagram

##
## Deploy
##
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /instagram /instagram

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/instagram"]



