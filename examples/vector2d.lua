Class = require"classloader"

local numberSetter = function (t, key, value)
		return function (t, value)
			assert(type(value) == "number", "Vector's fields have to be numbers.")
			t.__[key] = value
		end
	end

Class{
	name="Vector2D";
	obligatory={"x", "y"};
	readonly={"squarelength", "length"};
	metamethods={
		add = function (a, b)
			if type(a) == "number" then
				return Vector2D{x=b.x + a; y=b.y + a}
			elseif type(b) == "number" then
				return Vector2D{x=a.x + b; y=a.y + b}
			else
				return Vector2D{x=a.x + b.x; y=a.y + b.y}
			end
		end;
		sub = function (v1, v2)
			if type(a) == "number" then
				return Vector2D{x=b.x - a; y=b.y - a}
			elseif type(b) == "number" then
				return Vector2D{x=a.x - b; y=a.y - b}
			else
				return Vector2D{x=a.x - b.x; y=a.y - b.y}
			end
		end;
		mul = function (a, b)
			if type(a) == "number" then
				return Vector2D{x=b.x * a; y=b.y * a}
			elseif type(b) == "number" then
				return Vector2D{x=a.x * b; y=a.y * b}
			else
				return Vector2D{x=a.x * b.x; y=a.y * b.y}
			end
		end;
		div = function (a, b)
			if type(a) == "number" then
				return Vector2D{x=b.x / a; y=b.y / a}
			elseif type(b) == "number" then
				return Vector2D{x=a.x / b; y=a.y / b}
			else
				return Vector2D{x=a.x / b.x; y=a.y / b.y}
			end
		end;
		eq = function (a, b) 
			return a.x == b.x and a.y == b.y
		end;
		lt = function (a, b)
			return a.x < b.x or (a.x == b.x and a.y < b.y)
		end;
		le = function (a, b)
			return a.x <= b.x and a.y <= b.y
		end;
		tostring = function (a)
			return "Vector2d(" .. a.x .. ", " .. a.y .. ")"
		end;
	};
	getters= {
		squarelength = function (self)
			return self.x^2 + self.y^2
		end;
		length = function (self)
			return self.squarelength^0.5
		end;
		};
	setters = {
		x = numberSetter(self, "x", value);
		y = numberSetter(self, "y", value);
		};
	methods={
		unpack = function(self)
			return self.x, self.y
		end;
		normalize = function(self)
			local len = self.length
			self.x = self.x / len
			self.y = self.y / len
		end;
	};
}

