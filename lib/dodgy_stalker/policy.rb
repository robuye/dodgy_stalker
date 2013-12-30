module DodgyStalker
  class Policy
    def initialize(spamcheck_results)
      @spamcheck_results = spamcheck_results
    end

    def validate
      #analyze results to determine the ranking
      spamcheck_results.any?
    end

    private

    def spamcheck_results
      @spamcheck_results
    end
  end
end
