class User < ApplicationRecord
    has_many :reservations, foreign_key: 'guest_id'
    has_many :housings, foreign_key: 'admin_id'
    belongs_to :city
    validates :email, 
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" },
    presence: true, uniqueness: true
    validates :phone_number, format: {with: /\A+[0-9]+\z/}
end