# README
[Github](https://github.com/iboard/docker-workstation)

This is Andi's Docker Image for Ruby Development
The Environment and User-Settings on this system
is immutable and is maintained outside the container.

The path /home/developer/projects is supposed to be mounted
via Docker to a hosted path outside the image


RVM is used to support your rubies and gemsets.
ATTENTION!!! Changes to the RVM setup are immutable too. You
will loose them on every logout! Instead of changing the
RVM-Environment while you're logged in at the running image
make your changes in the Dockerfile.
The same is true for any setup in dot-files within the user's
home-path.

Now run: "rake -T <enter>"


