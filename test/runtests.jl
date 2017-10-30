# test file for LittleEndianBase128.jl
using Test

include("../src/LittleEndianBase128.jl")

println("Testing LittleEndianBase128 encoding and decoding.")

print("Known results ... ")
@test LittleEndianBase128.encode(UInt32(624485)) ==  UInt8[0xe5,0x8e,0x26]
@test LittleEndianBase128.encode(UInt64(2147483647)) == UInt8[0xff,0xff,0xff,0xff,0x07]
@test LittleEndianBase128.encode(-1) == UInt8[0x01]
@test LittleEndianBase128.encode(0) == UInt8[0x00]
@test LittleEndianBase128.encode(2147483647) == UInt8[0xfe,0xff,0xff,0xff,0x0f]
@test LittleEndianBase128.encode(-2147483647) == UInt8[0xfd,0xff,0xff,0xff,0x0f]
@test LittleEndianBase128.decodesigned(LittleEndianBase128.encode(-2147483647)) == [-2147483647]
@test LittleEndianBase128.decode(UInt8(0x01)) == [0x01]
println("PASS")

println("Type min and max ...")
types = [UInt8, UInt16, UInt32, UInt64, UInt64, Int8, Int16, Int32, Int64, Int64]
n = 3
for t in types
  a = typemin(t)
  b = typemax(t)
  print("$t min ... ")
  u = LittleEndianBase128.decode(LittleEndianBase128.encode(a),t)[1]
  @test u == a
  @test typeof(u) == typeof(a)
  println("PASS")
  print("$t max ... ")
  u = LittleEndianBase128.decode(LittleEndianBase128.encode(b),t)[1]
  @test u == b
  @test typeof(u) == typeof(b)
  println("PASS")
  print("$t random $n x $n matrix ...")
  x = rand(a:b, n, n)
  y = reshape(LittleEndianBase128.decode(LittleEndianBase128.encode(x),t), n, n)
  @test x == y
  println("PASS")
end
