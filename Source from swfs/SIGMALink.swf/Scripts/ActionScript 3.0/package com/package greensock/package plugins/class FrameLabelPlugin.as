//class FrameLabelPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class FrameLabelPlugin extends com.greensock.plugins.FramePlugin
    {
        public function FrameLabelPlugin()
        {
            super();
            this.propName = "frameLabel";
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (!arg3.target is flash.display.MovieClip) 
            {
                return false;
            }
            _target = arg1 as flash.display.MovieClip;
            this.frame = _target.currentFrame;
            var loc1:*=_target.currentLabels;
            var loc2:*=arg2;
            var loc3:*=_target.currentFrame;
            var loc4:*=loc1.length;
            while (loc4--) 
            {
                if (loc1[loc4].name != loc2) 
                {
                    continue;
                }
                loc3 = loc1[loc4].frame;
                break;
            }
            if (this.frame != loc3) 
            {
                addTween(this, "frame", this.frame, loc3, "frame");
            }
            return true;
        }

        public static const API:Number=1;
    }
}


