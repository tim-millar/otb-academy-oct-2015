class Bottles
  def verse(num)
    bottle_num = create_bottle(num)
    next_bottle_num = create_bottle(bottle_num.decrement)
            "#{bottle_num.no_more.capitalize} #{bottle_num.bottles_or_bottle}of beer on the wall, #{bottle_num.no_more} #{bottle_num.bottles_or_bottle}of beer.\n" +
              "#{bottle_num.action}, #{next_bottle_num.no_more()} #{next_bottle_num.bottles_or_bottle()}of beer on the wall.\n"

  end

  def verses(num, num2)
    num.downto(num2).inject("") { |result, v|
      result + verse(v) + "\n"
    }
  end

  def sing
    verses(99,0)
  end

  def create_bottle(num)
    if num == 0
      BottleZero.new(num)
    elsif num == 1
      BottleOne.new(num)
    elsif num == 6
      BottleSix.new(num)
    else
      BottleNum.new(num)
    end
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
    "Take #{it_or_one} down and pass it around"
  end

  def it_or_one
    "one"
  end
  
  def bottles_or_bottle
    "bottles "
  end

  def decrement
    @num - 1
  end

  def no_more
    @num.to_s
  end
  
end

class BottleOne < BottleNum

  def it_or_one
    "it"
  end
  
  def bottles_or_bottle
    "bottle "
  end

end

class BottleZero < BottleNum

  def action
    "Go to the store and buy some more"
  end

  def no_more
    "no more"
  end

  def decrement
    99
  end

end

class BottleSix < BottleNum

  def no_more
    "one six-pack"
  end

  def bottles_or_bottle
    ""
  end
end
