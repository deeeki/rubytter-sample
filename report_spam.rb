require File.expand_path('../boot', __FILE__)

@rubytter = OAuthRubytter.new(@access_token)
nc = -1
success, error = 0
begin
	followers = @rubytter.followers(nil, :cursor => nc)
	nc = followers.next_cursor
	followers.users.each do |u|
		next if u.friends_count < 5000
		p f.screen_name
		p f.friends_count
		begin
			success += 1 if @rubytter.report_spam(:id => f.id)
			p 'success'
			p success
		rescue
			p 'error'
			p error += 1
		end
	end
end until nc.zero?
