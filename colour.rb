module Colour
  WHITE = 0
  BROWN = 1
  BLACK = 2
  SPOTTED = 3

  def self.value_to_string(n)
    case n
    when 0 then 'White'
    when 1 then 'Brown'
    when 2 then 'Black'
    when 3 then 'Spotted'
    else 'Invalid'
    end
  end
end