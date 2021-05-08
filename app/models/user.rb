class User < ApplicationRecord
  has_many :orders

  validates :full_name, presence: true
  validates :password, format: {with: /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/}
  # Include default devise modules. Others available are:
  # :timeoutable, and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :lockable, :confirmable

  attr_writer :login

  def login
    full_name || email
  end

  def self.search(term)
    if term
      where("lower(full_name) LIKE ? or lower(email) LIKE ? or lower(admin) LIKE ?", "%#{term}%", "%#{term}%", "%#{term}%")
    else
      all
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(full_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:full_name].nil?
        where(conditions).first
      else
       where(full_name: conditions[:full_name]).first
      end
    end
  end
end
