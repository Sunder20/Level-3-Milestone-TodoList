require "date"

class Todo
  attr_accessor :text,:due_date,:completed,:is_overdue,:is_duetoday,:is_duelater
  def initialize(t,d,c)
    @text=t
    @due_date=d
    @completed=c
  end
  def is_duetoday?
    if @due_date==Date.today
      return true
    end
  end
  def is_overdue?
    if @due_date<Date.today
      return true
    end
  end
  def is_duelater?
    if @due_date>Date.today
      return true
    end
  end
  def to_displayable_string
    if is_duetoday? 
      if @completed==true
        s="[X] #{@text}"
      else
        s="[ ] #{@text} "
      end
    else
      if @completed==true
        s="[X] #{@text} #{@due_date} "
      else
        s="[ ] #{@text} #{@due_date} "
      end 
    end
    return s
  end
end  

class TodosList
  attr_accessor :todos
  def initialize(todo)
    @todos=todo
  end
  def add(todo)
    @todos << todo
  end
  def overdue
    TodosList.new(@todos.select { |todo| todo.is_overdue? })
  end  
  def due_today
    TodosList.new(@todos.select { |todo| todo.is_duetoday? })
  end
  def due_later
    TodosList.new(@todos.select { |todo| todo.is_duelater? })
  end

 
  def to_displayable_list
    @todos=@todos.map { |todo| todo.to_displayable_string}
  end
end

#main
date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
