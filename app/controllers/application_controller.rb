class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :set_search

	protected

	def configure_permitted_parameters
		added_attrs = [:first_name, :last_name, :rubi_first_name, :rubi_last_name, :birthdate, :postcode, :address, :tel, :email, :password, :password_confirmation]
		devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
	end

	def  set_search
    	@search = Item.includes(:artist).ransack(params[:q])
    	@search_items = @search.result(distinct: true).order(id: :desc)
    	@genres = Genre.all
    end



end

