# DUCK TYPING
# Un objeto que es pasado como parámetro a una función, soporta todos los métodos y atributos que se esperan que ese objeto pueda ejecutar. De esta manera, se puede implementar polimorfismo sin tener que recurrir a la herencia.

class Animal 
    def talk(animal)
        animal.talk 
    end
end

class Dog < Animal
    def talk
        puts "woof woof"
    end
end    

class Cat < Animal
    def talk
        puts "meow meow"
    end
end  

class Cow < Animal
    def talk
        puts "moo mooo"
    end
end  

animal = Animal
dog = Dog.new
cat = Cat.new
cow = Cow.new
animal.talk(dog)
animal.talk(cat)
animal.talk(cow)