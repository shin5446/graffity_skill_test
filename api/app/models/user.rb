class User < ApplicationRecord
  include Redis::Objects

  # パスワードのハッシュ化
  has_secure_password

  # メールアドレスのバリデーション
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }

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

  private

  # メールアドレスをすべて小文字にする
  def downcase_email
    self.email.downcase!
  end
end
