require File.expand_path('../boot', __FILE__)

@rubytter = OAuthRubytter.new(@access_token)
friends_ids = @rubytter.friends_ids nil
followers_ids = @rubytter.followers_ids nil
followings_ids = friends_ids - followers_ids
p followings_ids
followings_ids.each do |i|
	user = @rubytter.user(i)
	p user.screen_name
	p user.description
	p @rubytter.leave(i)
end
