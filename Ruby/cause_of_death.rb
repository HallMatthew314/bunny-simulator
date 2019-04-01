module CauseOfDeath
  OLD_AGE = 0
  FAMINE = 1

  def self.value_to_string(n)
    case n
    when 0 then 'old age'
    when 1 then 'famine'
    else 'Invalid'
    end
  end
end