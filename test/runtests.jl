# test file for LEB128.jl
using Base.Test

include("../src/leb128.jl")

println("Testing LEB128 encoding and decoding.")

print("Known results ... ")
@test LEB128.encode(UInt32(624485)) ==  UInt8[0xe5,0x8e,0x26]
@test LEB128.encode(UInt64(2147483647)) == UInt8[0xff,0xff,0xff,0xff,0x07]
@test LEB128.encode(-1) == UInt8[0x01]
@test LEB128.encode(0) == UInt8[0x00]
@test LEB128.encode(2147483647) == UInt8[0xfe,0xff,0xff,0xff,0x0f]
@test LEB128.encode(-2147483647) == UInt8[0xfd,0xff,0xff,0xff,0x0f]
println("PASS")

println("Type min and max ...")
types = [UInt8, UInt16, UInt32, UInt64, UInt64, Int8, Int16, Int32, Int64, Int64]
n = 3
for t in types
  a = typemin(t)
  b = typemax(t)
  print("$t min ... ")
  @test LEB128.decode(LEB128.encode(a),t)[1] == a
  println("PASS")
  print("$t max ... ")
  @test LEB128.decode(LEB128.encode(b),t)[1] == b
  println("PASS")
  print("$t random $n x $n matrix ...")
  x = rand(a:b, n, n)
  y = reshape(LEB128.decode(LEB128.encode(x),t), n, n)
  @test x == y
  println("PASS")
end
