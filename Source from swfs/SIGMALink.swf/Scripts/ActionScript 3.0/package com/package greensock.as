//package greensock
//  package core
//    class PropTween
package com.greensock.core 
{
    public class PropTween extends Object
    {
        public function PropTween(arg1:Object, arg2:String, arg3:Number, arg4:Number, arg5:String, arg6:Boolean, arg7:com.greensock.core.PropTween=null, arg8:int=0)
        {
            super();
            this.target = arg1;
            this.property = arg2;
            this.start = arg3;
            this.change = arg4;
            this.name = arg5;
            this.isPlugin = arg6;
            if (arg7) 
            {
                arg7.prevNode = this;
                this.nextNode = arg7;
            }
            this.priority = arg8;
            return;
        }

        public var priority:int;

        public var start:Number;

        public var prevNode:com.greensock.core.PropTween;

        public var change:Number;

        public var target:Object;

        public var name:String;

        public var property:String;

        public var nextNode:com.greensock.core.PropTween;

        public var isPlugin:Boolean;
    }
}


//    class SimpleTimeline
package com.greensock.core 
{
    public class SimpleTimeline extends com.greensock.core.TweenCore
    {
        public function SimpleTimeline(arg1:Object=null)
        {
            super(0, arg1);
            return;
        }

        public override function renderTime(arg1:Number, arg2:Boolean=false, arg3:Boolean=false):void
        {
            var loc2:*=NaN;
            var loc3:*=null;
            var loc1:*=_firstChild;
            this.cachedTotalTime = arg1;
            this.cachedTime = arg1;
            while (loc1) 
            {
                loc3 = loc1.nextNode;
                if (loc1.active || arg1 >= loc1.cachedStartTime && !loc1.cachedPaused && !loc1.gc) 
                {
                    if (loc1.cachedReversed) 
                    {
                        loc2 = loc1.cacheIsDirty ? loc1.totalDuration : loc1.cachedTotalDuration;
                        loc1.renderTime(loc2 - (arg1 - loc1.cachedStartTime) * loc1.cachedTimeScale, arg2, false);
                    }
                    else 
                    {
                        loc1.renderTime((arg1 - loc1.cachedStartTime) * loc1.cachedTimeScale, arg2, false);
                    }
                }
                loc1 = loc3;
            }
            return;
        }

        public function addChild(arg1:com.greensock.core.TweenCore):void
        {
            if (!arg1.cachedOrphan && arg1.timeline) 
            {
                arg1.timeline.remove(arg1, true);
            }
            arg1.timeline = this;
            if (arg1.gc) 
            {
                arg1.setEnabled(true, true);
            }
            if (_firstChild) 
            {
                _firstChild.prevNode = arg1;
            }
            arg1.nextNode = _firstChild;
            _firstChild = arg1;
            arg1.prevNode = null;
            arg1.cachedOrphan = false;
            return;
        }

        public function remove(arg1:com.greensock.core.TweenCore, arg2:Boolean=false):void
        {
            if (arg1.cachedOrphan) 
            {
                return;
            }
            if (!arg2) 
            {
                arg1.setEnabled(false, true);
            }
            if (arg1.nextNode) 
            {
                arg1.nextNode.prevNode = arg1.prevNode;
            }
            else if (_lastChild == arg1) 
            {
                _lastChild = arg1.prevNode;
            }
            if (arg1.prevNode) 
            {
                arg1.prevNode.nextNode = arg1.nextNode;
            }
            else if (_firstChild == arg1) 
            {
                _firstChild = arg1.nextNode;
            }
            arg1.cachedOrphan = true;
            return;
        }

        public function get rawTime():Number
        {
            return this.cachedTotalTime;
        }

        public var autoRemoveChildren:Boolean;

        protected var _lastChild:com.greensock.core.TweenCore;

        protected var _firstChild:com.greensock.core.TweenCore;
    }
}


//    class TweenCore
package com.greensock.core 
{
    import com.greensock.*;
    
    public class TweenCore extends Object
    {
        public function TweenCore(arg1:Number=0, arg2:Object=null)
        {
            super();
            this.vars = arg2 == null ? {} : arg2;
            var loc2:*;
            this.cachedTotalDuration = loc2 = arg1;
            this.cachedDuration = loc2;
            _delay = this.vars.delay ? Number(this.vars.delay) : 0;
            this.cachedTimeScale = this.vars.timeScale ? Number(this.vars.timeScale) : 1;
            this.active = Boolean(arg1 == 0 && _delay == 0 && !(this.vars.immediateRender == false));
            this.cachedTime = loc2 = 0;
            this.cachedTotalTime = loc2;
            this.data = this.vars.data;
            if (!_classInitted) 
            {
                if (isNaN(com.greensock.TweenLite.rootFrame)) 
                {
                    com.greensock.TweenLite.initClass();
                    _classInitted = true;
                }
                else 
                {
                    return;
                }
            }
            var loc1:*=this.vars.timeline is com.greensock.core.SimpleTimeline ? this.vars.timeline : this.vars.useFrames ? com.greensock.TweenLite.rootFramesTimeline : com.greensock.TweenLite.rootTimeline;
            this.cachedStartTime = loc1.cachedTotalTime + _delay;
            loc1.addChild(this);
            if (this.vars.reversed) 
            {
                this.cachedReversed = true;
            }
            if (this.vars.paused) 
            {
                this.paused = true;
            }
            return;
        }

        public function set currentTime(arg1:Number):void
        {
            setTotalTime(arg1, false);
            return;
        }

        protected function setDirtyCache(arg1:Boolean=true):void
        {
            var loc1:*=arg1 ? this : this.timeline;
            while (loc1) 
            {
                loc1.cacheIsDirty = true;
                loc1 = loc1.timeline;
            }
            return;
        }

        public function reverse(arg1:Boolean=true):void
        {
            this.reversed = true;
            if (arg1) 
            {
                this.paused = false;
            }
            else if (this.gc) 
            {
                this.setEnabled(true, false);
            }
            return;
        }

        public function renderTime(arg1:Number, arg2:Boolean=false, arg3:Boolean=false):void
        {
            return;
        }

        public function set paused(arg1:Boolean):void
        {
            if (!(arg1 == this.cachedPaused) && this.timeline) 
            {
                if (arg1) 
                {
                    _pauseTime = this.timeline.rawTime;
                }
                else 
                {
                    this.cachedStartTime = this.cachedStartTime + (this.timeline.rawTime - _pauseTime);
                    _pauseTime = NaN;
                    setDirtyCache(false);
                }
                this.cachedPaused = arg1;
                this.active = Boolean(!this.cachedPaused && this.cachedTotalTime > 0 && this.cachedTotalTime < this.cachedTotalDuration);
            }
            if (!arg1 && this.gc) 
            {
                this.setTotalTime(this.cachedTotalTime, false);
                this.setEnabled(true, false);
            }
            return;
        }

        public function set reversed(arg1:Boolean):void
        {
            if (arg1 != this.cachedReversed) 
            {
                this.cachedReversed = arg1;
                setTotalTime(this.cachedTotalTime, true);
            }
            return;
        }

        public function get delay():Number
        {
            return _delay;
        }

        public function kill():void
        {
            setEnabled(false, false);
            return;
        }

        public function set totalDuration(arg1:Number):void
        {
            this.duration = arg1;
            return;
        }

        public function restart(arg1:Boolean=false, arg2:Boolean=true):void
        {
            this.reversed = false;
            this.paused = false;
            this.setTotalTime(arg1 ? -_delay : 0, arg2);
            return;
        }

        public function get duration():Number
        {
            return this.cachedDuration;
        }

        public function set totalTime(arg1:Number):void
        {
            setTotalTime(arg1, false);
            return;
        }

        public function set startTime(arg1:Number):void
        {
            var loc1:*=Boolean(!(this.timeline == null) && (!(arg1 == this.cachedStartTime) || this.gc));
            this.cachedStartTime = arg1;
            if (loc1) 
            {
                this.timeline.addChild(this);
            }
            return;
        }

        public function set delay(arg1:Number):void
        {
            this.startTime = this.startTime + (arg1 - _delay);
            _delay = arg1;
            return;
        }

        public function get currentTime():Number
        {
            return this.cachedTime;
        }

        protected function setTotalTime(arg1:Number, arg2:Boolean=false):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (this.timeline) 
            {
                loc1 = _pauseTime || _pauseTime == 0 ? _pauseTime : this.timeline.cachedTotalTime;
                if (this.cachedReversed) 
                {
                    loc2 = this.cacheIsDirty ? this.totalDuration : this.cachedTotalDuration;
                    this.cachedStartTime = loc1 - (loc2 - arg1) / this.cachedTimeScale;
                }
                else 
                {
                    this.cachedStartTime = loc1 - arg1 / this.cachedTimeScale;
                }
                if (!this.timeline.cacheIsDirty) 
                {
                    setDirtyCache(false);
                }
                if (this.cachedTotalTime != arg1) 
                {
                    renderTime(arg1, arg2, false);
                }
            }
            return;
        }

        public function resume():void
        {
            this.paused = false;
            return;
        }

        public function get paused():Boolean
        {
            return this.cachedPaused;
        }

        public function pause():void
        {
            this.paused = true;
            return;
        }

        public function play():void
        {
            this.reversed = false;
            this.paused = false;
            return;
        }

        public function set duration(arg1:Number):void
        {
            var loc1:*;
            this.cachedTotalDuration = loc1 = arg1;
            this.cachedDuration = loc1;
            setDirtyCache(false);
            return;
        }

        public function get totalDuration():Number
        {
            return this.cachedTotalDuration;
        }

        public function invalidate():void
        {
            return;
        }

        public function complete(arg1:Boolean=false, arg2:Boolean=false):void
        {
            if (!arg1) 
            {
                renderTime(this.totalDuration, arg2, false);
                return;
            }
            if (this.timeline.autoRemoveChildren) 
            {
                this.setEnabled(false, false);
            }
            else 
            {
                this.active = false;
            }
            if (!arg2) 
            {
                if (this.vars.onComplete && this.cachedTotalTime == this.cachedTotalDuration && !this.cachedReversed) 
                {
                    this.vars.onComplete.apply(null, this.vars.onCompleteParams);
                }
                else if (this.cachedReversed && this.cachedTotalTime == 0 && this.vars.onReverseComplete) 
                {
                    this.vars.onReverseComplete.apply(null, this.vars.onReverseCompleteParams);
                }
            }
            return;
        }

        public function setEnabled(arg1:Boolean, arg2:Boolean=false):Boolean
        {
            this.gc = !arg1;
            if (arg1) 
            {
                this.active = Boolean(!this.cachedPaused && this.cachedTotalTime > 0 && this.cachedTotalTime < this.cachedTotalDuration);
                if (!arg2 && this.cachedOrphan) 
                {
                    this.timeline.addChild(this);
                }
            }
            else 
            {
                this.active = false;
                if (!arg2 && !this.cachedOrphan) 
                {
                    this.timeline.remove(this, true);
                }
            }
            return false;
        }

        public function get reversed():Boolean
        {
            return this.cachedReversed;
        }

        public function get totalTime():Number
        {
            return this.cachedTotalTime;
        }

        public function get startTime():Number
        {
            return this.cachedStartTime;
        }

        public static const version:Number=1.382;

        public var initted:Boolean;

        protected var _hasUpdate:Boolean;

        public var active:Boolean;

        protected var _delay:Number;

        public var cachedReversed:Boolean;

        public var nextNode:com.greensock.core.TweenCore;

        public var cachedTime:Number;

        protected var _rawPrevTime:Number=-1;

        public var vars:Object;

        public var cachedTotalTime:Number;

        public var data:*;

        public var timeline:com.greensock.core.SimpleTimeline;

        public var gc:Boolean;

        public var cachedStartTime:Number;

        public var prevNode:com.greensock.core.TweenCore;

        public var cachedPaused:Boolean;

        protected var _pauseTime:Number;

        public var cacheIsDirty:Boolean;

        public var cachedDuration:Number;

        public var cachedTimeScale:Number;

        public var cachedTotalDuration:Number;

        public var cachedOrphan:Boolean;

        protected static var _classInitted:Boolean;
    }
}


