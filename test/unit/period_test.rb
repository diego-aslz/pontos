require 'test_helper'

class PeriodTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Period.new.valid?
  end
end
