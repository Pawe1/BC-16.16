//class SimpleTimeline
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