//  package events
//    class TweenEvent
package com.greensock.events 
{
    import flash.events.*;
    
    public class TweenEvent extends flash.events.Event
    {
        public function TweenEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new com.greensock.events.TweenEvent(this.type, this.bubbles, this.cancelable);
        }

        public static const COMPLETE:String="complete";

        public static const START:String="start";

        public static const UPDATE:String="change";

        public static const REVERSE_COMPLETE:String="reverseComplete";

        public static const INIT:String="init";

        public static const VERSION:Number=1.1;

        public static const REPEAT:String="repeat";
    }
}


//  package plugins
//    class AutoAlphaPlugin
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


//    class BevelFilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class BevelFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        public function BevelFilterPlugin()
        {
            super();
            this.propName = "bevelFilter";
            this.overwriteProps = ["bevelFilter"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _type = flash.filters.BevelFilter;
            initFilter(arg2, new flash.filters.BevelFilter(0, 0, 16777215, 0.5, 0, 0.5, 2, 2, 0, arg2.quality || 2), _propNames);
            return true;
        }

        
        {
            _propNames = ["distance", "angle", "highlightColor", "highlightAlpha", "shadowColor", "shadowAlpha", "blurX", "blurY", "strength", "quality"];
        }

        public static const API:Number=1;

        internal static var _propNames:Array;
    }
}


//    class BezierPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import com.greensock.core.*;
    
    public class BezierPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function BezierPlugin()
        {
            _future = {};
            super();
            this.propName = "bezier";
            this.overwriteProps = [];
            return;
        }

        public override function killProps(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=_beziers;
            for (loc1 in loc3) 
            {
                if (!(loc1 in arg1)) 
                {
                    continue;
                }
                delete _beziers[loc1];
            }
            super.killProps(arg1);
            return;
        }

        protected function init(arg1:com.greensock.TweenLite, arg2:Array, arg3:Boolean):void
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            _target = arg1.target;
            var loc1:*=arg1.vars.isTV != true ? arg1.vars : arg1.vars.exposedVars;
            if (loc1.orientToBezier != true) 
            {
                if (loc1.orientToBezier is Array) 
                {
                    _orientData = loc1.orientToBezier;
                    _orient = true;
                }
            }
            else 
            {
                _orientData = [["x", "y", "rotation", 0, 0.01]];
                _orient = true;
            }
            var loc2:*={};
            loc3 = 0;
            while (loc3 < arg2.length) 
            {
                var loc6:*=0;
                var loc7:*=arg2[loc3];
                for (loc4 in loc7) 
                {
                    if (loc2[loc4] == undefined) 
                    {
                        loc2[loc4] = [arg1.target[loc4]];
                    }
                    if (typeof arg2[loc3][loc4] == "number") 
                    {
                        loc2[loc4].push(arg2[loc3][loc4]);
                        continue;
                    }
                    loc2[loc4].push(arg1.target[loc4] + Number(arg2[loc3][loc4]));
                }
                ++loc3;
            }
            loc6 = 0;
            loc7 = loc2;
            for (loc4 in loc7) 
            {
                this.overwriteProps[this.overwriteProps.length] = loc4;
                if (loc1[loc4] == undefined) 
                {
                    continue;
                }
                if (typeof loc1[loc4] != "number") 
                {
                    loc2[loc4].push(arg1.target[loc4] + Number(loc1[loc4]));
                }
                else 
                {
                    loc2[loc4].push(loc1[loc4]);
                }
                loc5 = {};
                loc5[loc4] = true;
                arg1.killVars(loc5, false);
                delete loc1[loc4];
            }
            _beziers = parseBeziers(loc2, arg3);
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (!(arg2 is Array)) 
            {
                return false;
            }
            init(arg3, arg2 as Array, false);
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=NaN;
            var loc5:*=0;
            var loc6:*=NaN;
            var loc7:*=null;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=null;
            var loc11:*=NaN;
            var loc12:*=null;
            var loc13:*=false;
            if (arg1 != 1) 
            {
                loc14 = 0;
                loc15 = _beziers;
                for (loc2 in loc15) 
                {
                    loc5 = _beziers[loc2].length;
                    if (arg1 < 0) 
                    {
                        loc1 = 0;
                    }
                    else if (arg1 >= 1) 
                    {
                        --loc1;
                    }
                    else 
                    {
                        loc1 = int(loc5 * arg1);
                    }
                    loc4 = (arg1 - loc1 * 1 / loc5) * loc5;
                    loc3 = _beziers[loc2][loc1];
                    if (this.round) 
                    {
                        loc6 = loc3[0] + loc4 * (2 * (1 - loc4) * (loc3[1] - loc3[0]) + loc4 * (loc3[2] - loc3[0]));
                        _target[loc2] = loc6 > 0 ? int(loc6 + 0.5) : int(loc6 - 0.5);
                        continue;
                    }
                    _target[loc2] = loc3[0] + loc4 * (2 * (1 - loc4) * (loc3[1] - loc3[0]) + loc4 * (loc3[2] - loc3[0]));
                }
            }
            else 
            {
                var loc14:*=0;
                var loc15:*=_beziers;
                for (loc2 in loc15) 
                {
                    loc1 = (_beziers[loc2].length - 1);
                    _target[loc2] = _beziers[loc2][loc1][2];
                }
            }
            if (_orient) 
            {
                loc1 = _orientData.length;
                loc7 = {};
                while (loc1--) 
                {
                    loc10 = _orientData[loc1];
                    loc7[loc10[0]] = _target[loc10[0]];
                    loc7[loc10[1]] = _target[loc10[1]];
                }
                loc12 = _target;
                loc13 = this.round;
                _target = _future;
                this.round = false;
                _orient = false;
                loc1 = _orientData.length;
                while (loc1--) 
                {
                    loc10 = _orientData[loc1];
                    this.changeFactor = arg1 + (loc10[4] || 0.01);
                    loc11 = loc10[3] || 0;
                    loc8 = _future[loc10[0]] - loc7[loc10[0]];
                    loc9 = _future[loc10[1]] - loc7[loc10[1]];
                    loc12[loc10[2]] = Math.atan2(loc9, loc8) * _RAD2DEG + loc11;
                }
                _target = loc12;
                this.round = loc13;
                _orient = true;
            }
            return;
        }

        public static function parseBeziers(arg1:Object, arg2:Boolean=false):Object
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*={};
            if (arg2) 
            {
                var loc6:*=0;
                var loc7:*=arg1;
                for (loc4 in loc7) 
                {
                    loc2 = arg1[loc4];
                    var loc8:*;
                    loc3 = loc8 = [];
                    loc5[loc4] = loc8;
                    if (loc2.length > 2) 
                    {
                        loc3[loc3.length] = [loc2[0], loc2[1] - (loc2[2] - loc2[0]) / 4, loc2[1]];
                        loc1 = 1;
                        while (loc1 < (loc2.length - 1)) 
                        {
                            loc3[loc3.length] = [loc2[loc1], loc2[loc1] + (loc2[loc1] - loc3[(loc1 - 1)][1]), loc2[loc1 + 1]];
                            ++loc1;
                        }
                        continue;
                    }
                    loc3[loc3.length] = [loc2[0], (loc2[0] + loc2[1]) / 2, loc2[1]];
                }
            }
            else 
            {
                loc6 = 0;
                loc7 = arg1;
                for (loc4 in loc7) 
                {
                    loc2 = arg1[loc4];
                    loc3 = loc8 = [];
                    loc5[loc4] = loc8;
                    if (loc2.length > 3) 
                    {
                        loc3[loc3.length] = [loc2[0], loc2[1], (loc2[1] + loc2[2]) / 2];
                        loc1 = 2;
                        while (loc1 < loc2.length - 2) 
                        {
                            loc3[loc3.length] = [loc3[loc1 - 2][2], loc2[loc1], (loc2[loc1] + loc2[loc1 + 1]) / 2];
                            ++loc1;
                        }
                        loc3[loc3.length] = [loc3[(loc3.length - 1)][2], loc2[loc2.length - 2], loc2[(loc2.length - 1)]];
                        continue;
                    }
                    if (loc2.length == 3) 
                    {
                        loc3[loc3.length] = [loc2[0], loc2[1], loc2[2]];
                        continue;
                    }
                    if (loc2.length != 2) 
                    {
                        continue;
                    }
                    loc3[loc3.length] = [loc2[0], (loc2[0] + loc2[1]) / 2, loc2[1]];
                }
            }
            return loc5;
        }

        public static const API:Number=1;

        protected static const _RAD2DEG:Number=180 / Math.PI;

        protected var _future:Object;

        protected var _orient:Boolean;

        protected var _orientData:Array;

        protected var _target:Object;

        protected var _beziers:Object;
    }
}


//    class BezierThroughPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    
    public class BezierThroughPlugin extends com.greensock.plugins.BezierPlugin
    {
        public function BezierThroughPlugin()
        {
            super();
            this.propName = "bezierThrough";
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            if (!(arg2 is Array)) 
            {
                return false;
            }
            init(arg3, arg2 as Array, true);
            return true;
        }

        public static const API:Number=1;
    }
}


//    class BlurFilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class BlurFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        public function BlurFilterPlugin()
        {
            super();
            this.propName = "blurFilter";
            this.overwriteProps = ["blurFilter"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _type = flash.filters.BlurFilter;
            initFilter(arg2, new flash.filters.BlurFilter(0, 0, arg2.quality || 2), _propNames);
            return true;
        }

        
        {
            _propNames = ["blurX", "blurY", "quality"];
        }

        public static const API:Number=1;

        internal static var _propNames:Array;
    }
}


