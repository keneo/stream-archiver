build: var/built

run: run_in_docker

var/built: Dockerfile package.json stream-archiver.js
	docker build . -t archiver:latest
	mkdir var || true
	touch var/built

run_in_docker: build
	docker run archiver:latest

#run_locally:
#	node stream-archiver.js

#setup:
#	npm install
