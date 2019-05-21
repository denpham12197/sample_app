class User < ApplicationRecord
  before_save{self.email = email.downcase}
  validates :name,  presence: true, length: {maximum: Setting.User.name_lenght}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Setting.User.email_lenght},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Setting.User.password_lenght}
end
