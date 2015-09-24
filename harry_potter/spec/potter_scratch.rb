## Harry Potter HW, Ruby Academy, Autumn 2015

def prices_procs xs
  
  raise ArgumentError,
        "array must be of length 5" unless xs.size == 5

  non_zeroes = ->(xs) {
    xs.select { |y| y > 0 } .size
  }

  update_array = ->(xs) {
    xs.map { |x| x > 0 ? x.pred  : x }
  }

  corner_case = ->(xs) {
    non_zeroes[xs] == 5 && non_zeroes.(update_array[xs]) >= 3  
  }

  update_corner = ->(xs) {
    update_helper = ->(i, xs) {
      if i == 3 || xs.empty?
        xs
      elsif xs[0] > 0
        xs[0] -= 1
        xs[0,1] + update_helper[i+1, xs[1..-1]]
      else
        xs[0,1] + update_helper[i,   xs[1..-1]]
      end
    }
    update_helper[0, xs]
  }

  discounted_price = {
    1 => 8, 2 => 15.2, 3 => 21.6, 4 => 25.6, 5 => 30, :corner_price => 51.20
  }

  if xs.inject(:+) == 0
    0
  elsif corner_case[xs]
    discounted_price[:corner_price] + prices_procs(update_corner[xs])
  else
    discounted_price[non_zeroes[xs]] + prices_procs(update_array[xs])
  end

end


def update_corner xs
  # aaaaarrrrrrgrggggghhh
  corner_removed = update_array(xs)
  flag, idx = 0, 0
  while flag < 3
    if corner_removed[idx] > 0
      corner_removed[idx] -= 1
      flag += 1
    end
    idx += 1
  end
  corner_removed
end

def update_corner_rec xs
  def update_helper i, xs
    if i == 3 || xs.empty?
      xs
    elsif xs[0] > 0
      xs[0] -= 1
      xs[0,1] + update_helper(i+1, xs[1,-1])
    else
      xs[0,1] + update_helper(i,   xs[1,-1])
    end
  end
  update_helper(0, xs)
end

update_corner_rec = ->(xs) {
  update_helper = ->(i, xs) {
    if i == 3 || xs.empty?
      xs
    elsif xs[0] > 0
      xs[0] -= 1
      xs[0,1] + update_helper[i+1, xs[1,-1]]
    else
      xs[0,1] + update_helper[i,   xs[1,-1]]
    end
  }
  update_helper[0, xs]
}

def update_array xs
  xs.map { |x| x > 0 ? x.pred  : x }
end

def non_zeroes xs
  xs.select { |y| y > 0 } .size
end

def update_corner xs
  # aaaaarrrrrrgrggggghhh
  corner_removed = update_array(xs)
  flag, idx = 0, 0
  while flag < 3
    if corner_removed[idx] > 0
      corner_removed[idx] -= 1
      flag += 1
    end
    idx += 1
  end
  corner_removed
end

def corner_case? xs
  non_zeroes(xs) == 5 && non_zeroes(update_array(xs)) >= 3
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

RSpec.describe "corner_case? helper function" do

  it "returns true if there's a set of five & three unique books in the array" do
    expect(corner_case?([1,2,2,1,2])).to eq(true)
    expect(corner_case?([2,2,2,1,1])).to eq(true)
    expect(corner_case?([2,10,3,40,1])).to eq(true)
  end

  it "returns false if there's not a set of five & three unique books in the array" do
    expect(corner_case?([2,1,3,0,1])).to eq(false)
    expect(corner_case?([2,1,1,1,1])).to eq(false)
    expect(corner_case?([31,0,0,1,2])).to eq(false)
  end

end

