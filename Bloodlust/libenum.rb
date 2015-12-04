#  Add methods to Enumerable, available in Array
module Enumerable

  def sum
    return self.inject(0){|acc,i|acc +i}
  end

  def mean
    return self.sum/self.length.to_f
  end

  def variance
    avg=self.mean
    sum=self.inject(0){|acc,i| acc + (i-avg)**2}
    return sum/(self.length - 1).to_f
  end

  def std
    return Math.sqrt(self.variance)
  end

end  #  module Enumerable
