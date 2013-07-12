package awesomesaucesoftware.testmod;
import cpw.mods.fml.relauncher.Side;
import cpw.mods.fml.relauncher.SideOnly;
import net.minecraft.client.renderer.texture.IconRegister;

public class TestItem extends net.minecraft.item.Item {

	  public TestItem(int id) {
		    super(id);
		    // TODO Auto-generated constructor stub
        setUnlocalizedName("TestItem");
	  }
    @Override
    @SideOnly(Side.CLIENT)
    public void registerIcons(IconRegister iconRegister) {
        this.itemIcon = iconRegister.registerIcon("TestMod:" + (this.getUnlocalizedName()));
    }
}
