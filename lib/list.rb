class List

  attr :name

  def initialize name
    @name = name
    @list_id = 0
  end

  def self.all
    all_lists = DB.exec("SELECT * FROM lists;")
    lists = []
    all_lists.each do |list|
      list_name = list["name"]
      lists << list_name
    end
    lists
  end

  def ==(different_list)
    self.name == different_list.name
  end

  def all_tasks
    tasks = []
    all_tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{@list_id};")
    all_tasks.each do |task|
      tasks << task
    end
    tasks
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING list_id;")
    @list_id = results.first['list_id'].to_i
  end

end
