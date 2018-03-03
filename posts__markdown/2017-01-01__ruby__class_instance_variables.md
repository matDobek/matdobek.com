## Class variables

Probably most of you already know what class variables are, but lets hit refresh.
Class variable is shared across all instances of class + all instances of subclasses.

```ruby
class Animal
  def self.animals_created
    @@animals_created ||= []
  end

  def self.add_animal(instance)
    @@animals_created << instance
  end

  def initialize
    self.class.animals_created
    self.class.add_animal(self)
  end
end

class Shark < Animal
end

class Seagull < Animal
end

shark = Shark.new
seagull1 = Seagull.new
seagull2= Seagull.new

puts Animal.animals_created.count #=> 3
puts Shark.animals_created.count #=> 3
puts Seagull.animals_created.count #=> 3
```

`Animal` , `Shark` and `Seagull` share the same `animals_created variable`, among all instances.

## Class instance variables

Class instance variable, is shared across all instances of class, but each subclass, has it's own copy of class instance variable.

```ruby
class Animal
  def self.animals_created
    @animals_created ||= []
  end

  def self.add_animal(instance)
    @animals_created << instance
  end

  def initialize
    self.class.animals_created
    self.class.add_animal(self)
  end
end

class Shark < Animal
end

class Seagull < Animal
end

shark = Shark.new
seagull1 = Seagull.new
seagull2= Seagull.new

puts Animal.animals_created.count #=> 0
puts Shark.animals_created.count #=> 1
puts Seagull.animals_created.count #=> 2
```

Class instance varialbe is different for `Animal`, `Shark` and `Seagull` class, but

* all `Animal` instances share the same `class_instance_variable`,
* all `Shark` instances share the same `class_instance_variable`, and
* all `Seagull` instances share the same `class_instance_variable`.
