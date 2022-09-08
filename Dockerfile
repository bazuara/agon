FROM ruby:3.0
ADD . /app
WORKDIR /app
RUN bundle install
CMD ["ruby", "web.rb", "-o", "0.0.0.0"]