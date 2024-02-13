FROM ruby:3.2.2
# RUN apt-get update -qq && apt-get install -y postgresql-client
WORKDIR /skill_test

# nodejsのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs

# yarnのインストール
RUN npm install --global yarn

# gemの設定
COPY Gemfile* /skill_test/
RUN bundle install

# 実行権限の付与とポートの開放
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# コンテナ外からの接続の受け入れ
CMD ["rails", "server", "-b", "0.0.0.0"]