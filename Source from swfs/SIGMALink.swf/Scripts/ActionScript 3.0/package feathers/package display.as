//package display
//  class RenderDelegate
package feathers.display 
{
    import flash.geom.*;
    import starling.display.*;
    import starling.rendering.*;
    import starling.utils.*;
    
    public class RenderDelegate extends starling.display.DisplayObject
    {
        public function RenderDelegate(arg1:starling.display.DisplayObject)
        {
            super();
            this.target = arg1;
            return;
        }

        public function get target():starling.display.DisplayObject
        {
            return this._target;
        }

        public function set target(arg1:starling.display.DisplayObject):void
        {
            if (this._target === arg1) 
            {
                return;
            }
            this._target = arg1;
            this.setRequiresRedraw();
            return;
        }

        public override function getBounds(arg1:starling.display.DisplayObject, arg2:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            arg2 = this._target.getBounds(this._target, arg2);
            var loc1:*=starling.utils.Pool.getMatrix();
            this.getTransformationMatrix(arg1, loc1);
            var loc2:*=Number.MAX_VALUE;
            var loc3:*=-Number.MAX_VALUE;
            var loc4:*=Number.MAX_VALUE;
            var loc5:*=-Number.MAX_VALUE;
            var loc6:*=0;
            while (loc6 < 4) 
            {
                starling.utils.MatrixUtil.transformCoords(loc1, loc6 % 2 != 0 ? arg2.width : 0, loc6 < 2 ? 0 : arg2.height, HELPER_POINT);
                if (HELPER_POINT.x < loc2) 
                {
                    loc2 = HELPER_POINT.x;
                }
                if (HELPER_POINT.x > loc3) 
                {
                    loc3 = HELPER_POINT.x;
                }
                if (HELPER_POINT.y < loc4) 
                {
                    loc4 = HELPER_POINT.y;
                }
                if (HELPER_POINT.y > loc5) 
                {
                    loc5 = HELPER_POINT.y;
                }
                ++loc6;
            }
            starling.utils.Pool.putMatrix(loc1);
            arg2.setTo(loc2, loc4, loc3 - loc2, loc5 - loc4);
            return arg2;
        }

        public override function render(arg1:starling.rendering.Painter):void
        {
            var loc1:*=arg1.cacheEnabled;
            arg1.cacheEnabled = false;
            this._target.render(arg1);
            arg1.cacheEnabled = loc1;
            arg1.excludeFromCache(this);
            return;
        }

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        protected var _target:starling.display.DisplayObject;
    }
}


