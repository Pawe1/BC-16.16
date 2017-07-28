//class VisiblePlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class VisiblePlugin extends com.greensock.plugins.TweenPlugin
    {
        public function VisiblePlugin()
        {
            super();
            this.propName = "visible";
            this.overwriteProps = ["visible"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _tween = arg3;
            _initVal = _target.visible;
            _visible = Boolean(arg2);
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            if (arg1 == 1 && (_tween.cachedDuration == _tween.cachedTime || _tween.cachedTime == 0)) 
            {
                _target.visible = _visible;
            }
            else 
            {
                _target.visible = _initVal;
            }
            return;
        }

        public static const API:Number=1;

        protected var _target:Object;

        protected var _initVal:Boolean;

        protected var _visible:Boolean;

        protected var _tween:com.greensock.TweenLite;
    }
}


