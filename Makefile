.SILENT :
.PHONY : dkz clean fmt

TAG:=`git describe --abbrev=0 --tags`
LDFLAGS:=-X main.buildVersion=$(TAG)

all: dkz

deps:
	go get github.com/robfig/glock
	glock sync -n < GLOCKFILE

dkz:
	echo "Building dkz"
	go install -ldflags "$(LDFLAGS)"

dist-clean:
	rm -rf dist
	rm -f dkz-*.tar.gz

dist: deps dist-clean
	mkdir -p dist/alpine-linux/amd64 && GOOS=linux GOARCH=amd64 go build -ldflags "$(LDFLAGS)" -a -tags netgo -installsuffix netgo -o dist/alpine-linux/amd64/dkz
	mkdir -p dist/linux/amd64 && GOOS=linux GOARCH=amd64 go build -ldflags "$(LDFLAGS)" -o dist/linux/amd64/dkz
	mkdir -p dist/linux/386 && GOOS=linux GOARCH=386 go build -ldflags "$(LDFLAGS)" -o dist/linux/386/dkz
	mkdir -p dist/linux/armel && GOOS=linux GOARCH=arm GOARM=5 go build -ldflags "$(LDFLAGS)" -o dist/linux/armel/dkz
	mkdir -p dist/linux/armhf && GOOS=linux GOARCH=arm GOARM=6 go build -ldflags "$(LDFLAGS)" -o dist/linux/armhf/dkz
	mkdir -p dist/linux/aarch64 && GOOS=linux GOARCH=aarch64 go build -ldflags "$(LDFLAGS)" -o dist/linux/aarch64/dkz
	mkdir -p dist/darwin/amd64 && GOOS=darwin GOARCH=amd64 go build -ldflags "$(LDFLAGS)" -o dist/darwin/amd64/dkz

release: dist
	tar -cvzf dkz-alpine-linux-amd64-$(TAG).tar.gz -C dist/alpine-linux/amd64 dkz
	tar -cvzf dkz-linux-amd64-$(TAG).tar.gz -C dist/linux/amd64 dkz
	tar -cvzf dkz-linux-386-$(TAG).tar.gz -C dist/linux/386 dkz
	tar -cvzf dkz-linux-armel-$(TAG).tar.gz -C dist/linux/armel dkz
	tar -cvzf dkz-linux-armhf-$(TAG).tar.gz -C dist/linux/armhf dkz
	tar -cvzf dkz-linux-aarch64-$(TAG).tar.gz -C dist/linux/aarch64 dkz
	tar -cvzf dkz-darwin-amd64-$(TAG).tar.gz -C dist/darwin/amd64 dkz
