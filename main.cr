x = Int32::MAX

puts x.to_s(base: 2)

# CLEARING TO ZERO
x = (x & ~(1 << 2))
puts(x.to_s(base: 2))
x = (x & ~(1 << 3))
puts(x.to_s(base: 2))
x = (x & ~(1 << 4))
puts(x.to_s(base: 2))
x = (x & ~(1 << 5))
puts(x.to_s(base: 2))

# SETTING A BIT
y = 0

y = y | 1 << 2
puts(y.to_s(base: 2))
y = y | 1 << 3
puts(y.to_s(base: 2))
y = y | 1 << 4
puts(y.to_s(base: 2))
y = y | 1 << 5
puts(y.to_s(base: 2))

# READING BITS
puts((x & (1 << 2)).to_s(base: 2))
puts((y & (1 << 2)).to_s(base: 2))
puts((x & (1 << 3)).to_s(base: 2))
puts((y & (1 << 3)).to_s(base: 2))
