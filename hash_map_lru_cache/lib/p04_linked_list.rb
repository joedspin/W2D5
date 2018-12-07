require 'byebug'


class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  attr_reader :count
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
    @count = 0
  end

  def [](i)
    each_with_index do |link, j| 
      return link if i == j 
    end
    nil
  end

  def first
    return nil if count == 0
    @head.next
  end

  def last
    return nil if count == 0
    @tail.prev
  end

  def empty?
    @count == 0
  end

  def get(key)
    self.each do |node|
      if node.key == key
        return node.val
      end
    end
  end

  def include?(key)
    self.any? { |node| node.key == key}
  end

  def append(key, val)
    new_node = Node.new(key, val)
    if @count == 0
      new_node.prev = @head
      @head.next = new_node
    else
      new_node.prev = self.last
      self.last.next = new_node
    end
    @tail.prev = new_node
    new_node.next = @tail
    @count += 1
  end

  def update(key, val)
    # return unless self.include?(key)
    # node = self[key] 
    # node.val = val
    self.each do |node|
      if node.key == key
        node.val = val
      end
    end
  end

  def remove(key)
    return unless self.include?(key)
    self.each do |node|
      if node.key == key
        prev_node = node.prev
        next_node = node.next
        next_node.prev = prev_node
        prev_node.next = next_node
        # node.prev = nil
        # node.next = nil
      end
    end
  end

  def each(&prc)
    prc ||= Proc.new { |node| node }
    node = @head.next
    until node == @tail
      prc.call(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
