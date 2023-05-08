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

build-linux: format 
	CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build
	TARGETOS=linux

build-darwin: format 
	CGO_ENABLED=0 GOOS=darwin GOARCH=${TARGETARCH} go build	
	TARGETOS=darwin

build-windows: format 
	CGO_ENABLED=0 GOOS=windows GOARCH=${TARGETARCH} go build
	TARGETOS=windows	

push:
	docker push ${REGISTRY}/${APP}:${TARGETARCH}

clean:
	rmi ${REGISTRY}/${APP}:${TARGETOS}-${TARGETARCH}	
