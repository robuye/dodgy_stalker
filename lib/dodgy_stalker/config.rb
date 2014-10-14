module DodgyStalker
  class Config
    attr_accessor :word_separator

    def word_separator
      @word_separator ||= %q{(^|\s|\A|\Z|$|\.|,|''|"|`)}
    end
  end
end
