module Sex
  FEMALE = 0
  MALE = 1

  def self.value_to_string(n)
    case n
    when 0 then 'Female'
    when 1 then 'Male'
    else 'Invalid'
    end
  end
end