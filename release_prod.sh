#!/bin/bash

echo "Creating release"

KEY=$1 
PORT=$2

cd assets && node_modules/brunch/bin/brunch b -p && cd ..

MIX_ENV=prod mix phx.digest
MIX_ENV=prod mix release

if [ -n $3 ] && [ "$3" = "run" ] 
    then
        echo "Running release in foreground"
        YELP_API_KEY=$KEY PORT=$PORT _build/prod/rel/whatsforlunch/bin/whatsforlunch foreground
fi
