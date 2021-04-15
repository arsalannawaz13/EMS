class User < ApplicationRecord
  validates :full_name, presence: true
  validates :password, length: {minimum: 8}, format:{with: /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/}
  validates :full_name, presence: true
  
  # Include default devise modules. Others available are:
  # :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :lockable, :confirmable

  attr_writer :login

  def login
    full_name || email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(full_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:login].nil?
        where(conditions).first
      else
       where(login: conditions[:login]).first
      end
    end
  end
end
