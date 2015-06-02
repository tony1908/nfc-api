class PayController < ApplicationController
	require 'rubygems' 
	require 'twilio-ruby'
	account_sid = ''
	auth_token = ''
	@client = Twilio::REST::Client.new account_sid, auth_token
	Twilio.configure do |config|
		config.account_sid = account_sid
		config.auth_token = auth_token
	end
	def pagar
		@device = Device.find_by_device_t(params[:device])
		@account = Account.where(user_id:@device.user)
		descon = params[:precio]
		saldo = @account.cantidad - descon.to_i
		if saldo > 0
			@account.cantidad = saldo
			@record = Record.new
			@record.user = @account.user
			@record.cantidad =params[:precio]
			@record.lugar = params[:lugar]
			@record.device = @device.id
			if @record.save
				user = User.find(@device.user)
				registration_ids = user.push
				gcm = GCM.new("")
			    options = {data: {mensaje: "Nueva Pago Realizado", subtitulo: "Pago en: " + @record.lugar}}
				response = gcm.send(registration_ids, options)

				
				@client = Twilio::REST::Client.new
				@client.messages.create(
				  from: '+14159341234',
				  to: '+16105557069',
				  body: 'Hey there!'
				)

			else
				render json: => {status: 2}
			end
		else
			render json: => {status: 1}
		end
	end
end
