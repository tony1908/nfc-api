class ApiController < ApplicationController
	before_action :check_auth, only:[:index]
	before_action :validar_token, only:[:pagos]
	respond_to :json
	 rescue_from(ActiveRecord::RecordInvalid) do |invalid|
	 response = {status: 'error', fields: invalid.record.errors}
	 render json: response, status: :unprocesaable_entity
	 end
	 rescue_from(ActiveRecord::RecordNotFound) do |invalid|
	 response = {status: 'error', fields: 'registro no encontrado'}
	 render json: response, status: :unprocesaable_entity
	 end

	 def validar_token
	 	token = params[:token]
	 	user = User.find_by_sign_token(token)
	 	if user.blank?
	 		
	 	 	render json: {status: 1}
	 	else
	 		sign_in :user, user
	 		$current_user = user
	 		
	 	end
	 end

	 def check_auth
    authenticate_or_request_with_http_basic do |username,password|
      resource = User.find_by_email(username) 
      if resource != nil
        if resource.valid_password?(password)
        sign_in :user, resource
        $identi = resource
        else
          render :json => {status: 0}
        end
      else
        render :json => {status: 2}
      end
      
      end
  end
	 
	def index
		 render json: {toke:$identi.sign_token}
	end

	def resgistrar
		user = User.new user_params
		user.sign_token = SecureRandom.hex(5)
		if user.save
			render :json => user.as_json(:email=>user.email), :status=>201
	      return
		else
	      warden.custom_failure!
	      render :json => manager.errors, :status=>422
	    end
	end

	def pagos
		#render :json => {message2: $current_user.id}
		respond_with $current_user.records
	end

	protected
	def user_params
		params.require(:user).permit(:email, :password)
	end
end
