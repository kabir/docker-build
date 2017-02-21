#!/bin/bash 

# Create the volumes here
docker volume create --name maven-build-mvn-repo
docker volume create --name maven-build-clones

docker run \
	-v ~/.ssh:/mapped/.ssh \
	-v ~/.gitconfig:/mapped/.gitconfig \
	-v ~/.m2/settings.xml:/mapped/mvn-settings.xml \
	-v maven-build-mvn-repo:/mapped/.m2-repo \
	-v maven-build-clones:/mapped/git-clones \
	-e LOCAL_USER_ID=`id -u $USER` \
	-it maven-build \
        bash	

