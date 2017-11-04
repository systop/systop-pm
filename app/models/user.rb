class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :lockable,
         :timeoutable
         #:omniauthable
  validates :name, presence: true
  validates :timezone, presence: true
  #check that value is time zone (from array)
  paginates_per 12

  has_many :roles
  has_many :projects, :through => :roles
  has_many :updates
end
