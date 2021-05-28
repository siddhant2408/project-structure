.PHONY: default
default: build test lint

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

.PHONY: lint
lint::
	$(MAKE) golangci-lint

.PHONY: golangci-lint
golangci-lint: install-golangci-lint
	$(GOLANGCI_LINT_BIN) -v run

GOLANGCI_LINT_VERSION=v1.40.1
GOLANGCI_LINT_DIR=$(shell go env GOPATH)/pkg/golangci-lint/$(GOLANGCI_LINT_VERSION)
GOLANGCI_LINT_BIN=$(GOLANGCI_LINT_DIR)/golangci-lint
$(GOLANGCI_LINT_BIN):
	curl -vfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(GOLANGCI_LINT_DIR) $(GOLANGCI_LINT_VERSION)

# Install golangci-lint, if not available
.PHONY: install-golangci-lint
install-golangci-lint: $(GOLANGCI_LINT_BIN)
