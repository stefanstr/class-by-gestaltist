class-by-gestaltist
===================

This is my implementation of OOP for Lua based on my personal preferences and needs.

## Design decisions ##

### implicit getters and setters

  This is the main feature and the main reason I have started working on this library. I hate to use explicit getter and setter methods as it is easy to get confused/forget where you should be using getter/setter methods. So I have made it the basic feature of this class system that you can write getter/setter methods which will be invoked automatically when you access properties. 
  
### declarative style

  In this library, you use tables both for class definitions and for instantiation. Because of that, you always have to explicitly state which parameters you are invoking. This is a feature, as it makes the code a lot more readable at a glance. And Lua makes it look elegant, too, with its notation (foo{bar}).
  
### easy to abstract class definitions to a separate file 

  The way classes are defined makes it real easy (and readable) to abstract their definitions to a separate file. I have also created a "classloader.lua" to facilitate it further.
  
### more control over keys and values

  I have included an easy way to set keys which are obligatory upon instantiation, read-only, and allowed. You can even specify, which types the keys are allowed to have. You can also set default values for selected keys.
  
### debug methods

  I have added two methods _printValues and _printMetaField which give an easy way to inspect the contents of a class instance.

### no inheritance

  I don't like inheritance and never use it if I can help it. It makes the code more difficult to understand and is prone to mistakes. And everybody says you should avoid it anyway. So I decided not to implement it at all. If you need it - this library is probably not for you (although feel free to implement inheritance for yourself)
  
### All fields are stored in the table "self.__"

  This is necessary to have index and newindex work for all properties. However, this also allows you to directly access all properties, should you need to do so.
  
## List of possible fields in the class initializing table:

### metamethods

  You can define all Lua metamethods for your class except for index and newindex. You should define them without the two starting underscorees. 
  
### name
  
  The class name, stored in each object under the 'class' property
  
### methods 

  This is where you define methods for your class. 
  
### getters, setters, typegetters, typesetters 

  Here you can define getter and setter functions for specific properties or for all properties of a given type (important: it's the type of the property **name** and NOT of it's value - e.g., you can set a setter for all numeric keys).
  
### readonly 

  List of all read-only properties which can only be set at the moment of object instantiation.
  
### defaults

  List of default values for given keys. If you want to set a default value for a whole class of keys, use typegetters instead.
  
### obligatory

  List of properties which must be defined when initializing an object.

### allowed, allowedkeytypes

  If allowed is defined, you will only be able to set these specific keys. allowedkeytypes works similarly but specifies the type of keys being allowed.
