require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
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
    bucket = num.hash % num_buckets
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
