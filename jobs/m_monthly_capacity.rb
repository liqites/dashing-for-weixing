require_relative '../modules/generator'
# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
data = Generator.generate_capicity(30,50.0,30.0,0.03,0.02,45,30)
SCHEDULER.every '10s', :first_in => 0 do |job|
  #Generator.generate_capicity(10,50.0,30.0,0.03,0.02,45,30)
  send_event('widget_id', {date:data["date"],plan:data["approvecapcity"],truecapicity:data["finishcapicity"],miscapicity:data["miscapicity"] })
end