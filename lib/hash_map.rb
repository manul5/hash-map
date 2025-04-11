require_relative 'node'

class HashMap
  attr_accessor :capacity, :buckets

  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = []
  end

  def grow_if_needed
    # Usamos compact.size para contar elementos no nil
    if @buckets.compact.size > (@capacity * @load_factor).round
      # Guardamos los elementos existentes antes de redimensionar
      old_buckets = @buckets.dup
      # Duplicamos la capacidad (o otro factor de crecimiento)
      @capacity *= 2
      # Reiniciamos los buckets con el nuevo tamaño
      @buckets = Array.new(@capacity)
      # Reinsertamos los elementos en los nuevos buckets
      rehash(old_buckets)
    end
  end
  
  def rehash(old_buckets)
    old_buckets.each do |bucket|
      next if bucket.nil?
      # Recalculamos el índice para cada elemento con el nuevo @capacity
      bucket.each do |key, value|
        index = key.hash % @capacity
        @buckets[index] ||= []  # Inicializa un array si no existe
        @buckets[index] << [key, value]
      end
    end
  end

  def reduce_index(index)
    grow_if_needed
    index % @capacity
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    reduce_index(hash_code)
  end

  def check_collition(hash_code)
    @buckets[hash_code] ? true : false
  end

  def iterate_bucket(hash_code, new_node)
    existing_node = @buckets[hash_code]
    while existing_node
      if existing_node.key == new_node.key
        existing_node.value = new_node.value
        break
      elsif existing_node.next_node.nil?
        existing_node.next_node = new_node
        break
      end
      existing_node = existing_node.next_node
    end
  end

  def set(key, value)
    hash_code = hash(key)
    node = Node.new(key, value)
    if check_collition(hash_code)
      iterate_bucket(hash_code, node)
    else
      @buckets[hash_code] = node
    end
  end


end