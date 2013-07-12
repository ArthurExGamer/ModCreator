#Creates a mod called TestMod, by AwesomeSauceSoftware, using the forge api.
mod "TestMod", "AwesomeSauceSoftware", :forge do
  #Create a block called "Test Block" ingame.
  block "Test Block" do
    #Nothing here, because this is regular block.
  end
  #Create a ore generator.
  generator :ore, "Test Block", 10
  #Create a recipe for the test block.
  recipe istack("Test Block") do
    code ";"
    #Set the layout for the recipe.
    recipe_layout "xxx", "xxx", "xxx"
    #Assign the letter "x" to the name "dirt"
    recipe_assign "x", "dirt"
  end
  jclass "HeyClass", "package awesomesaucesoftware.testmod;public class HeyClass {}"
  item "Test Item" do
    #Add rightclick option.
    rightclick do
      #Make the rightclick print stuff.
      consolelog "Right clicked with the item."
    end
  end
end