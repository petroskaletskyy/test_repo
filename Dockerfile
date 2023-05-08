FROM quay.io/projectquay/golang:1.20 AS build
WORKDIR /go/src/app
COPY . .
RUN make build 

FROM scratch
COPY --from=build /go/src/app/hello .
CMD ["./hello"]
