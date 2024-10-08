FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y ruby-full build-essential zlib1g-dev && \
    apt-get clean

WORKDIR /site

RUN gem install jekyll bundler

COPY jekyll_site /site

RUN bundle install

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]