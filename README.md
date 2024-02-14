# graffity_skill_test

## 技術スタック
Rubyのバージョン: 3.0.0
Railsのバージョン: 6.1.3
データベース: MySql8.0
## マイグレーション
gemのridgepoleを使っているので、マイグレーションはdocker-composeを立ち上げた状態で、下記のコマンドを打ってください
`docker exec skill_test-api-1 bundle exec ridgepole -c config/database.yml --apply`