build: var/built

run: docker-run

node_modules: package.json
	npm install

build_docker.ok: Dockerfile node_modules cat-coincap.js pipe-archive.sh
	docker build . -t archiver:latest
	touch build_docker.ok

docker-run-d: build_docker.ok
	docker run -d -v docker_var:/action/var:rw archiver:latest

docker-run-it: build_docker.ok
	docker run -it -v docker_var:/action/var:rw archiver:latest

docker-run-it-bash: build_docker.ok
	docker run -it -v docker_var:/action/var:rw archiver:latest bash

docker-run-it-ls: build_docker.ok
	docker run -it -v docker_var:/action/var:rw archiver:latest ls -al var

#run_locally:
#	node stream-archiver.js

#setup:
#	npm install

clean:
	rm -fr *.ok

delete-data:
	rm -fr var/*

tunnel-to-cluster:
	ssh -fNL 2375:localhost:2375 bartek@ekhmmmgmt.northeurope.cloudapp.azure.com -A -p 2200
	echo "export DOCKER_HOST=:2375"
