SHELL:=pwsh.exe
.SHELLFLAGS:=-Command

all: build

VERSION=$(shell git tag | Select-Object -Last 1)
PACKAGE=$(shell go list)
build: 
	@go build -ldflags "-s -w -X ${PACKAGE}/internal.Version=${VERSION}" ./cmd/gorss/...

run: build
	@./gorss


release:
	@mkdir release
	@mkdir dist
	@$$GOARCH="amd64"; $$GOOS="darwin"; go build -ldflags "-s -w -X ${PACKAGE}/internal.Version=${VERSION}" -o ./release/gorss_osx ./cmd/gorss/...
	@$$GOARCH="amd64"; $$GOOS="linux"; go build -ldflags "-s -w -X ${PACKAGE}/internal.Version=${VERSION}" -o ./release/gorss_linux ./cmd/gorss/...
	@$$GOARCH="amd64"; $$GOOS="windows"; go build -ldflags "-s -w -X ${PACKAGE}/internal.Version=${VERSION}" -o ./release/gorss_windows.exe ./cmd/gorss/...
	@cp gorss.conf dist/
	@cp themes/default.theme dist/
	@cp -r themes dist/
	@mv release/gorss_windows.exe dist && tar cvfz gorss_windows.tar.gz dist
	@rm dist/gorss_windows.exe
	@mv release/gorss_linux dist && tar cvfz gorss_linux.tar.gz dist
	@rm dist/gorss_linux
	@mv release/gorss_osx dist && tar cvfz gorss_osx.tar.gz dist
	@rm -r -fo release, dist

clean:
	rm -r -fo gorss, gorss.exe, gorss.log, gorss.db, release, dist, *.tar.gz

