FROM ruby:2.7.5

# yarnパッケージ管理ツールをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

RUN apt-get update -qq && apt-get install -y nodejs yarn
RUN mkdir /virtual_credit_api
WORKDIR /virtual_credit_api
COPY Gemfile /virtual_credit_api/Gemfile
COPY Gemfile.lock /virtual_credit_api/Gemfile.lock
RUN bundle install
COPY . /virtual_credit_api

RUN yarn install --check-files
RUN bundle exec rails webpacker:compile

# コンテナ起動時に実行させるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 4000

# Rails サーバ起動
CMD ["rails", "server", "-b", "0.0.0.0"]
