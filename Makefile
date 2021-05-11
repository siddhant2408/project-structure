.PHONY: default
default: build

all: clean build test

GO_BUILD_DIR=bin
build:
	mkdir -p $(GO_BUILD_DIR)
	go build -o $(GO_BUILD_DIR) ./cmd/...

test: build
	go test -short -coverprofile=bin/cov.out ./...
	go tool cover -func=bin/cov.out

clean:
	rm -rf ./bin

version := "1.0.0"
sonar: test
	sonar-scanner -Dsonar.projectVersion="$(version)"

start-sonar:
	docker run --name sonarqube -p 9000:9000 sonarqube
