//class DashboardBackgroundSkin
package frontend.screen.dashboard 
{
    import frontend.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class DashboardBackgroundSkin extends starling.display.Sprite
    {
        public function DashboardBackgroundSkin()
        {
            super();
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.bgDashboard);
            var loc2:*=new starling.display.Image(loc1);
            addChild(loc2);
            return;
        }
    }
}


