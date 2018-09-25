FROM elixir:1.6.5 as elixir 

FROM elixir as elixir-build
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN mkdir /source
WORKDIR /source
RUN mix local.hex --force 
COPY . /source
RUN mix deps.get && ./rprod.sh

FROM elixir as elixir-release
WORKDIR /opt
COPY --from=elixir-build /source/_build/prod/rel/whatsforlunch/releases/0.0.1/whatsforlunch.tar.gz .
RUN tar -xzvf whatsforlunch.tar.gz && ls -altr
EXPOSE 4001
CMD ["./bin/whatsforlunch", "foreground"]