SHELL:=pwsh.exe
.SHELLFLAGS:=-Command

VERSION=$(shell git tag | Select-Object -Last 1)
PACKAGE=$(shell go list)

VERSIONFLAG=-X ${PACKAGE}/internal.Version=${VERSION}
RELEASEFLAGS=-s -w

all: build

build:
	@go build -ldflags "${VERSIONFLAG}" ./cmd/gorss/...

build-race:
	@go build -race -ldflags "${VERSIONFLAG}" ./cmd/gorss/...

run: build
	@./gorss

release:
	@mkdir release
	@mkdir dist
	@$$GOARCH="amd64"; $$GOOS="darwin"; go build -ldflags "${RELEASEFLAG} ${VERSIONFLAG}" -o ./release/gorss_darwin ./cmd/gorss/...
	@$$GOARCH="amd64"; $$GOOS="linux"; go build -ldflags "${RELEASEFLAG} ${VERSIONFLAG}" -o ./release/gorss_linux ./cmd/gorss/...
	@$$GOARCH="amd64"; $$GOOS="windows"; go build -ldflags "${RELEASEFLAG} ${VERSIONFLAG}" -o ./release/gorss_windows.exe ./cmd/gorss/...
	@cp gorss.conf dist/
	@cp themes/default.theme dist/
	@cp -r themes dist/
	@mv release/gorss_darwin dist && tar cvfz gorss_darwin.tar.gz dist
	@rm dist/gorss_darwin
	@mv release/gorss_linux dist && tar cvfz gorss_linux.tar.gz dist
	@rm dist/gorss_linux
	@mv release/gorss_windows.exe dist && tar cvfz gorss_windows.tar.gz dist
	@rm -r -fo release, dist

clean:
	rm -r -fo gorss, gorss.exe, gorss.log, gorss.db, release, dist, *.tar.gz

