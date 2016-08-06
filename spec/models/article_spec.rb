require 'rails_helper'

describe Article do
  specify 'タイトル、本文、掲載開始日時は空であってはならない' do
    article = Article.new
    expect(article).to be_invalid
    expect(article.errors).to include(:title)
    expect(article.errors).to include(:body)
    expect(article.errors).to include(:released_at)
  end

  specify 'タイトルの長さは最大200文字' do
    article = FactoryGirl.build(:article)
    article.title = 'A' * 201
    expect(article).to be_invalid
    expect(article.errors).to include(:title)
  end

  specify '掲載終了日時に関するバリデーション' do
    article = FactoryGirl.build(:article)
    article.released_at = Time.current
    article.expired_at = 1.days.ago
    expect(article).to be_invalid
    expect(article.errors).to include(:expired_at)
  end

  specify 'no_expirationがオンならexpired_atを使わない' do
    article = FactoryGirl.build(:article)
    article.no_expiration = true
    expect(article).to be_valid
    expect(article.expired_at).to be_nil
  end

  specify 'openスコープのチェック' do
    article1 = FactoryGirl.create(:article, title: "現在",
      released_at: 1.day.ago, expired_at: 1.day.from_now)
    article2 = FactoryGirl.create(:article, title: "過去",
      released_at: 2.days.ago, expired_at: 1.day.ago)
    article3 = FactoryGirl.create(:article, title: "未来",
      released_at: 1.day.from_now, expired_at: 2.days.from_now)
    article4 = FactoryGirl.create(:article, title: "終了日なし",
      released_at: 1.day.ago, expired_at: nil)

    articles = Article.open
    expect(articles).to include(article1), "現在の記事が含まれる"
    expect(articles).not_to include(article2), "過去の記事は含まれない"
    expect(articles).not_to include(article3), "未来の記事は含まれない"
    expect(articles).to include(article4), "expiredがnilの場合"
  end
end
