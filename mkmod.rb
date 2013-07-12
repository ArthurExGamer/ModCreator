class Mod
  def initialize(name, by, type)
    @name = name
    @by = by
    @type = type
  end
end
class ModPiece
end

def mod(*args)
  $mod = Mod.new
  yield
  $mod.generate
end
def block(name)
  yield
end
def generator(type, *args)
end
def recipe(stack)
  yield
end
def istack(item, amount=1, damage=0)
end
def recipe_layout(l1, l2=nil, l3=nil)
end
def recipe_assign(what, to)
end
def item(name)
end
def rightclick
  yield
end
def consolelog(what)
end
if File.exists?(ARGV[0])
  load ARGV[0]
else
  puts "That mod doesn't exist."
end