//    class ColorMatrixFilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class ColorMatrixFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        public function ColorMatrixFilterPlugin()
        {
            super();
            this.propName = "colorMatrixFilter";
            this.overwriteProps = ["colorMatrixFilter"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _type = flash.filters.ColorMatrixFilter;
            var loc1:*=arg2;
            initFilter({"remove":arg2.remove, "index":arg2.index, "addFilter":arg2.addFilter}, new flash.filters.ColorMatrixFilter(_idMatrix.slice()), _propNames);
            _matrix = flash.filters.ColorMatrixFilter(_filter).matrix;
            var loc2:*=[];
            if (!(loc1.matrix == null) && loc1.matrix is Array) 
            {
                loc2 = loc1.matrix;
            }
            else 
            {
                if (loc1.relative != true) 
                {
                    loc2 = _idMatrix.slice();
                }
                else 
                {
                    loc2 = _matrix.slice();
                }
                loc2 = setBrightness(loc2, loc1.brightness);
                loc2 = setContrast(loc2, loc1.contrast);
                loc2 = setHue(loc2, loc1.hue);
                loc2 = setSaturation(loc2, loc1.saturation);
                loc2 = setThreshold(loc2, loc1.threshold);
                if (!isNaN(loc1.colorize)) 
                {
                    loc2 = colorize(loc2, loc1.colorize, loc1.amount);
                }
            }
            _matrixTween = new com.greensock.plugins.EndArrayPlugin();
            _matrixTween.init(_matrix, loc2);
            return true;
        }

        public override function set changeFactor(arg1:Number):void
        {
            _matrixTween.changeFactor = arg1;
            flash.filters.ColorMatrixFilter(_filter).matrix = _matrix;
            super.changeFactor = arg1;
            return;
        }

        public static function setSaturation(arg1:Array, arg2:Number):Array
        {
            if (isNaN(arg2)) 
            {
                return arg1;
            }
            var loc1:*=1 - arg2;
            var loc2:*=loc1 * _lumR;
            var loc3:*=loc1 * _lumG;
            var loc4:*=loc1 * _lumB;
            var loc5:*=[loc2 + arg2, loc3, loc4, 0, 0, loc2, loc3 + arg2, loc4, 0, 0, loc2, loc3, loc4 + arg2, 0, 0, 0, 0, 0, 1, 0];
            return applyMatrix(loc5, arg1);
        }

        public static function setHue(arg1:Array, arg2:Number):Array
        {
            if (isNaN(arg2)) 
            {
                return arg1;
            }
            arg2 = arg2 * Math.PI / 180;
            var loc1:*=Math.cos(arg2);
            var loc2:*=Math.sin(arg2);
            var loc3:*=[_lumR + loc1 * (1 - _lumR) + loc2 * (-_lumR), _lumG + loc1 * (-_lumG) + loc2 * (-_lumG), _lumB + loc1 * (-_lumB) + loc2 * (1 - _lumB), 0, 0, _lumR + loc1 * (-_lumR) + loc2 * 0.143, _lumG + loc1 * (1 - _lumG) + loc2 * 0.14, _lumB + loc1 * (-_lumB) + loc2 * -0.283, 0, 0, _lumR + loc1 * (-_lumR) + loc2 * (-(1 - _lumR)), _lumG + loc1 * (-_lumG) + loc2 * _lumG, _lumB + loc1 * (1 - _lumB) + loc2 * _lumB, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
            return applyMatrix(loc3, arg1);
        }

        public static function setContrast(arg1:Array, arg2:Number):Array
        {
            if (isNaN(arg2)) 
            {
                return arg1;
            }
            arg2 = arg2 + 0.01;
            var loc1:*=[arg2, 0, 0, 0, 128 * (1 - arg2), 0, arg2, 0, 0, 128 * (1 - arg2), 0, 0, arg2, 0, 128 * (1 - arg2), 0, 0, 0, 1, 0];
            return applyMatrix(loc1, arg1);
        }

        public static function applyMatrix(arg1:Array, arg2:Array):Array
        {
            var loc4:*=0;
            var loc5:*=0;
            if (!(arg1 is Array) || !(arg2 is Array)) 
            {
                return arg2;
            }
            var loc1:*=[];
            var loc2:*=0;
            var loc3:*=0;
            loc4 = 0;
            while (loc4 < 4) 
            {
                loc5 = 0;
                while (loc5 < 5) 
                {
                    if (loc5 != 4) 
                    {
                        loc3 = 0;
                    }
                    else 
                    {
                        loc3 = arg1[loc2 + 4];
                    }
                    loc1[loc2 + loc5] = arg1[loc2] * arg2[loc5] + arg1[loc2 + 1] * arg2[loc5 + 5] + arg1[loc2 + 2] * arg2[loc5 + 10] + arg1[loc2 + 3] * arg2[loc5 + 15] + loc3;
                    ++loc5;
                }
                loc2 = loc2 + 5;
                ++loc4;
            }
            return loc1;
        }

        public static function setThreshold(arg1:Array, arg2:Number):Array
        {
            if (isNaN(arg2)) 
            {
                return arg1;
            }
            var loc1:*=[_lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * arg2, _lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * arg2, _lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * arg2, 0, 0, 0, 1, 0];
            return applyMatrix(loc1, arg1);
        }

        public static function colorize(arg1:Array, arg2:Number, arg3:Number=1):Array
        {
            if (isNaN(arg2)) 
            {
                return arg1;
            }
            if (isNaN(arg3)) 
            {
                arg3 = 1;
            }
            var loc1:*=(arg2 >> 16 & 255) / 255;
            var loc2:*=(arg2 >> 8 & 255) / 255;
            var loc3:*=(arg2 & 255) / 255;
            var loc4:*=1 - arg3;
            var loc5:*=[loc4 + arg3 * loc1 * _lumR, arg3 * loc1 * _lumG, arg3 * loc1 * _lumB, 0, 0, arg3 * loc2 * _lumR, loc4 + arg3 * loc2 * _lumG, arg3 * loc2 * _lumB, 0, 0, arg3 * loc3 * _lumR, arg3 * loc3 * _lumG, loc4 + arg3 * loc3 * _lumB, 0, 0, 0, 0, 0, 1, 0];
            return applyMatrix(loc5, arg1);
        }

        public static function setBrightness(arg1:Array, arg2:Number):Array
        {
            if (isNaN(arg2)) 
            {
                return arg1;
            }
            arg2 = arg2 * 100 - 100;
            return applyMatrix([1, 0, 0, 0, arg2, 0, 1, 0, 0, arg2, 0, 0, 1, 0, arg2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1], arg1);
        }

        
        {
            _propNames = [];
            _idMatrix = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
            _lumR = 0.212671;
            _lumG = 0.71516;
            _lumB = 0.072169;
        }

        public static const API:Number=1;

        protected var _matrix:Array;

        protected var _matrixTween:com.greensock.plugins.EndArrayPlugin;

        internal static var _propNames:Array;

        protected static var _lumG:Number=0.71516;

        protected static var _lumR:Number=0.212671;

        protected static var _idMatrix:Array;

        protected static var _lumB:Number=0.072169;
    }
}


//    class ColorTransformPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.geom.*;
    
    public class ColorTransformPlugin extends com.greensock.plugins.TintPlugin
    {
        public function ColorTransformPlugin()
        {
            super();
            this.propName = "colorTransform";
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            var loc2:*=null;
            var loc3:*=NaN;
            if (!(arg1 is flash.display.DisplayObject)) 
            {
                return false;
            }
            var loc1:*=arg1.transform.colorTransform;
            var loc4:*=0;
            var loc5:*=arg2;
            for (loc2 in loc5) 
            {
                if (loc2 == "tint" || loc2 == "color") 
                {
                    if (arg2[loc2] != null) 
                    {
                        loc1.color = int(arg2[loc2]);
                    }
                    continue;
                }
                if (loc2 == "tintAmount" || loc2 == "exposure" || loc2 == "brightness") 
                {
                    continue;
                }
                loc1[loc2] = arg2[loc2];
            }
            if (isNaN(arg2.tintAmount)) 
            {
                if (isNaN(arg2.exposure)) 
                {
                    if (!isNaN(arg2.brightness)) 
                    {
                        loc1.blueOffset = loc4 = Math.max(0, (arg2.brightness - 1) * 255);
                        loc1.greenOffset = loc4 = loc4;
                        loc1.redOffset = loc4;
                        loc1.blueMultiplier = loc4 = 1 - Math.abs((arg2.brightness - 1));
                        loc1.greenMultiplier = loc4 = loc4;
                        loc1.redMultiplier = loc4;
                    }
                }
                else 
                {
                    loc1.blueOffset = loc4 = 255 * (arg2.exposure - 1);
                    loc1.greenOffset = loc4 = loc4;
                    loc1.redOffset = loc4;
                    loc1.blueMultiplier = loc4 = 1;
                    loc1.greenMultiplier = loc4 = loc4;
                    loc1.redMultiplier = loc4;
                }
            }
            else 
            {
                loc3 = arg2.tintAmount / (1 - (loc1.redMultiplier + loc1.greenMultiplier + loc1.blueMultiplier) / 3);
                loc1.redOffset = loc1.redOffset * loc3;
                loc1.greenOffset = loc1.greenOffset * loc3;
                loc1.blueOffset = loc1.blueOffset * loc3;
                loc1.blueMultiplier = loc4 = 1 - arg2.tintAmount;
                loc1.greenMultiplier = loc4 = loc4;
                loc1.redMultiplier = loc4;
            }
            _ignoreAlpha = Boolean(!(arg3.vars.alpha == undefined) && arg2.alphaMultiplier == undefined);
            init(arg1 as flash.display.DisplayObject, loc1);
            return true;
        }

        public static const API:Number=1;
    }
}


//    class DropShadowFilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class DropShadowFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        public function DropShadowFilterPlugin()
        {
            super();
            this.propName = "dropShadowFilter";
            this.overwriteProps = ["dropShadowFilter"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _type = flash.filters.DropShadowFilter;
            initFilter(arg2, new flash.filters.DropShadowFilter(0, 45, 0, 0, 0, 0, 1, arg2.quality || 2, arg2.inner, arg2.knockout, arg2.hideObject), _propNames);
            return true;
        }

        
        {
            _propNames = ["distance", "angle", "color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout", "hideObject"];
        }

        public static const API:Number=1;

        internal static var _propNames:Array;
    }
}


//    class EndArrayPlugin
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

//    class FilterPlugin
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


//    class FrameLabelPlugin
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


//    class FramePlugin
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


//    class GlowFilterPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    import flash.filters.*;
    
    public class GlowFilterPlugin extends com.greensock.plugins.FilterPlugin
    {
        public function GlowFilterPlugin()
        {
            super();
            this.propName = "glowFilter";
            this.overwriteProps = ["glowFilter"];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            _target = arg1;
            _type = flash.filters.GlowFilter;
            initFilter(arg2, new flash.filters.GlowFilter(16777215, 0, 0, 0, arg2.strength || 1, arg2.quality || 2, arg2.inner, arg2.knockout), _propNames);
            return true;
        }

        
        {
            _propNames = ["color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout"];
        }

        public static const API:Number=1;

        internal static var _propNames:Array;
    }
}


//    class HexColorsPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class HexColorsPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function HexColorsPlugin()
        {
            super();
            this.propName = "hexColors";
            this.overwriteProps = [];
            _colors = [];
            return;
        }

        public override function killProps(arg1:Object):void
        {
            var loc1:*=(_colors.length - 1);
            while (loc1 > -1) 
            {
                if (arg1[_colors[loc1][1]] != undefined) 
                {
                    _colors.splice(loc1, 1);
                }
                --loc1;
            }
            super.killProps(arg1);
            return;
        }

        public function initColor(arg1:Object, arg2:String, arg3:uint, arg4:uint):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (arg3 != arg4) 
            {
                loc1 = arg3 >> 16;
                loc2 = arg3 >> 8 & 255;
                loc3 = arg3 & 255;
                _colors[_colors.length] = [arg1, arg2, loc1, (arg4 >> 16) - loc1, loc2, (arg4 >> 8 & 255) - loc2, loc3, (arg4 & 255) - loc3];
                this.overwriteProps[this.overwriteProps.length] = arg2;
            }
            return;
        }

        public override function set changeFactor(arg1:Number):void
        {
            var loc1:*=0;
            var loc2:*=null;
            loc1 = (_colors.length - 1);
            while (loc1 > -1) 
            {
                loc2 = _colors[loc1];
                loc2[0][loc2[1]] = loc2[2] + arg1 * loc2[3] << 16 | loc2[4] + arg1 * loc2[5] << 8 | loc2[6] + arg1 * loc2[7];
                --loc1;
            }
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg2;
            for (loc1 in loc3) 
            {
                initColor(arg1, loc1, uint(arg1[loc1]), uint(arg2[loc1]));
            }
            return true;
        }

        public static const API:Number=1;

        protected var _colors:Array;
    }
}


//    class RemoveTintPlugin
package com.greensock.plugins 
{
    public class RemoveTintPlugin extends com.greensock.plugins.TintPlugin
    {
        public function RemoveTintPlugin()
        {
            super();
            this.propName = "removeTint";
            return;
        }

        public static const API:Number=1;
    }
}


