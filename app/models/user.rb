require 'digest/sha1'

class User < ActiveRecord::Base
  
  attr_accessor :password
  
  has_many :events,
#           .order("occurs_on DESC"),
#           .order("title ASC"),
           :dependent => :destroy
  has_many :registrations,
           :dependent => :destroy
  has_many :activities, :through => :registrations, :source => :event
  
  
  
  validates_presence_of    :login
  validates_length_of      :login,     :within => 3..40
  validates_uniqueness_of  :login,     :case_sensitive => false
  validates_format_of      :login,     :with => /\A[\w.-]+\z/i
  
  validates_presence_of    :email
  validates_format_of      :email,     :with => /\A[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}\z/i
  
  validates_presence_of     :password, :if => :password_required?
  validates_length_of       :password, :within => 4..40 , :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  
  before_save :encrypt_new_password
  
  def self.authenticate(login,password)
    user = find_by_login(login)
    return user if user && user.authenticated?(password)
  end
  
  def authenticated?(password)
    hashed_password == encrypt(password)
  end
   
  def password_required?
    hashed_password.blank? || !password.blank?
  end
   
  def encrypt(string)
    Digest::SHA1.hexdigest(string)
  end
  
  protected 
    def encrypt_new_password
      return if password.blank?
      self.hashed_password = encrypt(password)
    end
  
  
   
#  validates_acceptance_of :terms_of_service
end
