require_relative '../modules/generator'
# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
date = Generator.generate_date(30)
plan = Generator.generate_data(30,45,30)
finishcapicity = Generator.generate_data(30,50.0,30.0)
miscapicity = Generator.generate_rate_data(finishcapicity,0.03,0.02)

SCHEDULER.every '10s', :first_in => 0 do |job|
  #Generator.generate_capicity(10,50.0,30.0,0.03,0.02,45,30)
  send_event('widget_id', {date:date,plan:plan,truecapicity:finishcapicity,miscapicity:miscapicity })
end