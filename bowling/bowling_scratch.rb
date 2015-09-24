## Scatch Pad for Bowling Project
## ------------------------------

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
