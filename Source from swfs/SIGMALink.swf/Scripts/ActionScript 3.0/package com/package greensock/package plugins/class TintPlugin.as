//class TintPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import com.greensock.core.*;
    import flash.display.*;
    import flash.geom.*;
    
    public class TintPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function TintPlugin()
        {
            super();
            this.propName = "tint";
            this.overwriteProps = ["tint"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (!(arg1 is flash.display.DisplayObject)) 
            {
                return false;
            }
            var loc1:*=new flash.geom.ColorTransform();
            if (!(arg2 == null) && !(arg3.vars.removeTint == true)) 
            {
                loc1.color = uint(arg2);
            }
            _ignoreAlpha = true;
            init(arg1 as flash.display.DisplayObject, loc1);
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            var loc1:*=null;
            updateTweens(arg1);
            if (_ignoreAlpha) 
            {
                loc1 = _transform.colorTransform;
                _ct.alphaMultiplier = loc1.alphaMultiplier;
                _ct.alphaOffset = loc1.alphaOffset;
            }
            _transform.colorTransform = _ct;
            return;
        }

        public function init(arg1:flash.display.DisplayObject, arg2:flash.geom.ColorTransform):void
        {
            var loc2:*=null;
            _transform = arg1.transform;
            _ct = _transform.colorTransform;
            var loc1:*=_props.length;
            while (loc1--) 
            {
                loc2 = _props[loc1];
                if (_ct[loc2] == arg2[loc2]) 
                {
                    continue;
                }
                _tweens[_tweens.length] = new com.greensock.core.PropTween(_ct, loc2, _ct[loc2], arg2[loc2] - _ct[loc2], "tint", false);
            }
            return;
        }

        
        {
            _props = ["redMultiplier", "greenMultiplier", "blueMultiplier", "alphaMultiplier", "redOffset", "greenOffset", "blueOffset", "alphaOffset"];
        }

        public static const API:Number=1;

        protected var _ct:flash.geom.ColorTransform;

        protected var _transform:flash.geom.Transform;

        protected var _ignoreAlpha:Boolean;

        protected static var _props:Array;
    }
}


