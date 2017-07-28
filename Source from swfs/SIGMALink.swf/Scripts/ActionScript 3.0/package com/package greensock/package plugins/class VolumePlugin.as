//class VolumePlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.media.*;
    
    public class VolumePlugin extends com.greensock.plugins.TweenPlugin
    {
        public function VolumePlugin()
        {
            super();
            this.propName = "volume";
            this.overwriteProps = ["volume"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (isNaN(arg2) || !arg1.hasOwnProperty("soundTransform")) 
            {
                return false;
            }
            _target = arg1;
            _st = _target.soundTransform;
            addTween(_st, "volume", _st.volume, arg2, "volume");
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            updateTweens(arg1);
            _target.soundTransform = _st;
            return;
        }

        public static const API:Number=1;

        protected var _target:Object;

        protected var _st:flash.media.SoundTransform;
    }
}


