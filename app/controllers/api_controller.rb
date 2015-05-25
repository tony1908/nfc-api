class ApiController < ApplicationController
	respond_to :json
	 rescue_from(ActiveRecord::RecordInvalid) do |invalid|
	 response = {status: 'error', fields: invalid.record.errors}
	 render json: response, status: :unprocesaable_entity
	 end
	 rescue_from(ActiveRecord::RecordNotFound) do |invalid|
	 response = {status: 'error', fields: 'registro no encontrado'}
	 render json: response, status: :unprocesaable_entity
	 end
	def index
		 render json: {mensaje:"hola"}
	end
end
