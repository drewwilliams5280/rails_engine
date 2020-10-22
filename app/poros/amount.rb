class Amount
  attr_reader :id, :total
  def initialize(total)
    @id = nil
    @total = total
  end
end