mod "TestMod", "AwesomeSauceSoftware", :forge {
  #Create a block called "Test Block" ingame.
  block "testBlock" {
    #Nothing here, because this is regular block.
  }
  #Create a ore generator.
  generator :ore, "testBlock", 10
  #Create a recipe for the test block.
  recipe istack("testBlock") {
    #Set the layout for the recipe.
    recipe_layout "xxx", "xxx", "xxx"
    #Assign the letter "x" to the name "dirt"
    recipe_assign "x", "dirt"
  }
  item "testItem" {
    #Add rightclick option.
    rightclick {
      #Make the rightclick print stuff.
    }
  }
}