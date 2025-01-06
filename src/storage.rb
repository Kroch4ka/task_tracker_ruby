class Storage
  attr_reader :tasks

  def initialize
    @tasks = load_tasks
    @max_id = retrieve_id
  end

  def add(description)
    puts tasks.inspect
    Task.new(id: @max_id + 1, description:, status: :todo, created_at: Time.now).tap do |task|
      tasks << task
      persist
      @max_id += 1
    end
  end
  def delete(id)
    @tasks = @tasks.filter { _1.id != id }
    persist
  end
  def update(id, description, status)
    old_task = tasks.find { _1.id == id }
    need_update = (description && description != old_task.description) || (status && status != old_task.status)
    return unless need_update
    old_task.tap do |task|
      task.description = description if description
      task.status = status if status
      task.updated_at = Time.now
      persist
    end
  end

  protected

  def retrieve_id = tasks.map { _1.id.to_i }.max || 0
  def persist = raise NotImplementedError
  def load_tasks = raise NotImplementedError
end
