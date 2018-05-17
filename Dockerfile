FROM elixir:1.6.5

WORKDIR /opt

ADD _build/prod/rel/whatsforlunch/releases/0.0.1/whatsforlunch.tar.gz .

EXPOSE 4001

CMD ["./bin/whatsforlunch", "foreground"]