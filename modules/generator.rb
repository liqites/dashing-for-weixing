module Generator
  SECONDS_IN_DAY = 24*60*60
	# generate capicity
	# @interval how many days you want?
	# @truecapmax float
  # @truecapmin float
  # @ratemax float
  # @ratemin float
  # @plancapmax integer
  # @plancapmin integer
	def self.generate_capicity interval,truecapmax,truecapmin,ratemax,ratemin,plancapmax,plancapmin
    start_time = Time.now
    dates = []
    plancapcity = []
    truecapicity = []
    miscapicity = []
    prand = Random.new(1234)
    for i in 0..(interval.to_i-1)
      dates[i] = (Time.now - (interval.to_i-i-1)*SECONDS_IN_DAY).strftime("%F")
      plancapcity[i] = prand.rand(truecapmin..truecapmax)
      miscapicity[i] = plancapcity[i] * prand.rand(ratemin..ratemax)
      plancapcity[i] = prand.rand(plancapmin..plancapmax)
    end
    result = {}
    result = {'date'=>dates,'truecapicity'=>truecapicity,'plancapcity'=>plancapcity,'miscapicity'=>miscapicity}
    puts result
  end

  # generate_daily_capicity
  # @orival original value
  # @intervalmax integar
  # @intervalmin integer
  def self.generate_daily_capicity orival,intervalmax,intervalmin
    prand = Random.new(1234)
    orival = orival + prand.rand(intervalmin..intervalmax)
  end

  def self.generate_plan interval,planmax,planmin
    plan = []
    prand = Random.new(1234)
    for i in 0..(interval.to_i -1)
      plan[i] = prand.rand(planmin..planmin)
    end
    plan
  end

  # pass array of truecapicity
  # return week average
  def self.generate_week_truecapicity truecapicity
    interval = truecapicity.length
    start_time = Time.now - (interval.to_i - i -1)*SECONDS_IN_DAY
    for i in 0..(interval - 1)
      
    end
  end
end