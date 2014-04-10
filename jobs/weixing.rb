# -*- coding: utf-8 -*-
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
#send_event('metalclose_capicity', {date:date_30b, plan:metalclose_aprovedplan, finished:metalclose_finished, unfinished:metalclose_unfinished })
send_event('metalclose_capicity',{x:date_30b,value:[{title:"plan",value:metalclose_aprovedplan},{title:"finished",value:metalclose_finished},{title:"unfinished",value:metalclose_unfinished}]})

# 今日实际产量与前一个月（31个点）实际产量对比
# send_event('metalclose_output',{date:date_30b,output:metalclose_trueoutput})
# 前7天与后15天的计划组成
send_event('metalclose_plan',{date:date_7b15f,plan:(metalclose_plan_30b.last(7)<<metalclose_plan_30f.first(15)),finished:Generator.generate_new_array(22,7,metalclose_finished),unfinished:Generator.generate_array_minus((metalclose_plan_30b.last(7)<<metalclose_plan_30f.first(15)),Generator.generate_new_array(22,7,metalclose_finished))})

# 前一个月的累计误期值
send_event('metalclose_sum_unfinished',{value:Generator.generate_array_sum(metalclose_unfinished).round(2)})

# 前一个月的存量值+后15天的计划值                     date_30b
send_event('metalclose_sum_planunfinished',{value:(Generator.generate_array_sum(metalclose_plan_30b)+Generator.generate_array_sum(metalclose_plan_30f.first(15)).round(2))})

# 前一个月的实际产量周日均与实际产量的对比
send_event('metalclose_capicity_rate',{value:86});

# 后30天的每日计划量线性图
#send_event('mentalclose_plan_30f',{date:date_30f,points:metalclose_plan_30f})
send_event('mentalclose_plan_30f',{x:date_30f,y:metalclose_plan_30f,type:"line"})


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
# send_event('metalopen_capicity', {date:date_30b, plan:metalopen_aprovedplan, finished:metalopen_finished, unfinished:metalopen_unfinished })
send_event('metalopen_capicity',{x:date_30b,value:[{title:"plan",value:metalopen_aprovedplan},{title:"finished",value:metalopen_finished},{title:"unfinished",value:metalopen_unfinished}]})
# 今日实际产量与前一个月（31个点）实际产量对比
# send_event('metalopen_output',{date:date_30b,output:metalopen_trueoutput})
# 前7天与后15天的计划组成
send_event('metalopen_plan',{date:date_7b15f,plan:(metalopen_plan_30b.last(7)<<metalopen_plan_30f.first(15)),finished:Generator.generate_new_array(22,7,metalopen_finished),unfinished:Generator.generate_array_minus((metalopen_plan_30b.last(7)<<metalopen_plan_30f.first(15)),Generator.generate_new_array(22,7,metalopen_finished))})
# 前一个月的累计误期值
send_event('metalopen_sum_unfinished',{value:Generator.generate_array_sum(metalopen_unfinished).round(2)})
# 前一个月的存量值+后15天的计划值
send_event('metalopen_sum_planunfinished',{value:(Generator.generate_array_sum(metalopen_plan_30b)+Generator.generate_array_sum(metalopen_plan_30f.first(15)))})

# 前一个月的实际产量周日均与实际产量的对比
send_event('metalopen_capicity_rate',{value:98})

# 后30天的每日计划量线性图
#send_event('mentalopen_plan_30f',{date:date_30f,points:metalopen_plan_30f})
send_event('mentalopen_plan_30f',{x:date_30f,y:metalopen_plan_30f,type:"line"})

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
#send_event('mentalproofing_capacity',{date:date_30b,finished:metalproofing_finished,unfinished:metalproofing_unfinished})
send_event('mentalproofing_capacity',{x:date_30b,value:[{title:"finished",value:metalproofing_finished},{title:"unfinished",value:metalproofing_unfinished}]})
# （一个月）每日完工数占计划数比率
send_event('mentalproofing_finishrate',{value:(Generator.generate_array_sum(metalproofing_finished)/Generator.generate_array_sum(metalproofing_plan_30b)*100).round(0)})
#send_event('mentalproofing_finishrate',{a:Generator.generate_array_sum(metalproofing_finished),b:Generator.generate_array_sum(metalproofing_plan_30b)})

