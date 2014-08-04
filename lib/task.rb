class Task

  attr :name, :list_id

  def initialize name, list_id
    @name = name
    @list_id = list_id
  end

  def self.all
    @all_tasks = []
  end

  def ==(different_task)
    self.name == different_task.name
  end

  def save
    DB.exec("INSERT INTO tasks (name, list_id) VALUES ('#{@name}', #{@list_id});")
  end

end
