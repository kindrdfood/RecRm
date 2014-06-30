class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

  	

	def after_sign_in_path_for(resource)
		if resource.class == User
		    if resource.sign_in_count <= 1
		      # if first time give first time user experience
		      home_path
		    else
		      # if not take them to their home page
		      home_path
		    end
		elsif resource.class == Dietitian
				if resource.sign_in_count <= 1
		      # if first time give first time user experience
		      # would rather it direct to dietitian_authenticated_root_path but failing
		      ### dietitian_authenticated_root_path(current_dietitian)
		      ### dietitian_authenticated_root_path
					dietitian_recipes_path(current_dietitian)
		    else
		      # if not take them to their home page
					dietitian_recipes_path(current_dietitian)
		    end
		end

	end

end
