class Array
  def qsort
    self.size == 1 ? self : self.partition do |x|
      x <= (self - [max]).max
    end.map(&:qsort).inject(:+)
  end
  
end

(1..100).to_a.shuffle.qsort
