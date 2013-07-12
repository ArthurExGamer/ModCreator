package awesomesaucesoftware.testmod;
import cpw.mods.fml.relauncher.Side;
import cpw.mods.fml.relauncher.SideOnly;
import net.minecraft.block.material.Material;
import net.minecraft.client.renderer.texture.IconRegister;

public class TestBlock extends net.minecraft.block.Block {

	  public TestBlock(int id, Material material) {
		    super(id, material);
		    // TODO Auto-generated constructor stub
        setUnlocalizedName("TestBlock");
	  }
    @Override
    @SideOnly(Side.CLIENT)
    public void registerIcons(IconRegister iconRegister) {
        this.blockIcon = iconRegister.registerIcon("TestMod:" + (this.getUnlocalizedName()));
    }
}
