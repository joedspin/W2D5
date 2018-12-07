require 'byebug'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    num = num.hash
    unless self.include?(num)
      self[num] << num
      @count += 1
    end
     resize! if num_buckets == self.count

  end

  def remove(num)
    # debugger
    if self.include?(num)
      num = num.hash
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    num = num.hash
    self[num].include?(num)
  end

  def inspect
    puts @store
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    idx = num % num_buckets
    @store[idx]
  end

  def num_buckets
    @store.length
    
  end

  def resize!   
    temp_store = dd_map(@store)
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    temp_store.each do |bucket|
      bucket.each { |el| self.insert(el) }
    end
  end

  def dd_map(array)
    array.map { |el| el.is_a?(Array) ? dd_map(el) : el }
  end
end

# test = HashSet.new
# test.insert(6)
# test.insert(4)
# test.remove(6)
# p @store
