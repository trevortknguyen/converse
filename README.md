# Converse
Right now, it's a simple webapp that has a websockets chat!

The build situation isn't fully reproducible anywhere, but I'll document how I build on my Ubuntu system.
A huge disclaimer is this is for hobbyists who want a build experience with a little bit of
reproducibility, but lack the resources and/or interest to have remote builds integrated into CI systems.

The general flow is building the project locally, packing it into a Docker image, then deploying the Docker
image on Heroku's Container Registry using the CLI. Thus every deployment is manual and isn't scalable to
a large team or large project to build.

I have decided this is the easiest method for the hobbyist who does not want to put on a DevOps hat if they
can avoid it. Heroku Buildpacks might make this easier, but building projects is computationally expensive
and Heroku will likely crash when trying to build your project in the cloud. Then you have to basically integrate
some CI in there to build it somewhere else, cache it, then use it in the buildpack. This is likely worth exploring
if there's a place where you can build a bunch of stuff for free in the cloud.

## Building Locally with Cabal

For creating a binary, this will copy the actual binary into `$REPO/bin/converse`. It's not on the `$PATH`, but you can add
it to the path if you want. I mainly need this for deploying the executable only to my Docker image.

As far as I know, this ONLY works for me because I'm using Ubuntu 18.04 (bionic), which is based on Debian 10 (buster). The key is
my operating system matches the deployment Dockerfile's `debian:buster-slim` operating system as a base image.

If you're cool and using Archlinux, then this likely won't work. A more elegant approach is to create two Dockerfiles.
One is for building the project, likely based on `haskell:8.8.3-buster` or some other Haskell image that uses the same base
operating system as the deployment image.

```
cabal install --install-method=copy --installdir=bin
```

Alternatively, if you just want to run it locally, you can do `cabal run` or `cabal install && converse`.

## Building the Docker image

You can build again and again over the same image.

```
docker build -t converse:v1 ./
```

## Running the Docker image

Running the image in detached mode.

```
docker run --publish 3000:3000 --detach --name converse_container converse:v1
```

Killing the detached image. First check that it's running. Kill it by its name. Removed the stopped container.

```
docker ps                       # optional
docker kill converse_container
docker container ls             # optional
docker rm converse_container
```

## Introducing Heroku

This requires the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli), so get that if you don't have it.
Also, most of this is copied from the Heroku mini-tutorial when you Container Registry with Heroku CLI as the Deployment option
when starting a new Heroku app.


Logging into Heroku CLI and the Heroku container registry.

```
heroku login
heroku container:login
```

Now that we've built our image locally using Ubuntu, we can push it to our Heroku application.
Make sure you replace `$APP_NAME` with whatever the slug name of your Heroku application is.
Find that on your Heroku Dashboard or create an application in Heroku if you haven't already. 

```
heroku container:push --app $APP_NAME web
```

And release!

```
heroku container:release --app $APP_NAME web
```

## Acknowledgements

The Scotty tutorial was pretty helpful. I recommend it starting out with Haskell web development
especially if you're not aware of (or don't have any) business requirements that would guide you
toward a different framework.

The Websockets server was basically copied from the Haskell Websockets tutorial.

The Scotty + Websockets was based off of [this one gist](https://gist.github.com/andrevdm/9560b5e31933391694811bf22e25c312).

