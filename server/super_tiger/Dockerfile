FROM elixir:onbuild
MAINTAINER Vinh <kurei@axcoto.com>

RUN mix local.hex --force
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

WORKDIR /super_tiger