//    class RoundPropsPlugin
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


//    class ShortRotationPlugin
package com.greensock.plugins 
{
    import com.greensock.*;
    import flash.display.*;
    
    public class ShortRotationPlugin extends com.greensock.plugins.TweenPlugin
    {
        public function ShortRotationPlugin()
        {
            super();
            this.propName = "shortRotation";
            this.overwriteProps = [];
            return;
        }

        public override function onInitTween(arg1:Object, arg2:*, arg3:com.greensock.TweenLite):Boolean
        {
            var loc1:*=null;
            if (typeof arg2 == "number") 
            {
                return false;
            }
            var loc2:*=0;
            var loc3:*=arg2;
            for (loc1 in loc3) 
            {
                initRotation(arg1, loc1, arg1[loc1], typeof arg2[loc1] != "number" ? arg1[loc1] + Number(arg2[loc1]) : Number(arg2[loc1]));
            }
            return true;
        }

        public function initRotation(arg1:Object, arg2:String, arg3:Number, arg4:Number):void
        {
            var loc1:*=(arg4 - arg3) % 360;
            if (loc1 != loc1 % 180) 
            {
                loc1 = loc1 < 0 ? loc1 + 360 : loc1 - 360;
            }
            addTween(arg1, arg2, arg3, arg3 + loc1, arg2);
            this.overwriteProps[this.overwriteProps.length] = arg2;
            return;
        }

        public static const API:Number=1;
    }
}


//    class TintPlugin
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


//    class TweenPlugin
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


//    class VisiblePlugin
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


//    class VolumePlugin
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


//  class OverwriteManager
package com.greensock 
{
    import com.greensock.core.*;
    import flash.errors.*;
    import flash.utils.*;
    
    public class OverwriteManager extends Object
    {
        public function OverwriteManager()
        {
            super();
            return;
        }

        public static function getGlobalPaused(arg1:com.greensock.core.TweenCore):Boolean
        {
            while (arg1) 
            {
                if (arg1.cachedPaused) 
                {
                    return true;
                }
                arg1 = arg1.timeline;
            }
            return false;
        }

        public static function init(arg1:int=2):int
        {
            if (com.greensock.TweenLite.version < 11.1) 
            {
                throw new Error("Warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com.");
            }
            com.greensock.TweenLite.overwriteManager = com.greensock.OverwriteManager;
            mode = arg1;
            enabled = true;
            return mode;
        }

        public static function manageOverwrites(arg1:com.greensock.TweenLite, arg2:Object, arg3:Array, arg4:uint):Boolean
        {
            var loc1:*=0;
            var loc2:*=false;
            var loc3:*=null;
            var loc9:*=0;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=null;
            var loc13:*=NaN;
            var loc14:*=null;
            if (arg4 >= 4) 
            {
                loc9 = arg3.length;
                loc1 = 0;
                while (loc1 < loc9) 
                {
                    loc3 = arg3[loc1];
                    if (loc3 == arg1) 
                    {
                        if (arg4 == 5) 
                        {
                            break;
                        }
                    }
                    else if (loc3.setEnabled(false, false)) 
                    {
                        loc2 = true;
                    }
                    ++loc1;
                }
                return loc2;
            }
            var loc4:*=arg1.cachedStartTime + 1e-010;
            var loc5:*=[];
            var loc6:*=[];
            var loc7:*=0;
            var loc8:*=0;
            loc1 = arg3.length;
            while (--loc1 > -1) 
            {
                loc3 = arg3[loc1];
                if (loc3 == arg1 || loc3.gc) 
                {
                    continue;
                }
                if (loc3.timeline != arg1.timeline) 
                {
                    if (!getGlobalPaused(loc3)) 
                    {
                        var loc15:*;
                        loc6[loc15 = loc7++] = loc3;
                    }
                    continue;
                }
                if (!(loc3.cachedStartTime <= loc4 && loc3.cachedStartTime + loc3.totalDuration + 1e-010 > loc4 && !getGlobalPaused(loc3))) 
                {
                    continue;
                }
                loc5[loc15 = loc8++] = loc3;
            }
            if (loc7 != 0) 
            {
                loc10 = arg1.cachedTimeScale;
                loc11 = loc4;
                loc14 = arg1.timeline;
                while (loc14) 
                {
                    loc10 = loc10 * loc14.cachedTimeScale;
                    loc11 = loc11 + loc14.cachedStartTime;
                    loc14 = loc14.timeline;
                }
                loc4 = loc10 * loc11;
                loc1 = loc7;
                while (--loc1 > -1) 
                {
                    loc12 = loc6[loc1];
                    loc10 = loc12.cachedTimeScale;
                    loc11 = loc12.cachedStartTime;
                    loc14 = loc12.timeline;
                    while (loc14) 
                    {
                        loc10 = loc10 * loc14.cachedTimeScale;
                        loc11 = loc11 + loc14.cachedStartTime;
                        loc14 = loc14.timeline;
                    }
                    loc13 = loc10 * loc11;
                    if (!(loc13 <= loc4 && (loc13 + loc12.totalDuration * loc10 + 1e-010 > loc4 || loc12.cachedDuration == 0))) 
                    {
                        continue;
                    }
                    loc5[loc15 = loc8++] = loc12;
                }
            }
            if (loc8 == 0) 
            {
                return loc2;
            }
            loc1 = loc8;
            if (arg4 != 2) 
            {
                while (--loc1 > -1) 
                {
                    if (!com.greensock.TweenLite(loc5[loc1]).setEnabled(false, false)) 
                    {
                        continue;
                    }
                    loc2 = true;
                }
            }
            else 
            {
                while (--loc1 > -1) 
                {
                    loc3 = loc5[loc1];
                    if (loc3.killVars(arg2)) 
                    {
                        loc2 = true;
                    }
                    if (!(loc3.cachedPT1 == null && loc3.initted)) 
                    {
                        continue;
                    }
                    loc3.setEnabled(false, false);
                }
            }
            return loc2;
        }

        public static const ALL_ONSTART:int=4;

        public static const CONCURRENT:int=3;

        public static const ALL_IMMEDIATE:int=1;

        public static const PREEXISTING:int=5;

        public static const AUTO:int=2;

        public static const version:Number=6.02;

        public static const NONE:int=0;

        public static var enabled:Boolean;

        public static var mode:int;
    }
}


