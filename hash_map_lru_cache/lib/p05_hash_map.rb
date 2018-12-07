require_relative 'p04_linked_list'
require "byebug"

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    idx = key.hash % num_buckets
    @store[idx].include?(key)
  end

  def set(key, val)
    idx = key.hash % num_buckets
    if @store[idx].include?(key)
      @store[idx].update(key, val)
    else
      @store[idx].append(key, val)
      @count += 1
    end
  end

  def get(key)
    idx = key.hash % num_buckets
    @store[idx].get(key)
  end

  def delete(key)
    idx = key.hash % num_buckets
    if @store[idx].include?(key)
      @store[idx].remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    prc ||= Proc.new { |node| [node.key, node.val] }
    @store.each do |bucket|
      node = bucket.first
      until node == bucket.last
        prc.call(node)
        node = node.next
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
