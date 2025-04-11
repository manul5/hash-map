class Node
  attr_accessor :value, :next_node, :key

  def initialize(key = nil, value = nil)
    @key = key
    @value = value
    @next_node = nil
  end

  def to_s
    "{#{@key}: #{@value}}"
  end
end