//  class TweenLite
package com.greensock 
{
    import com.greensock.core.*;
    import com.greensock.plugins.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    
    public class TweenLite extends com.greensock.core.TweenCore
    {
        public function TweenLite(arg1:Object, arg2:Number, arg3:Object)
        {
            var loc2:*=null;
            super(arg2, arg3);
            this.target = arg1;
            if (this.target is com.greensock.core.TweenCore && this.vars.timeScale) 
            {
                this.cachedTimeScale = 1;
            }
            propTweenLookup = {};
            _ease = defaultEase;
            _overwrite = !(Number(arg3.overwrite) > -1) || !overwriteManager.enabled && arg3.overwrite > 1 ? overwriteManager.mode : int(arg3.overwrite);
            var loc1:*=masterList[arg1];
            if (loc1) 
            {
                if (_overwrite != 1) 
                {
                    loc1[loc1.length] = this;
                }
                else 
                {
                    var loc3:*=0;
                    var loc4:*=loc1;
                    for each (loc2 in loc4) 
                    {
                        if (loc2.gc) 
                        {
                            continue;
                        }
                        loc2.setEnabled(false, false);
                    }
                    masterList[arg1] = [this];
                }
            }
            else 
            {
                masterList[arg1] = [this];
            }
            if (this.active || this.vars.immediateRender) 
            {
                renderTime(0, false, true);
            }
            return;
        }

        protected function easeProxy(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            return this.vars.proxiedEase.apply(null, arguments.concat(this.vars.easeParams));
        }

        public override function renderTime(arg1:Number, arg2:Boolean=false, arg3:Boolean=false):void
        {
            var loc1:*=false;
            var loc2:*=this.cachedTime;
            if (arg1 >= this.cachedDuration) 
            {
                var loc4:*;
                this.cachedTime = loc4 = this.cachedDuration;
                this.cachedTotalTime = loc4;
                this.ratio = 1;
                loc1 = true;
                if (this.cachedDuration == 0) 
                {
                    if ((arg1 == 0 || _rawPrevTime < 0) && !(_rawPrevTime == arg1)) 
                    {
                        arg3 = true;
                    }
                    _rawPrevTime = arg1;
                }
            }
            else if (arg1 <= 0) 
            {
                this.ratio = loc4 = 0;
                this.cachedTime = loc4 = loc4;
                this.cachedTotalTime = loc4;
                if (arg1 < 0) 
                {
                    this.active = false;
                    if (this.cachedDuration == 0) 
                    {
                        if (_rawPrevTime > 0) 
                        {
                            arg3 = true;
                            loc1 = true;
                        }
                        _rawPrevTime = arg1;
                    }
                }
                if (this.cachedReversed && !(loc2 == 0)) 
                {
                    loc1 = true;
                }
            }
            else 
            {
                this.cachedTime = loc4 = arg1;
                this.cachedTotalTime = loc4;
                this.ratio = _ease(arg1, 0, 1, this.cachedDuration);
            }
            if (this.cachedTime == loc2 && !arg3) 
            {
                return;
            }
            if (!this.initted) 
            {
                init();
                if (!loc1 && this.cachedTime) 
                {
                    this.ratio = _ease(this.cachedTime, 0, 1, this.cachedDuration);
                }
            }
            if (!this.active && !this.cachedPaused) 
            {
                this.active = true;
            }
            if (loc2 == 0 && this.vars.onStart && !(this.cachedTime == 0) && !arg2) 
            {
                this.vars.onStart.apply(null, this.vars.onStartParams);
            }
            var loc3:*=this.cachedPT1;
            while (loc3) 
            {
                loc3.target[loc3.property] = loc3.start + this.ratio * loc3.change;
                loc3 = loc3.nextNode;
            }
            if (_hasUpdate && !arg2) 
            {
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            }
            if (loc1) 
            {
                if (_hasPlugins && this.cachedPT1) 
                {
                    onPluginEvent("onComplete", this);
                }
                complete(true, arg2);
            }
            return;
        }

        public override function invalidate():void
        {
            if (_notifyPluginsOfEnabled && this.cachedPT1) 
            {
                onPluginEvent("onDisable", this);
            }
            this.cachedPT1 = null;
            _overwrittenProps = null;
            var loc1:*;
            _notifyPluginsOfEnabled = loc1 = false;
            this.active = loc1 = loc1;
            this.initted = loc1 = loc1;
            _hasUpdate = loc1;
            this.propTweenLookup = {};
            return;
        }

        public override function setEnabled(arg1:Boolean, arg2:Boolean=false):Boolean
        {
            var loc1:*=null;
            if (arg1) 
            {
                loc1 = com.greensock.TweenLite.masterList[this.target];
                if (loc1) 
                {
                    loc1[loc1.length] = this;
                }
                else 
                {
                    com.greensock.TweenLite.masterList[this.target] = [this];
                }
            }
            super.setEnabled(arg1, arg2);
            if (_notifyPluginsOfEnabled && this.cachedPT1) 
            {
                return onPluginEvent(arg1 ? "onEnable" : "onDisable", this);
            }
            return false;
        }

        protected static function updateAll(arg1:flash.events.Event=null):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            rootTimeline.renderTime((flash.utils.getTimer() * 0.001 - rootTimeline.cachedStartTime) * rootTimeline.cachedTimeScale, false, false);
            var loc5:*;
            rootFrame++;
            rootFramesTimeline.renderTime((rootFrame - rootFramesTimeline.cachedStartTime) * rootFramesTimeline.cachedTimeScale, false, false);
            if (!(rootFrame % 60)) 
            {
                loc1 = masterList;
                loc5 = 0;
                loc6 = loc1;
                for (loc2 in loc6) 
                {
                    loc3 = loc1[loc2];
                    loc4 = loc3.length;
                    while (--loc4 > -1) 
                    {
                        if (!TweenLite(loc3[loc4]).gc) 
                        {
                            continue;
                        }
                        loc3.splice(loc4, 1);
                    }
                    if (loc3.length != 0) 
                    {
                        continue;
                    }
                    delete loc1[loc2];
                }
            }
            return;
        }

        public static function to(arg1:Object, arg2:Number, arg3:Object):com.greensock.TweenLite
        {
            return new TweenLite(arg1, arg2, arg3);
        }

        
        {
            plugins = {};
            fastEaseLookup = new flash.utils.Dictionary(false);
            killDelayedCallsTo = TweenLite.killTweensOf;
            defaultEase = TweenLite.easeOut;
            masterList = new flash.utils.Dictionary(false);
            _shape = new flash.display.Shape();
            _reservedProps = {"ease":1, "delay":1, "overwrite":1, "onComplete":1, "onCompleteParams":1, "useFrames":1, "runBackwards":1, "startAt":1, "onUpdate":1, "onUpdateParams":1, "roundProps":1, "onStart":1, "onStartParams":1, "onInit":1, "onInitParams":1, "onReverseComplete":1, "onReverseCompleteParams":1, "onRepeat":1, "onRepeatParams":1, "proxiedEase":1, "easeParams":1, "yoyo":1, "onCompleteListener":1, "onUpdateListener":1, "onStartListener":1, "onReverseCompleteListener":1, "onRepeatListener":1, "orientToBezier":1, "timeScale":1, "immediateRender":1, "repeat":1, "repeatDelay":1, "timeline":1, "data":1, "paused":1};
        }

        public static function initClass():void
        {
            rootFrame = 0;
            rootTimeline = new com.greensock.core.SimpleTimeline(null);
            rootFramesTimeline = new com.greensock.core.SimpleTimeline(null);
            rootTimeline.cachedStartTime = flash.utils.getTimer() * 0.001;
            rootFramesTimeline.cachedStartTime = rootFrame;
            rootTimeline.autoRemoveChildren = true;
            rootFramesTimeline.autoRemoveChildren = true;
            _shape.addEventListener(flash.events.Event.ENTER_FRAME, updateAll, false, 0, true);
            if (overwriteManager == null) 
            {
                overwriteManager = {"mode":1, "enabled":false};
            }
            return;
        }

        protected function init():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=undefined;
            var loc4:*=false;
            var loc5:*=null;
            var loc6:*=null;
            if (this.vars.onInit) 
            {
                this.vars.onInit.apply(null, this.vars.onInitParams);
            }
            if (typeof this.vars.ease == "function") 
            {
                _ease = this.vars.ease;
            }
            if (this.vars.easeParams) 
            {
                this.vars.proxiedEase = _ease;
                _ease = easeProxy;
            }
            this.cachedPT1 = null;
            this.propTweenLookup = {};
            var loc7:*=0;
            var loc8:*=this.vars;
            for (loc1 in loc8) 
            {
                if (loc1 in _reservedProps && !(loc1 == "timeScale" && this.target is com.greensock.core.TweenCore)) 
                {
                    continue;
                }
                if (loc1 in plugins) 
                {
                    loc1 in plugins;
                    var loc9:*;
                    loc3 = loc9 = new (plugins[loc1] as Class)();
                }
                if (loc1 in plugins) 
                {
                    this.cachedPT1 = new com.greensock.core.PropTween(loc3, "changeFactor", 0, 1, loc3.overwriteProps.length != 1 ? "_MULTIPLE_" : loc3.overwriteProps[0], true, this.cachedPT1);
                    if (this.cachedPT1.name != "_MULTIPLE_") 
                    {
                        this.propTweenLookup[this.cachedPT1.name] = this.cachedPT1;
                    }
                    else 
                    {
                        loc2 = loc3.overwriteProps.length;
                        while (--loc2 > -1) 
                        {
                            this.propTweenLookup[loc3.overwriteProps[loc2]] = this.cachedPT1;
                        }
                    }
                    if (loc3.priority) 
                    {
                        this.cachedPT1.priority = loc3.priority;
                        loc4 = true;
                    }
                    if (loc3.onDisable || loc3.onEnable) 
                    {
                        _notifyPluginsOfEnabled = true;
                    }
                    _hasPlugins = true;
                    continue;
                }
                this.cachedPT1 = new com.greensock.core.PropTween(this.target, loc1, Number(this.target[loc1]), typeof this.vars[loc1] != "number" ? Number(this.vars[loc1]) : Number(this.vars[loc1]) - this.target[loc1], loc1, false, this.cachedPT1);
                this.propTweenLookup[loc1] = this.cachedPT1;
            }
            if (loc4) 
            {
                onPluginEvent("onInit", this);
            }
            if (this.vars.runBackwards) 
            {
                loc6 = this.cachedPT1;
                while (loc6) 
                {
                    loc6.start = loc6.start + loc6.change;
                    loc6.change = -loc6.change;
                    loc6 = loc6.nextNode;
                }
            }
            _hasUpdate = Boolean(!(this.vars.onUpdate == null));
            if (_overwrittenProps) 
            {
                killVars(_overwrittenProps);
                if (this.cachedPT1 == null) 
                {
                    this.setEnabled(false, false);
                }
            }
            if (_overwrite > 1 && this.cachedPT1) 
            {
                _overwrite > 1 && this.cachedPT1;
                loc5 = loc7 = masterList[this.target];
            }
            if (_overwrite > 1 && this.cachedPT1 && loc5.length > 1) 
            {
                if (overwriteManager.manageOverwrites(this, this.propTweenLookup, loc5, _overwrite)) 
                {
                    init();
                }
            }
            this.initted = true;
            return;
        }

        public static function killTweensOf(arg1:Object, arg2:Boolean=false, arg3:Object=null):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=null;
            if (arg1 in masterList) 
            {
                loc1 = masterList[arg1];
                loc2 = loc1.length;
                while (--loc2 > -1) 
                {
                    loc3 = loc1[loc2];
                    if (loc3.gc) 
                    {
                        continue;
                    }
                    if (arg2) 
                    {
                        loc3.complete(false, false);
                    }
                    if (arg3 != null) 
                    {
                        loc3.killVars(arg3);
                    }
                    if (!(arg3 == null || loc3.cachedPT1 == null && loc3.initted)) 
                    {
                        continue;
                    }
                    loc3.setEnabled(false, false);
                }
                if (arg3 == null) 
                {
                    delete masterList[arg1];
                }
            }
            return;
        }

        public static function from(arg1:Object, arg2:Number, arg3:Object):com.greensock.TweenLite
        {
            arg3.runBackwards = true;
            if (!("immediateRender" in arg3)) 
            {
                arg3.immediateRender = true;
            }
            return new TweenLite(arg1, arg2, arg3);
        }

        protected static function easeOut(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc1:*;
            arg1 = loc1 = 1 - arg1 / arg4;
            return 1 - loc1 * arg1;
        }

        public function killVars(arg1:Object, arg2:Boolean=true):Boolean
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=false;
            if (_overwrittenProps == null) 
            {
                _overwrittenProps = {};
            }
            var loc4:*=0;
            var loc5:*=arg1;
            for (loc1 in loc5) 
            {
                if (loc1 in propTweenLookup) 
                {
                    loc2 = propTweenLookup[loc1];
                    if (loc2.isPlugin && loc2.name == "_MULTIPLE_") 
                    {
                        loc2.target.killProps(arg1);
                        if (loc2.target.overwriteProps.length == 0) 
                        {
                            loc2.name = "";
                        }
                    }
                    if (loc2.name != "_MULTIPLE_") 
                    {
                        if (loc2.nextNode) 
                        {
                            loc2.nextNode.prevNode = loc2.prevNode;
                        }
                        if (loc2.prevNode) 
                        {
                            loc2.prevNode.nextNode = loc2.nextNode;
                        }
                        else if (this.cachedPT1 == loc2) 
                        {
                            this.cachedPT1 = loc2.nextNode;
                        }
                        if (loc2.isPlugin && loc2.target.onDisable) 
                        {
                            loc2.target.onDisable();
                            if (loc2.target.activeDisable) 
                            {
                                loc3 = true;
                            }
                        }
                        delete propTweenLookup[loc1];
                    }
                }
                if (!(arg2 && !(arg1 == _overwrittenProps))) 
                {
                    continue;
                }
                _overwrittenProps[loc1] = 1;
            }
            return loc3;
        }

        public static function delayedCall(arg1:Number, arg2:Function, arg3:Array=null, arg4:Boolean=false):com.greensock.TweenLite
        {
            return new TweenLite(arg2, 0, {"delay":arg1, "onComplete":arg2, "onCompleteParams":arg3, "immediateRender":false, "useFrames":arg4, "overwrite":0});
        }

        public static const version:Number=11.36;

        protected var _hasPlugins:Boolean;

        public var propTweenLookup:Object;

        public var cachedPT1:com.greensock.core.PropTween;

        protected var _overwrite:uint;

        protected var _ease:Function;

        public var target:Object;

        public var ratio:Number=0;

        protected var _overwrittenProps:Object;

        protected var _notifyPluginsOfEnabled:Boolean;

        public static var rootTimeline:com.greensock.core.SimpleTimeline;

        public static var fastEaseLookup:flash.utils.Dictionary;

        public static var overwriteManager:Object;

        public static var rootFramesTimeline:com.greensock.core.SimpleTimeline;

        public static var rootFrame:Number;

        public static var killDelayedCallsTo:Function;

        public static var plugins:Object;

        internal static var _shape:flash.display.Shape;

        protected static var _reservedProps:Object;

        public static var defaultEase:Function;

        public static var masterList:flash.utils.Dictionary;

        public static var onPluginEvent:Function;
    }
}


