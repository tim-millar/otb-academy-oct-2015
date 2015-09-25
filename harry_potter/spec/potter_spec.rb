# coding: utf-8

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

    if non_zeroes(xs) == 0
      0
    elsif corner_case? xs
      @@discounted_price[:corner_price]  + prices(update_corner(xs))
    else
      @@discounted_price[non_zeroes(xs)] + prices(update_array(xs))
    end
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
    fst_update = update_array(xs)
    top_three  = fst_update.sort.reverse.take 3
    fst_update.map { |x| top_three.include?(x) ? x.pred : x }
  end

end


RSpec.describe "Harry Potter prices function" do

  it "costs nothing to buy no books" do
    expect(HarryPotter.price_order([0,0,0,0,0])).to eq(0)
  end

  it "charges £8 for one book" do
    expect(HarryPotter.price_order([1,0,0,0,0])).to eq(8)
    expect(HarryPotter.price_order([0,0,1,0,0])).to eq(8)
    expect(HarryPotter.price_order([0,0,0,0,1])).to eq(8)
  end

  it "discounts price by 5% if two different books are bought" do
    expect(HarryPotter.price_order([1,0,0,1,0])).to eq(15.20)
    expect(HarryPotter.price_order([0,0,1,1,0])).to eq(15.20)
  end

  it "discounts price by 10% if three different books are bought" do
    expect(HarryPotter.price_order([1,0,1,1,0])).to eq(21.6)
    expect(HarryPotter.price_order([0,0,1,1,1])).to eq(21.6)
  end

  it "discounts price by 20% if four different books are bought" do
    expect(HarryPotter.price_order([1,0,1,1,1])).to eq(25.6)
    expect(HarryPotter.price_order([0,1,1,1,1])).to eq(25.6)
  end
  
  it "discounts price by 25% if four different books are bought" do
    expect(HarryPotter.price_order([1,1,1,1,1])).to eq(30)
    expect(HarryPotter.price_order([3,3,3,3,3])).to eq(90)
  end

  it "handles combinations of books properly" do
    expect(HarryPotter.price_order([1,2,2,0,1])).to eq(40.80)
    expect(HarryPotter.price_order([7,2,0,0,3])).to eq(90.40)
    expect(HarryPotter.price_order([0,15,0,2,0])).to eq(134.4)

    expect(HarryPotter.price_order([2,2,2,1,1])).to eq(51.2)
    expect(HarryPotter.price_order([5,5,4,2,1])).to eq(113.60)
    expect(HarryPotter.price_order([5,5,4,5,4])).to eq(141.2)
  end

  it "maintains invariant: HarryPotter.price_order xs == HarryPotter.price_order xs.reverse == HarryPotter.price_order xs.shuffle" do
    expect(HarryPotter.price_order([3,3,3,4,3])).to eq(HarryPotter.price_order([3,3,3,4,3].reverse))
    expect(HarryPotter.price_order([2,2,2,1,1])).to eq(HarryPotter.price_order([2,2,2,1,1].reverse))
    expect(HarryPotter.price_order([5,5,4,2,1])).to eq(HarryPotter.price_order([5,5,4,2,1].reverse))
    expect(HarryPotter.price_order([5,4,3,2,1])).to eq(HarryPotter.price_order([5,4,3,2,1].reverse))

    expect(HarryPotter.price_order([3,3,3,4,3])).to eq(HarryPotter.price_order([3,3,3,4,3].shuffle))
    expect(HarryPotter.price_order([2,2,2,1,1])).to eq(HarryPotter.price_order([2,2,2,1,1].shuffle))
    expect(HarryPotter.price_order([5,5,4,2,1])).to eq(HarryPotter.price_order([5,5,4,2,1].shuffle))
    expect(HarryPotter.price_order([5,4,3,2,1])).to eq(HarryPotter.price_order([5,4,3,2,1].shuffle))
  end
  
end
