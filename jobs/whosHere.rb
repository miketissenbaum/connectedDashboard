require 'rubygems'
require 'json'
require 'pp'

# name_list = Hash.new({ value: 0 })
event_data = Hash.new({ value: 0 })

SCHEDULER.every '10s' do
	json = File.read('/Users/research/inoutdash/sweet_dashboard_project/jobs/list.json')
	response = JSON.parse(json)
	# event_data[response] = {label: response.keys, value: response.values}
	event_data = response.map{|who,status| {label: who, value: status} }
	puts event_data
	send_event('whosHere', items: event_data)
	puts send_event
	# puts response.keys
	# puts response.values
end
