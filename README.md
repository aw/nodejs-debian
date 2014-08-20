# Automatically build node.js debian packages

This repository will allow you to build your own .deb package of node.js.

Obviously, you need to run this on a debian server.

Tested on:

  * Debian 7.5
  * Debian 6.0.9

## Changes

* June 7, 2014 - We're now building node.js using shared libs instead of relying on Node's included libs.

## Version

Current version: 0.10.31

## Directory structure

* bin/ - contains the tool to create the .deb package
* debian/ - contains some files for building a .deb package "The Debian Way™"
* node.git/ - an empty directory, which is actually a git submodule that you pull

## How it works

When you run the script to build the .deb package, it will pull down 
the official node.git repository from GitHub. It will then create a tarball 
of the node.js version you want to build, extract the files, and run the
`debuild` tool to compile node.js.

If all worked well, you'll end up with a shiny .deb file that you can reprepro
to your APT repository, or simply rsync to your node.js servers. Build once,
install plenty.

Once the build is complete, feel-free to remove all the junk files 
`debuild` left behind. Some of those files have interesting information 
though, such as the *.dsc file.

## Setup

Install the debian package building prerequesites:

`apt-get install build-essential git-core libssl-dev pkg-config libc-ares-dev zlib1g-dev debuild devscripts`

## Usage

`bin/make-nodejs-deb.sh 0.10.17`

## Installing the package

`dpkg -i nodejs_0.10.17-1_amd64.deb`

## Updating

```
git pull
bin/make-nodejs-deb.sh 0.10.18
dpkg -i nodejs_0.10.18-1_amd64.deb
```

# Problems

I'll try to help as much as I can, but this is just a little hack to save time,
and i'm just offering this tool to help. Try to understand what's going on 
before asking questions. You can likely figure it out yourself.

If not, feel free to file an issue if this doesn't work for you. Ideally, attach the
output of the .build file so I can see what's the error message.

# TODO

* Run builds in a temporary work dir
* Add verifications for files/dirs that already exist
* Verify the OS (linux, debian)

# Disclaimer

This repository does NOT contain node.js.
It simply contains some tools and a custom debian/ directory structure 
for generating a nice little deployable debian package containing a compiled
node.js based on the version you want.

I do not distribute node.js or any copyrighted code.

Using the tools in this repository are at your own risk.

# License

Licensed under the MIT license, see the LICENSE file.
