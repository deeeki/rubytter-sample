require File.expand_path('../boot', __FILE__)

@rubytter = OAuthRubytter.new(@access_token)
friends_ids = @rubytter.friends_ids(nil, :cursor => -1).ids
followers_ids = @rubytter.followers_ids(nil, :cursor => -1).ids
followings_ids = friends_ids - followers_ids
p followings_ids
followings_ids.each do |id|
  user = @rubytter.user(id)
  @rubytter.leave(id)
  puts user.screen_name, user.description
  puts
end
