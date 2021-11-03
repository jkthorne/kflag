require "benchmark"

require "./src/kflag"

int = 0

# struct UserRecord (10 bytes)
#   @a : Bool (0 bytes)
#   @b : Bool (0 bytes)
#   @c : Bool (0 bytes)
#   @d : Bool (0 bytes)
#   @e : Bool (0 bytes)
#   @f : Bool (0 bytes)
#   @g : Bool (0 bytes)
#   @h : Bool (0 bytes)
#   @i : Bool (0 bytes)
#   @j : Bool (0 bytes)
record(
  UserRecord,
  a = false,
  b = false,
  c = false,
  d = false,
  e = false,
  f = false,
  g = false,
  h = false,
  i = false,
  j = false
)

record = UserRecord.new

# struct UserFlag (4 bytes)
#   @data : Int32 (4 bytes)
kflag(UserFlag, a, b, c, d, e, f, g, h, i, j)

flag = UserFlag.new

blank : (Int32 | Bool) = false

puts "SMOKE"
Benchmark.ips do |x|
  x.report("int") do
    int = int | 1 << 8
    blank = int & (1 << 8)
    int & (1 << 8)
    int = int | 1 << 1
    blank = int & (1 << 1)
    int & (1 << 1)
    int = int | 1 << 4
    blank = int & (1 << 4)
    int & (1 << 4)
  end

  x.report("record") do
    record = record.copy_with h: true
    blank = record.h
    record = record.copy_with h: false
    record = record.copy_with a: true
    blank = record.h
    record = record.copy_with a: false
    record = record.copy_with d: true
    blank = record.h
    record = record.copy_with d: false
  end

  x.report("flag") do
    flag.set_h
    blank = flag.check_h
    flag.clear_h
    flag.set_a
    blank = flag.check_a
    flag.clear_a
    flag.set_d
    blank = flag.check_d
    flag.clear_d
  end
end

puts "SET"
Benchmark.ips do |x|
  x.report("int") do
    int = int | 1 << 0
    int = int | 1 << 1
    int = int | 1 << 2
    int = int | 1 << 3
    int = int | 1 << 4
    int = int | 1 << 5
    int = int | 1 << 6
    int = int | 1 << 7
    int = int | 1 << 8
    int = int | 1 << 9
  end

  x.report("record") do
    record = record.copy_with a: true
    record = record.copy_with b: true
    record = record.copy_with c: true
    record = record.copy_with d: true
    record = record.copy_with e: true
    record = record.copy_with f: true
    record = record.copy_with g: true
    record = record.copy_with h: true
    record = record.copy_with i: true
    record = record.copy_with j: true
  end

  x.report("flag") do
    flag.set_a
    flag.set_b
    flag.set_c
    flag.set_d
    flag.set_e
    flag.set_f
    flag.set_g
    flag.set_h
    flag.set_i
    flag.set_j
  end
end

puts "CHECK"
Benchmark.ips do |x|
  x.report("int") do
    blank = int & (1 << 0)
    blank = int & (1 << 1)
    blank = int & (1 << 2)
    blank = int & (1 << 3)
    blank = int & (1 << 4)
    blank = int & (1 << 5)
    blank = int & (1 << 6)
    blank = int & (1 << 7)
    blank = int & (1 << 8)
    blank = int & (1 << 9)
  end

  x.report("record") do
    blank = record.a
    blank = record.b
    blank = record.c
    blank = record.d
    blank = record.e
    blank = record.f
    blank = record.g
    blank = record.h
    blank = record.i
    blank = record.j
  end

  x.report("flag") do
    blank = flag.check_a
    blank = flag.check_b
    blank = flag.check_c
    blank = flag.check_d
    blank = flag.check_e
    blank = flag.check_f
    blank = flag.check_g
    blank = flag.check_h
    blank = flag.check_i
    blank = flag.check_j
  end
end

puts "CLEAR"
Benchmark.ips do |x|
  x.report("int") do
    int & (1 << 0)
    int & (1 << 1)
    int & (1 << 2)
    int & (1 << 3)
    int & (1 << 4)
    int & (1 << 5)
    int & (1 << 6)
    int & (1 << 7)
    int & (1 << 8)
    int & (1 << 9)
  end

  x.report("record") do
    record = record.copy_with a: false
    record = record.copy_with b: false
    record = record.copy_with c: false
    record = record.copy_with d: false
    record = record.copy_with e: false
    record = record.copy_with f: false
    record = record.copy_with g: false
    record = record.copy_with h: false
    record = record.copy_with i: false
    record = record.copy_with j: false
  end

  x.report("flag") do
    flag.clear_a
    flag.clear_b
    flag.clear_c
    flag.clear_d
    flag.clear_e
    flag.clear_f
    flag.clear_g
    flag.clear_h
    flag.clear_i
    flag.clear_j
  end
end
