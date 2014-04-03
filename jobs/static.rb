require_relative '../modules/generator'
# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
#@@
prand = Random.new
#@@ 前30天的日期
date_30b = Generator.generate_date(20)
#@@ 前7天和后15天的日期
date_7b15f = Generator.generate_date(22,Time.now+15*24*3600)
#@@ 后30天日期
date_30f = Generator.generate_date(30,Time.now+30*24*3600)
###########
# 金属闭口
###########
#@@前30天核定产能
metalclose_aprovedplan = Generator.generate_data(20,45,30)
#@@前30天计划数
metalclose_plan_30b = Generator.generate_data(20,50.0,40.0)
#@@前30天完工数
metalclose_finished = Generator.generate_data(20,47.0,36.0)

#@@前30天实际产量
metalclose_trueoutput = Generator.generate_data(20,70.0,40.0)
#@@前30天缺数 = 计划数 - 完工数
metalclose_unfinished =Generator.generate_array_minus(metalclose_plan_30b,metalclose_finished)
#@@后15天计划数
metalclose_plan_30f = Generator.generate_data(15,50.0,20.0)
#---------------------------
#@@当日实际产量 //定时job
#---------------------------

# 前一个月缺数、完工数、核定产能对比
send_event('metalclose_capicity', {date:date_30b, plan:metalclose_aprovedplan, finished:metalclose_finished, unfinished:metalclose_unfinished })

# 今日实际产量与前一个月（31个点）实际产量对比
# send_event('metalclose_output',{date:date_30b,output:metalclose_trueoutput})
# 前7天与后15天的计划组成
send_event('metalclose_plan',{date:date_7b15f,plan:(metalclose_plan_30b.last(7)<<metalclose_plan_30f.first(15)),finished:Generator.generate_new_array(22,7,metalclose_finished),unfinished:Generator.generate_array_minus((metalclose_plan_30b.last(7)<<metalclose_plan_30f.first(15)),Generator.generate_new_array(22,7,metalclose_finished))})

# 前一个月的累计误期值
send_event('metalclose_sum_unfinished',{value:Generator.generate_array_sum(metalclose_unfinished)})

# 前一个月的存量值+后15天的计划值
send_event('metalclose_sum_planunfinished',{value:(Generator.generate_array_sum(metalclose_plan_30b)+Generator.generate_array_sum(metalclose_plan_30f.first(15)))})

# 前一个月的实际产量周日均与实际产量的对比

# 后30天的每日计划量线性图
send_event('mentalclose_plan_30f',{date:date_30f,points:metalclose_plan_30f})


###########
# 金属开口
###########
#@@前30天核定产能
metalopen_aprovedplan = Generator.generate_data(20,35,20)
#@@前30天计划数
metalopen_plan_30b = Generator.generate_data(20,40.0,30.0)
#@@前30天完工数
metalopen_finished = Generator.generate_data(20,36.0,28.0)
#@@前30天实际产量
metalopen_trueoutput = Generator.generate_data(20,50.0,35.0)
#@@前30天缺数 = 计划数 - 完工数
metalopen_unfinished =Generator.generate_array_minus(metalopen_plan_30b,metalopen_finished)
#@@后15天计划数
metalopen_plan_30f = Generator.generate_data(15,40.0,10.0)
#---------------------------
#@@当日实际产量 //定时job
#---------------------------

# 前一个月缺数、完工数、核定产能对比
send_event('metalopen_capicity', {date:date_30b, plan:metalopen_aprovedplan, finished:metalopen_finished, unfinished:metalopen_unfinished })
# 今日实际产量与前一个月（31个点）实际产量对比
# send_event('metalopen_output',{date:date_30b,output:metalopen_trueoutput})
# 前7天与后15天的计划组成
send_event('metalopen_plan',{date:date_7b15f,plan:(metalopen_plan_30b.last(7)<<metalopen_plan_30f.first(15)),finished:Generator.generate_new_array(22,7,metalopen_finished),unfinished:Generator.generate_array_minus((metalopen_plan_30b.last(7)<<metalopen_plan_30f.first(15)),Generator.generate_new_array(22,7,metalopen_finished))})
# 前一个月的累计误期值
send_event('metalopen_sum_unfinished',{value:Generator.generate_array_sum(metalopen_unfinished)})
# 前一个月的存量值+后15天的计划值
send_event('metalopen_sum_planunfinished',{value:(Generator.generate_array_sum(metalopen_plan_30b)+Generator.generate_array_sum(metalopen_plan_30f.first(15)))})
# 前一个月的实际产量周日均与实际产量的对比


# 后30天的每日计划量线性图
send_event('mentalopen_plan_30f',{date:date_30f,points:metalopen_plan_30f})

###########
# 金属打样
###########
#@@前30天计划数
metalproofing_plan_30b = Generator.generate_data(20,50.0,20.0)
#@@前30天完工数
metalproofing_finished = Generator.generate_data(20,49.0,10.0)
#@@前30天实际产量
metalproofing_trueoutput = Generator.generate_data(20,70.0,20.0)
#@@前30天缺数 = 计划数 - 完工数
metalproofing_unfinished =Generator.generate_array_minus(metalproofing_plan_30b,metalproofing_finished)

# 前一个月缺数、完工数、核定产能对比
send_event('mentalproofing_capacity',{date:date_30b,finished:metalproofing_finished,unfinished:metalproofing_unfinished})
# （一个月）每日完工数占计划数比率
send_event('mentalproofing_finishrate',{a:Generator.generate_array_sum(metalproofing_finished),b:Generator.generate_array_sum(metalproofing_plan_30b)})
# 前一个月的累计误期值
send_event('mentalproofing_unfinished',{value:Generator.generate_array_sum(metalproofing_unfinished)})
# 总累计误期占总计划量的比值
send_event('mentalprooging_unfinishedrate',{a:Generator.generate_array_sum(metalproofing_unfinished),b:Generator.generate_array_sum(metalproofing_plan_30b)})

