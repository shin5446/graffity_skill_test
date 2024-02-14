class User < ApplicationRecord
  include Redis::Objects

  # リレーション
  has_many :consume_items, as: :itemable
  has_many :weapon_items, as: :itemable

  # パスワードのハッシュ化
  has_secure_password

  # メールアドレスのバリデーション
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: Constant::VALID_EMAIL_REGEX }

  # 名前のバリデーション
  validates :name, presence: true, length: { maximum: 50 }

  # パスワードのバリデーション
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # メールアドレスを小文字に変換するコールバック
  before_save :downcase_email

  # Redisにセッショントークンを保存するためのvalue定義
  value :session_token

  # セッショントークンを生成して保存するメソッド
  def generate_session_token
    token = SecureRandom.hex(64)
    self.session_token = token
    token
  end

  # アイテムを付与するメソッド
  def add_item(item_type, item_id)
    case item_type
    when Constant::ITEM_TYPES[:consume_item]
      item = ConsumeItem.find_by(id: item_id)
    when Constant::ITEM_TYPES[:weapon_item]
      item = WeaponItem.find_by(id: item_id)
    else
      return nil
    end

    item.update(itemable: self) if item.present?
    item
  end

  private

  # メールアドレスをすべて小文字にする
  def downcase_email
    self.email.downcase!
  end
end
