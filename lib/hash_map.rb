class HashMap
  attr_accessor :capacity, :buckets, :size

  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = []
    @size = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def grow_needed?
    @size + 1 > (@capacity * @load_factor).round
  end

  def rehash(old_buckets)
    @buckets = []
    @size = 0
    old_buckets.each do |list|
      next if list.nil?
      list.each do |node|
        hash_code = hash(node[0])
        bucket_number = get_bucket(hash_code)
        if @buckets[bucket_number].nil?
          @buckets[bucket_number] = []
          @buckets[bucket_number] << [node[0], node[1]]
        else
          handle_collition(bucket_number, node[0], node[1])
        end
        @size += 1
      end
    end
  end

  def grow
    @capacity *= 2
    old_buckets = @buckets
    rehash(old_buckets)
  end

  def get_bucket(hash_code)
    grow if grow_needed?
    hash_code % @capacity
  end

  def handle_collition(bucket_number, key, value)
    for node in @buckets[bucket_number]
      if node[0] == key
        node[1] = value
        return
      end
    end
    @buckets[bucket_number] << [key, value]
  end

  def set(key, value)
    hash_code = hash(key)
    bucket_number = get_bucket(hash_code)
    if @buckets[bucket_number].nil?
      @buckets[bucket_number] = []
      @buckets[bucket_number] << [key, value]
    else
      handle_collition(bucket_number, key, value)
    end
    @size += 1
  end

  def get(key)
    hash_code = hash(key)
    bucket_number = get_bucket(hash_code)
    bucket = @buckets[bucket_number]
    return nil unless bucket

    bucket.each do |node|
      return node[1] if node[0] == key
    end
  end

  def has?(key)
    hash_code = hash(key)
    bucket_number = get_bucket(hash_code)
    bucket = @buckets[bucket_number]
    return false unless bucket

    bucket.each do |node|
      return true if node[0] == key
    end
    false
  end
end
