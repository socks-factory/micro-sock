FROM registry.opensuse.org/opensuse/bci/golang:1.23 AS build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . ./

RUN make micro-sock

FROM scratch
COPY --from=build /app/micro-sock /micro-sock

CMD ["/micro-sock"]
