# Base on the OpenJDK 8 image
FROM fedora:25

# Install the gosu user tool, and install Java, Maven and Git
# I cannot get the gpg verification mentioned in https://denibertovic.com/posts/handling-permissions-with-docker-volumes/ 
# working, so I am skipping it for now
RUN dnf -y upgrade
RUN dnf install -y java-1.8.0-openjdk-devel maven git dpkg
RUN dnf clean all
RUN git --version
RUN mvn -version
RUN echo running dpkg
RUN dpkg --print-architecture
RUN dpkg --print-architecture | awk -F- '{ print $NF }'
RUN curl -L -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture | awk -F- '{ print $NF }')"
RUN chmod +x /usr/local/bin/gosu
RUN ls -al /usr/local/bin/
RUN gosu nobody true

ADD container/change-version.sh /change-version.sh
COPY container/entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

#TODO how to make it start in the /git-clones folder?

