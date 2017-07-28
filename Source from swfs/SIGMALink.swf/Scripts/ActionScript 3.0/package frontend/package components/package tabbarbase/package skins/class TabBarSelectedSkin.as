//class TabBarSelectedSkin
package frontend.components.tabbarbase.skins 
{
    import core.general.*;
    import starling.display.*;
    
    public class TabBarSelectedSkin extends starling.display.Sprite
    {
        public function TabBarSelectedSkin()
        {
            super();
            var loc1:*=new starling.display.Quad(1, 19 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            var loc2:*=new starling.display.Quad(1, 2 * SIGMALink.scaleFactor, core.general.Colors.RED);
            loc2.y = 19 * SIGMALink.scaleFactor;
            addChild(loc2);
            addChild(loc1);
            return;
        }
    }
}


