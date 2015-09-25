## Tests for Harry Potter helper functions

def update_array xs
  xs.map { |x| x > 0 ? x.pred  : x }
end

def non_zeroes xs
  xs.select { |y| y > 0 } .size
end

def corner_case? xs    # possible problem here
  non_zeroes(xs) == 5 && non_zeroes(update_array(xs)) >= 3
end

# def test xs   # definite problem here
#   def update_helper(i, xs)
#     p xs
#     if i == 3 || xs.empty?
#       xs
#     elsif xs[0] > 0
#       p "updating ...#{xs[0]}"
#       xs[0] -= 1
#       xs[0,1] + update_helper(i+1, xs[1..-1])
#     else
#       xs[0,1] + update_helper(i,   xs[1..-1])
#     end
#   end
#   update_helper(0, update_array(xs.sort.reverse)) # won't work here
# end

def update_corner_ xs
  initial_update = update_array xs
  take_from = initial_update.sort.reverse.take 3
  initial_update.map { |x| take_from.include?(x) ? x.pred : x }
end

def update_corner xs
  take_from = update_array(xs).sort.reverse.take 3
  update_array(xs).map { |x| take_from.include?(x) ? x.pred : x }
end


RSpec.describe "Harry Potter prices helper functions" do
  
  it "correctly updates the array in the corner case" do
    expect([0,0,0,0,0]).to eq(update_corner([2,2,2,1,1]))
    expect([0,0,0,0,0]).to eq(update_corner([2,2,2,1,1].reverse))

    expect([1,1,1,1,1]).to eq(update_corner([3,3,3,2,2]))
    expect([1,1,1,1,1]).to eq(update_corner([3,3,3,2,2].reverse))

    expect([0,4,2,0,7]).to eq(update_corner([1,6,4,1,9]))
  end
end
