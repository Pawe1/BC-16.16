//class ColorTransformPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.geom.*;
    
    public class ColorTransformPlugin extends com.greensock.plugins.TintPlugin
    {
        public function ColorTransformPlugin()
        {
            super();
            this.propName = "colorTransform";
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            var loc2:*=null;
            var loc3:*=NaN;
            if (!(arg1 is flash.display.DisplayObject)) 
            {
                return false;
            }
            var loc1:*=arg1.transform.colorTransform;
            var loc4:*=0;
            var loc5:*=arg2;
            for (loc2 in loc5) 
            {
                if (loc2 == "tint" || loc2 == "color") 
                {
                    if (arg2[loc2] != null) 
                    {
                        loc1.color = int(arg2[loc2]);
                    }
                    continue;
                }
                if (loc2 == "tintAmount" || loc2 == "exposure" || loc2 == "brightness") 
                {
                    continue;
                }
                loc1[loc2] = arg2[loc2];
            }
            if (isNaN(arg2.tintAmount)) 
            {
                if (isNaN(arg2.exposure)) 
                {
                    if (!isNaN(arg2.brightness)) 
                    {
                        loc1.blueOffset = loc4 = Math.max(0, (arg2.brightness - 1) * 255);
                        loc1.greenOffset = loc4 = loc4;
                        loc1.redOffset = loc4;
                        loc1.blueMultiplier = loc4 = 1 - Math.abs((arg2.brightness - 1));
                        loc1.greenMultiplier = loc4 = loc4;
                        loc1.redMultiplier = loc4;
                    }
                }
                else 
                {
                    loc1.blueOffset = loc4 = 255 * (arg2.exposure - 1);
                    loc1.greenOffset = loc4 = loc4;
                    loc1.redOffset = loc4;
                    loc1.blueMultiplier = loc4 = 1;
                    loc1.greenMultiplier = loc4 = loc4;
                    loc1.redMultiplier = loc4;
                }
            }
            else 
            {
                loc3 = arg2.tintAmount / (1 - (loc1.redMultiplier + loc1.greenMultiplier + loc1.blueMultiplier) / 3);
                loc1.redOffset = loc1.redOffset * loc3;
                loc1.greenOffset = loc1.greenOffset * loc3;
                loc1.blueOffset = loc1.blueOffset * loc3;
                loc1.blueMultiplier = loc4 = 1 - arg2.tintAmount;
                loc1.greenMultiplier = loc4 = loc4;
                loc1.redMultiplier = loc4;
            }
            _ignoreAlpha = Boolean(!(arg3.vars.alpha == undefined) && arg2.alphaMultiplier == undefined);
            init(arg1 as flash.display.DisplayObject, loc1);
            return true;
        }

        public static const API:Number=1;
    }
}


