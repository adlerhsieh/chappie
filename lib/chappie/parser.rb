module Chappie
  class Parser
    def self.parse(request = {})
      JSON.parse(request.body.read)
    end
  end
end
