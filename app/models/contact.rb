class Contact < ActiveRecord::Base
  # Conatct form validations
  validates :name, presence: true
  validates :email, presence: true
  validates :comments, presence: true
  
end
