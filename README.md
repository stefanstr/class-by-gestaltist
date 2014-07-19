class-by-gestaltist
===================

This is my implementation of OOP for Lua based on my personal preferences and needs.

## Design decisions ##

* implicit getters and setters

  This is the main feature and the main reason I have started working on this library. I hate to use explicit getter and setter methods as it is easy to get confused/forget where you should be using getter/setter methods. So I have made it the basic feature of this class system that you can write getter/setter methods which will be invoked automatically when you access properties. 
  
* declarative style

  In this library, you use tables both for class definitions and for instantiation. Because of that, you always have to explicitly state which parameters you are invoking. This is a feature, as it makes the code a lot more readable at a glance. And Lua makes it look elegant, too, with its notation (foo{bar}).
  
* easy to abstract class definitions to a separate file 

  The way classes are defined makes it real easy (and readable) to abstract their definitions to a separate file. I have also created a "classloader.lua" to facilitate it further.
  
* more control over keys and values

  I have included an easy way to set keys which are obligatory upon instantiation, read-only, and allowed. You can even specify, which types the keys are allowed to have. You can also set default values for selected keys.
  
* debug methods

  I have added two methods _printValues and _printMetaField which give an easy way to inspect the contents of a class instance.

* no inheritance

  I don't like inheritance and never use it if I can help it. It makes the code more difficult to understand and is prone to mistakes. And everybody says you should avoid it anyway. So I decided not to implement it at all. If you need it - this library is probably not for you (although feel free to implement inheritance for yourself)
  
