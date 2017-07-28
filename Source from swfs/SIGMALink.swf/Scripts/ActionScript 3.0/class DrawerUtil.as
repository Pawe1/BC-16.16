//class DrawerUtil
package 
{
    import flash.display.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class DrawerUtil extends Object
    {
        public function DrawerUtil()
        {
            super();
            return;
        }

        public static function getImageFromSprite(arg1:flash.display.Sprite, arg2:Number, arg3:Number):starling.display.Image
        {
            var loc1:*=new starling.display.Image(getTextureFromSprite(arg1));
            loc1.x = arg2;
            loc1.y = arg3;
            return loc1;
        }

        public static function getTextureFromSprite(arg1:flash.display.Sprite):starling.textures.Texture
        {
            var loc1:*=Math.max(1, arg1.width);
            var loc2:*=Math.max(1, arg1.height);
            var loc3:*=new flash.display.BitmapData(loc1, loc2, true, 16777215);
            loc3.draw(arg1);
            return starling.textures.Texture.fromBitmapData(loc3);
        }
    }
}


