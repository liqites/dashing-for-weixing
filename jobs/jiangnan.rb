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
send_event('jn_sale_tws_buy',{date:date_7b,value:[{title:"台州",value:Generator.generate_data(7,20000,8000)},{title:"上海",value:Generator.generate_data(7,15000,8000)},{title:"温州",value:Generator.generate_data(7,5000,4000)}]})

# 一段时间内各分厂的采购金额占比
send_event('jn_sale_allsub_buy',{value:[{name:"通用一部",val:prand.rand(10000..500000)},{name:"通用二部",val:prand.rand(10000..500000)},{name:"宝马一部",val:prand.rand(10000..500000)},{name:"宝马二部",val:prand.rand(10000..500000)},{name:"奔驰一部",val:prand.rand(10000..500000)},{name:"奔驰二部",val:prand.rand(10000..500000)},{name:"大众一部",val:prand.rand(10000..500000)},{name:"大众二部",val:prand.rand(10000..500000)},{name:"大众三部",val:prand.rand(10000..500000)}]})

# 一段时间内总客户订单份数的排行汇总
send_event('jn_sale_order_catenum',{x:["美特斯邦威","森马","Only","H&M","Zara"],y:[prand.rand(10..70),prand.rand(10..70),prand.rand(10..70),prand.rand(10..70),prand.rand(10..70)]})

# 一段时间内总客户订单金额的排行汇总
send_event('jn_sale_order_catenum',{x:["美特斯邦威","森马","Only","H&M","Zara"],y:[prand.rand(5000..500000),prand.rand(5000..500000),prand.rand(5000..500000),prand.rand(5000..500000),prand.rand(5000..500000)]})

############
#生产监控表
############

############
#设备综合效率表
############