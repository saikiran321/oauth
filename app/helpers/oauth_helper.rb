module OauthHelper


$CLIENT_ID='labodi'
$CLIENT_SECRET= '0vtP5YxdUwv3njI4ucejheSK78YFBY5CuyszxZMr'
$RESPONSE_TYPE='code'
$GRANT_TYPE='authorization_code'
$SCOPE= 'profile'
$STATE= ''
$AUTH_SERVER= 'http://students.iitm.ac.in/oauth/'
$CMD_AUTHORIZE='authorize/'
$CMD_SIGNOUT='signout/'
$CMD_REQUEST_TOKEN='request_token/'
$CMD_REQUEST_ACCESS='request_access/'
$PRIVATE_SITE=false
	

  	def generate_auth_req 
    	@auth_url = $AUTH_SERVER + $CMD_AUTHORIZE + "?response_type="+ $RESPONSE_TYPE +"&client_id=" + $CLIENT_ID + "&redirect_uri=" + @redirect_uri + "&scope="+ $SCOPE + "&state=" + $STATE
	end
  

  	def generate_token_req 
    	@token_url = $AUTH_SERVER + $CMD_REQUEST_TOKEN + "?client_id=" + $CLIENT_ID + "&client_secret=" + $CLIENT_SECRET + "&grant_type=" + @redirect_uri + "&authorization_code="+ @auth_code
	end
  

  	def generate_access_req 
    	@access_url = $AUTH_SERVER + $CMD_REQUEST_ACCESS + "?client_id=" + $CLIENT_ID + "&client_secret=" + $CLIENT_SECRET + "&access_token=" +@access_token
  	end

  	def get_token 
	   
	    require 'json'
		require 'open-uri'
		@file = JSON.parse open(@token_url).read
		@access_token=@file['access_token']
   
		end

  	def get_access_token 
    	@access_token = session[:access_token]
  	end

	def has_access_token 
	    if (@access_token) 
	      return true
	    else
	      return false
	  	end
	end	

    def has_auth_code 
    	if(@auth_code) 
      	 return true
    	else
      	return false
    	end	
  	end

 
  
	def get_user 
	  	require 'json'
		require 'open-uri'
		@user = JSON.parse open(@access_url).read
		
	end

end

