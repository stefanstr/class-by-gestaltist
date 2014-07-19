Class = require "classloader"

Class {
	name = "Tuple";
	allowedkeytypes = {"number"};
	initialize = function (self)
		for i=1, #self do
			assert(type(self[i]) == "number", "Only numeric values are allowed for tuples.")
		end
	end;
	typesetters = {
		number = function (self, value)
			error("You cannot modify values of a tuple")
		end
	};
	methods = {
		unpack = function (self)
			local unpack = unpack or table.unpack
			return unpack(self.__)
		end;
		slice = function (self, start, finish)
			if start < 0 then
				start = #self + start
			end
			if finish < 0 then
				finish = #self + finish
			end
			local new = {}
			for i = start, finish do
				table.insert(new, self[i])
			end
			return Tuple(new)
		end;
	};
	metamethods = {
		tostring = function (self)
			local ret = "Tuple: " 
			for _, v in ipairs(self.__) do
				ret = ret .. v .. ", "
			end
			return ret
		end;
		len = function (self)
			return #self.__
		end;
		concat = function (a, b)
			local ret = {}
			for _, v in ipairs(a.__) do
				table.insert(ret, v)
			end
			for _, v in ipairs(b.__) do
				table.insert(ret, v)
			end
			return Tuple(ret)
		end;
		add = function (a, b)
			local a = {a:unpack()}
			local b = {b:unpack()}
			if #b > #a then
				a, b = b, a
			end
			for i = 1, #b do
				a[i] = a[i] + b[i]
			end
			return Tuple(a)
		end;	
		sub = function (a, b)
			local a = {a:unpack()}
			local b = {b:unpack()}
			len = math.max(#a, #b)
			for i = 1, len do
				a[i] = (a[i] or 0) - (b[i] or 0)
			end
			return Tuple(a)
		end;	
		eq = function (a, b)
			local a = {a:unpack()}
			local b = {b:unpack()}
			if #a ~= #b then
				return false
			else
				len = math.max(#a, #b)
				for i=1, len do
					if a[i] ~= b[i] then
						return false
					end
				end
				return true
			end
		end;	
		-- The "<=" operator is meant to mean "is in" in this context.
		le	= function (a, b)
			
			if type(a) ~= "number" then
				return false
			else
				for _, v in ipairs(b.__) do
					if a == v then
						return true
					end
				end
				return false
			end
		end;
	};
}