# coding: utf-8

def prices xs
  
  result = 0
  disc_price = {1 => 8, 2 => 15.2, 3 => 21.6, 4 => 25.6, 5 => 30}

  if xs.inject(:+) == 0
    result
  else
    lot = xs.select { |y| y > 0 } .size
    disc_price[lot] + prices(xs.map { |x| x > 0 ? x.pred  : x })
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
    expect(prices([1,2,2,1,0,1])).to eq(40.80)
  end
  
end