//  class TweenMax
package com.greensock 
{
    import com.greensock.core.*;
    import com.greensock.events.*;
    import com.greensock.plugins.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    
    public class TweenMax extends com.greensock.TweenLite implements flash.events.IEventDispatcher
    {
        public function TweenMax(arg1:Object, arg2:Number, arg3:Object)
        {
            super(arg1, arg2, arg3);
            if (com.greensock.TweenLite.version < 11.2) 
            {
                throw new Error("TweenMax error! Please update your TweenLite class or try deleting your ASO files. TweenMax requires a more recent version. Download updates at http://www.TweenMax.com.");
            }
            this.yoyo = Boolean(this.vars.yoyo);
            _repeat = this.vars.repeat ? int(this.vars.repeat) : 0;
            _repeatDelay = this.vars.repeatDelay ? Number(this.vars.repeatDelay) : 0;
            this.cacheIsDirty = true;
            if (this.vars.onCompleteListener || this.vars.onInitListener || this.vars.onUpdateListener || this.vars.onStartListener || this.vars.onRepeatListener || this.vars.onReverseCompleteListener) 
            {
                initDispatcher();
                if (arg2 == 0 && _delay == 0) 
                {
                    _dispatcher.dispatchEvent(new com.greensock.events.TweenEvent(com.greensock.events.TweenEvent.UPDATE));
                    _dispatcher.dispatchEvent(new com.greensock.events.TweenEvent(com.greensock.events.TweenEvent.COMPLETE));
                }
            }
            if (this.vars.timeScale && !(this.target is com.greensock.core.TweenCore)) 
            {
                this.cachedTimeScale = this.vars.timeScale;
            }
            return;
        }

        public function dispatchEvent(arg1:flash.events.Event):Boolean
        {
            return _dispatcher != null ? _dispatcher.dispatchEvent(arg1) : false;
        }

        public function set timeScale(arg1:Number):void
        {
            if (arg1 == 0) 
            {
                arg1 = 0.0001;
            }
            var loc1:*=_pauseTime || _pauseTime == 0 ? _pauseTime : this.timeline.cachedTotalTime;
            this.cachedStartTime = loc1 - (loc1 - this.cachedStartTime) * this.cachedTimeScale / arg1;
            this.cachedTimeScale = arg1;
            setDirtyCache(false);
            return;
        }

        public override function renderTime(arg1:Number, arg2:Boolean=false, arg3:Boolean=false):void
        {
            var loc3:*=false;
            var loc4:*=false;
            var loc5:*=false;
            var loc7:*=NaN;
            var loc8:*=0;
            var loc9:*=0;
            var loc10:*=NaN;
            var loc1:*=this.cacheIsDirty ? this.totalDuration : this.cachedTotalDuration;
            var loc2:*=this.cachedTime;
            if (arg1 >= loc1) 
            {
                this.cachedTotalTime = loc1;
                this.cachedTime = this.cachedDuration;
                this.ratio = 1;
                loc3 = true;
                if (this.cachedDuration == 0) 
                {
                    if ((arg1 == 0 || _rawPrevTime < 0) && !(_rawPrevTime == arg1)) 
                    {
                        arg3 = true;
                    }
                    _rawPrevTime = arg1;
                }
            }
            else if (arg1 <= 0) 
            {
                if (arg1 < 0) 
                {
                    this.active = false;
                    if (this.cachedDuration == 0) 
                    {
                        if (_rawPrevTime > 0) 
                        {
                            arg3 = true;
                            loc3 = true;
                        }
                        _rawPrevTime = arg1;
                    }
                }
                var loc11:*;
                this.ratio = loc11 = 0;
                this.cachedTime = loc11 = loc11;
                this.cachedTotalTime = loc11;
                if (this.cachedReversed && !(loc2 == 0)) 
                {
                    loc3 = true;
                }
            }
            else 
            {
                this.cachedTime = loc11 = arg1;
                this.cachedTotalTime = loc11;
                loc5 = true;
            }
            if (_repeat != 0) 
            {
                loc7 = this.cachedDuration + _repeatDelay;
                if (loc3) 
                {
                    if (this.yoyo && _repeat % 2) 
                    {
                        this.ratio = loc11 = 0;
                        this.cachedTime = loc11;
                    }
                }
                else if (arg1 > 0) 
                {
                    loc8 = _cyclesComplete;
                    _cyclesComplete = int(this.cachedTotalTime / loc7);
                    if (_cyclesComplete == this.cachedTotalTime / loc7) 
                    {
                        _cyclesComplete--;
                    }
                    if (loc8 != _cyclesComplete) 
                    {
                        loc4 = true;
                    }
                    this.cachedTime = (this.cachedTotalTime / loc7 - _cyclesComplete) * loc7;
                    if (this.yoyo && _cyclesComplete % 2) 
                    {
                        this.cachedTime = this.cachedDuration - this.cachedTime;
                    }
                    else if (this.cachedTime >= this.cachedDuration) 
                    {
                        this.cachedTime = this.cachedDuration;
                        this.ratio = 1;
                        loc5 = false;
                    }
                    if (this.cachedTime <= 0) 
                    {
                        this.ratio = loc11 = 0;
                        this.cachedTime = loc11;
                        loc5 = false;
                    }
                }
            }
            if (loc2 == this.cachedTime && !arg3) 
            {
                return;
            }
            if (!this.initted) 
            {
                init();
            }
            if (!this.active && !this.cachedPaused) 
            {
                this.active = true;
            }
            if (loc5) 
            {
                if (_easeType) 
                {
                    loc9 = _easePower;
                    loc10 = this.cachedTime / this.cachedDuration;
                    if (_easeType != 2) 
                    {
                        if (_easeType != 1) 
                        {
                            if (loc10 < 0.5) 
                            {
                                loc10 = loc11 = loc10 * 2;
                                this.ratio = loc11;
                                while (--loc9 > -1) 
                                {
                                    this.ratio = loc10 * this.ratio;
                                }
                                this.ratio = this.ratio * 0.5;
                            }
                            else 
                            {
                                loc10 = loc11 = (1 - loc10) * 2;
                                this.ratio = loc11;
                                while (--loc9 > -1) 
                                {
                                    this.ratio = loc10 * this.ratio;
                                }
                                this.ratio = 1 - 0.5 * this.ratio;
                            }
                        }
                        else 
                        {
                            this.ratio = loc10;
                            while (--loc9 > -1) 
                            {
                                this.ratio = loc10 * this.ratio;
                            }
                        }
                    }
                    else 
                    {
                        loc10 = loc11 = 1 - loc10;
                        this.ratio = loc11;
                        while (--loc9 > -1) 
                        {
                            this.ratio = loc10 * this.ratio;
                        }
                        this.ratio = 1 - this.ratio;
                    }
                }
                else 
                {
                    this.ratio = _ease(this.cachedTime, 0, 1, this.cachedDuration);
                }
            }
            if (loc2 == 0 && !(this.cachedTotalTime == 0) && !arg2) 
            {
                if (this.vars.onStart) 
                {
                    this.vars.onStart.apply(null, this.vars.onStartParams);
                }
                if (_dispatcher) 
                {
                    _dispatcher.dispatchEvent(new com.greensock.events.TweenEvent(com.greensock.events.TweenEvent.START));
                }
            }
            var loc6:*=this.cachedPT1;
            while (loc6) 
            {
                loc6.target[loc6.property] = loc6.start + this.ratio * loc6.change;
                loc6 = loc6.nextNode;
            }
            if (_hasUpdate && !arg2) 
            {
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            }
            if (_hasUpdateListener && !arg2) 
            {
                _dispatcher.dispatchEvent(new com.greensock.events.TweenEvent(com.greensock.events.TweenEvent.UPDATE));
            }
            if (loc3) 
            {
                if (_hasPlugins && this.cachedPT1) 
                {
                    onPluginEvent("onComplete", this);
                }
                complete(true, arg2);
            }
            else if (loc4 && !arg2) 
            {
                if (this.vars.onRepeat) 
                {
                    this.vars.onRepeat.apply(null, this.vars.onRepeatParams);
                }
                if (_dispatcher) 
                {
                    _dispatcher.dispatchEvent(new com.greensock.events.TweenEvent(com.greensock.events.TweenEvent.REPEAT));
                }
            }
            return;
        }

        public static function getAllTweens():Array
        {
            var loc4:*=null;
            var loc5:*=0;
            var loc1:*=masterList;
            var loc2:*=0;
            var loc3:*=[];
            var loc6:*=0;
            var loc7:*=loc1;
            for each (loc4 in loc7) 
            {
                loc5 = loc4.length;
                while (--loc5 > -1) 
                {
                    if (com.greensock.TweenLite(loc4[loc5]).gc) 
                    {
                        continue;
                    }
                    var loc8:*;
                    loc3[loc8 = loc2++] = loc4[loc5];
                }
            }
            return loc3;
        }

        public static function resumeAll(arg1:Boolean=true, arg2:Boolean=true):void
        {
            changePause(false, arg1, arg2);
            return;
        }

        public override function set totalDuration(arg1:Number):void
        {
            if (_repeat == -1) 
            {
                return;
            }
            this.duration = (arg1 - _repeat * _repeatDelay) / (_repeat + 1);
            return;
        }

        public function addEventListener(arg1:String, arg2:Function, arg3:Boolean=false, arg4:int=0, arg5:Boolean=false):void
        {
            if (_dispatcher == null) 
            {
                initDispatcher();
            }
            if (arg1 == com.greensock.events.TweenEvent.UPDATE) 
            {
                _hasUpdateListener = true;
            }
            _dispatcher.addEventListener(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        protected function insertPropTween(arg1:Object, arg2:String, arg3:Number, arg4:*, arg5:String, arg6:Boolean, arg7:com.greensock.core.PropTween):com.greensock.core.PropTween
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc1:*=new com.greensock.core.PropTween(arg1, arg2, arg3, typeof arg4 != "number" ? Number(arg4) : arg4 - arg3, arg5, arg6, arg7);
            if (arg6 && arg5 == "_MULTIPLE_") 
            {
                loc2 = arg1.overwriteProps;
                loc3 = loc2.length;
                while (--loc3 > -1) 
                {
                    this.propTweenLookup[loc2[loc3]] = loc1;
                }
            }
            else 
            {
                this.propTweenLookup[arg5] = loc1;
            }
            return loc1;
        }

        protected override function init():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=0;
            if (this.vars.startAt) 
            {
                this.vars.startAt.overwrite = 0;
                this.vars.startAt.immediateRender = true;
                loc1 = new com.greensock.TweenMax(this.target, 0, this.vars.startAt);
            }
            if (_dispatcher) 
            {
                _dispatcher.dispatchEvent(new com.greensock.events.TweenEvent(com.greensock.events.TweenEvent.INIT));
            }
            super.init();
            if (_ease in fastEaseLookup) 
            {
                _easeType = fastEaseLookup[_ease][0];
                _easePower = fastEaseLookup[_ease][1];
            }
            if (!(this.vars.roundProps == null) && "roundProps" in com.greensock.TweenLite.plugins) 
            {
                loc5 = this.vars.roundProps;
                loc9 = loc5.length;
                while (--loc9 > -1) 
                {
                    loc3 = loc5[loc9];
                    loc8 = this.cachedPT1;
                    while (loc8) 
                    {
                        if (loc8.name != loc3) 
                        {
                            if (loc8.isPlugin && loc8.name == "_MULTIPLE_" && !loc8.target.round) 
                            {
                                loc4 = " " + loc8.target.overwriteProps.join(" ") + " ";
                                if (loc4.indexOf(" " + loc3 + " ") != -1) 
                                {
                                    loc8.target.round = true;
                                }
                            }
                        }
                        else if (loc8.isPlugin) 
                        {
                            loc8.target.round = true;
                        }
                        else 
                        {
                            if (loc6 != null) 
                            {
                                loc6.add(loc8.target, loc3, loc8.start, loc8.change);
                            }
                            else 
                            {
                                loc6 = new com.greensock.TweenLite.plugins.roundProps();
                                loc6.add(loc8.target, loc3, loc8.start, loc8.change);
                                _hasPlugins = true;
                                var loc10:*;
                                loc7 = loc10 = insertPropTween(loc6, "changeFactor", 0, 1, "_MULTIPLE_", true, this.cachedPT1);
                                this.cachedPT1 = loc10;
                            }
                            this.removePropTween(loc8);
                            this.propTweenLookup[loc3] = loc7;
                        }
                        loc8 = loc8.nextNode;
                    }
                }
            }
            return;
        }

        public function removeEventListener(arg1:String, arg2:Function, arg3:Boolean=false):void
        {
            if (_dispatcher) 
            {
                _dispatcher.removeEventListener(arg1, arg2, arg3);
            }
            return;
        }

        public function setDestination(arg1:String, arg2:*, arg3:Boolean=true):void
        {
            var loc1:*={};
            loc1[arg1] = arg2;
            updateTo(loc1, !arg3);
            return;
        }

        public function willTrigger(arg1:String):Boolean
        {
            return _dispatcher != null ? _dispatcher.willTrigger(arg1) : false;
        }

        public function hasEventListener(arg1:String):Boolean
        {
            return _dispatcher != null ? _dispatcher.hasEventListener(arg1) : false;
        }

        protected function initDispatcher():void
        {
            if (_dispatcher == null) 
            {
                _dispatcher = new flash.events.EventDispatcher(this);
            }
            if (this.vars.onInitListener is Function) 
            {
                _dispatcher.addEventListener(com.greensock.events.TweenEvent.INIT, this.vars.onInitListener, false, 0, true);
            }
            if (this.vars.onStartListener is Function) 
            {
                _dispatcher.addEventListener(com.greensock.events.TweenEvent.START, this.vars.onStartListener, false, 0, true);
            }
            if (this.vars.onUpdateListener is Function) 
            {
                _dispatcher.addEventListener(com.greensock.events.TweenEvent.UPDATE, this.vars.onUpdateListener, false, 0, true);
                _hasUpdateListener = true;
            }
            if (this.vars.onCompleteListener is Function) 
            {
                _dispatcher.addEventListener(com.greensock.events.TweenEvent.COMPLETE, this.vars.onCompleteListener, false, 0, true);
            }
            if (this.vars.onRepeatListener is Function) 
            {
                _dispatcher.addEventListener(com.greensock.events.TweenEvent.REPEAT, this.vars.onRepeatListener, false, 0, true);
            }
            if (this.vars.onReverseCompleteListener is Function) 
            {
                _dispatcher.addEventListener(com.greensock.events.TweenEvent.REVERSE_COMPLETE, this.vars.onReverseCompleteListener, false, 0, true);
            }
            return;
        }

        public function set currentProgress(arg1:Number):void
        {
            if (_cyclesComplete != 0) 
            {
                setTotalTime(this.duration * arg1 + _cyclesComplete * this.cachedDuration, false);
            }
            else 
            {
                setTotalTime(this.duration * arg1, false);
            }
            return;
        }

        public static function to(arg1:Object, arg2:Number, arg3:Object):com.greensock.TweenMax
        {
            return new TweenMax(arg1, arg2, arg3);
        }

        public function get totalProgress():Number
        {
            return this.cachedTotalTime / this.totalDuration;
        }

        public function set totalProgress(arg1:Number):void
        {
            setTotalTime(this.totalDuration * arg1, false);
            return;
        }

        protected function removePropTween(arg1:com.greensock.core.PropTween):Boolean
        {
            if (arg1.nextNode) 
            {
                arg1.nextNode.prevNode = arg1.prevNode;
            }
            if (arg1.prevNode) 
            {
                arg1.prevNode.nextNode = arg1.nextNode;
            }
            else if (this.cachedPT1 == arg1) 
            {
                this.cachedPT1 = arg1.nextNode;
            }
            if (arg1.isPlugin && arg1.target.onDisable) 
            {
                arg1.target.onDisable();
                if (arg1.target.activeDisable) 
                {
                    return true;
                }
            }
            return false;
        }

        public static function allTo(arg1:Array, arg2:Number, arg3:Object, arg4:Number=0, arg5:Function=null, arg6:Array=null):Array
        {
            var targets:Array;
            var onCompleteAll:Function=null;
            var duration:Number;
            var onCompleteProxy:Function;
            var lastIndex:int;
            var a:Array;
            var curDelay:Number;
            var i:int;
            var vars:Object;
            var stagger:Number=0;
            var onCompleteAllParams:Array=null;
            var p:String;
            var varsDup:Object;
            var onCompleteParamsProxy:Array;
            var l:uint;

            var loc1:*;
            i = 0;
            varsDup = null;
            p = null;
            onCompleteProxy = null;
            onCompleteParamsProxy = null;
            targets = arg1;
            duration = arg2;
            vars = arg3;
            stagger = arg4;
            onCompleteAll = arg5;
            onCompleteAllParams = arg6;
            l = targets.length;
            a = [];
            curDelay = "delay" in vars ? Number(vars.delay) : 0;
            onCompleteProxy = vars.onComplete;
            onCompleteParamsProxy = vars.onCompleteParams;
            lastIndex = stagger <= 0 ? 0 : (l - 1);
            i = 0;
            while (i < l) 
            {
                varsDup = {};
                var loc2:*=0;
                var loc3:*=vars;
                for (p in loc3) 
                {
                    varsDup[p] = vars[p];
                }
                varsDup.delay = curDelay;
                if (i == lastIndex && !(onCompleteAll == null)) 
                {
                    varsDup.onComplete = function ():void
                    {
                        if (onCompleteProxy != null) 
                        {
                            onCompleteProxy.apply(null, onCompleteParamsProxy);
                        }
                        onCompleteAll.apply(null, onCompleteAllParams);
                        return;
                    }
                }
                a[a.length] = new TweenMax(targets[i], duration, varsDup);
                curDelay = curDelay + stagger;
                ++i;
            }
            return a;
        }

        public function get currentProgress():Number
        {
            return this.cachedTime / this.duration;
        }

        public function set repeatDelay(arg1:Number):void
        {
            _repeatDelay = arg1;
            setDirtyCache(true);
            return;
        }

        public function get repeat():int
        {
            return _repeat;
        }

        public function updateTo(arg1:Object, arg2:Boolean=false):void
        {
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=null;
            var loc5:*=NaN;
            var loc1:*=this.ratio;
            if (arg2 && !(this.timeline == null) && this.cachedStartTime < this.timeline.cachedTime) 
            {
                this.cachedStartTime = this.timeline.cachedTime;
                this.setDirtyCache(false);
                if (this.gc) 
                {
                    this.setEnabled(true, false);
                }
                else 
                {
                    this.timeline.addChild(this);
                }
            }
            var loc6:*=0;
            var loc7:*=arg1;
            for (loc2 in loc7) 
            {
                this.vars[loc2] = arg1[loc2];
            }
            if (this.initted) 
            {
                this.initted = false;
                if (!arg2) 
                {
                    init();
                    if (!arg2 && this.cachedTime > 0 && this.cachedTime < this.cachedDuration) 
                    {
                        loc3 = 1 / (1 - loc1);
                        loc4 = this.cachedPT1;
                        while (loc4) 
                        {
                            loc5 = loc4.start + loc4.change;
                            loc4.change = loc4.change * loc3;
                            loc4.start = loc5 - loc4.change;
                            loc4 = loc4.nextNode;
                        }
                    }
                }
            }
            return;
        }

        
        {
            _overwriteMode = com.greensock.OverwriteManager.enabled ? com.greensock.OverwriteManager.mode : com.greensock.OverwriteManager.init(2);
            killTweensOf = com.greensock.TweenLite.killTweensOf;
            killDelayedCallsTo = com.greensock.TweenLite.killTweensOf;
            com.greensock.plugins.TweenPlugin.activate([com.greensock.plugins.AutoAlphaPlugin, com.greensock.plugins.EndArrayPlugin, com.greensock.plugins.FramePlugin, com.greensock.plugins.RemoveTintPlugin, com.greensock.plugins.TintPlugin, com.greensock.plugins.VisiblePlugin, com.greensock.plugins.VolumePlugin, com.greensock.plugins.BevelFilterPlugin, com.greensock.plugins.BezierPlugin, com.greensock.plugins.BezierThroughPlugin, com.greensock.plugins.BlurFilterPlugin, com.greensock.plugins.ColorMatrixFilterPlugin, com.greensock.plugins.ColorTransformPlugin, com.greensock.plugins.DropShadowFilterPlugin, com.greensock.plugins.FrameLabelPlugin, com.greensock.plugins.GlowFilterPlugin, com.greensock.plugins.HexColorsPlugin, com.greensock.plugins.RoundPropsPlugin, com.greensock.plugins.ShortRotationPlugin, {}]);
        }

        public override function set currentTime(arg1:Number):void
        {
            if (_cyclesComplete != 0) 
            {
                if (this.yoyo && _cyclesComplete % 2 == 1) 
                {
                    arg1 = this.duration - arg1 + _cyclesComplete * (this.cachedDuration + _repeatDelay);
                }
                else 
                {
                    arg1 = arg1 + _cyclesComplete * (this.duration + _repeatDelay);
                }
            }
            setTotalTime(arg1, false);
            return;
        }

        public function get repeatDelay():Number
        {
            return _repeatDelay;
        }

        public function killProperties(arg1:Array):void
        {
            var loc1:*={};
            var loc2:*=arg1.length;
            while (--loc2 > -1) 
            {
                loc1[arg1[loc2]] = true;
            }
            killVars(loc1);
            return;
        }

        public override function get totalDuration():Number
        {
            if (this.cacheIsDirty) 
            {
                this.cachedTotalDuration = _repeat != -1 ? this.cachedDuration * (_repeat + 1) + _repeatDelay * _repeat : 999999999999;
                this.cacheIsDirty = false;
            }
            return this.cachedTotalDuration;
        }

        public function set repeat(arg1:int):void
        {
            _repeat = arg1;
            setDirtyCache(true);
            return;
        }

        public override function complete(arg1:Boolean=false, arg2:Boolean=false):void
        {
            super.complete(arg1, arg2);
            if (!arg2 && _dispatcher) 
            {
                if (this.cachedTotalTime == this.cachedTotalDuration && !this.cachedReversed) 
                {
                    _dispatcher.dispatchEvent(new com.greensock.events.TweenEvent(com.greensock.events.TweenEvent.COMPLETE));
                }
                else if (this.cachedReversed && this.cachedTotalTime == 0) 
                {
                    _dispatcher.dispatchEvent(new com.greensock.events.TweenEvent(com.greensock.events.TweenEvent.REVERSE_COMPLETE));
                }
            }
            return;
        }

        public override function invalidate():void
        {
            this.yoyo = Boolean(this.vars.yoyo == true);
            _repeat = this.vars.repeat ? Number(this.vars.repeat) : 0;
            _repeatDelay = this.vars.repeatDelay ? Number(this.vars.repeatDelay) : 0;
            _hasUpdateListener = false;
            if (!(this.vars.onCompleteListener == null) || !(this.vars.onUpdateListener == null) || !(this.vars.onStartListener == null)) 
            {
                initDispatcher();
            }
            setDirtyCache(true);
            super.invalidate();
            return;
        }

        public function get timeScale():Number
        {
            return this.cachedTimeScale;
        }

        public static function set globalTimeScale(arg1:Number):void
        {
            if (arg1 == 0) 
            {
                arg1 = 0.0001;
            }
            if (com.greensock.TweenLite.rootTimeline == null) 
            {
                com.greensock.TweenLite.to({}, 0, {});
            }
            var loc1:*=com.greensock.TweenLite.rootTimeline;
            var loc2:*=flash.utils.getTimer() * 0.001;
            loc1.cachedStartTime = loc2 - (loc2 - loc1.cachedStartTime) * loc1.cachedTimeScale / arg1;
            loc1 = com.greensock.TweenLite.rootFramesTimeline;
            loc2 = com.greensock.TweenLite.rootFrame;
            loc1.cachedStartTime = loc2 - (loc2 - loc1.cachedStartTime) * loc1.cachedTimeScale / arg1;
            var loc3:*;
            com.greensock.TweenLite.rootTimeline.cachedTimeScale = loc3 = arg1;
            com.greensock.TweenLite.rootFramesTimeline.cachedTimeScale = loc3;
            return;
        }

        public static function fromTo(arg1:Object, arg2:Number, arg3:Object, arg4:Object):com.greensock.TweenMax
        {
            arg4.startAt = arg3;
            if (arg3.immediateRender) 
            {
                arg4.immediateRender = true;
            }
            return new TweenMax(arg1, arg2, arg4);
        }

        public static function allFromTo(arg1:Array, arg2:Number, arg3:Object, arg4:Object, arg5:Number=0, arg6:Function=null, arg7:Array=null):Array
        {
            arg4.startAt = arg3;
            if (arg3.immediateRender) 
            {
                arg4.immediateRender = true;
            }
            return allTo(arg1, arg2, arg4, arg5, arg6, arg7);
        }

        public static function pauseAll(arg1:Boolean=true, arg2:Boolean=true):void
        {
            changePause(true, arg1, arg2);
            return;
        }

        public static function getTweensOf(arg1:Object):Array
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc1:*=masterList[arg1];
            var loc2:*=[];
            if (loc1) 
            {
                loc3 = loc1.length;
                loc4 = 0;
                while (--loc3 > -1) 
                {
                    if (loc1[loc3].gc) 
                    {
                        continue;
                    }
                    var loc5:*;
                    loc2[loc5 = loc4++] = loc1[loc3];
                }
            }
            return loc2;
        }

        public static function get globalTimeScale():Number
        {
            return com.greensock.TweenLite.rootTimeline != null ? com.greensock.TweenLite.rootTimeline.cachedTimeScale : 1;
        }

        public static function killChildTweensOf(arg1:flash.display.DisplayObjectContainer, arg2:Boolean=false):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=getAllTweens();
            var loc4:*=loc1.length;
            while (--loc4 > -1) 
            {
                loc2 = loc1[loc4].target;
                if (!(loc2 is flash.display.DisplayObject)) 
                {
                    continue;
                }
                loc3 = loc2.parent;
                while (loc3) 
                {
                    if (loc3 == arg1) 
                    {
                        if (arg2) 
                        {
                            loc1[loc4].complete(false);
                        }
                        else 
                        {
                            loc1[loc4].setEnabled(false, false);
                        }
                    }
                    loc3 = loc3.parent;
                }
            }
            return;
        }

        public static function delayedCall(arg1:Number, arg2:Function, arg3:Array=null, arg4:Boolean=false):com.greensock.TweenMax
        {
            return new TweenMax(arg2, 0, {"delay":arg1, "onComplete":arg2, "onCompleteParams":arg3, "immediateRender":false, "useFrames":arg4, "overwrite":0});
        }

        public static function isTweening(arg1:Object):Boolean
        {
            var loc3:*=null;
            var loc1:*=getTweensOf(arg1);
            var loc2:*=loc1.length;
            while (--loc2 > -1) 
            {
                loc3 = loc1[loc2];
                if (!(loc3.active || loc3.cachedStartTime == loc3.timeline.cachedTime && loc3.timeline.active)) 
                {
                    continue;
                }
                return true;
            }
            return false;
        }

        public static function killAll(arg1:Boolean=false, arg2:Boolean=true, arg3:Boolean=true):void
        {
            var loc2:*=false;
            var loc1:*=getAllTweens();
            var loc3:*=loc1.length;
            while (--loc3 > -1) 
            {
                loc2 = loc1[loc3].target == loc1[loc3].vars.onComplete;
                if (!(loc2 == arg3 || !(loc2 == arg2))) 
                {
                    continue;
                }
                if (arg1) 
                {
                    loc1[loc3].complete(false);
                    continue;
                }
                loc1[loc3].setEnabled(false, false);
            }
            return;
        }

        internal static function changePause(arg1:Boolean, arg2:Boolean=true, arg3:Boolean=false):void
        {
            var loc2:*=false;
            var loc1:*=getAllTweens();
            var loc3:*=loc1.length;
            while (--loc3 > -1) 
            {
                loc2 = com.greensock.TweenLite(loc1[loc3]).target == com.greensock.TweenLite(loc1[loc3]).vars.onComplete;
                if (!(loc2 == arg3 || !(loc2 == arg2))) 
                {
                    continue;
                }
                com.greensock.core.TweenCore(loc1[loc3]).paused = arg1;
            }
            return;
        }

        public static function from(arg1:Object, arg2:Number, arg3:Object):com.greensock.TweenMax
        {
            arg3.runBackwards = true;
            if (!("immediateRender" in arg3)) 
            {
                arg3.immediateRender = true;
            }
            return new TweenMax(arg1, arg2, arg3);
        }

        public static function allFrom(arg1:Array, arg2:Number, arg3:Object, arg4:Number=0, arg5:Function=null, arg6:Array=null):Array
        {
            arg3.runBackwards = true;
            if (!("immediateRender" in arg3)) 
            {
                arg3.immediateRender = true;
            }
            return allTo(arg1, arg2, arg3, arg4, arg5, arg6);
        }

        public static const version:Number=11.37;

        protected var _cyclesComplete:uint=0;

        protected var _dispatcher:flash.events.EventDispatcher;

        protected var _hasUpdateListener:Boolean;

        protected var _easeType:uint;

        public var yoyo:Boolean;

        internal static var _overwriteMode:int;

        public static var killDelayedCallsTo:Function;

        protected var _repeat:int=0;

        protected var _repeatDelay:Number=0;

        public static var killTweensOf:Function;

        protected var _easePower:uint;
    }
}


