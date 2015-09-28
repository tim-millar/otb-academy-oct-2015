class Bottles
  
  def verse(num)
    "#{handle_zero(num).capitalize} #{pluralize_bottle(num)} of beer on the wall, #{handle_zero(num)} #{pluralize_bottle(num)} of beer.\n#{take_or_go(num)}, #{handle_zero(dec(num))} #{pluralize_bottle(dec(num))} of beer on the wall.\n"
  end

    def take_or_go(num)
      if num == 0
        "Go to the store and buy some more"
      else
        "Take #{handle_unit(num)} down and pass it around"
      end
    end

    def dec(num)
      if num == 0
        99
      else
        num-1
      end
    end

    def handle_zero(num)
      if num == 0
        "no more"
      else
        num.to_s
      end
    end

    def handle_unit(num)
      if num == 1
        "it"
      else
        "one"
      end
    end

    def pluralize_bottle(num)
      if num == 1
        "bottle"
      else
        "bottles"
      end
    end

    def verses(num, num2)
      result = ""
      num.downto(num2).each do |v|
        result += self.verse(v) + "\n"
      end
      result
    end

    def sing
      verses(99,0)
    end
end
