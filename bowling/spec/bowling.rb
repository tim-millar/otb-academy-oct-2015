class Bowling

  def self.total_score game
    new.score_game game
  end

  :private

  def initialize; end

  def score_game xs
    sum_scores(build_total_score_list(xs))
  end

  def sum_scores xs
    xs.inject(:+)
  end

  def build_total_score_list xs
    if last_frame? xs
      xs
    elsif strike? xs
      double_next_two_rolls(xs) + build_total_score_list(xs[1..-1])
    elsif spare? xs
      double_next_roll(xs) + build_total_score_list(xs[2..-1])
    else
      do_nothing(xs) + build_total_score_list(xs[2..-1])
    end
  end

  def last_frame? xs
    xs.size <= 3
  end

  def strike? xs
    xs[0] == 10
  end

  def spare? xs
    xs[0] + xs[1] == 10
  end

  def double_next_two_rolls xs
    xs[0,1] + xs[1,2]
  end

  def double_next_roll xs
    xs[0,2] + xs[2,1]
  end

  def do_nothing xs
    xs[0,2]
  end
  
end
