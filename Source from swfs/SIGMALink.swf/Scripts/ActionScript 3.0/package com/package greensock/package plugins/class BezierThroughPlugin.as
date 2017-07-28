//class BezierThroughPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    
    public class BezierThroughPlugin extends com.greensock.plugins.BezierPlugin
    {
        public function BezierThroughPlugin()
        {
            super();
            this.propName = "bezierThrough";
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (!(arg2 is Array)) 
            {
                return false;
            }
            init(arg3, arg2 as Array, true);
            return true;
        }

        public static const API:Number=1;
    }
}


