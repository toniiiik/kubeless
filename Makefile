GO = go
GO_FLAGS =
GOFMT = gofmt
KUBECFG = kubecfg
DOCKER = docker
CONTROLLER_IMAGE = repodx.goldmann.sk/kubeless/function-controller:1.24.0
FUNCTION_IMAGE_BUILDER = kubeless-function-image-builder:latest
OS = linux
ARCH = amd64
BUNDLES = bundles
GO_PACKAGES = ./cmd/... ./pkg/...
GO_FILES := $(shell find $(shell $(GO) list -f '{{.Dir}}' $(GO_PACKAGES)) -name \*.go)

export KUBECFG_JPATH := $(CURDIR)/ksonnet-lib
export PATH := $(PATH):$(CURDIR)/bats/bin

.PHONY: all

KUBELESS_ENVS := \
	-e OS_PLATFORM_ARG \
	-e OS_ARCH_ARG \

default: binary

binary:
	CGO_ENABLED=0 ./script/binary

binary-cross:
	./script/binary-cli


%.yaml: %.jsonnet
	$(KUBECFG) show -U https://raw.githubusercontent.com/kubeless/runtimes/master -o yaml $< > $@.tmp
	mv $@.tmp $@

all-yaml: kubeless.yaml kubeless-non-rbac.yaml kubeless-openshift.yaml

kubeless.yaml: kubeless.jsonnet kubeless-non-rbac.jsonnet

kubeless-non-rbac.yaml: kubeless-non-rbac.jsonnet

kubeless-openshift.yaml: kubeless-openshift.jsonnet

docker/function-controller: controller-build
	cp $(BUNDLES)/kubeless_$(OS)-$(ARCH)/kubeless-function-controller $@

controller-build:
	./script/binary-controller -os=$(OS) -arch=$(ARCH)

function-controller: docker/function-controller
	$(DOCKER) build -t $(CONTROLLER_IMAGE) $<

docker/function-image-builder: function-image-builder-build
	cp $(BUNDLES)/kubeless_$(OS)-$(ARCH)/imbuilder $@

function-image-builder-build:
	./script/binary-controller -os=$(OS) -arch=$(ARCH) imbuilder github.com/kubeless/kubeless/pkg/function-image-builder

function-image-builder: docker/function-image-builder
	$(DOCKER) build -t $(FUNCTION_IMAGE_BUILDER) $<

update:
	./hack/update-codegen.sh

test:
	$(GO) test $(GO_FLAGS) $(GO_PACKAGES)

validation:
	./script/validate-lint
	./script/validate-gofmt
	./script/validate-git-marks

integration-tests:
	./script/integration-tests minikube deployment
	./script/integration-tests minikube basic

fmt:
	$(GOFMT) -s -w $(GO_FILES)

bats:
	git clone --branch=v0.4.0 --depth=1 https://github.com/sstephenson/bats.git

ksonnet-lib:
	git clone --depth=1 https://github.com/ksonnet/ksonnet-lib.git

.PHONY: bootstrap
bootstrap: bats ksonnet-lib

	GO111MODULE="off" go get -u github.com/mitchellh/gox
	GO111MODULE="off" go get -u golang.org/x/lint/golint

	@if ! which kubecfg >/dev/null; then \
	sudo wget -q -O /usr/local/bin/kubecfg https://github.com/ksonnet/kubecfg/releases/download/v0.9.0/kubecfg-$$(go env GOOS)-$$(go env GOARCH); \
	sudo chmod +x /usr/local/bin/kubecfg; \
	fi

	@if ! which kubectl >/dev/null; then \
	KUBECTL_VERSION=$$(wget -qO- https://storage.googleapis.com/kubernetes-release/release/stable.txt); \
	sudo wget -q -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$$KUBECTL_VERSION/bin/$$(go env GOOS)/$$(go env GOARCH)/kubectl; \
	sudo chmod +x /usr/local/bin/kubectl; \
	fi