###########
# 钢塑订单表
###########
#---------------------------
#@@今日订单份数 //定时job
#@@今日订单总量 //定时job
#@@当前采购金额 //定时job
#@@当前收费金额 //定时job
#---------------------------
#@@ 前30天订单份数
order_catenum = Generator.generate_data(20,20,1)
#@@ 美特斯帮威 羽绒服 前30天订单总量
order_sumnumA = prand.rand(400..2000)
#@@ 美特斯帮威 运动服 前30天订单总量
order_sumnumB = prand.rand(15000..30000)
#@@ 美特斯帮威 外套 前30天订单总量
order_sumnumC = prand.rand(30000..40000)
#@@ 一段时间按订单类型占比分析

#@@ 一段时间内订单数量的同期对比
order_lastyear_30b = Generator.generate_data(20,250000,0)
order_thisyear_30b = Generator.generate_data(20,250000,0)

# 一段时间内客户A的订单份数
send_event('order_cusordercate',{date:date_30b,value:order_catenum})

# 客户A的订单类型的各个数量
send_event('order_cusordernum',{a:order_sumnumA,b:order_sumnumB,c:order_sumnumC})

# 一段时间按订单类型占比分析

# 一段时间内订单数量的同期对比
send_event('order_sameperiod',{date:date_30b,last:order_lastyear_30b,current:order_thisyear_30b})

#############
#销售对比
#############
# 一段时间华北采购与收费金额对比
send_event('sale_hubei',{a:prand.rand(360000...400000),b:prand.rand(360000...400000)})

# 一段时间内，台州分公司，上海分公司，温州分公司采购金额对比
send_event('sale_tws_buy',{a:prand.rand(10000..500000),b:prand.rand(20000..90000),c:prand.rand(200000..300000)})

# 一段时间内各分厂的采购金额占比
send_event('sale_allsub_but',{a:prand.rand(10000..500000),b:prand.rand(10000..500000),c:prand.rand(10000..500000),d:prand.rand(10000..500000),e:prand.rand(10000..500000),f:prand.rand(10000..500000),g:prand.rand(10000..500000),h:prand.rand(10000..500000),i:prand.rand(10000..500000)})

# 一段时间内总客户订单份数的排行汇总
send_event('sale_order_catenum',{a:prand.rand(10..70),b:prand.rand(10..70),c:prand.rand(10..70),d:prand.rand(10..70),e:prand.rand(10..70)})

# 一段时间内总客户订单金额的排行汇总
send_event('sale_order_sumnum',{a:prand.rand(5000..500000),b:prand.rand(5000..500000),c:prand.rand(5000..500000),d:prand.rand(5000..500000),e:prand.rand(5000..500000)})

#############
#OEE&TEEP
#############
# 当前平均OEE
send_event('oeeteep_currentoee',{value:prand.rand(40.0..50.0)})

# 当前平均TEEP
send_event('oeeteep_currentteep',{value:prand.rand(40.0..42.0)})

# 某生产车间与全厂平均的OEE的对比
send_event('oeeteep_facoee',{a:prand.rand(40.0..48.0),b:prand.rand(36.0..48.0)})

# 某生产车间与全厂平均的TEEP的对比
send_event('oeeteep_facteep',{a:prand.rand(39.7..48.8),b:prand.rand(32.0..45.0)})

# 各生产车间OEE的前三名排行
send_event('oeeteep_fst3oee',{a:prand.rand(55.0..58.0),b:prand.rand(48.0..53.0),c:prand.rand(45.0..48.0)})

# 各生产车间TEEP的前三名排行
send_event('oeeteep_fst3teep',{a:prand.rand(53.0..55.0),b:prand.rand(46.0..48.0),c:prand.rand(43.0..46.0)})

# 各生产车间OEE的后三名排行
send_event('oeeteep_lst3oee',{a:prand.rand(33.0..35.0),b:prand.rand(36.0..39.0),c:prand.rand(36.0..39.0)})

# 各生产车间TEEP的后三名排行
send_event('oeeteep_lst3teep',{a:prand.rand(31.0..33.0),b:prand.rand(34.7..45.8),c:prand.rand(36.5..40.0)})

# Daily
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
  puts "push data"
  mentalclose_trueoutput = Generator.generate_single_value(mentalclose_trueoutput,10,2)
  mentalopen_trueoutput = Generator.generate_single_value(mentalopen_trueoutput,8,2)
  order_daily_num = Generator.generate_single_value(order_daily_num,2,1)
  order_daily_sum = Generator.generate_single_value(order_daily_sum,40,10)
  order_buy = Generator.generate_single_value(order_buy,200,20)
  order_fee = Generator.generate_single_value(order_fee,200,20)
  #

  #
  send_event('metalclose_output', {date:date_30b,output:metalclose_trueoutput, output_daily:mentalclose_trueoutput})
  #
  send_event('metalopen_output', {date:date_30b,output:metalopen_trueoutput, output_daily:mentalopen_trueoutput})
  #
  send_event('order_daily_num', {value:order_daily_num })
  #
  send_event('order_daily_sum', {value:order_daily_sum })
  #
  send_event('order_buy', {value:order_buy })
  #
  send_event('order_fee', {value:order_fee })
  #
end