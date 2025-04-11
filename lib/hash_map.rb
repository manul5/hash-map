class HashMap
  attr_accessor :capacity, :buckets

  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = []
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def get_bucket(hash_code)
    hash_code % @capacity
  end

  def set(key,value)
    hash_code = hash(key)
    bucket_number = get_bucket(hash_code)
    @buckets[bucket_number] = [] if @buckets[bucket_number].nil?
    @buckets[bucket_number] << [key, value]
    p @buckets[bucket_number]
  end


end