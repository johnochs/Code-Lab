require 'byebug'

class Of_2016

  def initialize(deez = "nuts")
    @deez = deez
    @i, @j, = 6, 9
    silly_local_var = %(=^.^=)
  end

  def work_work_work_work_work
    serious_local_var = %(凸ಠ益ಠ\)凸)
    byebug
  end
end

instance = Of_2016.new("kneez")
instance.work_work_work_work_work
