require 'rspec'
require 'pg'
require 'task'
require 'list'

DB = PG.connect(:dbname => 'to_do')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lists *;")
  end
end

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe Task do

  it 'should start with no tasks.' do
    expect(Task.all).to eq []
  end

  it 'should create a task.' do
    test_task = Task.new('do homework', 1)
    expect(test_task).to be_an_instance_of Task
  end

  it 'should return its name' do
    test_task = Task.new('do homework', 1)
    expect(test_task.name).to eq 'do homework'
  end

  it 'initializes with a list id' do
    test_task = Task.new('do homework', 1)
    expect(test_task.list_id).to eq 1
  end

  it 'should be the same task if the task names are the same' do
    task1 = Task.new('do homework', 1)
    task2 = Task.new('do homework', 1)
    expect(task1==task2).to eq true
  end

  it 'should save the task to a list.' do
    task = Task.new('do homework', 15)
    test_list = List.new('school tasks')
    test_list.save
    task.save
    expect(test_list.all_tasks).to eq [task]
  end
end

describe List do

  it 'should create a list with a name.' do
    test_list = List.new('school tasks')
    expect(test_list).to be_an_instance_of List
  end

  it 'should return the list name' do
    test_list = List.new('school tasks')
    expect(test_list.name).to eq 'school tasks'
  end

  it 'starts off with no lists' do
    expect(List.all).to eq []
  end

  it 'should be the same list if the list names are the same' do
    list1 = List.new('school stuff')
    list2 = List.new('school stuff')
    expect(list1==list2).to eq true
  end

  it 'allows you to save lists to the database' do
    test_list = List.new('school stuff')
    test_list.save
    expect(List.all).to eq [test_list.name]
  end
end
