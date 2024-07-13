class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email.downcase! }
  # REMIND: 仮想passwordカラムはバリデーションでも使用可能
  validates :password,
    presence: true,
    length: { minimum: 8 }

  # SEARCH: regexを理解する
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: true

  has_many :environments
  has_many :shortcuts, through: :environments
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(User.new_token))
  end

  # 渡されたトークンが正しければtrueを返す
  # SEARCH: 動作原理は
  # def authenticated?(remember_token)
  #   return false if self.remember_digest.nil?
  #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
  # end

  # source code
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest)#.is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
