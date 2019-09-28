class PrivateMessage < ApplicationRecord
	validates :content,
		presence: true

	belongs_to :sender, class_name: "User"
	has_many :join_table_pm_recipients, foreign_key: 'received_message_id', class_name: "JoinTablePmRecipient"
	has_many :recipients, through: :join_table_pm_recipients
end
