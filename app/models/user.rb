class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  # Lines 4-5 were modified as follows:
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  # the below was added later:
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

end
