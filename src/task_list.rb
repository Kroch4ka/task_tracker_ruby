class TaskList
  def initialize(tasks)
    @tasks = tasks
  end

  def todo = tasks.filter { _1.status == :todo }
  def done = tasks.filter { _1.status == :done }
  def in_progress = tasks.filter { _1.status == :in_progress }

  private

  attr_reader :tasks
end
