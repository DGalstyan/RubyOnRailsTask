class User < ApplicationRecord
  has_and_belongs_to_many :forecasts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable
  before_save :ensure_authentication_token
end
