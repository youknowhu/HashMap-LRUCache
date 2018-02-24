class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num >= 0  && num < @store.length
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = num % num_buckets
    @store[bucket] << num
  end

  def remove(num)
    bucket = num % num_buckets
    @store[bucket].delete(num)
  end

  def include?(num)
    bucket = num % num_buckets
    @store[bucket].include?(num)
  end

  private

  # def [](num)
  #   # optional but useful; return the bucket corresponding to `num`
  #   # [num % num_buckets]
  # end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return if self[num].include?(num)

    if count == num_buckets
      resize!
    end

    self[num] << num
    @count += 1
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    bucket = num % num_buckets
    @store[bucket]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new  }

    @store.each do |bucket|
      bucket.each do |el|
        new_bucket = el % new_store.length
        new_store[new_bucket] << el
      end
    end

    @store = new_store
  end
end
