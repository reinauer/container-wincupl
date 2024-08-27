USER:=stefanreinauer

all:
	@echo "Usage:"
	@echo
	@echo "make build     -   build new docker image"
	@echo "make run       -   simple test of cupl, make and gcc"
	@echo "make test      -   use docker image to build ~/git/A4091/a4091-latest"
	@echo "make upload    -   tag and upload image to $(USER)/wincupl"

build:
	docker build -t wincupl .

upload:
	docker image tag wincupl:latest stefanreinauer/wincupl:latest
	docker image push $(USER)/wincupl:latest

run:
	docker run -it wincupl wine C:\\WinCupl\\Shared\\cupl.exe
	docker run -it wincupl make -v
	docker run -it wincupl gcc -v

test:
	docker run -v $(HOME)/git/A4091/a4091-logic:/mnt -it wincupl make -C /mnt clean all
