class Mod
  def initialize(name, by, type)
    @name = name
    @by = by
    @type = type
    @parts = []
  end
  def generate
    puts "Generating Mod: "+@name+" by: "+@by+" using generator: "+@type.to_s
    load "generators/"+@type.to_s+".rb"
    $generator.init(@name, @by)
    puts "Number of parts: "+@parts.length.to_s
    for i in @parts
      $generator.send(i.type, *i.args)
    end
    puts "Gone through all parts."
    $generator.finalize
  end
  def add_part(type, *args)
    @parts.push(ModPart.new(type, *args))
  end
end
class ModPart
  def initialize(type, *args)
    @type = type
    @args = args
  end
  attr_reader :type, :args
end
class ModGenerator
  def init(name, by)
  end
  def finalize
  end
  def block(name)
    puts "Blocks are unable to be made with this generator."
  end
  def block_end
  end
  def generator(type, *args)
    puts "Generators are unable to be made with this generator."
  end
  def recipe(stack)
    puts "Recipes are unable to be made with this generator."
  end
  def recipe_end
  end
  def istack(item, amount=1, damage=0)
    puts "Item Stacks are unable to be made with this generator."
  end
  def recipe_layout(l1, l2=nil, l3=nil)
  end
  def recipe_assign(what, to)
  end
  def item(name)
    puts "Items are unable to be made with this generator."
  end
  def item_end
  end
  def rightclick
    puts "Right Click options are unavailable with this generator."
  end
  def rightclick_end
  end
  def consolelog(what)
    puts "Generator unable to log anything to console."
  end
end

def mod(*args)
  $mod = Mod.new(*args)
  yield
  $mod.generate
end
def block(name)
  $mod.add_part(:block, name)
  yield
  $mod.add_part(:block_end)
end
def generator(type, *args)
  $mod.add_part(:generator, type, *args)
end
def recipe(stack)
  $mod.add_part(:recipe, stack)
  yield
  $mod.add_part(:recipe_end)
end
def istack(item, amount=1, damage=0)
  $mod.add_part(:istack, item, amount, damage)
end
def recipe_layout(l1, l2=nil, l3=nil)
  $mod.add_part(:recipe_layout, l1, l2, l3)
end
def recipe_assign(what, to)
  $mod.add_part(:recipe_assign, what, to)
end
def item(name)
  $mod.add_part(:item, name)
  yield
  $mod.add_part(:item_end)
end
def rightclick
  $mod.add_part(:rightclick)
  yield
  $mod.add_part(:rightclick_end)
end
def consolelog(what)
  $mod.add_part(:consolelog, what)
end
if File.exists?(ARGV[0])
  puts "Reading Mod: "+ARGV[0]
  load ARGV[0]
else
  puts "That mod doesn't exist."
end