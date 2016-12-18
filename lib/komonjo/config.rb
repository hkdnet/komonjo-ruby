module Komonjo
  class Config
    attr_accessor :remove_skin_tone

    def initialize
      @remove_skin_tone = false
    end
  end
end
