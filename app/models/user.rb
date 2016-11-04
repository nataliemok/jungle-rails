class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  before_save :downcase_email

   EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
   validates :first_name, :presence => true, :length => { :in => 3..20 }
   validates :last_name, :presence => true, :length => { :in => 3..20 }
   validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
   validates :password, :confirmation => true
   validates_length_of :password, :in => 6..20, :on => :create

   def downcase_email
     self.email.downcase!
   end
end
