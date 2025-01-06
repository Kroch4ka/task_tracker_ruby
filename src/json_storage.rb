require_relative "storage"
require_relative "task"

require "json"

class JSONStorage < Storage
  FILE_NAME = "tasks_storage.json"

  protected

  def persist
    File.open(FILE_NAME, "w+") do |f|
      f.write(JSON.dump(tasks.map(&:to_h)))
    end
  end

  def load_tasks
    File.open(FILE_NAME, "a+") do |f|
      JSON.parse(f.read).map do |task|
        Task.new(
          id: task["id"].to_i, 
          description: task["description"], 
          status: task["status"].to_sym,
          created_at: task["created_at"],
          updated_at: task["updated_at"]
        )
      end
    rescue JSON::ParserError
      []
    end
  end
end
