//class FramePlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class FramePlugin extends com.greensock.plugins.TweenPlugin
    {
        public function FramePlugin()
        {
            super();
            this.propName = "frame";
            this.overwriteProps = ["frame", "frameLabel"];
            this.round = true;
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (!(arg1 is flash.display.MovieClip) || isNaN(arg2)) 
            {
                return false;
            }
            _target = arg1 as flash.display.MovieClip;
            this.frame = _target.currentFrame;
            addTween(this, "frame", this.frame, arg2, "frame");
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            updateTweens(arg1);
            _target.gotoAndStop(this.frame);
            return;
        }

        public static const API:Number=1;

        protected var _target:flash.display.MovieClip;

        public var frame:int;
    }
}


