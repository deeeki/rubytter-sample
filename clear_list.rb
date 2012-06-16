require File.expand_path('../boot', __FILE__)

@rubytter = OAuthRubytter.new(@access_token)
owner_name = 'deeeki'
list_name = 'geek'

nc = -1
begin
  lm = @rubytter.list_members(owner_name, list_name, :cursor => nc)
  nc = lm.next_cursor
  lm.users.each do |u|
    p @rubytter.post('/lists/members/destroy', {:slug => list_name, :owner_screen_name => owner_name, :user_id => u.id})
  end
end until nc.zero?
