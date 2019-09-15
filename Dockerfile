FROM ruby:2.6.3-alpine

RUN gem install redis
RUN gem install sinatra

RUN mkdir -p /app
WORKDIR /app
ADD . /app

EXPOSE 4567
ENV RACK_ENV=production
CMD [ "ruby", "main.rb" ]