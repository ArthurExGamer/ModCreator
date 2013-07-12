package awesomesaucesoftware.testmod;

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
@Mod(modid="TestMod", name="TestMod", version="0.0.1")
@NetworkMod(clientSideRequired=true, serverSideRequired=false)
public class TestMod {

    // The instance of your mod that Forge uses.
    @Instance("TestMod")
    public static TestMod instance;
    // Says where the client and server 'proxy' code is loaded.
    @SidedProxy(clientSide="awesomesaucesoftware.testmod.ClientProxy", serverSide="awesomesaucesoftware.testmod.CommonProxy")
    public static CommonProxy proxy;
        public static TestBlock testblock = new TestBlock(501, Material.ground);
        public static TestItem testitem = new TestItem(5001);

        @EventHandler
        public void load(FMLInitializationEvent event) {
                proxy.registerRenderers();
       
		testblock.setCreativeTab(CreativeTabs.tabBlock);
		LanguageRegistry.addName(testblock, "Test Block");
		GameRegistry.registerBlock(testblock);
new ItemStack(testblock, 1, 0)
;
       
		testitem.setCreativeTab(CreativeTabs.tabMisc);
		LanguageRegistry.addName(testitem, "Test Item");
    }
}
