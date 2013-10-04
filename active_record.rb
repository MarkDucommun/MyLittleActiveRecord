require 'sqlite3'

class Database
  def initialize(database_name)
    @db = SQLite3::Database.new(database_name + ".db")
  end

  def execute(sql_code_string)
    @db.execute(sql_code_string)
  end
end

class Table
  attr_reader :database, :table_name

  def initialize(table_name, database)
    @database = database
    @table_name = table_name
    database.execute(
      "CREATE TABLE #{table_name}(
         id INTEGER PRIMARY KEY AUTOINCREMENT);")
  end

  def add_column(column_name, type)
    database.execute(
      "ALTER TABLE #{table_name} ADD #{column_name} #{type};")
  end

  def create(input_hash)
    database.execute("INSERT INTO #{table_name} (#{input_hash.each_key.to_a.join(",")})" +
      " VALUES (" + create_value_string(input_hash) + ");")
  end

  def create_value_string(input_hash)
    string = ""
    input_hash.each_value do |value|
      string += '"' + value + '",' if value.class == String
      string += value.to_s + ',' if value.class == Fixnum
    end
    string.slice!(-1)
    string
  end
end

class Model
  def initialize
  # reach into the database
    # find the schema for the table that matches the class name
    # for each column in that table
      # make a getter
      # make a setter
  end
end

# Migration
test = Database.new("test")

cars = Table.new("cars", test)
cars.add_column("capacity", "INTEGER")
cars.add_column("make", "VARCHAR(64)")
cars.add_column("model", "VARCHAR(64)")

people = Table.new("people", test)
people.add_column("name", "VARCHAR(64)")
people.add_column("car_id", "INTEGER")


# classes

class Car < Model
end

# Some Code

car_1 = Car.create(make: "Ford", model: "Focus", capacity: 5)
car_1.make # return Ford
car_1.make = "Chevy"
car_1.save

# Close the program

car_1.make # return Chevy 

# people.create({name: "Jim", car_id: 1})
# people.create({name: "Jeff", car_id: 1})

# car_hash = {make: "Ford", model: "Focus", capacity: 5}
# cars.create(car_hash)
