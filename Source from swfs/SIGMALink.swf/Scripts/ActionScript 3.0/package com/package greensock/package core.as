//package core
//  class PropTween
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


//  class SimpleTimeline
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


//  class TweenCore
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


