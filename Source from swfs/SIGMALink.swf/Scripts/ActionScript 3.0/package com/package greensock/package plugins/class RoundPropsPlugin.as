//class RoundPropsPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class RoundPropsPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function RoundPropsPlugin()
        {
            super();
            this.propName = "roundProps";
            this.overwriteProps = [];
            this.round = true;
            return;
        }

        public function add(arg1:Object, arg2:String, arg3:Number, arg4:Number):void
        {
            addTween(arg1, arg2, arg3, arg3 + arg4, arg2);
            this.overwriteProps[this.overwriteProps.length] = arg2;
            return;
        }

        public static const API:Number=1;
    }
}