# 前一个月的累计误期值
send_event('mentalproofing_unfinished',{value:Generator.generate_array_sum(metalproofing_unfinished)})

# 总累计误期占总计划量的比值
send_event('mentalprooging_unfinishedrate',{value:(Generator.generate_array_sum(metalproofing_unfinished)/Generator.generate_array_sum(metalproofing_plan_30b)*100).round(0)})
#send_event('mentalprooging_unfinishedrate',{a:Generator.generate_array_sum(metalproofing_unfinished),b:Generator.generate_array_sum(metalproofing_plan_30b)})

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
# send_event('order_cusordercate',{date:date_30b,value:order_catenum})
send_event('order_cusordercate',{x:date_30b,y:order_catenum,type:"column"})

# 客户A的订单类型的各个数量
# send_event('order_cusordernum',{a:order_sumnumA,b:order_sumnumB,c:order_sumnumC})
send_event('order_cusordernum',{x:["羽绒服","运动服","外套"],y:[order_sumnumA,order_sumnumB,order_sumnumC],type:"bar"})

# 一段时间按订单类型占比分析

# 一段时间内订单数量的同期对比
send_event('order_sameperiod',{date:date_30b,last:order_lastyear_30b,current:order_thisyear_30b})

#############
#销售对比
#############
#@@七天的时间
date_7b = Generator.generate_date(7)
# 一段时间华北采购与收费金额对比
send_event('sale_hubei',{a:prand.rand(360000...400000),b:prand.rand(360000...400000)})

# 一段时间内，台州分公司，上海分公司，温州分公司采购金额对比
# send_event('sale_tws_buy',{a:prand.rand(10000..500000),b:prand.rand(20000..90000),c:prand.rand(200000..300000)})
#send_event('sale_tws_buy',{date:date_7b,a:Generator.generate_data(7,20000,8000),b:Generator.generate_data(7,15000,8000),c:Generator.generate_data(7,5000,4000)})
send_event('sale_tws_buy',{date:date_7b,value:[{title:"台州",value:Generator.generate_data(7,20000,8000)},{title:"上海",value:Generator.generate_data(7,15000,8000)},{title:"温州",value:Generator.generate_data(7,5000,4000)}]})

# 一段时间内各分厂的采购金额占比
# send_event('sale_allsub_but',{a:prand.rand(10000..500000),b:prand.rand(10000..500000),c:prand.rand(10000..500000),d:prand.rand(10000..500000),e:prand.rand(10000..500000),f:prand.rand(10000..500000),g:prand.rand(10000..500000),h:prand.rand(10000..500000),i:prand.rand(10000..500000)})
send_event('sale_allsub_buy',{value:[{name:"台州",val:prand.rand(10000..500000)},{name:"上海",val:prand.rand(10000..500000)},{name:"温州",val:prand.rand(10000..500000)},{name:"大洋外贸",val:prand.rand(10000..500000)},{name:"成都",val:prand.rand(10000..500000)},{name:"广东",val:prand.rand(10000..500000)},{name:"青岛",val:prand.rand(10000..500000)},{name:"石家庄",val:prand.rand(10000..500000)},{name:"厦门",val:prand.rand(10000..500000)}]})

# 一段时间内总客户订单份数的排行汇总
# send_event('sale_order_catenum',{a:prand.rand(10..70),b:prand.rand(10..70),c:prand.rand(10..70),d:prand.rand(10..70),e:prand.rand(10..70)})
send_event('sale_order_catenum',{x:["美特斯邦威","森马","Only","H&M","Zara"],y:[prand.rand(10..70),prand.rand(10..70),prand.rand(10..70),prand.rand(10..70),prand.rand(10..70)]})

