## Scatch Pad for Bowling Project
## ------------------------------

def bowling_scores(game)
  score_game(build_total_score_list(game))
end

def score_game(xs)
  xs.inject(:+)
end

def build_total_score_list xs
  if last_frame? xs
    xs
  elsif strike? xs
    handle_strike(xs) + build_total_score_list(xs[1..-1])
  elsif spare? xs
    handle_spare(xs)  + build_total_score_list(xs[2..-1])
  else
    handle_frame(xs)  + build_total_score_list(xs[2..-1])
  end
end

def strike?(xs)
  xs[0] == 0
end

def spare?(xs)
  xs[0] + xs[1] == 10
end

def handle_strike(xs)
  xs[0,1] + xs[1,2]
end

def handle_spare(xs)
  xs[0,2] + xs[2,1]
end

def handle_frame(xs)
  xs[0,2]
end

def rec_score_helper xs
  if xs.length <= 3
    xs
  elsif xs[0] == 10
    xs[0,1] + xs[1,2] + rec_scores(xs[1..-1])
  elsif xs[0] + xs[1] == 10
    xs[0,2] + xs[2,1] + rec_scores(xs[2..-1])
  else
    xs[0,2]] + rec_scores(xs[2..-1])
  end
end

def bowling_scores(lines)
  rec_score_helper(xs).inject(:+)
end

def helper xs
  return xs if xs.size <= 3
  return xs[0,1] + xs[1,2] + helper(xs[1..-1]) if xs[0] == 10
  return xs[0,2] + xs[2,1] + helper(xs[2..-1]) if xs[0] + xs[1] == 10
  return xs[0,2] + helper(xs[2..-1])
end

puts ->() {

  comp = ->(f, g) {
    ->(n) { f.(g.(n)) }
  }

  fact = ->(n) { n.zero? ? 1 : n*fact.(n-1) }
  fact.(5)

  add1 = ->(n) { n + 1 }
  mul3 = ->() { ->(n) { n * 3 } }.call()
  mul3.(2)

  add1mul3 = comp.(mul3, add1)
  add1mul3.(10)

  fact = ->(gen) {
    gen.(gen)
  }.(
    ->(gen) {
      ->(n) { n.zero? ? 1 : n*gen.(gen).(n-1) }      
    }
  )

  fact.(5)

}.call()
