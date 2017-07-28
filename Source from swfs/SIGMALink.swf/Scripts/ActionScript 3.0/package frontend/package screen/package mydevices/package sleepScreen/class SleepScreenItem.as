//class SleepScreenItem
package frontend.screen.mydevices.sleepScreen 
{
    import core.sleepScreen.*;
    import starling.textures.*;
    
    public class SleepScreenItem extends core.sleepScreen.SleepScreen
    {
        public function SleepScreenItem(arg1:XML)
        {
            super(arg1);
            this.texture = DrawerUtil.getTextureFromSprite(sprite);
            return;
        }

        public var texture:starling.textures.Texture;
    }
}


