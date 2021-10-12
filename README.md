# Catalogue & Payment system

This project is a concepts test for an eCommerce platform with the application of a dinamic catalogue and payment registration. The main object is the implementation of polymorphic associations.

- [Catalogue & Payment system](#catalogue---payment-system)
  * [Ruby & Rails version](#ruby---rails-version)
  * [PART I](#part-i)
    + [1. Diagram model](#1-diagram-model)
    + [2. Incorporating the dinamic catalogue](#2-incorporating-the-dinamic-catalogue)
    + [3. Incorporating the payment system](#3-incorporating-the-payment-system)
    + [4. Simulation](#4-simulation)
  * [PART II: Polymorphic associations](#part-ii--polymorphic-associations)

## Ruby & Rails version

* ruby 2.6.1
* rails 5.2.3

## PART I

### 1. Diagram model

The next flowchart describes the final state of models incorporated below.

![diagram](/app/assets/images/diagram_last.png)

### 2. Incorporating the dinamic catalogue 

The eCommerce has a product with two categories: digital and physical products. Digital will have one image while physical will have many. The models for each of them are generated as it follows:

```console
rails g model Digital name
rails g model Physical name
rails g model Image url 
```

The new attribute category will be added to the Product model and will contain the polymorphic association connecting the digital and physical products. The Digital and Physical model will have many products through the category.

```console
rails g migration addCategoryToProduct category:references{polymorphic}
```

The relations are added to the models as:

```ruby
class Product < ApplicationRecord
  belongs_to :category, polymorphic: true
end

class Digital < ApplicationRecord
    has_one :image
    has_many :products, as: :category
end

class Physical < ApplicationRecord
    has_many :images
    has_many :products, as: :category
end

class Image < ApplicationRecord
    has_one_attached :image
end
```

Next, the funcionality is checked in the rails console:

```console
Product.create(name: 'lavadora', description: 'lava', stock: 10, category: Digital.create(name: 'linea blanca')
Product.create(name: 'secadora', description: 'seca', stock: 9, category: Physical.create(name: 'linea blanca'))
Product.all
```

### 3. Incorporating the payment system

The system includes three categories: Stripe, Transbank and Paypal. In addition, Transbank will have three payment methods: Credit Card, Webpay and One Click. The models are generated as it follows:

The payment model will contain the polymorphic association connecting stripe, paypal and transbank payments. Stripe, paypal and transbank will have many payments through paymentcategory.

```console
rails g model Payment state total:decimal paymentcategory:references{polymorphic}
rails g model Stripe user_ip
rails g model Paypal user_ip
```

The transbank model will contain the polymorphic association connecting credit card, webpay and one click payment methods. The CreditCard, Webpay and OneClick will have many transbanks through method.

```console
rails g model Transbank user_ip method:references{polymorphic}
rails g model CreditCard name  
rails g model Webpay name
rails g model OneClick name
```

In the models the associations are added just as:

```ruby
class Payment < ApplicationRecord
  belongs_to :paymentcategory, polymorphic: true
end

class Stripe < ApplicationRecord
    has_many :payments, as: :paymentcategory
end

class Paypal < ApplicationRecord
    has_many :payments, as: :paymentcategory
end

class Transbank < ApplicationRecord
  belongs_to :method, polymorphic: true
  has_many :payments, as: :paymentcategory
end

class CreditCard < ApplicationRecord
    has_many :transbanks, as: :method
end

class Webpay < ApplicationRecord
    has_many :transbanks, as: :method
end

class OneClick < ApplicationRecord
    has_many :transbanks, as: :method
end
```

The funcionality of the models is checked in the rails console as:

```console
Payment.create(state: 'initial', total: 99.9, paymentcategory: Stripe.create(user_ip: 'stripe user ip'))
Payment.create(state: 'progress', total: 99.9, paymentcategory: Transbank.create(user_ip: 'transbank user ip'))
Payment.create(state: 'finished', total: 99.9, paymentcategory: Paypal.create(user_ip: 'transbank user ip'))
Payment.all
```

```console
Transbank.create(user_ip: '123', method: CreditCard.create(name: 'carding'))
Transbank.create(user_ip: '345', method: Webpay.create(name: 'paying'))
Transbank.create(user_ip: '678', method: OneClick.create(name: 'clicking'))
Transbank.all
```

### 4. Simulation 

The form simulation of the payment system is accomplished through the model Order.

## PART II: Polymorphic associations

Initial database style:

```ruby
# model/animal.rb

class Animal < ApplicationController # ...
    def create
        # ...
        kind = params[:animal][:kind]
        if kind == "Dog":
            animal = Dog.new(animal_params)
            elsif kind == "Cat"
            animal = Cat.new(animal_params)
            else
            animal = Cow.new(animal_params)
        end 
    end
end
```

One way of improve the previous code is with Duck Typing. This way provides a polimorphic implementation without the use of inheritance. 

First, let's remember that a **Polymorphic Association** is an Active Record association that connects a model to multiple other models, in other words, a model can belong to more than one other model, all of this on a single association. Duck Typing is an implemetation of polymorphism.

Polymorphism example:

![diagram](/app/assets/images/polymorphism_example.png)

**Duck Typing** is described as an object type which is not defined by what it is but __*by what can do*__. This means that allows any object to be passed into a method in order to run. Just remember:

> If it looks like a duck, swims like a duck, and quacks like a duck, then it probably is a duck.

With Duck Typing the code looks just as it follows: 

```ruby
# model/animal.rb

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
```

```ruby
animal = Animal
dog = Dog.new
cat = Cat.new
cow = Cow.new
animal.talk(dog) # woof woof
animal.talk(cat) # meow meow
animal.talk(cow) # moo mooo
```

As it can be seen, each class has it's own representation of the talk() method.

![diagram](/app/assets/images/duck_typing_diagram.png)

The Animal variable can call the talk() method in all the different objects and the output will be the signature method of each one of them.
