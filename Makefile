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

build-darwin: format 
	CGO_ENABLED=0 GOOS=darwin GOARCH=${TARGETARCH} go build	

build-windows: format 
	CGO_ENABLED=0 GOOS=windows GOARCH=${TARGETARCH} go build	

push:
	docker push ${REGISTRY}/${APP}:${TARGETARCH}

clean:
	rmi ${REGISTRY}/${APP}:${TARGETOS}-${TARGETARCH}	
