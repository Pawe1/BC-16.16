//class BlurFilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class BlurFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        public function BlurFilterPlugin()
        {
            super();
            this.propName = "blurFilter";
            this.overwriteProps = ["blurFilter"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _type = flash.filters.BlurFilter;
            initFilter(arg2, new flash.filters.BlurFilter(0, 0, arg2.quality || 2), _propNames);
            return true;
        }

        
        {
            _propNames = ["blurX", "blurY", "quality"];
        }

        public static const API:Number=1;

        internal static var _propNames:Array;
    }
}


