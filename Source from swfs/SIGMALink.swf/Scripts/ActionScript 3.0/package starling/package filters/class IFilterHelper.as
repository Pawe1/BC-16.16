//class IFilterHelper
package starling.filters 
{
    import flash.geom.*;
    import starling.display.*;
    import starling.textures.*;
    
    public interface IFilterHelper
    {
        function getTexture(arg1:Number=1):starling.textures.Texture;

        function putTexture(arg1:starling.textures.Texture):void;

        function get targetBounds():flash.geom.Rectangle;

        function get target():starling.display.DisplayObject;
    }
}


