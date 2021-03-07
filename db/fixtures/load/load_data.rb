# frozen_string_literal: true

# このファイルでseedデータを一括管理している
# 各seedファイルを"db/fixtures/_master"(マスターデータ用)に"db/fixtures/_develop"(開発データ用)に
# 追加したら、このファイルに指定すること
# https://github.com/mbleigh/seed-fu
# https://qiita.com/ko2ic/items/be96e450a33d631e0059
# https://dev.classmethod.jp/articles/rails-seed-fu-gem/

# seedデータの取り込みコマンド
# bundle exec rake db:seed_fu FIXTURE_PATH=db/fixtures/load

master_fixture_path = 'db/fixtures/_master'
develop_fixture_path = 'db/fixtures/_develop'
# demo_fixture_path = "db/fixtures/demo"

# master data
run_file("#{master_fixture_path}/skill_categories.rb")
run_file("#{master_fixture_path}/skill_sets.rb")

if Rails.env.development?
  # development data
  run_file("#{develop_fixture_path}/users.rb")
  run_file("#{develop_fixture_path}/user_and_skill_category_relationships.rb")
  run_file("#{develop_fixture_path}/user_and_skill_set_relationships.rb")
end
