# coding: utf-8

def prices xs
  
  raise ArgumentError,
        "array must be of length 5" unless xs.size == 5

  disc_price = {
    1 => 8, 2 => 15.2, 3 => 21.6, 4 => 25.6, 5 => 30
  }

  if xs.inject(:+) == 0
    0
  elsif corner_case? xs
    51.2
  else
    no_in_lot = xs.select { |y| y > 0 } .size
    disc_price[no_in_lot] + prices(xs.map { |x| x > 0 ? x.pred  : x })
  end
  
end

def corner_case? xs
  xs.count(1) == 2 && xs.count(2) == 3
end

def five_uniq? xs
  xs.count(1) == 5
end

def three_uniq? xs
  xs.count(1) == 3
end

RSpec.describe "corner_case? helper function" do

  it "returns true if there are five and three unique books in the array" do
    expect(corner_case?([1,2,2,1,2])).to eq(true)
    expect(corner_case?([2,2,2,1,1])).to eq(true)
  end

  it "returns false of there are not three unique books in the array" do
    expect(corner_case?([2,1,3,0,1])).to eq(false)
    expect(corner_case?([2,1,1,1,1])).to eq(false)
    expect(corner_case?([31,0,0,1,2])).to eq(false)
    expect(corner_case?([2,10,3,40,1])).to eq(false)
  end

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

RSpec.describe "Harry Potter prices function" do

  it "costs nothing to buy no books" do
    expect(prices([0,0,0,0,0])).to eq(0)
  end

  it "charges £8 for one book" do
    expect(prices([1,0,0,0,0])).to eq(8)
    expect(prices([0,0,1,0,0])).to eq(8)
    expect(prices([0,0,0,0,1])).to eq(8)
  end

  it "discounts price by 5% if two different books are bought" do
    expect(prices([1,0,0,1,0])).to eq(15.20)
    expect(prices([0,0,1,1,0])).to eq(15.20)
  end

  it "discounts price by 10% if three different books are bought" do
    expect(prices([1,0,1,1,0])).to eq(21.6)
    expect(prices([0,0,1,1,1])).to eq(21.6)
  end

  it "discounts price by 20% if four different books are bought" do
    expect(prices([1,0,1,1,1])).to eq(25.6)
    expect(prices([0,1,1,1,1])).to eq(25.6)
  end
  
  it "discounts price by 25% if four different books are bought" do
    expect(prices([1,1,1,1,1])).to eq(30)
  end

  it "handles combinations of books properly" do
    expect(prices([1,2,2,0,1])).to eq(40.80)
    expect(prices([7,2,0,0,3])).to eq(90.40)
    expect(prices([0,15,0,2,0])).to eq(134.4)
  end
  
end
