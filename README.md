# docker-maven-build
Docker job with all the bits set up to do a maven build. It has a totally separate local maven repository from your host OS, and a separate folder for your git clones. These locations are stored on shared Docker volumes, so they can be shared amongst containers and will survive bouncing the containers.

To build the image, run the `./build-docker-shell.sh` script. Do so from within the folder where you have cloned this git repository. It might take some time the first time you do this. 

To run a container, run the `run-docker-shell.sh` script. This will create the two Docker volumes mentioned (for your git clones and your maven repository), and then boot docker into an interactive bash shell. Java, Git and Maven will all be installed. 

There is also a script to help you change versions of poms when you do releases, located at `/change-versions.sh`. It takes the from version and the to version, so e.g. to change from `1.0.0.Beta1-SNAPSHOT` to `1.0.0.Beta1` you would run the following from within the git clone folder for which you are doing a release:

	$ cd /git-clones/my-awesome-project
	$ /change-versions 1.0.0.Beta1-SNAPSHOT 1.0.0.Beta1

The container will be able to read your `~/.ssh` folder, your `~/.gitconfig` and your `~/.m2/settings.xml`, so you should be able to access git and deploy to maven as normal.

Once started cd into the `/git-clones` folder which is the root directory for your git clones. From there clone your git repositories, and then `mvn install` or whatever other maven commands you would like as normal.
