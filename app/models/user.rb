class User < ActiveRecord::Base

  before_save {self.email = email.downcase}

  VALID_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50 }

  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEXP}, uniqueness: { case_sensitive: false }

  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCRYPT::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
