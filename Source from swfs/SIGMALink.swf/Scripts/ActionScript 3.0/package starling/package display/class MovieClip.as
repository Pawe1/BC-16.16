//class MovieClip
package starling.display 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    import flash.media.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.textures.*;
    
    public class MovieClip extends starling.display.Image implements starling.animation.IAnimatable
    {
        public function MovieClip(arg1:__AS3__.vec.Vector.<starling.textures.Texture>, arg2:Number=12)
        {
            if (arg1.length > 0) 
            {
                super(arg1[0]);
                this.init(arg1, arg2);
            }
            else 
            {
                throw new ArgumentError("Empty texture array");
            }
            return;
        }

        public function set muted(arg1:Boolean):void
        {
            this._muted = arg1;
            return;
        }

        public function get soundTransform():flash.media.SoundTransform
        {
            return this._soundTransform;
        }

        public function set soundTransform(arg1:flash.media.SoundTransform):void
        {
            this._soundTransform = arg1;
            return;
        }

        public function get currentFrame():int
        {
            return this._currentFrameID;
        }

        internal function init(arg1:__AS3__.vec.Vector.<starling.textures.Texture>, arg2:Number):void
        {
            if (arg2 <= 0) 
            {
                throw new ArgumentError("Invalid fps: " + arg2);
            }
            var loc1:*=arg1.length;
            this._defaultFrameDuration = 1 / arg2;
            this._loop = true;
            this._playing = true;
            this._currentTime = 0;
            this._currentFrameID = 0;
            this._wasStopped = true;
            this._frames = new Vector.<MovieClipFrame>(0);
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                this._frames[loc2] = new MovieClipFrame(arg1[loc2], this._defaultFrameDuration, this._defaultFrameDuration * loc2);
                ++loc2;
            }
            return;
        }

        public function set currentFrame(arg1:int):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this.currentTime = this._frames[arg1].startTime;
            return;
        }

        public function get fps():Number
        {
            return 1 / this._defaultFrameDuration;
        }

        public function set fps(arg1:Number):void
        {
            if (arg1 <= 0) 
            {
                throw new ArgumentError("Invalid fps: " + arg1);
            }
            var loc1:*=1 / arg1;
            var loc2:*=loc1 / this._defaultFrameDuration;
            this._currentTime = this._currentTime * loc2;
            this._defaultFrameDuration = loc1;
            var loc3:*=0;
            while (loc3 < this.numFrames) 
            {
                this._frames[loc3].duration = this._frames[loc3].duration * loc2;
                ++loc3;
            }
            this.updateStartTimes();
            return;
        }

        public function get isPlaying():Boolean
        {
            if (this._playing) 
            {
                return this._loop || this._currentTime < this.totalTime;
            }
            return false;
        }

        public function get isComplete():Boolean
        {
            return !this._loop && this._currentTime >= this.totalTime;
        }

        public function addFrame(arg1:starling.textures.Texture, arg2:flash.media.Sound=null, arg3:Number=-1):void
        {
            this.addFrameAt(this.numFrames, arg1, arg2, arg3);
            return;
        }

        public function addFrameAt(arg1:int, arg2:starling.textures.Texture, arg3:flash.media.Sound=null, arg4:Number=-1):void
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (arg1 < 0 || arg1 > this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            if (arg4 < 0) 
            {
                arg4 = this._defaultFrameDuration;
            }
            var loc1:*=new MovieClipFrame(arg2, arg4);
            loc1.sound = arg3;
            this._frames.insertAt(arg1, loc1);
            if (arg1 != this.numFrames) 
            {
                this.updateStartTimes();
            }
            else 
            {
                loc2 = arg1 > 0 ? this._frames[(arg1 - 1)].startTime : 0;
                loc3 = arg1 > 0 ? this._frames[(arg1 - 1)].duration : 0;
                loc1.startTime = loc2 + loc3;
            }
            return;
        }

        public function removeFrameAt(arg1:int):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            if (this.numFrames == 1) 
            {
                throw new flash.errors.IllegalOperationError("Movie clip must not be empty");
            }
            this._frames.removeAt(arg1);
            if (arg1 != this.numFrames) 
            {
                this.updateStartTimes();
            }
            return;
        }

        public function getFrameTexture(arg1:int):starling.textures.Texture
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            return this._frames[arg1].texture;
        }

        public function setFrameTexture(arg1:int, arg2:starling.textures.Texture):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this._frames[arg1].texture = arg2;
            return;
        }

        public function getFrameSound(arg1:int):flash.media.Sound
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            return this._frames[arg1].sound;
        }

        public function setFrameSound(arg1:int, arg2:flash.media.Sound):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this._frames[arg1].sound = arg2;
            return;
        }

        public function getFrameAction(arg1:int):Function
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            return this._frames[arg1].action;
        }

        public function setFrameAction(arg1:int, arg2:Function):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this._frames[arg1].action = arg2;
            return;
        }

        public function getFrameDuration(arg1:int):Number
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            return this._frames[arg1].duration;
        }

        public function setFrameDuration(arg1:int, arg2:Number):void
        {
            if (arg1 < 0 || arg1 >= this.numFrames) 
            {
                throw new ArgumentError("Invalid frame id");
            }
            this._frames[arg1].duration = arg2;
            this.updateStartTimes();
            return;
        }

        public function reverseFrames():void
        {
            this._frames.reverse();
            this._currentTime = this.totalTime - this._currentTime;
            this._currentFrameID = (this.numFrames - this._currentFrameID - 1);
            this.updateStartTimes();
            return;
        }

        public function play():void
        {
            this._playing = true;
            return;
        }

        public function pause():void
        {
            this._playing = false;
            return;
        }

        public function stop():void
        {
            this._playing = false;
            this._wasStopped = true;
            this.currentFrame = 0;
            return;
        }

        internal function updateStartTimes():void
        {
            var loc1:*=this.numFrames;
            var loc2:*=this._frames[0];
            loc2.startTime = 0;
            var loc3:*=1;
            while (loc3 < loc1) 
            {
                this._frames[loc3].startTime = loc2.startTime + loc2.duration;
                loc2 = this._frames[loc3];
                ++loc3;
            }
            return;
        }

        public function advanceTime(arg1:Number):void
        {
            var loc7:*=false;
            if (!this._playing) 
            {
                return;
            }
            var loc1:*=this._frames[this._currentFrameID];
            if (this._wasStopped) 
            {
                this._wasStopped = false;
                loc1.playSound(this._soundTransform);
                if (loc1.action != null) 
                {
                    loc1.executeAction(this, this._currentFrameID);
                    this.advanceTime(arg1);
                    return;
                }
            }
            if (this._currentTime == this.totalTime) 
            {
                if (this._loop) 
                {
                    this._currentTime = 0;
                    this._currentFrameID = 0;
                    loc1 = this._frames[0];
                    loc1.playSound(this._soundTransform);
                    texture = loc1.texture;
                    if (loc1.action != null) 
                    {
                        loc1.executeAction(this, this._currentFrameID);
                        this.advanceTime(arg1);
                        return;
                    }
                }
                else 
                {
                    return;
                }
            }
            var loc2:*=(this._frames.length - 1);
            var loc3:*=loc1.duration - this._currentTime + loc1.startTime;
            var loc4:*=false;
            var loc5:*=null;
            var loc6:*=this._currentFrameID;
            while (arg1 >= loc3) 
            {
                loc7 = false;
                arg1 = arg1 - loc3;
                this._currentTime = loc1.startTime + loc1.duration;
                if (this._currentFrameID != loc2) 
                {
                    this._currentFrameID = this._currentFrameID + 1;
                    loc7 = true;
                }
                else if (hasEventListener(starling.events.Event.COMPLETE)) 
                {
                    loc4 = true;
                }
                else if (this._loop) 
                {
                    this._currentTime = 0;
                    this._currentFrameID = 0;
                    loc7 = true;
                }
                else 
                {
                    return;
                }
                loc1 = this._frames[this._currentFrameID];
                loc5 = loc1.action;
                if (loc7) 
                {
                    loc1.playSound(this._soundTransform);
                }
                if (loc4) 
                {
                    texture = loc1.texture;
                    dispatchEventWith(starling.events.Event.COMPLETE);
                    this.advanceTime(arg1);
                    return;
                }
                if (loc5 != null) 
                {
                    texture = loc1.texture;
                    loc1.executeAction(this, this._currentFrameID);
                    this.advanceTime(arg1);
                    return;
                }
                loc3 = loc1.duration;
                if (!(arg1 + 0.0001 > loc3 && arg1 - 0.0001 < loc3)) 
                {
                    continue;
                }
                arg1 = loc3;
            }
            if (loc6 != this._currentFrameID) 
            {
                texture = this._frames[this._currentFrameID].texture;
            }
            this._currentTime = this._currentTime + arg1;
            return;
        }

        public function get numFrames():int
        {
            return this._frames.length;
        }

        public function get totalTime():Number
        {
            var loc1:*=this._frames[(this._frames.length - 1)];
            return loc1.startTime + loc1.duration;
        }

        public function get currentTime():Number
        {
            return this._currentTime;
        }

        public function set currentTime(arg1:Number):void
        {
            if (arg1 < 0 || arg1 > this.totalTime) 
            {
                throw new ArgumentError("Invalid time: " + arg1);
            }
            var loc1:*=(this._frames.length - 1);
            this._currentTime = arg1;
            this._currentFrameID = 0;
            while (this._currentFrameID < loc1 && this._frames[this._currentFrameID + 1].startTime <= arg1) 
            {
                var loc3:*;
                var loc4:*=((loc3 = this)._currentFrameID + 1);
                loc3._currentFrameID = loc4;
            }
            var loc2:*=this._frames[this._currentFrameID];
            texture = loc2.texture;
            return;
        }

        public function get loop():Boolean
        {
            return this._loop;
        }

        public function set loop(arg1:Boolean):void
        {
            this._loop = arg1;
            return;
        }

        public function get muted():Boolean
        {
            return this._muted;
        }

        internal var _frames:__AS3__.vec.Vector.<MovieClipFrame>;

        internal var _defaultFrameDuration:Number;

        internal var _currentTime:Number;

        internal var _currentFrameID:int;

        internal var _playing:Boolean;

        internal var _muted:Boolean;

        internal var _wasStopped:Boolean;

        internal var _soundTransform:flash.media.SoundTransform;

        internal var _loop:Boolean;
    }
}

