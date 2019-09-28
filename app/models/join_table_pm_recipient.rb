class JoinTablePmRecipient < ApplicationRecord
	belongs_to :received_message, class_name: "PrivateMessage"
	belongs_to :recipient, class_name: "User"
end
