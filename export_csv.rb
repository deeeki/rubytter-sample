require File.expand_path('../boot', __FILE__)

@rubytter = OAuthRubytter.new(@access_token)
attrs = [
	:id,
	:screen_name,
	:name,
	:friends_count,
	:followers_count,
	:listed_count,
	:favorites_count,
	:location,
	:description,
	:url,
	:profile_image_url,
]
nc = -1
begin
	friends = @rubytter.friends(nil, :cursor => nc)
	nc = friends.next_cursor
	friends.users.each do |u|
		outs = []
		attrs.each do |attr|
			outs << u.send(attr).to_s.gsub(/"/, '""')
		end
		print '"' + outs.join("\",\"") + '"'
		print "\r\n"
	end
end until nc.zero?
