require 'rubygems'
require 'json'
require 'pp'
require 'httparty'

# name_list = Hash.new({ value: 0 })
event_data = Hash.new({ value: 0 })



SCHEDULER.every '10s' do
	locationresponse = HTTParty.post('https://hidden-springs-6751.herokuapp.com/getStatus.json',
	:body => {"location" => "Room 150"})

	puts locationresponse.body #this must show the JSON contents
	# json = File.read('/Users/research/inoutdash/sweet_dashboard_project/jobs/list2.json')
	# response = JSON.parse(json)
	# event_data = response.map{|who,status| {label: who, value: status} }
	response = JSON.parse(locationresponse.body)
	puts response
	event_data = response["Members"].map{ |who, status| {label: who, value: status }}
	puts event_data
	send_event('whosHere2', items: event_data)
	puts send_event
	# puts response.keys
	# puts response.values
end
