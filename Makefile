all: build run

build:
	docker build -t wincupl .

run:
	#docker run -it wincupl /bin/bash
	docker run -it wincupl wine C:\\WinCupl\\Shared\\cupl.exe
