# Base on the OpenJDK 8 image
FROM fedora:25

# Install the gosu user tool (checking signatures), and install Java, Maven and Git
RUN dnf -y upgrade \
&& dnf install -y java-1.8.0-openjdk-devel maven git dpkg sed gnupg ca-certificates \
&& dnf clean all \
&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
&& curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture | awk -F- '{ print $NF }').asc" \
&& ls -al /usr/local/bin/ \
&& gpg --verify /usr/local/bin/gosu.asc \
&& rm /usr/local/bin/gosu.asc \
&& chmod +x /usr/local/bin/gosu \
&& gosu nobody true \
&& git --version \
&& mvn -version 




ADD container/change-version.sh /change-version.sh
COPY container/entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

#TODO how to make it start in the /git-clones folder?

