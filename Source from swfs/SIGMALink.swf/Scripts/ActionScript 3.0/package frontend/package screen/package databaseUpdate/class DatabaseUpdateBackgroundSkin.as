//class DatabaseUpdateBackgroundSkin
package frontend.screen.databaseUpdate 
{
    import frontend.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class DatabaseUpdateBackgroundSkin extends starling.display.Sprite
    {
        public function DatabaseUpdateBackgroundSkin()
        {
            super();
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.bgDashboard);
            var loc2:*=new starling.display.Image(loc1);
            addChild(loc2);
            return;
        }
    }
}


