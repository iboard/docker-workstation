# README

This is Andi's Docker Image for Ruby Development
The Environment and User-Settings on this system
is imutable and get's maintained outside this container

The path /home/developer/projects is supposed to be mounted
via Docker to a hosted path outside the image


RVM is used to support your rubies and gemsets.
ATTATION!!! Changes to the RVM setup are imutable too. You
will loose them on every logout! Instead of changing the
RVM-Environment while you're logged in at the running image
make your changes in the Dockerfile of the host!
The same is true for any setup in dot-files within the user's 
home-path.

now run: "rake -T <enter>"


Howly Cow


