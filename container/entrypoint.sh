#!/bin/sh

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=$LOCAL_USER_ID

echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m user

# Change ownership of the shared volumes and link to them from the home directory
# chown -R user:user /git-clones
#ln -s /git-clones/ /home/user/git-clones 

# Change ownership of the mapped folders from shared volumes and 
# the host OS, so we can read them and link from the home dir
chown -R user:user /mapped

#Create the user's .m2 directory, we'll map settings.xml and the repository later
mkdir /home/user/.m2

#link folders
ln -s /mapped/.ssh /home/user/.ssh
ln -s /mapped/.gitconfig /home/user/.gitconfig
ln -s /mapped/mvn-settings.xml /home/user/.m2/settings.xml 
ln -s /mapped/.m2-repo /home/user/.m2/repository
ln -s /mapped/git-clones/ /home/user/git-clones 

# Make everything under the user directory visible to the user
chown -R user:user /home/user

# Go to the clones directory
cd /home/user/git-clones


export HOME=/home/user
/usr/local/bin/gosu user "$@"


