# (Heroku-ish) Slug Runner

A container image that runs Heroku-like [slugs](https://devcenter.heroku.com/articles/slug-compiler) produced by slugbuilder.

## What does it do exactly?

It takes a gzipped tarball of a "compiled" application via stdin or from a URL, letting you run a command in that application environment.

## Using Slug Runner

First, you need Docker.
Then you can either pull the image from the public index:

	$ docker pull elasticio/apprunner

Or you can build from this source:

	$ docker build -t elasticio/apprunner .

When you run the container, it always expects an app slug to be passed via stdin or by giving it a URL using the SLUG_URL environment variable.
Lets run a Rake task that our app uses, attaching to stdout:

	$ cat myslug.tgz | docker run -i -a stdin -a stdout elasticio/apprunner rake mytask

We can also load slugs using the SLUG_URL environment variable.
This is currently the only way to run interactively, for example running Bash:

	$ docker run -e SLUG_URL=http://example.com/slug.tgz -i -t elasticio/apprunner /bin/bash

Commands are run in the application environment, in the root directory of the application, with any default environment variables.

To provide .env variables to started image, use "--env-file" option 

	$ cat myslug.tgz | docker run -i -a stdin -a stdout -a stderr --env-file .env elasticio/apprunner bash sail.sh
