FROM jekyll/jekyll
MAINTAINER Jeremías Casteglione <jrmsdev@gmail.com>

RUN gem install github-pages

COPY --chown=jekyll:jekyll Gemfile /srv/jekyll/

RUN cd /srv/jekyll && jekyll build

RUN rm -vf /srv/jekyll/Gemfile
