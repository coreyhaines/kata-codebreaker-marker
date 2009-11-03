class Marker
  def initialize(secret)
    @secret = secret
  end
  def guess(these)
    @guess = these
  end
  def mark
    ['p'] * count_of_positional_matches + 
    ['m'] * count_of_non_positional_matches
  end
  def count_of_positional_matches
    [@secret, @guess].transpose.inject(0) do |count, colors|
      count + (colors[0] == colors[1] ? 1 : 0)
    end
  end
  def count_of_non_positional_matches
    (@secret & @guess).size - count_of_positional_matches
  end
end
