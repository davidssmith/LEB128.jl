# LEB128.jl

Little Endian Base 128 (LEB128) encoding and decoding module for the Julia programming language

## Introduction

[LEB128](https://en.wikipedia.org/wiki/LEB128) or Little Endian Base 128 is a form of variable-length code compression
used to store an arbitrarily large integer in a small number of bytes. There are 2 versions of LEB128: unsigned LEB128 and signed LEB128. The decoder must know whether the
encoded value is unsigned LEB128 or signed LEB128.


## Example