//  class TweenNano
package com.greensock 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    
    public class TweenNano extends Object
    {
        public function TweenNano(arg1:Object, arg2:Number, arg3:Object)
        {
            super();
            if (!_tnInitted) 
            {
                _time = flash.utils.getTimer() * 0.001;
                _frame = 0;
                _shape.addEventListener(flash.events.Event.ENTER_FRAME, updateAll, false, 0, true);
                _tnInitted = true;
            }
            this.vars = arg3;
            this.duration = arg2;
            this.active = Boolean(arg2 == 0 && this.vars.delay == 0 && !(this.vars.immediateRender == false));
            this.target = arg1;
            if (typeof this.vars.ease == "function") 
            {
                _ease = this.vars.ease;
            }
            else 
            {
                _ease = TweenNano.easeOut;
            }
            _propTweens = [];
            this.useFrames = Boolean(arg3.useFrames == true);
            var loc1:*="delay" in this.vars ? Number(this.vars.delay) : 0;
            this.startTime = this.useFrames ? _frame + loc1 : _time + loc1;
            var loc2:*=_masterList[arg1];
            if (loc2 == null || int(this.vars.overwrite) == 1 || this.vars.overwrite == null) 
            {
                _masterList[arg1] = [this];
            }
            else 
            {
                loc2[loc2.length] = this;
            }
            if (this.vars.immediateRender == true || this.active) 
            {
                renderTime(0);
            }
            return;
        }

        public function renderTime(arg1:Number):void
        {
            var loc1:*=null;
            if (!_initted) 
            {
                init();
            }
            var loc2:*=_propTweens.length;
            if (arg1 >= this.duration) 
            {
                arg1 = this.duration;
                this.ratio = 1;
            }
            else if (arg1 <= 0) 
            {
                this.ratio = 0;
            }
            else 
            {
                this.ratio = _ease(arg1, 0, 1, this.duration);
            }
            while (--loc2 > -1) 
            {
                loc1 = _propTweens[loc2];
                this.target[loc1[0]] = loc1[1] + this.ratio * loc1[2];
            }
            if (this.vars.onUpdate) 
            {
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            }
            if (arg1 == this.duration) 
            {
                complete(true);
            }
            return;
        }

        public function init():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=this.vars;
            for (loc1 in loc5) 
            {
                if (loc1 in _reservedProps) 
                {
                    continue;
                }
                _propTweens[_propTweens.length] = [loc1, this.target[loc1], typeof this.vars[loc1] != "number" ? Number(this.vars[loc1]) : this.vars[loc1] - this.target[loc1]];
            }
            if (this.vars.runBackwards) 
            {
                loc3 = _propTweens.length;
                while (--loc3 > -1) 
                {
                    loc2 = _propTweens[loc3];
                    loc2[1] = loc2[1] + loc2[2];
                    loc2[2] = -loc2[2];
                }
            }
            _initted = true;
            return;
        }

        public function kill():void
        {
            this.gc = true;
            this.active = false;
            return;
        }

        public function complete(arg1:Boolean=false):void
        {
            if (!arg1) 
            {
                renderTime(this.duration);
                return;
            }
            kill();
            if (this.vars.onComplete) 
            {
                this.vars.onComplete.apply(null, this.vars.onCompleteParams);
            }
            return;
        }

        public static function delayedCall(arg1:Number, arg2:Function, arg3:Array=null, arg4:Boolean=false):com.greensock.TweenNano
        {
            return new TweenNano(arg2, 0, {"delay":arg1, "onComplete":arg2, "onCompleteParams":arg3, "useFrames":arg4, "overwrite":0});
        }

        public static function updateAll(arg1:flash.events.Event=null):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=NaN;
            var loc6:*=null;
            var loc7:*;
            _frame++;
            _time = flash.utils.getTimer() * 0.001;
            var loc1:*=_masterList;
            loc7 = 0;
            loc8 = loc1;
            for (loc3 in loc8) 
            {
                loc2 = loc1[loc3];
                loc4 = loc2.length;
                while (--loc4 > -1) 
                {
                    loc6 = loc2[loc4];
                    loc5 = loc6.useFrames ? _frame : _time;
                    if (loc6.active || !loc6.gc && loc5 >= loc6.startTime) 
                    {
                        loc6.renderTime(loc5 - loc6.startTime);
                        continue;
                    }
                    if (!loc6.gc) 
                    {
                        continue;
                    }
                    loc2.splice(loc4, 1);
                }
                if (loc2.length != 0) 
                {
                    continue;
                }
                delete loc1[loc3];
            }
            return;
        }

        internal static function easeOut(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc1:*;
            arg1 = loc1 = arg1 / arg4;
            return -1 * loc1 * (arg1 - 2);
        }

        public static function from(arg1:Object, arg2:Number, arg3:Object):com.greensock.TweenNano
        {
            arg3.runBackwards = true;
            if (!("immediateRender" in arg3)) 
            {
                arg3.immediateRender = true;
            }
            return new TweenNano(arg1, arg2, arg3);
        }

        public static function to(arg1:Object, arg2:Number, arg3:Object):com.greensock.TweenNano
        {
            return new TweenNano(arg1, arg2, arg3);
        }

        public static function killTweensOf(arg1:Object, arg2:Boolean=false):void
        {
            var loc1:*=null;
            var loc2:*=0;
            if (arg1 in _masterList) 
            {
                if (arg2) 
                {
                    loc1 = _masterList[arg1];
                    loc2 = loc1.length;
                    while (--loc2 > -1) 
                    {
                        if (TweenNano(loc1[loc2]).gc) 
                        {
                            continue;
                        }
                        TweenNano(loc1[loc2]).complete(false);
                    }
                }
                delete _masterList[arg1];
            }
            return;
        }

        
        {
            _masterList = new flash.utils.Dictionary(false);
            _shape = new flash.display.Shape();
            _reservedProps = {"ease":1, "delay":1, "useFrames":1, "overwrite":1, "onComplete":1, "onCompleteParams":1, "runBackwards":1, "immediateRender":1, "onUpdate":1, "onUpdateParams":1};
        }

        protected var _initted:Boolean;

        public var active:Boolean;

        protected var _propTweens:Array;

        public var ratio:Number=0;

        protected var _ease:Function;

        public var startTime:Number;

        public var target:Object;

        public var useFrames:Boolean;

        public var duration:Number;

        public var gc:Boolean;

        public var vars:Object;

        protected static var _reservedProps:Object;

        protected static var _tnInitted:Boolean;

        protected static var _time:Number;

        protected static var _frame:uint;

        protected static var _shape:flash.display.Shape;

        protected static var _masterList:flash.utils.Dictionary;
    }
}