# 一段时间内总客户订单金额的排行汇总
#send_event('sale_order_sumnum',{a:prand.rand(5000..500000),b:prand.rand(5000..500000),c:prand.rand(5000..500000),d:prand.rand(5000..500000),e:prand.rand(5000..500000)})
send_event('sale_order_catenum',{x:["美特斯邦威","森马","Only","H&M","Zara"],y:[prand.rand(5000..500000),prand.rand(5000..500000),prand.rand(5000..500000),prand.rand(5000..500000),prand.rand(5000..500000)]})

#############
#OEE&TEEP
#############
# 当前平均OEE
send_event('oeeteep_currentoee',{value:prand.rand(40.0..50.0).round(2)})

# 当前平均TEEP
send_event('oeeteep_currentteep',{value:prand.rand(40.0..42.0).round(2)})

# 某生产车间与全厂平均的OEE的对比
#send_event('oeeteep_facoee',{a:prand.rand(40.0..48.0).round(2),b:prand.rand(36.0..48.0).round(2)})
send_event('oeeteep_facoee',{x:["塑钢一车间","全厂"],y:[prand.rand(40.0..48.0).round(2),prand.rand(36.0..48.0).round(2)],type:"column"})

# 某生产车间与全厂平均的TEEP的对比
#send_event('oeeteep_facteep',{a:prand.rand(39.7..48.8).round(2),b:prand.rand(32.0..45.0).round(2)})
send_event('oeeteep_facoee',{x:["塑钢一车间","全厂"],y:[prand.rand(39.7..48.8).round(2),prand.rand(32.0..45.0).round(2)],type:"column"})

# 各生产车间OEE的前三名排行
# send_event('oeeteep_fst3oee',{a:prand.rand(55.0..58.0).round(2),b:prand.rand(48.0..53.0).round(2),c:prand.rand(45.0..48.0).round(2)})
send_event('oeeteep_fst3oee',{x:["塑钢二车间","塑钢三车间","尼龙一车间"],y:[prand.rand(55.0..58.0).round(2),prand.rand(48.0..53.0).round(2),prand.rand(45.0..48.0).round(2)],type:"bar"})

# 各生产车间TEEP的前三名排行
# send_event('oeeteep_fst3teep',{a:prand.rand(53.0..55.0).round(2),b:prand.rand(46.0..48.0).round(2),c:prand.rand(43.0..46.0).round(2)})
send_event('oeeteep_fst3teep',{x:["塑钢二车间","塑钢三车间","尼龙一车间"],y:[prand.rand(53.0..55.0).round(2),prand.rand(46.0..48.0).round(2),prand.rand(43.0..46.0).round(2)],type:"bar"})

# 各生产车间OEE的后三名排行
#send_event('oeeteep_lst3oee',{a:prand.rand(33.0..35.0).round(2),b:prand.rand(36.0..39.0).round(2),c:prand.rand(36.0..39.0).round(2)})
send_event('oeeteep_lst3oee',{x:["金属一车间","金属二车间","尼龙三车间"],y:[prand.rand(33.0..35.0).round(2),prand.rand(36.0..39.0).round(2),prand.rand(36.0..39.0).round(2)],type:"bar"})

# 各生产车间TEEP的后三名排行
#send_event('oeeteep_lst3teep',{a:prand.rand(31.0..33.0).round(2),b:prand.rand(34.7..45.8).round(2)),c:prand.rand(36.5..40.0).round(2)})
send_event('oeeteep_lst3oee',{x:["金属一车间","金属二车间","尼龙三车间"],y:[prand.rand(31.0..33.0).round(2),prand.rand(34.7..45.8).round(2),prand.rand(36.5..40.0).round(2)],type:"bar"})

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

SCHEDULER.every '2s', :first_in => 0 do |job|

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
