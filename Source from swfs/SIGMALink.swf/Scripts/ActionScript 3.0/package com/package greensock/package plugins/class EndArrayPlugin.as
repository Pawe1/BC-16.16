//class EndArrayPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class EndArrayPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function EndArrayPlugin()
        {
            _info = [];
            super();
            this.propName = "endArray";
            this.overwriteProps = ["endArray"];
            return;
        }

        public function init(arg1:Array, arg2:Array):void
        {
            _a = arg1;
            var loc1:*=arg2.length;
            while (loc1--) 
            {
                if (!(!(arg1[loc1] == arg2[loc1]) && !(arg1[loc1] == null))) 
                {
                    continue;
                }
                _info[_info.length] = new ArrayTweenInfo(loc1, _a[loc1], arg2[loc1] - _a[loc1]);
            }
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (!(arg1 is Array) || !(arg2 is Array)) 
            {
                return false;
            }
            init(arg1 as Array, arg2);
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=NaN;
            var loc1:*=_info.length;
            if (this.round) 
            {
                while (loc1--) 
                {
                    loc2 = _info[loc1];
                    loc3 = loc2.start + loc2.change * arg1;
                    _a[loc2.index] = loc3 > 0 ? int(loc3 + 0.5) : int(loc3 - 0.5);
                }
            }
            else 
            {
                while (loc1--) 
                {
                    loc2 = _info[loc1];
                    _a[loc2.index] = loc2.start + loc2.change * arg1;
                }
            }
            return;
        }

        public static const API:Number=1;

        protected var _a:Array;

        protected var _info:Array;
    }
}


class ArrayTweenInfo extends Object
{
    public function ArrayTweenInfo(arg1:uint, arg2:Number, arg3:Number)
    {
        super();
        this.index = arg1;
        this.start = arg2;
        this.change = arg3;
        return;
    }

    public var change:Number;

    public var start:Number;

    public var index:uint;
}

