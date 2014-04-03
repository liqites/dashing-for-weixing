module Generator
  SECONDS_IN_DAY = 24*60*60

  #===========================
  #generate date
  #===========================
  def self.generate_date interval
    date = []
    for i in 0..(interval.to_i-1)
      date[i] = (Time.now - (interval.to_i-i-1)*SECONDS_IN_DAY).strftime("%F")
    end
    date
  end

  #===========================
  #generate data
  #===========================
  def self.generate_data interval,max,min
    data = []
    prand = Random.new(1234)
    for i in 0..(interval.to_i-1)
      data[i] = prand.rand(min..max)
    end
    data
  end

  #===========================
  #generate rate data
  #===========================
  def self.generate_rate_data array,ratemax,ratemin
    data = []
    prand = Random.new(1234)
    for i in 0..(array.count-1)
      data[i] = array[i]*prand.rand(ratemin..ratemax)
    end
    data
  end

  #===========================
  #generate array sum
  #===========================
  def self.generate_array_sum array
    array.inject{|sum,x| sum + x}
  end

  #week average
  def self.gererate_week_average array
    data = []

    data
  end

  #single value
  def self.generate_single_value orival,intervalmax,intervalmin
    prand = Random.new(1234)
    orival = orival + prand.rand(intervalmin..intervalmax)
  end
end