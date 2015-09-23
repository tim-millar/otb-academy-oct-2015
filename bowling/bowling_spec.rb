def bowling_scores_first_attempt(scores)
  elem_doubles = []
  scores.each_with_index do |elem, index|
    if index % 2 == 0 && elem == 10
      elem_doubles << index+1 if scores[index+1]
      elem_doubles << index+2 if scores[index+2]
    elsif index % 2 == 0 && scores[index+1] && elem + scores[index+1] == 10 \
      && scores[index+1] != 10 ##
      elem_doubles << index+2
    end
  end
  # p elem_doubles
  if elem_doubles.length > 0
    elem_doubles.each { |e| scores[e] = scores[e]*2 }
  end
  scores.inject(:+)
end

def rec_score_helper xs
  if xs.length <= 3
    xs
  elsif xs[0] == 10
    xs[0,1] + xs[1,2] + rec_score_helper(xs[1..-1])
  elsif xs[0] + xs[1] == 10
    xs[0,2] + xs[2,1] + rec_score_helper(xs[2..-1])
  else
    xs[0,2] + rec_score_helper(xs[2..-1])
  end
end

def bowling_scores lines
  rec_score_helper(lines).inject(:+)
end


RSpec.describe "Bowling Scores" do

  it "returns zero if all of the rolls are zero" do
    expect(bowling_scores([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])).to eq(0)
  end

  it "returns 2 when given an array containing 2 and 19 zeroes" do
    expect(bowling_scores([0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])).to eq(2)
  end

  it "returns the sum of the array when all the numbers are less than five" do
    expect(bowling_scores([1,2,3,4,1,2,3,4,1,2,3,4,0,2,3,4,1,2,3,4])).to eq(49)
  end

  it "doubles the following roll's score if a half-strike is rolled" do
    expect(bowling_scores([1,2,3,5,5,2,3,4,1,2,3,4,0,2,3,4,1,2,3,4])).to eq(54)
    expect(bowling_scores([1,2,3,4,5,5,3,4,1,2,3,4,0,2,3,4,1,2,3,4])).to eq(59)
    
    expect(bowling_scores([1,2,3,4,5,5,3,4,1,2,3,4,0,2,3,5,5,2,3,4])).to eq(64)
    expect(bowling_scores([1,2,3,4,1,9,3,4,1,2,3,4,0,2,3,4,5,5,3,4])).to eq(69)

    expect(bowling_scores([1,2,3,4,1,9,3,7,1,2,3,4,0,2,3,4,5,5,3,4])).to eq(73)

    # this test is wrong
    # expect(bowling_scores([1,2,3,5,5,2,3,4,1,2,3,4,0,2,3,4,1,2,3,7,4])).to eq(65)
    expect(bowling_scores([1,2,3,5,5,2,3,4,1,2,3,4,0,2,3,4,1,2,3,7,4])).to eq(61)
  end

  it "ends the frame & doubles scores of following two rolls if a strike occurs" do
    expect(bowling_scores([10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])).to eq(10)

    expect(bowling_scores([0,10,3,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])).to eq(20)
    expect(bowling_scores([10,3,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])).to eq(24)
    expect(bowling_scores([10,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])).to eq(18)

    expect(bowling_scores([10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0])).to eq(20)
  end

  it "scores a mixed game" do
    rolls = [2,4,5,3,1,6,8,2,0,2,6,4,10,7,3,0,10,6,4,7]
    expect(bowling_scores rolls).to eq 116
  end

end
