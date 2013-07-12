class ForgeGenerator < ModGenerator
  def init(name, by)
    Dir.mkdir("out") if not File.exists? "out"
    Dir.mkdir("out/"+by.downcase) if not File.exists? "out/"+by.downcase
    Dir.mkdir("out/"+by.downcase+"/"+name.downcase) if not File.exists? "out/"+by.downcase+"/"+name.downcase
    Dir.chdir("out/"+by+"/"+name.downcase)
    File.open("ClientProxy.java", "w") do |f|
      f.puts "package #{by.downcase}.#{name.downcase};

public class ClientProxy extends CommonProxy {

	public void registerRenderers() {
		// TODO Auto-generated method stub
		
	}
}
"
    end
    File.open("CommonProxy.java", "w") do |f|
      f.puts "package #{by.downcase}.#{name.downcase};

public class CommonProxy {

	public void registerRenderers() {
		// TODO Auto-generated method stub
		
	}
}
"
    end
    @f = File.open(name+".java", "w")
    @f.puts "package #{by.downcase}.#{name.downcase};

import net.minecraft.block.material.Material;
import net.minecraft.creativetab.CreativeTabs;
import net.minecraft.item.ItemStack;

import cpw.mods.fml.common.Mod;
import cpw.mods.fml.common.Mod.EventHandler;
import cpw.mods.fml.common.Mod.Init;
import cpw.mods.fml.common.Mod.Instance;
import cpw.mods.fml.common.Mod.PostInit;
import cpw.mods.fml.common.Mod.PreInit;
import cpw.mods.fml.common.SidedProxy;
import cpw.mods.fml.common.event.FMLInitializationEvent;
import cpw.mods.fml.common.event.FMLPostInitializationEvent;
import cpw.mods.fml.common.event.FMLPreInitializationEvent;
import cpw.mods.fml.common.network.NetworkMod;
import cpw.mods.fml.common.registry.GameRegistry;
import cpw.mods.fml.common.registry.LanguageRegistry;
@Mod(modid=\"#{name}\", name=\"#{name}\", version=\"0.0.1\")
@NetworkMod(clientSideRequired=true, serverSideRequired=false)
public class #{name} {

    // The instance of your mod that Forge uses.
    @Instance(\"#{name}\")
    public static #{name} instance;
    // Says where the client and server 'proxy' code is loaded.
    @SidedProxy(clientSide=\"#{by.downcase}.#{name.downcase}.ClientProxy\", serverSide=\"#{by.downcase}.#{name.downcase}.CommonProxy\")
    public static CommonProxy proxy;
"
    @mains = []
    @by = by
    @name = name
    @iidindex = 5000
    @bidindex = 500
  end
  def item(oname)
    name = oname.gsub(/ /, "")
    File.open(name+".java", "w") do |f|
      f.puts "package #{@by.downcase}.#{@name.downcase};
import cpw.mods.fml.relauncher.Side;
import cpw.mods.fml.relauncher.SideOnly;
import net.minecraft.client.renderer.texture.IconRegister;

public class #{name} extends net.minecraft.item.Item {

	  public #{name}(int id) {
		    super(id);
		    // TODO Auto-generated constructor stub
        setUnlocalizedName(\"#{name}\");
	  }
    @Override
    @SideOnly(Side.CLIENT)
    public void registerIcons(IconRegister iconRegister) {
        this.itemIcon = iconRegister.registerIcon(\"#{@name}:\" + (this.getUnlocalizedName()));
    }
}
"
    end
    @iidindex += 1
    @f.puts "        public static #{name} #{name.downcase} = new #{name}(#{@iidindex});"
    @mains.push "       
		#{name.downcase}.setCreativeTab(CreativeTabs.tabMisc);
		LanguageRegistry.addName(#{name.downcase}, \"#{oname}\");"
  end
  def block(oname)
    name = oname.gsub(/ /, "")
    File.open(name+".java", "w") do |f|
      f.puts "package #{@by.downcase}.#{@name.downcase};
import cpw.mods.fml.relauncher.Side;
import cpw.mods.fml.relauncher.SideOnly;
import net.minecraft.block.material.Material;
import net.minecraft.client.renderer.texture.IconRegister;

public class #{name} extends net.minecraft.block.Block {

	  public #{name}(int id, Material material) {
		    super(id, material);
		    // TODO Auto-generated constructor stub
        setUnlocalizedName(\"#{name}\");
	  }
    @Override
    @SideOnly(Side.CLIENT)
    public void registerIcons(IconRegister iconRegister) {
        this.blockIcon = iconRegister.registerIcon(\"#{@name}:\" + (this.getUnlocalizedName()));
    }
}
"
    end
    @bidindex += 1
    @f.puts "        public static #{name} #{name.downcase} = new #{name}(#{@bidindex}, Material.ground);"
    @mains.push "       
		#{name.downcase}.setCreativeTab(CreativeTabs.tabBlock);
		LanguageRegistry.addName(#{name.downcase}, \"#{oname}\");
		GameRegistry.registerBlock(#{name.downcase});"
  end
  def jclass(name, code)
    File.open(name+".java", "w") do |f|
      f.puts code
    end
  end
  def code(code, location=1)
    if location == 0
      @f.puts code
    else
      @mains.push code
    end
  end
  def istack(item, amount=1, damage=0)
    @mains.push "new ItemStack(#{item.gsub(/ /, "").downcase}, #{amount}, #{damage})"
  end
  def finalize
    @f.puts "
        @EventHandler
        public void load(FMLInitializationEvent event) {
                proxy.registerRenderers();"
    for i in @mains
      @f.puts i
    end
    @f.puts "    }
}"
  end
end
$generator = ForgeGenerator.new