class User < ApplicationRecord
  validates :full_name, presence: true
  validates :password, length:{minimum: 8}, format:{with: /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/}
  validates :full_name, presence: true, uniqueness: { case_sensitive: false }
  # Include default devise modules. Others available are:
  # :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :lockable, :confirmable

  attr_writer :login

  def login
    @login || self.full_name || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(full_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:full_name) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end
end
