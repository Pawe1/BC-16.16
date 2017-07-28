//class ShortRotationPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class ShortRotationPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function ShortRotationPlugin()
        {
            super();
            this.propName = "shortRotation";
            this.overwriteProps = [];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            var loc1:*=null;
            if (typeof arg2 == "number") 
            {
                return false;
            }
            var loc2:*=0;
            var loc3:*=arg2;
            for (loc1 in loc3) 
            {
                initRotation(arg1, loc1, arg1[loc1], typeof arg2[loc1] != "number" ? arg1[loc1] + Number(arg2[loc1]) : Number(arg2[loc1]));
            }
            return true;
        }

        public function initRotation(arg1:Object, arg2:String, arg3:Number, arg4:Number):void
        {
            var loc1:*=(arg4 - arg3) % 360;
            if (loc1 != loc1 % 180) 
            {
                loc1 = loc1 < 0 ? loc1 + 360 : loc1 - 360;
            }
            addTween(arg1, arg2, arg3, arg3 + loc1, arg2);
            this.overwriteProps[this.overwriteProps.length] = arg2;
            return;
        }

        public static const API:Number=1;
    }
}


