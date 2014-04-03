module Generator
  SECONDS_IN_DAY = 24*60*60
  #===========================
  #generate date
  #===========================
  def self.generate_date interval,end_time=nil
    if end_time.nil?
      end_time = Time.now
    end
    date = []
    for i in 0..(interval.to_i-1)
      date[i] = (end_time - (interval.to_i-i-1)*SECONDS_IN_DAY).strftime("%m.%d")
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

  #generate_new_array
  def self.generate_new_array(length,targetlength,oriarray)
    data = []
    for i in 0..length-1
      if i<targetlength
        data[i] = oriarray[i]
      end
      data[i] = 0
    end
    data
  end

  #===========================
  #generate tricky data
  #===========================
  def self.generate_trcky_data(oriarray,interval)
    data = []
    prand = Random.new(1234)
    for i in 0..(oriarray.length-1)
      if i < interval
        data[i] = oriarray[i]*prand.rand(0.9..0.95)
      elsif i == interval
        data[i] = oriarray[i]*prand.rand(0..1.0)
      end
      data[i] = 0
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

  #===========================
  #generate array monus
  #===========================
  def self.generate_array_minus oriarray,targetarray
    if oriarray.length != targetarray.length
      0
    else
      data = []
      for i in 0..oriarray.length-1
        data[i] = oriarray[i]-targetarray[i]
      end
      data
    end
  end

  #week average
  def self.gererate_week_average array
    #set today as the end day
    day_start = 0
    day_end = 0
    val = 0
    count = 0
    current_date = Time.now
    data = []
    #for i in 0..array.length-1
    #  date = current_date - (array.length-i-1)*SECONDS_IN_DAY
    #  if date.wday < 6
    #    count=count+1
    #  else

    #  end
    #end
    data
  end

  #single value
  def self.generate_single_value orival,intervalmax,intervalmin
    prand = Random.new(1234)
    orival = orival + prand.rand(intervalmin..intervalmax)
  end
end