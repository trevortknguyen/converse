# Converse
Right now, it's a simple webapp that has a websockets chat!

The build situation isn't fully reproducible anywhere, but I'll document how I build on my Ubuntu system.

## Building Locally with Cabal

For creating a binary, this will copy the actual binary into `$REPO/bin/converse`. It's not on the `$PATH`, but you can add
it to the path if you want. I mainly need this for deploying the executable only to my Docker image.

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