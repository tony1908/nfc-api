class PayController < ApplicationController
	def pagar
		@account = Account.where(user_id:params[:user])
		descon = params[:precio]
		saldo = @account.cantidad - descon.to_i
		if saldo > 0
			
		else
			
		end
	end
end
