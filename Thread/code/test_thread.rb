# A Thread subclass with some handy features for tracking them.
class TestingThread < Thread
  def initialize(id = 0)
    @id = id
    @creation_time = Time.now
    super
  end

  def to_s
    self.inspect
  end

  def inspect
    "\#<#{self.class}:#{@id} (#{status})>"
  end
end
