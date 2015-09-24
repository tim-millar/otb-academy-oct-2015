## Harry Potter HW, Ruby Academy, Autumn 2015

def prices xs
  
  raise ArgumentError,
        "array must be of length 5" unless xs.size == 5

  corner_case? = ->(xs) {
    non_zeroes(xs) == 5 && non_zeroes(update_array(xs)) >= 3  
  }

  non_zeroes = ->(xs) {
    xs.select { |y| y > 0 } .size
  }

  update_array = ->(xs) {
    xs.map { |x| x > 0 ? x.pred  : x }
  }

  discounted_price = {
    1 => 8, 2 => 15.2, 3 => 21.6, 4 => 25.6, 5 => 30, :corner_price => 51.20
  }

  if xs.inject(:+) == 0
    0
  elsif corner_case?.(xs)
    discounted_price[:corner_price] + prices(update_corner(xs))
  else
    discounted_price[non_zeroes.(xs)] + prices(update_array.(xs))
  end

end



def five_uniq? xs
  xs.count(1) == 5
end

def three_uniq? xs
  xs.count(1) == 3
end

RSpec.describe "three_uniq? helper function" do

  it "returns true if there are three unique books in the array" do
    expect(three_uniq?([1,0,1,1,0])).to eq(true)
    expect(three_uniq?([0,0,1,1,1])).to eq(true)
  end

  it "returns false of there are not three unique books in the array" do
    expect(three_uniq?([2,1,3,0,1])).to eq(false)
    expect(three_uniq?([2,1,1,1,1])).to eq(false)
    expect(three_uniq?([31,0,0,1,2])).to eq(false)
    expect(three_uniq?([2,10,3,40,1])).to eq(false)
  end

end

RSpec.describe "five_uniq? helper function" do

  it "returns true if there are five unique books in the array" do
    expect(five_uniq?([1,1,1,1,1])).to eq(true)
  end

  it "returns false of there are not five unique books in the array" do
    expect(five_uniq?([2,1,3,0,1])).to eq(false)
    expect(five_uniq?([2,1,1,1,1])).to eq(false)
    expect(five_uniq?([31,0,0,1,2])).to eq(false)
    expect(five_uniq?([2,10,3,40,1])).to eq(false)
  end
  

end
