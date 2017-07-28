//class CloudViewBackgroundSkin
package frontend.screen.cloud 
{
    import frontend.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class CloudViewBackgroundSkin extends starling.display.Sprite
    {
        public function CloudViewBackgroundSkin()
        {
            super();
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.bgCloud);
            var loc2:*=new starling.display.Image(loc1);
            addChild(loc2);
            return;
        }
    }
}


