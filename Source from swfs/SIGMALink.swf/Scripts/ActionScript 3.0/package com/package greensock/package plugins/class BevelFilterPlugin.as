//class BevelFilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class BevelFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        public function BevelFilterPlugin()
        {
            super();
            this.propName = "bevelFilter";
            this.overwriteProps = ["bevelFilter"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _type = flash.filters.BevelFilter;
            initFilter(arg2, new flash.filters.BevelFilter(0, 0, 16777215, 0.5, 0, 0.5, 2, 2, 0, arg2.quality || 2), _propNames);
            return true;
        }

        
        {
            _propNames = ["distance", "angle", "highlightColor", "highlightAlpha", "shadowColor", "shadowAlpha", "blurX", "blurY", "strength", "quality"];
        }

        public static const API:Number=1;

        internal static var _propNames:Array;
    }
}


