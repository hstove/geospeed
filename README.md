# Geospeed

An app for getting the current speed limit, wherever you are.

[geospeed.co](http://geospeed.co)

## Overview

This is a Ruby on Rails (4.2) application with two main components:

1. The front-end React application. Pretty much all of that code lives in
[app/assets/javascripts/components](https://github.com/hstove/geospeed/tree/master/app/assets/javascripts/components). The front end app served is a basic static site
with no dynamic data.

2. A server-side API for getting speed limit data. This is a simple wrapper around
the [Overpass API](http://overpass-api.de/). Most of this code lives in
[app/models/overpass.rb](https://github.com/hstove/geospeed/blob/master/app/models/overpass.rb).

## Features

- Shows the road where the currently displayed speed limit is relevant to. This
is useful when geolocation information is slightly inaccurate.
- Show current speed and speed limit.
- "HUD Mode" where text is mirrored, so you can reflect the screen off of your
windshield and use the app as a HUD.
- A color picker to change the color scheme.

## Contributing

This is a relatively straightforward Rails application to install and hack on:

```bash
git clone https://github.com/hstove/geospeed.git
cd geospeed
bundle install -j4
bundle exec bin/rake db:setup
bundle exec guard
```

Running `guard` will startup the server and setup LiveReload and `guard-rspec`.

## Self-Host

You can self host this app with the click of a button:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/hstove/geospeed)

----

![codeship](https://codeship.com/projects/c2a84230-d3f1-0132-ce9d-6a9d26101b06/status?branch=master)
