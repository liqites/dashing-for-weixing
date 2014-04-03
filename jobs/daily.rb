require_relative '../modules/generator'
# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
################
#所有的daily
################
#@@ 金属闭口实际生产量
mentalclose_trueoutput = 0
#@@ 金属开口实际生产量
mentalopen_trueoutput = 0
#@@ 订单分数
order_daily_num = 0
#@@ 订单数量
order_daily_sum = 0
#@@ 当前采购金额
order_buy = 0
#@@ 当前收费金额
order_fee = 0

SCHEDULER.every '5s', :first_in => 0 do |job|
  mentalclose_trueoutput = Generator.generate_single_value(mentalclose_trueoutput,10,2)
  mentalopen_trueoutput = Generator.generate_single_value(mentalopen_trueoutput,8,2)
  order_daily_num = Generator.generate_single_value(order_daily_num,2,1)
  order_daily_sum = Generator.generate_single_value(order_daily_sum,40,10)
  order_buy = Generator.generate_single_value(order_buy,200,20)
  order_fee = Generator.generate_single_value(order_fee,200,20)
  #

  send_event('metalclose_output', { outpu_daily:mentalclose_trueoutput})
  send_event('metalopen_output', { output_daily:mentalopen_trueoutput})
  send_event('order_daily_num', {value:order_daily_num })
  send_event('order_daily_sum', {value:order_daily_sum })
  send_event('order_buy', {value:order_buy })
  send_event('order_fee', {value:order_fee })
end