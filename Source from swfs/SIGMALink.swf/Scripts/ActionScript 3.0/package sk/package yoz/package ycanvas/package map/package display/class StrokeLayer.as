//class StrokeLayer
package sk.yoz.ycanvas.map.display 
{
    import __AS3__.vec.*;
    
    public class StrokeLayer extends sk.yoz.ycanvas.map.display.MapLayer
    {
        public function StrokeLayer()
        {
            list = new __AS3__.vec.Vector.<sk.yoz.ycanvas.map.display.MapStroke>();
            super();
            return;
        }

        public override function set mapScale(arg1:Number):void
        {
            if (mapScale == arg1) 
            {
                return;
            }
            super(
#error('findrop') mapScale
            ).mapScale = arg1;
            if (autoUpdateThickness) 
            {
                updateThickness();
            }
            return;
        }

        public function updateThickness():void
        {
            var loc2:*=0;
            var loc1:*=null;
            loc2 = list.length;
            while (loc2--) 
            {
                loc1 = list[loc2];
                loc1.layerScale = mapScale;
                if (loc1.autoUpdate) 
                {
                    continue;
                }
                loc1.update();
            }
            return;
        }

        public function add(arg1:sk.yoz.ycanvas.map.display.MapStroke):void
        {
            arg1.layerScale = mapScale;
            if (!arg1.autoUpdate) 
            {
                arg1.update();
            }
            list.push(arg1);
            addChild(arg1);
            return;
        }

        public function remove(arg1:sk.yoz.ycanvas.map.display.MapStroke):void
        {
            list.splice(list.indexOf(arg1), 1);
            removeChild(arg1);
            return;
        }

        internal var list:__AS3__.vec.Vector.<sk.yoz.ycanvas.map.display.MapStroke>;

        public var autoUpdateThickness:Boolean=true;
    }
}


