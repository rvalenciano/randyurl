require 'singleton'

class EncodingUrlService
  include Singleton
  # Thanks to this SO question for helping understand the algorithm:
  # https://stackoverflow.com/questions/742013/how-to-code-a-url-shortener

  def initialize
    @alphabet = (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a).shuffle.join
  end

  def bijective_encode(i)
    # from http://refactormycode.com/codes/125-base-62-encoding
    # with only minor modification
    return @alphabet[0] if i == 0
    s = ''
    base = @alphabet.length
    while i > 0
      s << @alphabet[i.modulo(base)]
      i /= base
    end
    s.reverse
  end

  def bijective_decode(s)
    # based on base2dec() in Tcl translation
    # at http://rosettacode.org/wiki/Non-decimal_radices/Convert#Ruby
    i = 0
    base = @alphabet.length
    s.each_char { |c| i = i * base + @alphabet.index(c) }
    i
  end
end
