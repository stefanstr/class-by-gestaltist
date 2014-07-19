--[[

Copyright © 2014 Stefan Stryjecki

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

--]]

--[[ Example use of this file:

In file "definitions.lua":

---
Class = require"classloader"

Class{
	name="Klass";
	methods={
		test = function(self)
			print"test"
		end
		};
	}
	
---
In main file:
assert(loadfile("definitions.lua"))()

and the class "Klass" will be accessible and usable.	

--]]

local class = require"class"

return function(tab)
	-- The below makes this file usable for various versions of Lua
	local env = getfenv and getfenv(1) or _ENV
	env[tab.name] = class(tab)
end
