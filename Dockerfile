FROM ruby:2.7.0

# Rails6からJSのコンパイラがwebpackerになったからそれに必要なyarnをインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /Rails6_on_Docker
WORKDIR /Rails6_on_Docker
COPY Gemfile /Rails6_on_Docker/Gemfile
COPY Gemfile.lock /Rails6_on_Docker/Gemfile.lock
RUN bundle install
COPY . /Rails6_on_Docker

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
