//class TweenMax
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


