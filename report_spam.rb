require File.expand_path('../boot', __FILE__)

#require code below into gem
#report_spam             /report_spam                    post
@rubytter = OAuthRubytter.new(@access_token)
nc = -1
success, error = 0
begin
	followers = @rubytter.followers(nil, :cursor => nc)
	nc = followers.next_cursor
	followers.users.each do |u|
		next if u.friends_count < 5000
		p u.screen_name
		p u.friends_count
		begin
			success += 1 if @rubytter.report_spam(:id => u.id)
			p 'success'
			p success
		rescue
			p 'error'
			p error += 1
		end
	end
end until nc.zero?
