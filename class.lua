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

local classmeta = {}
classmeta.__index = classmeta
classmeta.__call = function(klass, definitions)
	local meta = {}
	local name = definitions.name
	if not name then
		error("You need to include the class name in the class definition.")
	end
	
	-- This is supposed to hold functions - using colon notation and/or self is not required and is up to the user.
	meta.__methods = definitions.methods or {}
	
	-- If a setter exists for a given key, then changing that key will invoke the setter.
	-- The fields of this table need to be functions. These functions take two arguments:
	-- a table and a value.
	-- Typically, they will access "t.__" to set the values.
	-- Getters work analogously
	meta.__setters = definitions.setters or {}
	meta.__getters = definitions.getters or {}
	
	-- If a key is given a true value here, it won't be changeable after object initialization
	meta.__readonly = {class=true}
	if definitions.readonly then
		for _, v in pairs(definitions.readonly) do
			meta.__readonly[v] = true
		end
	end
	
	-- Default value to be returned if there is no value set on the object
	meta.__defaults = {class=name}
	if definitions.defaults then
		for k, v in pairs(definitions.defaults) do
			meta.__defaults[k] = v
		end
	end
	
	-- The below fields must be included with the creation of a new instance. Otherwise,
	-- an error will be raised. This should be a list of keys.
	meta.__obligatory = definitions.obligatory or {}

	meta.__index = function(t,k)
		if k== "__" then 
			return rawget(t,k)
		elseif meta.__methods[k] then
			return meta.__methods[k]
		elseif meta.__getters[k] then
			return meta.__getters[k](t)
		elseif not rawget(t, "__")[k] then
			return meta.__defaults[k]
		else
			return rawget(t, "__")[k]
		end
	end

	meta.__newindex = function(t,k,v)
		if k =="__" then 
			rawset(t,k,v) 
		elseif meta.__setters[k] then
			meta.__setters[k](t, v)
		elseif meta.__readonly[k] then
			error("'" .. k .. "' is a read-only property.", 2)
		else
			rawset(t.__, k, v)
		end
	end

	return function (initValues, ...)
		local t = {}
		for k,v in pairs(initValues) do
			t[k] = v
		end
		for _, v in pairs(meta.__obligatory) do
			if not t[v] then
				error("'" .. v .. "' is an obligatory parameter for a new instance of class " .. name, 2)
			end
		end
		local obj = setmetatable({__=t}, meta)
		if definitions.initialize then
			definitions.initialize(obj)
		end
		return obj
	end
end

return setmetatable({}, classmeta)