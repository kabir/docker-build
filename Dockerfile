# Base on the OpenJDK 8 image
FROM fedora:25

RUN dnf install -y java-1.8.0-openjdk-devel maven git && \
    dnf clean all && \
    git --version && \
    mvn -version

ADD container/change-version.sh /change-version.sh

#TODO how to make it start in the /git-clones folder?

