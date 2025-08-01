local jmath = {}
jmath.__index = jmath

local SIN_TABLE_FAST = {}
local SIN_TABLE = {}
local multiplyDeBruijnBitPosition

for i = 0, 65535 do
    SIN_TABLE[i] = math.sin(i * math.pi * 2 / 65536)
end

multiplyDeBruijnBitPosition = {0, 1, 28, 2, 29, 14, 24, 3, 30, 22, 20, 15, 25, 17, 4, 8, 31, 27, 13, 23, 21, 19, 16, 7, 26, 12, 18, 6, 11, 5, 10, 9}

for i = 0, 4095 do
    SIN_TABLE_FAST[i] = math.sin((i + 0.5) / 4096 * (math.pi * 2))
end

for i = 0, 360, 90 do
    SIN_TABLE_FAST[math.floor(i * 11.377778) % 4096] = math.sin(i * 0.017453292)
end

function jmath.sin(value)
    return SIN_TABLE[math.floor(value * 10430.378) % 65536]
end

function jmath.cos(value)
    return SIN_TABLE[math.floor(value * 10430.378 + 16384) % 65536]
end

function jmath.fastSin(value)
    return SIN_TABLE_FAST[math.floor(value * 651.8986) % 4096]
end

function jmath.fastCos(value)
    return SIN_TABLE_FAST[math.floor((value + (math.pi / 2)) * 651.8986) % 4096]
end

local function isPowerOfTwo(value)
    return value ~= 0 and (value and (value - 1)) == 0
end

local function calculateLogBaseTwoDeBruijn(value)
    value = isPowerOfTwo(value) and value or jmath.roundUpToPowerOfTwo(value)
    return multiplyDeBruijnBitPosition[math.floor(value * 125613361 / 2147483648) % 32 + 1]
end

function jmath.roundUpToPowerOfTwo(value)
    local var1 = value - 1
    var1 = bit.bor(var1, bit.rshift(var1, 1))
    var1 = bit.bor(var1, bit.rshift(var1, 2))
    var1 = bit.bor(var1, bit.rshift(var1, 4))
    var1 = bit.bor(var1, bit.rshift(var1, 8))
    var1 = bit.bor(var1, bit.rshift(var1, 16))
    return var1 + 1
end

function jmath.floor(value)
    local var2 = math.floor(value)
    return value < var2 and var2 - 1 or var2
end

function jmath.calculateLogBaseTwo(i)
    return calculateLogBaseTwoDeBruijn(i) - (isPowerOfTwo(i) and 0 or 1)
end

return jmath
