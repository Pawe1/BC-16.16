//class TweenPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import com.greensock.core.*;
    
    public class TweenPlugin extends Object
    {
        public function TweenPlugin()
        {
            _tweens = [];
            super();
            return;
        }

        protected function updateTweens(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=NaN;
            var loc1:*=_tweens.length;
            if (this.round) 
            {
                while (loc1--) 
                {
                    loc2 = _tweens[loc1];
                    loc3 = loc2.start + loc2.change * arg1;
                    loc2.target[loc2.property] = loc3 > 0 ? int(loc3 + 0.5) : int(loc3 - 0.5);
                }
            }
            else 
            {
                while (loc1--) 
                {
                    loc2 = _tweens[loc1];
                    loc2.target[loc2.property] = loc2.start + loc2.change * arg1;
                }
            }
            return;
        }

        protected function addTween(arg1:Object, arg2:String, arg3:Number, arg4:*, arg5:String=null):void
        {
            var loc1:*=NaN;
            if (arg4 != null) 
            {
                loc1 = typeof arg4 != "number" ? Number(arg4) : Number(arg4) - arg3;
                if (loc1 != 0) 
                {
                    _tweens[_tweens.length] = new com.greensock.core.PropTween(arg1, arg2, arg3, loc1, arg5 || arg2, false);
                }
            }
            return;
        }

        public function get changeFactor():Number
        {
            return _changeFactor;
        }

        public function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            addTween(arg1, this.propName, arg1[this.propName], arg2, this.propName);
            return true;
        }

        public function killProps(arg1:Object):void
        {
            var loc1:*=this.overwriteProps.length;
            while (loc1--) 
            {
                if (!(this.overwriteProps[loc1] in arg1)) 
                {
                    continue;
                }
                this.overwriteProps.splice(loc1, 1);
            }
            loc1 = _tweens.length;
            while (loc1--) 
            {
                if (!(com.greensock.core.PropTween(_tweens[loc1]).name in arg1)) 
                {
                    continue;
                }
                _tweens.splice(loc1, 1);
            }
            return;
        }

        public function set changeFactor(arg1:Number):void
        {
            updateTweens(arg1);
            _changeFactor = arg1;
            return;
        }

        public static function activate(arg1:Array):Boolean
        {
            var loc2:*=null;
            com.greensock.TweenLite.onPluginEvent = com.greensock.plugins.TweenPlugin.onTweenEvent;
            var loc1:*=arg1.length;
            while (loc1--) 
            {
                if (!arg1[loc1].hasOwnProperty("API")) 
                {
                    continue;
                }
                loc2 = new (arg1[loc1] as Class)();
                com.greensock.TweenLite.plugins[loc2.propName] = arg1[loc1];
            }
            return true;
        }

        internal static function onTweenEvent(arg1:String, arg2:com.greensock.TweenLite):Boolean
        {
            var loc2:*=false;
            var loc3:*=null;
            var loc4:*=0;
            var loc1:*=arg2.cachedPT1;
            if (arg1 != "onInit") 
            {
                while (loc1) 
                {
                    if (loc1.isPlugin && loc1.target[arg1]) 
                    {
                        if (loc1.target.activeDisable) 
                        {
                            loc2 = true;
                        }
                        var loc5:*;
                        (loc5 = loc1.target)[arg1]();
                    }
                    loc1 = loc1.nextNode;
                }
            }
            else 
            {
                loc3 = [];
                while (loc1) 
                {
                    loc3[loc3.length] = loc1;
                    loc1 = loc1.nextNode;
                }
                loc3.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
                loc4 = loc3.length;
                while (loc4--) 
                {
                    com.greensock.core.PropTween(loc3[loc4]).nextNode = loc3[loc4 + 1];
                    com.greensock.core.PropTween(loc3[loc4]).prevNode = loc3[(loc4 - 1)];
                }
                arg2.cachedPT1 = loc3[0];
            }
            return loc2;
        }

        public static const VERSION:Number=1.31;

        public static const API:Number=1;

        public var activeDisable:Boolean;

        protected var _changeFactor:Number=0;

        protected var _tweens:Array;

        public var onDisable:Function;

        public var propName:String;

        public var round:Boolean;

        public var onEnable:Function;

        public var priority:int=0;

        public var overwriteProps:Array;

        public var onComplete:Function;
    }
}


