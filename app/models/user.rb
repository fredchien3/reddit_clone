class User < ApplicationRecord
  attr_reader :password
  validates_presence_of :username, :password_digest
  validates_length_of :password, minimum: 6, allow_nil: true # the missing piece
  after_initialize :ensure_session_token

  has_many :subs
  has_many :posts
  has_many :comments

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password) # class method
    user = User.find_by(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.session_token = User.generate_new_token
    self.save!
    self.session_token
  end

  def self.generate_new_token
    SecureRandom::urlsafe_base64
  end
  
  def ensure_session_token
    self.session_token ||= User.generate_new_token
  end
end
