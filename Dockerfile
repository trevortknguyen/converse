# FROM haskell:8.8.3-buster
# COPY *.cabal /app
# WORKDIR /app
# RUN cabal build --only-dependencies
# RUN cabal install
# CMD converse

FROM debian:buster-slim
WORKDIR /app
COPY ./bin/converse /app
COPY ./html/index.html /app/html/index.html
CMD /app/converse