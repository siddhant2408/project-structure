.PHONY: default
default: build

all: clean build test

GO_BUILD_DIR=build
build:
	mkdir -p $(GO_BUILD_DIR)
	go build -o $(GO_BUILD_DIR) ./cmd/...

test: build
	go test -short -coverprofile=build/cov.out ./...
	go tool cover -func=build/cov.out

clean:
	rm -rf ./build

version := "1.0.0"
sonar: test
	sonar-scanner -Dsonar.projectVersion="$(version)"

start-sonar:
	docker run --name sonarqube -p 9000:9000 sonarqube
