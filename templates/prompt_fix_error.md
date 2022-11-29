# CODE
a = 1 + "b"
# ERROR
String can't be coerced into Integer (TypeError)
# FIX
a = "1" + "b"
# CODE
a = "b#{c}"
# ERROR
undefined local variable or method `c' for main:Object (NameError)
# FIX
c = "c"
a = "b#{c}"
# CODE
"a".revrese
# ERROR
undefined method `revrese' for "a":String (NoMethodError)
# FIX
"a".reverse
# CODE
[1, 2, 3].map{ |a| a + b + 1 }
# ERROR
undefined local variable or method `b' for main:Object (NameError)
# FIX
[1, 2, 3].map do |a|
  b = 1
  a + b + 1
end
# CODE
[:a, :b, :c].map :&to_s
# ERROR
syntax error, unexpected local variable or method, expecting end-of-input (SyntaxError)
# FIX
[:a, :b, :c].map &:to_s
# CODE

# ERROR

# FIX

# CODE

# ERROR

# FIX

# CODE

# ERROR

# FIX

# CODE

# ERROR

# FIX
