require "ostruct"
require "securerandom"

module FakeStripe
  def self.charge(amount_cents:, currency:, source:, description:)
    OpenStruct.new(success?: true, id: "ch_fake_#{SecureRandom.hex(8)}")
  end
end

