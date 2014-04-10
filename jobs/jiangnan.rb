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
############
#财务分析表
############
#@@七天的时间
date_7b = Generator.generate_date(7)

# 一段时间华北采购与收费金额对比
send_event('jn_sale_hubei',{a:prand.rand(360000...400000),b:prand.rand(360000...400000)})

# 一段时间内，台州分公司，上海分公司，温州分公司采购金额对比
send_event('jn_sale_tws_buy',{date:date_7b,value:[{title:"上海",value:Generator.generate_data(7,20000,8000)},{title:"烟台",value:Generator.generate_data(7,15000,8000)},{title:"武汉",value:Generator.generate_data(7,5000,4000)}]})

# 一段时间内各分厂的采购金额占比
send_event('jn_sale_allsub_buy',{value:[{name:"通用一部",val:prand.rand(10000..500000)},{name:"通用二部",val:prand.rand(10000..500000)},{name:"宝马一部",val:prand.rand(10000..500000)},{name:"宝马二部",val:prand.rand(10000..500000)},{name:"奔驰一部",val:prand.rand(10000..500000)},{name:"奔驰二部",val:prand.rand(10000..500000)},{name:"大众一部",val:prand.rand(10000..500000)},{name:"大众二部",val:prand.rand(10000..500000)},{name:"大众三部",val:prand.rand(10000..500000)}]})

# 一段时间内总客户订单份数的排行汇总
send_event('jn_sale_order_catenum',{x:["通用","奔驰","宝马","大众","观致"],y:[prand.rand(10..70),prand.rand(10..70),prand.rand(10..70),prand.rand(10..70),prand.rand(10..70)]})

# 一段时间内总客户订单金额的排行汇总
send_event('jn_sale_order_catenum',{x:["通用","奔驰","宝马","大众","观致"],y:[prand.rand(5000..500000),prand.rand(5000..500000),prand.rand(5000..500000),prand.rand(5000..500000),prand.rand(5000..500000)]})

############
#生产监控表
############
#@@前30天计划数
metalproofing_plan_30b = Generator.generate_data(20,50.0,20.0)
#@@前30天完工数
metalproofing_finished = Generator.generate_data(20,49.0,10.0)
#@@前30天实际产量
metalproofing_trueoutput = Generator.generate_data(20,70.0,20.0)
#@@前30天缺数 = 计划数 - 完工数
metalproofing_unfinished =Generator.generate_array_minus(metalproofing_plan_30b,metalproofing_finished)

# 前一个月缺数、完工数、核定产能对比
send_event('jn_mentalproofing_capacity',{x:date_30b,value:[{title:"finished",value:metalproofing_finished},{title:"unfinished",value:metalproofing_unfinished}]})
# （一个月）每日完工数占计划数比率
send_event('jn_mentalproofing_finishrate',{value:(Generator.generate_array_sum(metalproofing_finished)/Generator.generate_array_sum(metalproofing_plan_30b)*100).round(0)})

# 前一个月的累计误期值
send_event('jn_mentalproofing_unfinished',{value:prand.rand(2..10)})

# 总累计误期占总计划量的比值
send_event('jn_mentalprooging_unfinishedrate',{value:prand.rand(100..150)})


############
#设备综合效率表
############
# 当前平均OEE
send_event('jn_oeeteep_currentoee',{value:prand.rand(40.0..50.0).round(2)})

# 当前平均TEEP
send_event('jn_oeeteep_currentteep',{value:prand.rand(40.0..42.0).round(2)})

# 某生产车间与全厂平均的OEE的对比
send_event('jn_oeeteep_facoee',{x:["通用一部","全厂"],y:[prand.rand(40.0..48.0).round(2),prand.rand(36.0..48.0).round(2)],type:"column"})

# 某生产车间与全厂平均的TEEP的对比
send_event('jn_oeeteep_facoee',{x:["通用一部","全厂"],y:[prand.rand(39.7..48.8).round(2),prand.rand(32.0..45.0).round(2)],type:"column"})

# 各生产车间OEE的前三名排行
send_event('jn_oeeteep_fst3oee',{x:["通用一部","通用二部","宝马一部"],y:[prand.rand(55.0..58.0).round(2),prand.rand(48.0..53.0).round(2),prand.rand(45.0..48.0).round(2)],type:"bar"})

# 各生产车间TEEP的前三名排行
send_event('jn_oeeteep_fst3teep',{x:["通用一部","通用二部","宝马一部"],y:[prand.rand(53.0..55.0).round(2),prand.rand(46.0..48.0).round(2),prand.rand(43.0..46.0).round(2)],type:"bar"})

# 各生产车间OEE的后三名排行
send_event('jn_oeeteep_lst3oee',{x:["奔驰一部","奔驰二部","观致二部"],y:[prand.rand(33.0..35.0).round(2),prand.rand(36.0..39.0).round(2),prand.rand(36.0..39.0).round(2)],type:"bar"})

# 各生产车间TEEP的后三名排行
send_event('jn_oeeteep_lst3oee',{x:["奔驰一部","奔驰二部","观致二部"],y:[prand.rand(31.0..33.0).round(2),prand.rand(34.7..45.8).round(2),prand.rand(36.5..40.0).round(2)],type:"bar"})