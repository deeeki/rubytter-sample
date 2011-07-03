require File.expand_path('../boot', __FILE__)

@rubytter = OAuthRubytter.new(@access_token)
nc = -1
begin
	lm = @rubytter.list_members('deeeki', 'watching', :cursor => nc)
	nc = lm.next_cursor
	lm.users.each do |u|
		p @rubytter.remove_member_from_list('deeeki', 'watching', u.id)
	end
end until nc.zero?
