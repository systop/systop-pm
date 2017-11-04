class AdminSetting < ApplicationRecord
  validates :title, :value, presence: true

  validates :title, format: { with: /\A[a-zA-Zs\s]+\z/,
    message: "only allows letters" }

  validates :title, length: { in: 4..20 }

  validates :value, uniqueness: true
  #validates :value, presence: true
  #add bad symbols validation yes
end
