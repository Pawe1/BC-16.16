//class FilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import com.greensock.core.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class FilterPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function FilterPlugin()
        {
            super();
            return;
        }

        public function onCompleteTween():void
        {
            var loc1:*=null;
            var loc2:*=0;
            if (_remove) 
            {
                loc1 = _target.filters;
                if (loc1[_index] is _type) 
                {
                    loc1.splice(_index, 1);
                }
                else 
                {
                    loc2 = loc1.length;
                    while (loc2--) 
                    {
                        if (!(loc1[loc2] is _type)) 
                        {
                            continue;
                        }
                        loc1.splice(loc2, 1);
                        break;
                    }
                }
                _target.filters = loc1;
            }
            return;
        }

        protected function initFilter(arg1:Object, arg2:flash.filters.BitmapFilter, arg3:Array):void
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*=_target.filters;
            var loc5:*=arg1 is flash.filters.BitmapFilter ? {} : arg1;
            _index = -1;
            if (loc5.index == null) 
            {
                loc3 = loc1.length;
                while (loc3--) 
                {
                    if (!(loc1[loc3] is _type)) 
                    {
                        continue;
                    }
                    _index = loc3;
                }
            }
            else 
            {
                _index = loc5.index;
            }
            if (_index == -1 || loc1[_index] == null || loc5.addFilter == true) 
            {
                _index = loc5.index == null ? loc1.length : loc5.index;
                loc1[_index] = arg2;
                _target.filters = loc1;
            }
            _filter = loc1[_index];
            if (loc5.remove == true) 
            {
                _remove = true;
                this.onComplete = onCompleteTween;
            }
            loc3 = arg3.length;
            while (loc3--) 
            {
                loc2 = arg3[loc3];
                if (!(loc2 in arg1 && !(_filter[loc2] == arg1[loc2]))) 
                {
                    continue;
                }
                if (loc2 == "color" || loc2 == "highlightColor" || loc2 == "shadowColor") 
                {
                    loc4 = new com.greensock.plugins.HexColorsPlugin();
                    loc4.initColor(_filter, loc2, _filter[loc2], arg1[loc2]);
                    _tweens[_tweens.length] = new com.greensock.core.PropTween(loc4, "changeFactor", 0, 1, loc2, false);
                    continue;
                }
                if (loc2 == "quality" || loc2 == "inner" || loc2 == "knockout" || loc2 == "hideObject") 
                {
                    _filter[loc2] = arg1[loc2];
                    continue;
                }
                addTween(_filter, loc2, _filter[loc2], arg1[loc2], loc2);
            }
            return;
        }

        public override function set changeFactor(arg1:Number):void
        {
            var loc2:*=null;
            var loc1:*=_tweens.length;
            var loc3:*=_target.filters;
            while (loc1--) 
            {
                loc2 = _tweens[loc1];
                loc2.target[loc2.property] = loc2.start + loc2.change * arg1;
            }
            if (!(loc3[_index] is _type)) 
            {
                var loc4:*;
                _index = loc4 = loc3.length;
                loc1 = loc4;
                while (loc1--) 
                {
                    if (!(loc3[loc1] is _type)) 
                    {
                        continue;
                    }
                    _index = loc1;
                }
            }
            loc3[_index] = _filter;
            _target.filters = loc3;
            return;
        }

        public static const VERSION:Number=2.03;

        public static const API:Number=1;

        protected var _remove:Boolean;

        protected var _target:Object;

        protected var _index:int;

        protected var _filter:flash.filters.BitmapFilter;

        protected var _type:Class;
    }
}


