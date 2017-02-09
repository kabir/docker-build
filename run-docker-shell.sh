#!/bin/bash 

# Create the volumes here
docker volume create --name maven-build-mvn-repo
docker volume create --name maven-build-clones

docker run \
	-v ~/.m2/settings.xml:/root/.m2/settings.xml \
	-v ~/.ssh:/root/.ssh \
	-v ~/.gitconfig:/root/.gitconfig \
	-v maven-build-mvn-repo:/root/.m2 \
	-v maven-build-clones:/git-clones \
	-it maven-build \
        bash	

