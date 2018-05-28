class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password
  has_many :posts

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password, confirmation: true

  def self.authenticate(email, password)
      user = find_by_email(email)
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      else
        nil
      end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.search(query)
    where("name like ?", "%#{query}%")
  end
end
