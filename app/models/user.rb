class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
     #:confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
            :lockable, :trackable
      has_many :articles, dependent: :destroy
      before_save {self.email = email.downcase}
     # validates :username, presence: true, uniqueness: {case_sesitive: false}, length: {minimum: 3, maximum: 25}
      VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      validates :email, presence: true, length: {maximum: 105}, uniqueness: {case_sensitive: false}, 
      format: {with: VALID_EMAIL_REGEX}
       has_secure_password
       alias_attribute :password_digest, :encrypted_password
  end