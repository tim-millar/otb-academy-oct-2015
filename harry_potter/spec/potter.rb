class HarryPotter

  def self.price_order order
    new.prices order
  end

  :private

  @@discounted_price = {
    1 => 8,
    2 => 15.2,
    3 => 21.6,
    4 => 25.6,
    5 => 30,
    :corner_price => 51.20
  }
  
  def initialize; end

  def prices xs
    raise ArgumentError,
          "array must be of length 5" unless xs.size == 5
    if no_books? xs 
      0
    elsif corner_case? xs
      @@discounted_price[:corner_price]  + prices(update_corner(xs))
    else
      @@discounted_price[non_zeroes(xs)] + prices(update_array(xs))
    end
  end

  def no_books? xs
    non_zeroes(xs) == 0
  end

  def non_zeroes xs
    xs.select { |x| x.nonzero? }.size
  end
  
  def update_array xs
    xs.map { |x| x.nonzero? ? x.pred : x }
  end

  def corner_case? xs
    non_zeroes(xs) == 5 && xs.select { |x| x > xs.min }.size >= 3
  end

  def update_corner xs
    five_removed = update_array(xs)
    top_three = five_removed.sort.reverse.take 3
    five_removed.map { |x| top_three.include?(x) ? x.pred : x }
  end

end
