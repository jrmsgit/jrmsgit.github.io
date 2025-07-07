#!/bin/sh
set -eu
exec docker run -it --rm -u devel \
	--name jrmsgit-site \
	--hostname jrmsgit.local \
	-v "${PWD}:/opt/jrmsgit/site" \
	--workdir /opt/jrmsgit/site \
	-p 127.0.0.1:8045:8045 \
	jrmsgit/site
