# frozen_string_literal: true

require "securerandom"

# ジョブ
15.times do |n|
  if n == 0
    Job.create!(
      name: "テストジョブ_#{n}"
    )
  else
    Job.create!(
      name: "テストジョブ_#{n}",
      ancestry: "1"
    )
  end
end

# カテゴリ
15.times do |n|
  if n == 0
    Category.create!(
      name: "テストカテゴリー_#{n}"
    )
  else
    Category.create!(
      name: "テストカテゴリー_#{n}",
      ancestry: "1"
    )
  end
end

# ユーザー
10.times do |n|
  user = User.new(
    name: "テストユーザー_#{n}",
    description: "テスト概要\r\nテスト概要\r\nテスト概要",
    main_image_url: "",
    thumb_image_url: ""
  )

  # ユーザーログイン
  user.build_user_login(
    email: "yukke5222@gmail.com",
    password_digest: SecureRandom.hex(10),
    last_logged_in_at: Time.zone.now
  )

  # ソーシャル
  user.build_social(
    twitter_id: "yu_yukke"
  )

  user.save!

  # 問い合わせ
  3.times do |m|
    user.inquiries.create!(
      text: "テスト問い合わせ\r\nテスト問い合わせ"
    )
  end

  # ジョブマッピング
  user.job_mappings.create!(
    job_id: "#{n.odd? ? 2 : 3}"
  )

  # アセット
  5.times do |l|
    user.assets.create!(
      name: "テストアセット_#{n}#{l}",
      url: "https://community.camp-fire.jp/projects/view/89453",
      image_url: "hogehoge"
    )
  end

  # タグ
  5.times do |o|
    user.tags.create!(
      name: "テストタグ_#{n}#{o}"
    )
  end
end

# 作品
20.times do |n|
  product = Product.new(
    category_id: "#{n.odd? ? 1 : 2}",
    name: "テスト作品_#{n}",
    description: "テスト概要\r\nテスト概要\r\nテスト概要"
  )

  # 作品イメージ
  5.times do |m|
    product.image_files.new(
      sequence: m + 1,
      image_url: "hogehoge",
      video_id: ""
    )
  end

  product.save!

  # タグマッピング
  3.times do |l|
    product.tag_mappings.create!(
      tag_id: l + 1
    )
  end

  # アセットマッピング
  3.times do |o|
    product.asset_mappings.create!(
      asset_id: o + 1
    )
  end

  # お気に入り
  User.all.each_with_index do |user, i|
    user.favorites.create!(
      product_id: product.id
    )

    user.creator_mappings.create!(
      product_id: product.id,
      is_author: "#{i == 0 ? 1 : 0}"
    )
  end
end
