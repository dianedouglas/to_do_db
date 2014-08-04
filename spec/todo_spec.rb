require 'rspec'
require 'pg'
require 'task'
require 'list'

DB = PG.connect(:dbname => 'to_do_test')

describe Task do

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
end
