module Monkeypatches

  class ::Hash
    alias_method :f, :fetch
  end

  class ::Array
    alias_method :f, :fetch
  end

end
