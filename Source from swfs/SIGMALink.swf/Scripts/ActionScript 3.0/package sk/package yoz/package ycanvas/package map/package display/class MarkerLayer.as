//class MarkerLayer
package sk.yoz.ycanvas.map.display 
{
    import __AS3__.vec.*;
    import starling.display.*;
    
    public class MarkerLayer extends sk.yoz.ycanvas.map.display.MapLayer
    {
        public function MarkerLayer()
        {
            list = new __AS3__.vec.Vector.<starling.display.DisplayObject>();
            super();
            return;
        }

        public override function set rotation(arg1:Number):void
        {
            var loc1:*=0;
            if (rotation == arg1) 
            {
                return;
            }
            super(
#error('findrop') rotation
            ).rotation = arg1;
            loc1 = list.length;
            while (loc1--) 
            {
                list[loc1].rotation = -rotation;
            }
            return;
        }

        public override function set mapScale(arg1:Number):void
        {
            var loc1:*=0;
            if (mapScale == arg1) 
            {
                return;
            }
            super(
#error('findrop') mapScale
            ).mapScale = arg1;
            loc1 = list.length;
            while (loc1--) 
            {
                var loc2:*;
                list[loc1].scaleY = loc2 = 1 / mapScale;
                list[loc1].scaleX = loc2;
            }
            return;
        }

        public function add(arg1:starling.display.DisplayObject):void
        {
            var loc1:*;
            arg1.scaleY = loc1 = 1 / mapScale;
            arg1.scaleX = loc1;
            arg1.rotation = -rotation;
            list.push(arg1);
            addChild(arg1);
            return;
        }

        public function remove(arg1:starling.display.DisplayObject):void
        {
            list.splice(list.indexOf(arg1), 1);
            removeChild(arg1);
            return;
        }

        internal var list:__AS3__.vec.Vector.<starling.display.DisplayObject>;
    }
}


