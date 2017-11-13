class TransactionController < ApplicationController

	def generate
		@random = "VISIT"+Random.rand(1..9).to_s+Random.rand(1..9).to_s+Random.rand(1..9).to_s+Random.rand(1..9).to_s+
				  "-"+Random.rand(1..9).to_s+Random.rand(1..9).to_s+Random.rand(1..9).to_s+Random.rand(1..9).to_s+
				  "-"+Random.rand(1..9).to_s+Random.rand(1..9).to_s+Random.rand(1..9).to_s+Random.rand(1..9).to_s+
				  "-"+Random.rand(1..9).to_s+Random.rand(1..9).to_s+Random.rand(1..9).to_s+Random.rand(1..9).to_s
		@transaction = current_user.transactions.build(:name => @random,:user_id => current_user.id)
		@transaction.save
		current_user.update(:transactionid => @transaction.id)

		redirect_to :edit_user_registration
	end
end
