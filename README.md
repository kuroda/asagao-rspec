# 『改訂3版 基礎 Ruby on Rails』7章のテストをRSpec/Capybaraで書き直す

https://github.com/oiax/asagao4/tree/master/chapter7 をベースとする。

## Rails を 4 系の最新版に

* `rails` を 4.2.7 にアップデート
* `sass-rails` を 5.0.6 にアップデート

## RSpec と Capybara の導入

`Gemfile` の 48-50 行を書き換え。

```ruby
group :test do
  gem 'factory_girl_rails', '~> 4.4.0'
  gem 'rspec-rails'
  gem 'capybara'
end
```

ターミナルで以下のコマンドを実行。

```text
$ bundle
$ bundle binstubs rspec-core
$ rails g rspec:install
```

`config/initializers/generators.rb` を書き換え。

```ruby
Rails.application.config.generators do |g|
  g.helper false         # ヘルパーを生成しない
  g.assets false         # CSS, JavaScript ファイルを生成しない
  g.skip_routes true     # config/routes.rb を変更しない
  g.test_framework 'rspec'
end
```

## factories を test/ から spec/ へ移動

```text
$ mv test/factories spec/
```

## test/models のテストを書き換える

* `article_spec.rb`
* `member_spec.rb`