import flash.media.*;
import starling.textures.*;


class MovieClipFrame extends Object
{
    public function MovieClipFrame(arg1:starling.textures.Texture, arg2:Number=0.1, arg3:Number=0)
    {
        super();
        this.texture = arg1;
        this.duration = arg2;
        this.startTime = arg3;
        return;
    }

    public function playSound(arg1:flash.media.SoundTransform):void
    {
        if (this.sound) 
        {
            this.sound.play(0, 0, arg1);
        }
        return;
    }

    public function executeAction(arg1:starling.display.MovieClip, arg2:int):void
    {
        var loc1:*=0;
        if (this.action != null) 
        {
            loc1 = this.action.length;
            if (loc1 != 0) 
            {
                if (loc1 != 1) 
                {
                    if (loc1 != 2) 
                    {
                        throw new Error("Frame actions support zero, one or two parameters: " + "movie:MovieClip, frameID:int");
                    }
                    else 
                    {
                        this.action(arg1, arg2);
                    }
                }
                else 
                {
                    this.action(arg1);
                }
            }
            else 
            {
                this.action();
            }
        }
        return;
    }

    public var texture:starling.textures.Texture;

    public var sound:flash.media.Sound;

    public var duration:Number;

    public var startTime:Number;

    public var action:Function;
}

