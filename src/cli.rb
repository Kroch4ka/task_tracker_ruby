require_relative "json_storage"
require_relative "task"
require_relative "task_list"

action, *params = ARGV
storage = JSONStorage.new
list = TaskList.new(storage.tasks)

arg_to_list_action = {
  "done" => proc { list.done },
  "todo" => proc { list.todo },
  "in-progress" => proc { list.in_progress }
}

case action
when "add"
  description = params[0]
  task = storage.add(description)
  puts "Output: Task added successfully (ID: #{task.id})"
when "delete"
  id = params[0]
  storage.delete(id.to_i)
  puts "Output: Task deleted successfully (ID: #{id})"
when "update"
  id, description = params
  storage.update(id.to_i, description, nil)
  puts "Output: Task updated successfully (ID: #{id})"
when "mark-in-progress"
  id = params[0]
  result = storage.update(id.to_i, nil, :in_progress)
  puts "Output: Task updated successfully (ID: #{id})" if result
when "mark-done"
  id = params[0]
  storage.update(id.to_i, nil, :done)
  puts "Output: Task updated successfully (ID: #{id})"
when "list"
  status = params[0]
  tasks = arg_to_list_action[status]&.call || storage.tasks
  tasks.each_with_index do |task, index|
    puts "#{index + 1}) ID: #{task.id}. Description: #{task.description}. Status: #{task.status}. CreatedAt: #{task.created_at}"
  end
end
