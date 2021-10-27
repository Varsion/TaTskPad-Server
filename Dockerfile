###                    ###
# build TaTsk Pad Server #
###                    ###
FROM ruby:3.0.1

LABEL Name=tatskpadserver Version=0.0.1

EXPOSE 3003


WORKDIR /home/app
RUN gem install bundler:2.2.19 --no-document

RUN bundle config set deployment true
RUN bundle config set without 'development test'
ADD Gemfile /home/app/Gemfile
ADD Gemfile.lock /home/app/Gemfile.lock
RUN bundle install --jobs 16


RUN mkdir -p /home/nginx
ADD docker/nginx.conf /home/nginx/app.conf


RUN bundle install


