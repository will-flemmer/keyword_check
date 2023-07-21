FROM ruby:alpine3.12

RUN gem install bundler -v 2.3.4

COPY . .

RUN bundle


CMD ["/bin/bash"]