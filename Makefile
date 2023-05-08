DOCKER_REGISTRY=quay.io
REGISTRY=petroskaletskyy
TARGETOS=linux#darwin windows
TARGETARCH=amd64#arm64
APP=hello

format:
	gofmt -s -w ./

image:
	docker build . -t ${REGISTRY}/${APP}:${TARGETOS}-${TARGETARCH}	

amd64:
	TARGETARCH=amd64

arm64:
	TARGETARCH=arm64	

build: format
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build

linux: 
	TARGETOS=linux
	make build

darwin:
	TARGETOS=darwin
	make build	

windows: 
	TARGETOS=windows
	make build	

push:
	docker push ${REGISTRY}/${APP}:${TARGETARCH}

clean:
	rmi ${REGISTRY}/${APP}:${TARGETOS}-${TARGETARCH}	
