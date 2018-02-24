class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    accumulator = self.length.hash

    self[0..-2].each_with_index do |el, idx|
      accumulator += (el.hash % self[idx + 1]).hash
    end

    accumulator += self[-1].hash
  end
end

class String
  def hash
    string_ords = chars.map { |char| char.ord.to_f }

    string_ords.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    accumulator = self.length.hash.to_f
    hash_pairs = self.to_a.sort
    hash_pairs.each do |k, v|
      accumulator += (k.hash.to_f * v.hash.to_f)
    end
    accumulator.to_i
  end
end
