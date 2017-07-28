//class DropShadowFilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class DropShadowFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        public function DropShadowFilterPlugin()
        {
            super();
            this.propName = "dropShadowFilter";
            this.overwriteProps = ["dropShadowFilter"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _type = flash.filters.DropShadowFilter;
            initFilter(arg2, new flash.filters.DropShadowFilter(0, 45, 0, 0, 0, 0, 1, arg2.quality || 2, arg2.inner, arg2.knockout, arg2.hideObject), _propNames);
            return true;
        }

        
        {
            _propNames = ["distance", "angle", "color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout", "hideObject"];
        }

        public static const API:Number=1;

        internal static var _propNames:Array;
    }
}


