class Bottles
  def verse(num)
    nextbnum = num.pred
      "#{no_more(num).capitalize} #{bottles_or_bottle(num)} of beer on the wall, #{no_more(num)} #{bottles_or_bottle(num)} of beer.\n" +
        "#{action(num)}, #{no_more(nextbnum)} #{bottles_or_bottle(nextbnum)} of beer on the wall.\n"
  end

  def verses(num, num2)
    num.downto(num2).inject("") { |result, v|
      result + verse(v) + "\n"
    }
  end

  def sing
    verses(99,0)
  end

  private
  def action(num)
    BottleNum.new(num).action
  end

  def bottles_or_bottle(num)
    BottleNum.new(num).bottles_or_bottle
  end

  def it_or_one(num)
    BottleNum.new(num).it_or_one
  end

  def bottles_remaining(num)
    BottleNum.new(num).bottles_remaining
  end

  def decrement(num)
    BottleNum.new(num).decrement
  end

  def no_more(num)
    BottleNum.new(num).no_more
  end
  
end

class BottleNum

  def initialize(num)
    @num = num
  end

  def one_less_then_num
    @num - 1
  end

  def action
    if @num == 0
      "Go to the store and buy some more"
    else
      "Take #{it_or_one} down and pass it around"
    end
  end

  def it_or_one
    @num == 1 ? "it" : "one"
  end
  
  def bottles_or_bottle
    @num == 1 ? "bottle" : "bottles"
  end

  def decrement
    return 99 if @num == -1
    @num
  end

  def no_more
    @num == 0 ? "no more" : "#{decrement}"
  end
  
  
end
