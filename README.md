# README

挫折乗り越えサロンのメンバー検索アプリです

## バージョン情報
- Ruby 2.6.6
- Rails 5.2.4
- MySQL 5.7

## 開発環境構築

### 前提条件
- Dockerがインストールされていること

### 環境構築手順

0. `$ cd /zasetsu_norikoe_app`
(リポジトリ直下へ移動)

1. `$ docker-compose build`

2. `$ docker-compose up -d`

3. `$ docker ps -a`でSTATUSがUpになっていることを確認
```shell
$ docker ps -a
CONTAINER ID   IMAGE                          COMMAND                  CREATED        STATUS                      PORTS                                                      NAMES
containerID  zasetsu_norikoe_app_app        "bundle exec rails s…"   10 hours ago   Up 29 seconds               0.0.0.0:3000->3000/tcp                                     rails524
containerID   mysql:5.7                      "docker-entrypoint.s…"   10 hours ago   Up 29 seconds               0.0.0.0:3306->3306/tcp, 33060/tcp                          mysql57
```

4. `$ docker-compose run app rails db:create`

5. `http://localhost:3000/`へアクセス

6. Yay! You’re on Rails!

## コード解析
**RuboCop**を使用して、静的コード解析（コーディング規約どおりに書かれているかをチェック）を行います。

### RuboCopを使ったコード修正手順
1. RuboCopで自動修正する
```shell
$ docker-compose exec app bundle exec rubocop -a
```

2. コーディング規約に違反しているコードがないかチェックする
```shell
$ docker-compose exec app bundle exec rubocop
```
3. 修正する
- エラーの内容はこちらを参考にしてください。
  - [RuboCopチートシート](https://qiita.com/tanish-kr/items/abb881c098b3df3f9871)
  
## ER図
[ER_Diagram](ER_Diagram.pdf)
    