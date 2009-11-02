class Marker
  NonPositionalMarker = 'm'
  PositionalMarker = 'p'
  def initialize(secret)
    @secret = secret
  end
  def guess(these)
    @guess = these
  end
  def mark
    return [PositionalMarker] * count_of_positional_matches +
           [NonPositionalMarker] * count_of_nonpositional_matches 
  end
  def count_of_positional_matches
    color_pairs = [@secret, @guess].transpose
    color_pairs.inject(0) do |count, colors|
      count + (colors[0] == colors[1] ? 1 : 0)
    end
  end
  def count_of_nonpositional_matches
    (@guess & @secret).size - count_of_positional_matches
  end
end
