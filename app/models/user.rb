class User < ApplicationRecord
	validates :first_name,
		presence: true,
		length: { minimum: 2 }
	validates :last_name,
		presence: true,
		length: { minimum: 2 }
	validates :description,
		length: { maximum: 500 }
	validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Email adress please" }
  validates :age,
  	presence: true,
  	numericality: { only_integer: true, greater_than: 18 }
  
	belongs_to :city
	has_many :gossips
	has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
	has_many :join_table_pm_recipients, foreign_key: 'recipient_id', class_name: "JoinTablePmRecipient"
	has_many :received_messages, through: :join_table_pm_recipients
	has_many :comments
	has_many :likes
end
