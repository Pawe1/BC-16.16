//class Slide
package feathers.motion 
{
    import starling.display.*;
    
    public class Slide extends Object
    {
        public function Slide()
        {
            super();
            return;
        }

        public static function createSlideLeftTransition(arg1:Number=0.5, arg2:Object="easeOut", arg3:Object=null):Function
        {
            var duration:Number=0.5;
            var ease:Object="easeOut";
            var tweenProperties:Object=null;

            var loc1:*;
            duration = arg1;
            ease = arg2;
            tweenProperties = arg3;
            return function (arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject, arg3:Function):void
            {
                if (!arg1 && !arg2) 
                {
                    throw new ArgumentError(SCREEN_REQUIRED_ERROR);
                }
                if (arg2) 
                {
                    if (arg1) 
                    {
                        arg1.x = 0;
                        arg1.y = 0;
                    }
                    arg2.x = arg2.width;
                    arg2.y = 0;
                    new SlideTween(arg2, arg1, -arg2.width, 0, duration, ease, arg3, tweenProperties);
                }
                else 
                {
                    arg1.x = 0;
                    arg1.y = 0;
                    new SlideTween(arg1, null, -arg1.width, 0, duration, ease, arg3, tweenProperties);
                }
                return;
            }
        }

        public static function createSlideRightTransition(arg1:Number=0.5, arg2:Object="easeOut", arg3:Object=null):Function
        {
            var duration:Number=0.5;
            var ease:Object="easeOut";
            var tweenProperties:Object=null;

            var loc1:*;
            duration = arg1;
            ease = arg2;
            tweenProperties = arg3;
            return function (arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject, arg3:Function):void
            {
                if (!arg1 && !arg2) 
                {
                    throw new ArgumentError(SCREEN_REQUIRED_ERROR);
                }
                if (arg2) 
                {
                    if (arg1) 
                    {
                        arg1.x = 0;
                        arg1.y = 0;
                    }
                    arg2.x = -arg2.width;
                    arg2.y = 0;
                    new SlideTween(arg2, arg1, arg2.width, 0, duration, ease, arg3, tweenProperties);
                }
                else 
                {
                    arg1.x = 0;
                    arg1.y = 0;
                    new SlideTween(arg1, null, arg1.width, 0, duration, ease, arg3, tweenProperties);
                }
                return;
            }
        }

        public static function createSlideUpTransition(arg1:Number=0.5, arg2:Object="easeOut", arg3:Object=null):Function
        {
            var duration:Number=0.5;
            var ease:Object="easeOut";
            var tweenProperties:Object=null;

            var loc1:*;
            duration = arg1;
            ease = arg2;
            tweenProperties = arg3;
            return function (arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject, arg3:Function):void
            {
                if (!arg1 && !arg2) 
                {
                    throw new ArgumentError(SCREEN_REQUIRED_ERROR);
                }
                if (arg2) 
                {
                    if (arg1) 
                    {
                        arg1.x = 0;
                        arg1.y = 0;
                    }
                    arg2.x = 0;
                    arg2.y = arg2.height;
                    new SlideTween(arg2, arg1, 0, -arg2.height, duration, ease, arg3, tweenProperties);
                }
                else 
                {
                    arg1.x = 0;
                    arg1.y = 0;
                    new SlideTween(arg1, null, 0, -arg1.height, duration, ease, arg3, tweenProperties);
                }
                return;
            }
        }

        public static function createSlideDownTransition(arg1:Number=0.5, arg2:Object="easeOut", arg3:Object=null):Function
        {
            var duration:Number=0.5;
            var ease:Object="easeOut";
            var tweenProperties:Object=null;

            var loc1:*;
            duration = arg1;
            ease = arg2;
            tweenProperties = arg3;
            return function (arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject, arg3:Function):void
            {
                if (!arg1 && !arg2) 
                {
                    throw new ArgumentError(SCREEN_REQUIRED_ERROR);
                }
                if (arg2) 
                {
                    if (arg1) 
                    {
                        arg1.x = 0;
                        arg1.y = 0;
                    }
                    arg2.x = 0;
                    arg2.y = -arg2.height;
                    new SlideTween(arg2, arg1, 0, arg2.height, duration, ease, arg3, tweenProperties);
                }
                else 
                {
                    arg1.x = 0;
                    arg1.y = 0;
                    new SlideTween(arg1, null, 0, arg1.height, duration, ease, arg3, tweenProperties);
                }
                return;
            }
        }

        protected static const SCREEN_REQUIRED_ERROR:String="Cannot transition if both old screen and new screen are null.";
    }
}

import starling.animation.*;
import starling.core.*;
import starling.display.*;


class SlideTween extends starling.animation.Tween
{
    public function SlideTween(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject, arg3:Number, arg4:Number, arg5:Number, arg6:Object, arg7:Function, arg8:Object)
    {
        var loc1:*=null;
        super(arg1, arg5, arg6);
        if (arg3 != 0) 
        {
            this._xOffset = arg3;
            this.animate("x", arg1.x + arg3);
        }
        if (arg4 != 0) 
        {
            this._yOffset = arg4;
            this.animate("y", arg1.y + arg4);
        }
        if (arg8) 
        {
            var loc2:*=0;
            var loc3:*=arg8;
            for (loc1 in loc3) 
            {
                this[loc1] = arg8[loc1];
            }
        }
        this._navigator = arg1.parent;
        if (arg2) 
        {
            this._otherTarget = arg2;
            this.onUpdate = this.updateOtherTarget;
        }
        this._onCompleteCallback = arg7;
        this.onComplete = this.cleanupTween;
        starling.core.Starling.juggler.add(this);
        return;
    }

    internal function updateOtherTarget():void
    {
        var loc1:*=starling.display.DisplayObject(this.target);
        if (this._xOffset < 0) 
        {
            this._otherTarget.x = loc1.x - this._navigator.width;
        }
        else if (this._xOffset > 0) 
        {
            this._otherTarget.x = loc1.x + loc1.width;
        }
        if (this._yOffset < 0) 
        {
            this._otherTarget.y = loc1.y - this._navigator.height;
        }
        else if (this._yOffset > 0) 
        {
            this._otherTarget.y = loc1.y + loc1.height;
        }
        return;
    }

    internal function cleanupTween():void
    {
        this.target.x = 0;
        this.target.y = 0;
        if (this._otherTarget) 
        {
            this._otherTarget.x = 0;
            this._otherTarget.y = 0;
        }
        if (this._onCompleteCallback !== null) 
        {
            this._onCompleteCallback();
        }
        return;
    }

    internal var _navigator:starling.display.DisplayObject;

    internal var _otherTarget:starling.display.DisplayObject;

    internal var _onCompleteCallback:Function;

    internal var _xOffset:Number=0;

    internal var _yOffset:Number=0;
}

