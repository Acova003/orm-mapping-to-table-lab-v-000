class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  attr_accessor :name, :grade
  attr_reader :id
  
  ALL = []
  
  def initialize(id=nil, name, grade)
    @id = id 
    @name = name 
    @grade = grade
    ALL << self
  end 
  
  def self.all 
    ALL
  end 
  
  def self.create_table 
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade INTEGER
        )
    SQL
    DB[:conn].execute(sql) 
  end 
  
  def self.drop_table 
    sql = <<-SQL 
    DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
  end 
  
  def save 
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    
    last_student = ALL[-1]
    @id = last_student.id
    binding.pry
  end 
  
  def self.create
    ALL << Student.new(name, grade)
  end 
end
