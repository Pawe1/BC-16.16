//class AutoAlphaPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class AutoAlphaPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function AutoAlphaPlugin()
        {
            super();
            this.propName = "autoAlpha";
            this.overwriteProps = ["alpha", "visible"];
            return;
        }

        public override function killProps(arg1:Object):void
        {
            super.killProps(arg1);
            _ignoreVisible = Boolean("visible" in arg1);
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            addTween(arg1, "alpha", arg1.alpha, arg2, "alpha");
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            updateTweens(arg1);
            if (!_ignoreVisible) 
            {
                _target.visible = Boolean(!(_target.alpha == 0));
            }
            return;
        }

        public static const API:Number=1;

        protected var _target:Object;

        protected var _ignoreVisible:Boolean;
    }
}


