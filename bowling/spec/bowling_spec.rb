require_relative 'bowling'

RSpec.describe "Bowling Scores" do

  it "returns zero if all of the rolls are zero" do
    expect(Bowling.total_score([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])).to eq(0)
  end

  it "returns 2 when given an array containing 2 and 19 zeroes" do
    expect(Bowling.total_score([0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])).to eq(2)
  end

  it "returns the sum of the array when all the numbers are less than five" do
    expect(Bowling.total_score([1,2,3,4,1,2,3,4,1,2,3,4,0,2,3,4,1,2,3,4])).to eq(49)
  end

  it "doubles the following roll's score if a half-strike is rolled" do
    expect(Bowling.total_score([1,2,3,5,5,2,3,4,1,2,3,4,0,2,3,4,1,2,3,4])).to eq(54)
    expect(Bowling.total_score([1,2,3,4,5,5,3,4,1,2,3,4,0,2,3,4,1,2,3,4])).to eq(59)
    
    expect(Bowling.total_score([1,2,3,4,5,5,3,4,1,2,3,4,0,2,3,5,5,2,3,4])).to eq(64)
    expect(Bowling.total_score([1,2,3,4,1,9,3,4,1,2,3,4,0,2,3,4,5,5,3,4])).to eq(69)

    expect(Bowling.total_score([1,2,3,4,1,9,3,7,1,2,3,4,0,2,3,4,5,5,3,4])).to eq(73)

    expect(Bowling.total_score([1,2,3,5,5,2,3,4,1,2,3,4,0,2,3,4,1,2,3,7,4])).to eq(61)
  end

  it "ends the frame & doubles score of following two rolls if a strike occurs" do
    expect(Bowling.total_score([10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])).to eq(10)

    expect(Bowling.total_score([0,10,3,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])).to eq(20)
    expect(Bowling.total_score([10,3,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])).to eq(24)
    expect(Bowling.total_score([10,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])).to eq(18)

    expect(Bowling.total_score([10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0])).to eq(20)
  end

  it "scores a mixed game" do
    rolls1 = [2,4,5,3,1,6,8,2,0,2,6,4,10,7,3,0,10,6,4,7]
    expect(Bowling.total_score(rolls1)).to eq(116)

    rolls2 = [2,6,3,4,4,6,2,2,10,1,3,6,3,10,4,4,3,7,5]
    expect(Bowling.total_score(rolls2)).to eq(99)

    rolls3 = [4,2, 6,3, 1,1, 9,0, 3,7, 6,2, 1,8, 5,5, 10, 6,2,3]
    expect(Bowling.total_score(rolls3)).to eq(108)

    rolls4 = [3,3,3,4,5,5,2,1,6,4,3,0,0,10,3,4,1,9,4,6,2]
    expect(Bowling.total_score(rolls4)).to eq(90)

    rolls5 = [3,5,3,1,6,2,1,1,0,10,8,1,2,0,10,5,0,6,4,4]
    expect(Bowling.total_score(rolls5)).to eq(85)

    rolls6 = [6,4,0,5,4,2,9,1,4,2,7,3,0,0,7,1,10,7,3,2]
    expect(Bowling.total_score(rolls6)).to eq(91)
  end

  it "scores the maxiumum correctly" do
    rolls = [10,10,10,10,10,10,10,10,10,10,10,10]
    expect(Bowling.total_score(rolls)).to eq(300)
  end

end
