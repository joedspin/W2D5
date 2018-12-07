class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    arr_num = 0 
    return arr_num.hash if self.empty?
    self.each_with_index{ |ele, i| arr_num += ( ele * (i + 4) ) }
    arr_num.hash
  end
end

class String
  def hash
    ints = self.chars.map { |char| char.ord }
    ints.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    keys = self.keys.sort.join
    values = self.values.sort.join 
   (keys + values).hash
  end
end
