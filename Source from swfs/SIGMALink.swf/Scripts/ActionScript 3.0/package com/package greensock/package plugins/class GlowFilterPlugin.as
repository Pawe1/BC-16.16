//class GlowFilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class GlowFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        public function GlowFilterPlugin()
        {
            super();
            this.propName = "glowFilter";
            this.overwriteProps = ["glowFilter"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _type = flash.filters.GlowFilter;
            initFilter(arg2, new flash.filters.GlowFilter(16777215, 0, 0, 0, arg2.strength || 1, arg2.quality || 2, arg2.inner, arg2.knockout), _propNames);
            return true;
        }

        
        {
            _propNames = ["color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout"];
        }

        public static const API:Number=1;

        internal static var _propNames:Array;
    }
}


