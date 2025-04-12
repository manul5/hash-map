require_relative 'lib/hash_map'

test = HashMap.new
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
puts test.capacity
puts test.get('kite')
test.set('moon', 'silver')
puts test.capacity
puts test.get('kite')
test.set('tralalero', 'tralalerito')
puts test.has?('555555')
puts test.has?('tralalero')
