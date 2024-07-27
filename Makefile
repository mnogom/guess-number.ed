build:
	docker build --tag guest-number:latest --progress plain .

run:
	docker run --rm --init -it guest-number:latest

brun: build run

clean:
	docker rmi guest-number:debug guest-number:latest
