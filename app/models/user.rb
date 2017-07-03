class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { email.downcase! }
  #[name] Confirm existence,Maximum 50 characters
  validates:name,  presence:true, length: { maximum: 50 }
  
  #Assign normalized expression to constant
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #[email] Confirm existence,Maximum 255 characters, Confirm format, 
  
  validates:email, presence:true, length: { maximum: 255 },
             format:{ with: VALID_EMAIL_REGEX },
             uniqueness:{ case_sensitive: false }
  has_secure_password
  validates:password, presence: true, length: {minimum: 6 }, allow_nil: true
  
  #Returns the hash value of the passed in string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  #Return random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  #Store users in the database for persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  #Returns true if the passed token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  #Discard the user's login information
  def forget
    update_attribute(:remember_digest, nil)
  end
end