class OauthController < ApplicationController

	def index
		@redirect_uri = request.original_url
		@auth_code = params[:authorization_code]
		if session[:access_token]
			@access_token = session[:access_token]
		else	
			@access_token=cookies[:remember_token]
			session[:access_token]=@access_token	
		end	

		if @access_token
			generate_access_req
     		get_user
     		@username=@user['username'].downcase
     		if @access_token
	     		session[:username]=@username
	     		session[:user_id]=@user['id']  
	     		@student=User.find_by_username(@user['username'])
	     		@student.update('remember_token'=>@access_token)
	     		cookies.permanent[:remember_token] = @student.remember_token 		    
	     	end	
		elsif  @auth_code
			   	generate_token_req
      			get_token
      			session[:access_token] =@access_token
   				redirect_to  @redirect_uri


		else
			generate_auth_req
		      if($PRIVATE_SITE) 

		       redirect_to @auth_url
		      
		      else 
		        @signin_url = @auth_url
      		  end

		end


	end

	def signout
		@redirect_uri=params[:path]
		session.delete(:access_token)
		cookies.delete :remember_token
		@signout = $AUTH_SERVER +$CMD_SIGNOUT + "?response_type="+ $RESPONSE_TYPE +"&client_id=" +$CLIENT_ID +"&redirect_uri="+@redirect_uri +"&scope="+ $SCOPE +"&state=" +$STATE
		redirect_to @signout
	end


end
