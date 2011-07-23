# coding: utf-8
require File.expand_path('../boot', __FILE__)

YAML::ENGINE.yamler = 'psych'

Dir.mkdir('tmp') unless File.directory?('tmp')
d = Date.today
today = 'tmp/' + d.to_s
yesterday = 'tmp/' + (d - 1).to_s
past = File.exists?(yesterday) ? YAML.load_file(yesterday).map {|l| l[:full_name]} : []

@rubytter = OAuthRubytter.new(@access_token)

keys = [:full_name, :description, :member_count, :subscriber_count]
results = []
nc = -1
begin
	lists = @rubytter.lists_followers('deeeki', :cursor => nc)
	nc = lists.next_cursor
	lists.lists.each do |l|
		results << keys.inject({}) {|ret, key| ret[key] = l.send(key); ret}
	end
end until nc.zero?
current = results.map {|l| l[:full_name]}

puts "#{d - 1} > #{d}"
puts "\n##### removed #####\n"
(past - current).each do |l|
	puts l
end
puts "\n##### added #####\n"
(current - past).each do |l|
	puts l
end

File.open(today, 'w') {|f| f.puts results.to_yaml}
