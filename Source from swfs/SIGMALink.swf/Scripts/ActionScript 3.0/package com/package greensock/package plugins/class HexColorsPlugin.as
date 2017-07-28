//class HexColorsPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class HexColorsPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function HexColorsPlugin()
        {
            super();
            this.propName = "hexColors";
            this.overwriteProps = [];
            _colors = [];
            return;
        }

        public override function killProps(arg1:Object):void
        {
            var loc1:*=(_colors.length - 1);
            while (loc1 > -1) 
            {
                if (arg1[_colors[loc1][1]] != undefined) 
                {
                    _colors.splice(loc1, 1);
                }
                --loc1;
            }
            super.killProps(arg1);
            return;
        }

        public function initColor(arg1:Object, arg2:String, arg3:uint, arg4:uint):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (arg3 != arg4) 
            {
                loc1 = arg3 >> 16;
                loc2 = arg3 >> 8 & 255;
                loc3 = arg3 & 255;
                _colors[_colors.length] = [arg1, arg2, loc1, (arg4 >> 16) - loc1, loc2, (arg4 >> 8 & 255) - loc2, loc3, (arg4 & 255) - loc3];
                this.overwriteProps[this.overwriteProps.length] = arg2;
            }
            return;
        }

        public override function set changeFactor(arg1:Number):void
        {
            var loc1:*=0;
            var loc2:*=null;
            loc1 = (_colors.length - 1);
            while (loc1 > -1) 
            {
                loc2 = _colors[loc1];
                loc2[0][loc2[1]] = loc2[2] + arg1 * loc2[3] << 16 | loc2[4] + arg1 * loc2[5] << 8 | loc2[6] + arg1 * loc2[7];
                --loc1;
            }
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg2;
            for (loc1 in loc3) 
            {
                initColor(arg1, loc1, uint(arg1[loc1]), uint(arg2[loc1]));
            }
            return true;
        }

        public static const API:Number=1;

        protected var _colors:Array;
    }
}


