# frozen_string_literal: true

# Check if a string is an integer
class String
  def i?
    !!(self =~ /\A[-+]?[0-9]+\z/)
  end
end
