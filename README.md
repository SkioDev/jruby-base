# jruby-base
Location of Dockerfiles for jruby-base image

## How to update
To update to version X.X.X.X:
- Change the JRUBY_VERSION environment variable in the Dockerfile to X.X.X.X
- Run `curl https://s3.amazonaws.com/jruby.org/downloads/X.X.X.X/jruby-bin-X.X.X.X.tar.gz.sha256`
  and use the SHA256 hash that results to update the JRUBY_SHA256 environment
  variable to that value
- Run `docker build -t skio/jruby .` and make sure that the image builds
- Make sure you're on the master branch and run
  `git commit -m "Update to JRuby version X.X.X.X"
- Run `git push -u` to update the latest tag
- Create a new branch `git checkout -b X.X.X.X`
- Run `git push -u` to add the version tag