class SampleLeadsCount
  LEAD_COUNTS = [20, 40, 100, 200, 500, 1000]

  def self.call(array = nil)
    (array || LEAD_COUNTS).sample
  end
end
