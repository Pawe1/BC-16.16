//package utils
//  package display
//    class ScreenDensityScaleCalculator
package feathers.utils.display 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    
    public class ScreenDensityScaleCalculator extends Object
    {
        public function ScreenDensityScaleCalculator()
        {
            this._buckets = new Vector.<ScreenDensityBucket>(0);
            super();
            return;
        }

        public function addScaleForDensity(arg1:int, arg2:Number):void
        {
            var loc3:*=null;
            var loc1:*=this._buckets.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._buckets[loc2];
                if (loc3.density > arg1) 
                {
                    break;
                }
                if (loc3.density === arg1) 
                {
                    throw new ArgumentError("Screen density cannot be added more than once: " + arg1);
                }
                ++loc2;
            }
            this._buckets.insertAt(loc2, new ScreenDensityBucket(arg1, arg2));
            return;
        }

        public function removeScaleForDensity(arg1:int):void
        {
            var loc3:*=null;
            var loc1:*=this._buckets.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._buckets[loc2];
                if (loc3.density === arg1) 
                {
                    this._buckets.removeAt(loc2);
                    return;
                }
                ++loc2;
            }
            return;
        }

        public function getScale(arg1:int):Number
        {
            var loc5:*=NaN;
            if (this._buckets.length === 0) 
            {
                throw new flash.errors.IllegalOperationError("Cannot choose scale because none have been added");
            }
            var loc1:*=this._buckets[0];
            if (arg1 <= loc1.density) 
            {
                return loc1.scale;
            }
            var loc2:*=loc1;
            var loc3:*=this._buckets.length;
            var loc4:*=1;
            while (loc4 < loc3) 
            {
                loc1 = this._buckets[loc4];
                if (arg1 > loc1.density) 
                {
                    loc2 = loc1;
                }
                else 
                {
                    loc5 = (loc1.density + loc2.density) / 2;
                    if (arg1 < loc5) 
                    {
                        return loc2.scale;
                    }
                    return loc1.scale;
                }
                ++loc4;
            }
            return loc1.scale;
        }

        protected var _buckets:__AS3__.vec.Vector.<ScreenDensityBucket>;
    }
}


class ScreenDensityBucket extends Object
{
    public function ScreenDensityBucket(arg1:Number, arg2:Number)
    {
        super();
        this.density = arg1;
        this.scale = arg2;
        return;
    }

    public var density:Number;

    public var scale:Number;
}

//    function getDisplayObjectDepthFromStage
package feathers.utils.display 
{
    import starling.display.*;
    
    public function getDisplayObjectDepthFromStage(arg1:starling.display.DisplayObject):int
    {
        if (!arg1.stage) 
        {
            return -1;
        }
        var loc1:*=0;
        while (arg1.parent) 
        {
            arg1 = arg1.parent;
            ++loc1;
        }
        return loc1;
    }
}


//    function stageToStarling
package feathers.utils.display 
{
    import starling.core.*;
    import starling.display.*;
    
    public function stageToStarling(arg1:starling.display.Stage):starling.core.Starling
    {
        var loc1:*=null;
        var loc2:*=0;
        var loc3:*=starling.core.Starling.all;
        for each (loc1 in loc3) 
        {
            if (loc1.stage !== arg1) 
            {
                continue;
            }
            return loc1;
        }
        return null;
    }
}


//  package geom
//    function matrixToRotation
package feathers.utils.geom 
{
    import flash.geom.*;
    
    public function matrixToRotation(arg1:flash.geom.Matrix):Number
    {
        var loc1:*=arg1.c;
        var loc2:*=arg1.d;
        return -Math.atan(loc1 / loc2);
    }
}


//    function matrixToScaleX
package feathers.utils.geom 
{
    import flash.geom.*;
    
    public function matrixToScaleX(arg1:flash.geom.Matrix):Number
    {
        var loc1:*=arg1.a;
        var loc2:*=arg1.b;
        return Math.sqrt(loc1 * loc1 + loc2 * loc2);
    }
}


//    function matrixToScaleY
package feathers.utils.geom 
{
    import flash.geom.*;
    
    public function matrixToScaleY(arg1:flash.geom.Matrix):Number
    {
        var loc1:*=arg1.c;
        var loc2:*=arg1.d;
        return Math.sqrt(loc1 * loc1 + loc2 * loc2);
    }
}


//  package keyboard
//    class KeyToSelect
package feathers.utils.keyboard 
{
    import feathers.core.*;
    import feathers.events.*;
    import starling.display.*;
    import starling.events.*;
    
    public class KeyToSelect extends Object
    {
        public function KeyToSelect(arg1:feathers.core.IToggle=null)
        {
            super();
            this.target = arg1;
            return;
        }

        public function get target():feathers.core.IToggle
        {
            return this._target;
        }

        public function set target(arg1:feathers.core.IToggle):void
        {
            if (this._target === arg1) 
            {
                return;
            }
            if (!(arg1 is feathers.core.IFocusDisplayObject)) 
            {
                throw new ArgumentError("Target of KeyToSelect must implement IFocusDisplayObject");
            }
            if (this._target) 
            {
                this._target.removeEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.target_focusInHandler);
                this._target.removeEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.target_focusOutHandler);
                this._target.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.target_removedFromStageHandler);
            }
            this._target = arg1;
            if (this._target) 
            {
                this._target.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.target_focusInHandler);
                this._target.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.target_focusOutHandler);
                this._target.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.target_removedFromStageHandler);
            }
            return;
        }

        public function get keyCode():uint
        {
            return this._keyCode;
        }

        public function set keyCode(arg1:uint):void
        {
            this._keyCode = arg1;
            return;
        }

        public function get cancelKeyCode():uint
        {
            return this._cancelKeyCode;
        }

        public function set cancelKeyCode(arg1:uint):void
        {
            this._cancelKeyCode = arg1;
            return;
        }

        public function get keyToDeselect():Boolean
        {
            return this._keyToDeselect;
        }

        public function set keyToDeselect(arg1:Boolean):void
        {
            this._keyToDeselect = arg1;
            return;
        }

        public function get isEnabled():Boolean
        {
            return this._isEnabled;
        }

        public function set isEnabled(arg1:Boolean):void
        {
            this._isEnabled = arg1;
            return;
        }

        protected function target_focusInHandler(arg1:starling.events.Event):void
        {
            this._target.stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            return;
        }

        protected function target_focusOutHandler(arg1:starling.events.Event):void
        {
            this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            return;
        }

        protected function target_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            return;
        }

        protected function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (!this._isEnabled) 
            {
                return;
            }
            if (arg1.keyCode !== this._cancelKeyCode) 
            {
                if (arg1.keyCode === this._keyCode) 
                {
                    this._target.stage.addEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
                }
            }
            else 
            {
                this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            }
            return;
        }

        protected function stage_keyUpHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (!this._isEnabled) 
            {
                return;
            }
            if (arg1.keyCode !== this._keyCode) 
            {
                return;
            }
            var loc1:*=starling.display.Stage(arg1.currentTarget);
            loc1.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            if (this._target.stage !== loc1) 
            {
                return;
            }
            if (this._keyToDeselect) 
            {
                this._target.isSelected = !this._target.isSelected;
            }
            else 
            {
                this._target.isSelected = true;
            }
            return;
        }

        protected var _target:feathers.core.IToggle;

        protected var _keyCode:uint=32;

        protected var _cancelKeyCode:uint=27;

        protected var _keyToDeselect:Boolean=false;

        protected var _isEnabled:Boolean=true;
    }
}


//    class KeyToTrigger
package feathers.utils.keyboard 
{
    import feathers.core.*;
    import feathers.events.*;
    import starling.display.*;
    import starling.events.*;
    
    public class KeyToTrigger extends Object
    {
        public function KeyToTrigger(arg1:feathers.core.IFocusDisplayObject=null)
        {
            super();
            this.target = arg1;
            return;
        }

        public function get target():feathers.core.IFocusDisplayObject
        {
            return this._target;
        }

        public function set target(arg1:feathers.core.IFocusDisplayObject):void
        {
            if (this._target === arg1) 
            {
                return;
            }
            if (this._target) 
            {
                this._target.removeEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.target_focusInHandler);
                this._target.removeEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.target_focusOutHandler);
                this._target.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.target_removedFromStageHandler);
            }
            this._target = arg1;
            if (this._target) 
            {
                this._target.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.target_focusInHandler);
                this._target.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.target_focusOutHandler);
                this._target.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.target_removedFromStageHandler);
            }
            return;
        }

        public function get keyCode():uint
        {
            return this._keyCode;
        }

        public function set keyCode(arg1:uint):void
        {
            this._keyCode = arg1;
            return;
        }

        public function get cancelKeyCode():uint
        {
            return this._cancelKeyCode;
        }

        public function set cancelKeyCode(arg1:uint):void
        {
            this._cancelKeyCode = arg1;
            return;
        }

        public function get isEnabled():Boolean
        {
            return this._isEnabled;
        }

        public function set isEnabled(arg1:Boolean):void
        {
            this._isEnabled = arg1;
            return;
        }

        protected function target_focusInHandler(arg1:starling.events.Event):void
        {
            this._target.stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            return;
        }

        protected function target_focusOutHandler(arg1:starling.events.Event):void
        {
            this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            return;
        }

        protected function target_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            return;
        }

        protected function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (!this._isEnabled) 
            {
                return;
            }
            if (arg1.keyCode !== this._cancelKeyCode) 
            {
                if (arg1.keyCode === this._keyCode) 
                {
                    this._target.stage.addEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
                }
            }
            else 
            {
                this._target.stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            }
            return;
        }

        protected function stage_keyUpHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (!this._isEnabled) 
            {
                return;
            }
            if (arg1.keyCode !== this._keyCode) 
            {
                return;
            }
            var loc1:*=starling.display.Stage(arg1.currentTarget);
            loc1.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            if (this._target.stage !== loc1) 
            {
                return;
            }
            this._target.dispatchEventWith(starling.events.Event.TRIGGERED);
            return;
        }

        protected var _target:feathers.core.IFocusDisplayObject;

        protected var _keyCode:uint=32;

        protected var _cancelKeyCode:uint=27;

        protected var _isEnabled:Boolean=true;
    }
}


//  package math
//    function clamp
package feathers.utils.math 
{
    public function clamp(arg1:Number, arg2:Number, arg3:Number):Number
    {
        if (arg2 > arg3) 
        {
            throw new ArgumentError("minimum should be smaller than maximum.");
        }
        if (arg1 < arg2) 
        {
            arg1 = arg2;
        }
        else if (arg1 > arg3) 
        {
            arg1 = arg3;
        }
        return arg1;
    }
}


//    function roundDownToNearest
package feathers.utils.math 
{
    public function roundDownToNearest(arg1:Number, arg2:Number=1):Number
    {
        if (arg2 == 0) 
        {
            return arg1;
        }
        return Math.floor(feathers.utils.math.roundToPrecision(arg1 / arg2, 10)) * arg2;
    }
}


//    function roundToNearest
package feathers.utils.math 
{
    public function roundToNearest(arg1:Number, arg2:Number=1):Number
    {
        if (arg2 == 0) 
        {
            return arg1;
        }
        var loc1:*=Math.round(feathers.utils.math.roundToPrecision(arg1 / arg2, 10)) * arg2;
        return feathers.utils.math.roundToPrecision(loc1, 10);
    }
}


//    function roundToPrecision
package feathers.utils.math 
{
    public function roundToPrecision(arg1:Number, arg2:int=0):Number
    {
        var loc1:*=Math.pow(10, arg2);
        return Math.round(loc1 * arg1) / loc1;
    }
}


//    function roundUpToNearest
package feathers.utils.math 
{
    public function roundUpToNearest(arg1:Number, arg2:Number=1):Number
    {
        if (arg2 == 0) 
        {
            return arg1;
        }
        return Math.ceil(feathers.utils.math.roundToPrecision(arg1 / arg2, 10)) * arg2;
    }
}


//  package skins
//    function resetFluidChildDimensionsForMeasurement
package feathers.utils.skins 
{
    import feathers.core.*;
    import starling.display.*;
    
    public function resetFluidChildDimensionsForMeasurement(arg1:starling.display.DisplayObject, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:Number, arg10:Number, arg11:Number, arg12:Number, arg13:Number):void
    {
        var loc4:*=NaN;
        var loc5:*=NaN;
        var loc6:*=NaN;
        var loc7:*=NaN;
        if (arg1 === null) 
        {
            return;
        }
        var loc1:*=!(arg2 === arg2);
        var loc2:*=!(arg3 === arg3);
        if (loc1) 
        {
            arg1.width = arg8;
        }
        else 
        {
            arg1.width = arg2;
        }
        if (loc2) 
        {
            arg1.height = arg9;
        }
        else 
        {
            arg1.height = arg3;
        }
        var loc3:*=arg1 as feathers.core.IMeasureDisplayObject;
        if (loc3 !== null) 
        {
            loc4 = arg4;
            compilerWorkaround = loc4;
            if (!(loc4 === loc4) || arg10 > loc4) 
            {
                loc4 = arg10;
            }
            loc3.minWidth = loc4;
            loc5 = arg5;
            compilerWorkaround = loc5;
            if (!(loc5 === loc5) || arg11 > loc5) 
            {
                loc5 = arg11;
            }
            loc3.minHeight = loc5;
            loc6 = arg6;
            compilerWorkaround = loc6;
            if (!(loc6 === loc6) || arg12 < loc6) 
            {
                loc6 = arg12;
            }
            loc3.maxWidth = loc6;
            loc7 = arg7;
            compilerWorkaround = loc7;
            if (!(loc7 === loc7) || arg13 < loc7) 
            {
                loc7 = arg13;
            }
            loc3.maxHeight = loc7;
        }
        return;
    }
}


var compilerWorkaround:Object;

//  package text
//    class TextEditorIMEClient
package feathers.utils.text 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.ime.*;
    import starling.core.*;
    import starling.display.*;
    
    public class TextEditorIMEClient extends flash.display.Sprite implements flash.text.ime.IIMEClient
    {
        public function TextEditorIMEClient(arg1:feathers.core.IIMETextEditor, arg2:Function, arg3:Function, arg4:Function)
        {
            super();
            this._textEditor = arg1;
            this._startCallback = arg2;
            this._updateCallback = arg3;
            this._confirmCallback = arg4;
            this.addEventListener(flash.events.IMEEvent.IME_START_COMPOSITION, this.imeStartCompositionHandler);
            return;
        }

        public function get verticalTextLayout():Boolean
        {
            return false;
        }

        public function get compositionStartIndex():int
        {
            return this._compositionStartIndex;
        }

        public function get compositionEndIndex():int
        {
            return this._compositionEndIndex;
        }

        public function get selectionAnchorIndex():int
        {
            return this._textEditor.selectionAnchorIndex;
        }

        public function get selectionActiveIndex():int
        {
            return this._textEditor.selectionActiveIndex;
        }

        public function getTextBounds(arg1:int, arg2:int):flash.geom.Rectangle
        {
            var loc1:*=this._textEditor.stage;
            if (loc1 === null) 
            {
                return new flash.geom.Rectangle();
            }
            var loc2:*=this._textEditor.getBounds(loc1);
            var loc3:*=this._textEditor.stage === null ? starling.core.Starling.current : this._textEditor.stage.starling;
            var loc4:*=1;
            if (loc3.supportHighResolutions) 
            {
                loc4 = loc3.nativeStage.contentsScaleFactor;
            }
            var loc5:*=loc3.contentScaleFactor / loc4;
            loc2.x = loc2.x * loc5;
            loc2.y = loc2.y * loc5;
            loc2.width = loc2.width * loc5;
            loc2.height = loc2.height * loc5;
            var loc6:*=loc3.viewPort;
            loc2.x = loc2.x + loc6.x;
            loc2.y = loc2.y + loc6.y;
            return loc2;
        }

        public function confirmComposition(arg1:String=null, arg2:Boolean=false):void
        {
            this._confirmCallback(arg1, arg2);
            return;
        }

        public function updateComposition(arg1:String, arg2:__AS3__.vec.Vector.<flash.text.ime.CompositionAttributeRange>, arg3:int, arg4:int):void
        {
            this._compositionStartIndex = arg3;
            this._compositionEndIndex = arg4;
            this._updateCallback(arg1, arg2, arg3, arg4);
            return;
        }

        public function selectRange(arg1:int, arg2:int):void
        {
            return this._textEditor.selectRange(arg1, arg2);
        }

        public function getTextInRange(arg1:int, arg2:int):String
        {
            return this._textEditor.text.substring(arg1, arg2);
        }

        protected function imeStartCompositionHandler(arg1:flash.events.IMEEvent):void
        {
            arg1.imeClient = this;
            this._startCallback();
            return;
        }

        protected var _textEditor:feathers.core.IIMETextEditor;

        protected var _startCallback:Function;

        protected var _updateCallback:Function;

        protected var _confirmCallback:Function;

        protected var _compositionStartIndex:int=-1;

        protected var _compositionEndIndex:int=-1;
    }
}


//    class TextInputNavigation
package feathers.utils.text 
{
    public class TextInputNavigation extends Object
    {
        public function TextInputNavigation()
        {
            super();
            return;
        }

        public static function findPreviousWordStartIndex(arg1:String, arg2:int):int
        {
            var loc3:*=false;
            if (arg2 <= 0) 
            {
                return 0;
            }
            var loc1:*=IS_WORD.test(arg1.charAt((arg2 - 1)));
            var loc2:*=arg2 - 2;
            while (loc2 >= 0) 
            {
                loc3 = IS_WORD.test(arg1.charAt(loc2));
                if (!loc3 && loc1) 
                {
                    return loc2 + 1;
                }
                loc1 = loc3;
                --loc2;
            }
            return 0;
        }

        public static function findCurrentWordStartIndex(arg1:String, arg2:int):int
        {
            var loc3:*=false;
            if (arg2 <= 0) 
            {
                return 0;
            }
            var loc1:*=IS_WORD.test(arg1.charAt(arg2 + 1));
            var loc2:*=arg2;
            while (loc2 >= 0) 
            {
                loc3 = IS_WORD.test(arg1.charAt(loc2));
                if (!loc3 && loc2 === arg2) 
                {
                    return findPreviousWordStartIndex(arg1, arg2);
                }
                if (!loc3 && loc1) 
                {
                    return loc2 + 1;
                }
                loc1 = loc3;
                --loc2;
            }
            return 0;
        }

        public static function findCurrentWordEndIndex(arg1:String, arg2:int):int
        {
            var loc3:*=false;
            var loc4:*=0;
            var loc1:*=arg1.length;
            if (arg2 >= (loc1 - 1)) 
            {
                return loc1;
            }
            var loc2:*=arg2;
            while (loc2 < loc1) 
            {
                loc3 = IS_WORD.test(arg1.charAt(loc2));
                if (!loc3 && loc2 === arg2) 
                {
                    loc4 = findNextWordStartIndex(arg1, arg2);
                    return findCurrentWordEndIndex(arg1, loc4);
                }
                if (!loc3) 
                {
                    return loc2;
                }
                ++loc2;
            }
            return loc1;
        }

        public static function findNextWordStartIndex(arg1:String, arg2:int):int
        {
            var loc4:*=false;
            var loc1:*=arg1.length;
            if (arg2 >= (loc1 - 1)) 
            {
                return loc1;
            }
            var loc2:*=!IS_WHITESPACE.test(arg1.charAt(arg2));
            var loc3:*=arg2 + 1;
            while (loc3 < loc1) 
            {
                loc4 = IS_WORD.test(arg1.charAt(loc3));
                if (loc4 && !loc2) 
                {
                    return loc3;
                }
                loc2 = loc4;
                ++loc3;
            }
            return loc1;
        }

        protected static const IS_WORD:RegExp=new RegExp("\\w");

        protected static const IS_WHITESPACE:RegExp=new RegExp("\\s");
    }
}


//    class TextInputRestrict
package feathers.utils.text 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    
    public class TextInputRestrict extends Object
    {
        public function TextInputRestrict(arg1:String=null)
        {
            super();
            this.restrict = arg1;
            return;
        }

        public function get restrict():String
        {
            return this._restrict;
        }

        public function set restrict(arg1:String):void
        {
            var loc1:*=0;
            var loc2:*=false;
            var loc3:*=0;
            var loc4:*=null;
            if (this._restrict === arg1) 
            {
                return;
            }
            this._restrict = arg1;
            if (arg1) 
            {
                if (this._restricts) 
                {
                    this._restricts.length = 0;
                }
                else 
                {
                    this._restricts = new Vector.<RegExp>(0);
                }
                if (this._restrict !== "") 
                {
                    if (this._restrict) 
                    {
                        loc1 = 0;
                        loc2 = arg1.indexOf("^") == 0;
                        this._restrictStartsWithExclude = loc2;
                        do 
                        {
                            loc3 = arg1.indexOf("^", loc1 + 1);
                            if (loc3 >= 0) 
                            {
                                loc4 = arg1.substr(loc1, loc3 - loc1);
                                this._restricts.push(this.createRestrictRegExp(loc4, loc2));
                            }
                            else 
                            {
                                loc4 = arg1.substr(loc1);
                                this._restricts.push(this.createRestrictRegExp(loc4, loc2));
                            }
                            loc1 = loc3;
                            loc2 = !loc2;
                        }
                        while (true);
                    }
                }
                else 
                {
                    this._restricts.push(new RegExp("^$"));
                }
            }
            else 
            {
                this._restricts = null;
            }
            return;
        }

        public function isCharacterAllowed(arg1:int):Boolean
        {
            var loc6:*=null;
            if (!this._restricts) 
            {
                return true;
            }
            var loc1:*=String.fromCharCode(arg1);
            var loc2:*=this._restrictStartsWithExclude;
            var loc3:*=loc2;
            var loc4:*=this._restricts.length;
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc6 = this._restricts[loc5];
                if (loc2) 
                {
                    loc3 = loc3 && loc6.test(loc1);
                }
                else 
                {
                    loc3 = loc3 || loc6.test(loc1);
                }
                loc2 = !loc2;
                ++loc5;
            }
            return loc3;
        }

        public function filterText(arg1:String):String
        {
            var loc4:*=null;
            var loc5:*=false;
            var loc6:*=false;
            var loc7:*=0;
            var loc8:*=null;
            if (!this._restricts) 
            {
                return arg1;
            }
            var loc1:*=arg1.length;
            var loc2:*=this._restricts.length;
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                loc4 = arg1.charAt(loc3);
                loc5 = this._restrictStartsWithExclude;
                loc6 = loc5;
                loc7 = 0;
                while (loc7 < loc2) 
                {
                    loc8 = this._restricts[loc7];
                    if (loc5) 
                    {
                        loc6 = loc6 && loc8.test(loc4);
                    }
                    else 
                    {
                        loc6 = loc6 || loc8.test(loc4);
                    }
                    loc5 = !loc5;
                    ++loc7;
                }
                if (!loc6) 
                {
                    arg1 = arg1.substr(0, loc3) + arg1.substr(loc3 + 1);
                    --loc3;
                    --loc1;
                }
                ++loc3;
            }
            return arg1;
        }

        protected function createRestrictRegExp(arg1:String, arg2:Boolean):RegExp
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (!arg2 && arg1.indexOf("^") == 0) 
            {
                arg1 = arg1.substr(1);
            }
            arg1 = arg1.replace(new RegExp("\\\\", "g"), "\\\\");
            var loc4:*=0;
            var loc5:*=REQUIRES_ESCAPE;
            for (loc1 in loc5) 
            {
                loc2 = loc1 as RegExp;
                loc3 = REQUIRES_ESCAPE[loc2] as String;
                arg1 = arg1.replace(loc2, loc3);
            }
            return new RegExp("[" + arg1 + "]");
        }

        
        {
            REQUIRES_ESCAPE[new RegExp("\\[", "g")] = "\\[";
            REQUIRES_ESCAPE[new RegExp("\\]", "g")] = "\\]";
            REQUIRES_ESCAPE[new RegExp("\\{", "g")] = "\\{";
            REQUIRES_ESCAPE[new RegExp("\\}", "g")] = "\\}";
            REQUIRES_ESCAPE[new RegExp("\\(", "g")] = "\\(";
            REQUIRES_ESCAPE[new RegExp("\\)", "g")] = "\\)";
            REQUIRES_ESCAPE[new RegExp("\\|", "g")] = "\\|";
            REQUIRES_ESCAPE[new RegExp("\\/", "g")] = "\\/";
            REQUIRES_ESCAPE[new RegExp("\\.", "g")] = "\\.";
            REQUIRES_ESCAPE[new RegExp("\\+", "g")] = "\\+";
            REQUIRES_ESCAPE[new RegExp("\\*", "g")] = "\\*";
            REQUIRES_ESCAPE[new RegExp("\\?", "g")] = "\\?";
            REQUIRES_ESCAPE[new RegExp("\\$", "g")] = "\\$";
        }

        protected static const REQUIRES_ESCAPE:flash.utils.Dictionary=new flash.utils.Dictionary();

        protected var _restrictStartsWithExclude:Boolean=false;

        protected var _restricts:__AS3__.vec.Vector.<RegExp>;

        internal var _restrict:String;
    }
}


//  package textures
//    class TextureCache
package feathers.utils.textures 
{
    import __AS3__.vec.*;
    import flash.errors.*;
    import starling.textures.*;
    
    public class TextureCache extends Object
    {
        public function TextureCache(arg1:int=2147483647)
        {
            this._unretainedKeys = new Vector.<String>(0);
            this._unretainedTextures = {};
            this._retainedTextures = {};
            this._retainCounts = {};
            super();
            this._maxUnretainedTextures = arg1;
            return;
        }

        public function get maxUnretainedTextures():int
        {
            return this._maxUnretainedTextures;
        }

        public function set maxUnretainedTextures(arg1:int):void
        {
            if (this._maxUnretainedTextures === arg1) 
            {
                return;
            }
            this._maxUnretainedTextures = arg1;
            if (this._unretainedKeys.length > arg1) 
            {
                this.trimCache();
            }
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this._unretainedTextures;
            for each (loc1 in loc3) 
            {
                loc1.dispose();
            }
            loc2 = 0;
            loc3 = this._retainedTextures;
            for each (loc1 in loc3) 
            {
                loc1.dispose();
            }
            this._retainedTextures = null;
            this._unretainedTextures = null;
            this._retainCounts = null;
            return;
        }

        public function addTexture(arg1:String, arg2:starling.textures.Texture, arg3:Boolean=true):void
        {
            if (!this._retainedTextures) 
            {
                throw new flash.errors.IllegalOperationError("Cannot add a texture after the cache has been disposed.");
            }
            if (arg1 in this._unretainedTextures || arg1 in this._retainedTextures) 
            {
                throw new ArgumentError("Key \"" + arg1 + "\" already exists in the cache.");
            }
            if (arg3) 
            {
                this._retainedTextures[arg1] = arg2;
                this._retainCounts[arg1] = 1 as int;
                return;
            }
            this._unretainedTextures[arg1] = arg2;
            this._unretainedKeys[this._unretainedKeys.length] = arg1;
            if (this._unretainedKeys.length > this._maxUnretainedTextures) 
            {
                this.trimCache();
            }
            return;
        }

        public function removeTexture(arg1:String, arg2:Boolean=false):void
        {
            if (!this._unretainedTextures) 
            {
                return;
            }
            var loc1:*=this._unretainedTextures[arg1] as starling.textures.Texture;
            if (loc1) 
            {
                this.removeUnretainedKey(arg1);
            }
            else 
            {
                loc1 = this._retainedTextures[arg1] as starling.textures.Texture;
                delete this._retainedTextures[arg1];
                delete this._retainCounts[arg1];
            }
            if (arg2 && loc1) 
            {
                loc1.dispose();
            }
            return;
        }

        public function hasTexture(arg1:String):Boolean
        {
            if (!this._retainedTextures) 
            {
                return false;
            }
            return arg1 in this._retainedTextures || arg1 in this._unretainedTextures;
        }

        public function getRetainCount(arg1:String):int
        {
            if (this._retainCounts && arg1 in this._retainCounts) 
            {
                return this._retainCounts[arg1] as int;
            }
            return 0;
        }

        public function retainTexture(arg1:String):starling.textures.Texture
        {
            var loc2:*=0;
            if (!this._retainedTextures) 
            {
                throw new flash.errors.IllegalOperationError("Cannot retain a texture after the cache has been disposed.");
            }
            if (arg1 in this._retainedTextures) 
            {
                loc2 = this._retainCounts[arg1] as int;
                ++loc2;
                this._retainCounts[arg1] = loc2;
                return starling.textures.Texture(this._retainedTextures[arg1]);
            }
            if (!(arg1 in this._unretainedTextures)) 
            {
                throw new ArgumentError("Texture with key \"" + arg1 + "\" cannot be retained because it has not been added to the cache.");
            }
            var loc1:*=starling.textures.Texture(this._unretainedTextures[arg1]);
            this.removeUnretainedKey(arg1);
            this._retainedTextures[arg1] = loc1;
            this._retainCounts[arg1] = 1 as int;
            return loc1;
        }

        public function releaseTexture(arg1:String):void
        {
            var loc2:*=null;
            if (!this._retainedTextures || !(arg1 in this._retainedTextures)) 
            {
                return;
            }
            var loc1:*=this._retainCounts[arg1] as int;
            --loc1;
            if (loc1 !== 0) 
            {
                this._retainCounts[arg1] = loc1;
            }
            else 
            {
                loc2 = starling.textures.Texture(this._retainedTextures[arg1]);
                delete this._retainCounts[arg1];
                delete this._retainedTextures[arg1];
                this._unretainedTextures[arg1] = loc2;
                this._unretainedKeys[this._unretainedKeys.length] = arg1;
                if (this._unretainedKeys.length > this._maxUnretainedTextures) 
                {
                    this.trimCache();
                }
            }
            return;
        }

        protected function removeUnretainedKey(arg1:String):void
        {
            var loc1:*=this._unretainedKeys.indexOf(arg1);
            if (loc1 < 0) 
            {
                return;
            }
            this._unretainedKeys.removeAt(loc1);
            delete this._unretainedTextures[arg1];
            return;
        }

        protected function trimCache():void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=this._unretainedKeys.length;
            var loc2:*=this._maxUnretainedTextures;
            while (loc1 > loc2) 
            {
                loc3 = this._unretainedKeys.shift();
                loc4 = starling.textures.Texture(this._unretainedTextures[loc3]);
                loc4.dispose();
                delete this._unretainedTextures[loc3];
                --loc1;
            }
            return;
        }

        protected var _unretainedKeys:__AS3__.vec.Vector.<String>;

        protected var _unretainedTextures:Object;

        protected var _retainedTextures:Object;

        protected var _retainCounts:Object;

        protected var _maxUnretainedTextures:int;
    }
}


//    function calculateSnapshotTextureDimensions
package feathers.utils.textures 
{
    import flash.geom.*;
    import starling.utils.*;
    
    public function calculateSnapshotTextureDimensions(arg1:Number, arg2:Number, arg3:Number, arg4:Boolean, arg5:flash.geom.Point=null):flash.geom.Point
    {
        var loc1:*=arg1;
        var loc2:*=arg2;
        if (arg4) 
        {
            if (loc1 > arg3) 
            {
                loc1 = int(loc1 / arg3) * arg3 + loc1 % arg3;
            }
        }
        else if (loc1 > arg3) 
        {
            loc1 = int(loc1 / arg3) * arg3 + starling.utils.MathUtil.getNextPowerOfTwo(loc1 % arg3);
        }
        else 
        {
            loc1 = starling.utils.MathUtil.getNextPowerOfTwo(loc1);
        }
        if (arg4) 
        {
            if (loc2 > arg3) 
            {
                loc2 = int(loc2 / arg3) * arg3 + loc2 % arg3;
            }
        }
        else if (loc2 > arg3) 
        {
            loc2 = int(loc2 / arg3) * arg3 + starling.utils.MathUtil.getNextPowerOfTwo(loc2 % arg3);
        }
        else 
        {
            loc2 = starling.utils.MathUtil.getNextPowerOfTwo(loc2);
        }
        if (arg5 !== null) 
        {
            arg5.setTo(loc1, loc2);
        }
        else 
        {
            arg5 = new flash.geom.Point(loc1, loc2);
        }
        return arg5;
    }
}


//  package touch
//    class LongPress
package feathers.utils.touch 
{
    import feathers.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class LongPress extends Object
    {
        public function LongPress(arg1:starling.display.DisplayObject=null)
        {
            this._touchLastGlobalPosition = new flash.geom.Point();
            super();
            this.target = arg1;
            return;
        }

        public function get target():starling.display.DisplayObject
        {
            return this._target;
        }

        public function set target(arg1:starling.display.DisplayObject):void
        {
            if (this._target == arg1) 
            {
                return;
            }
            if (this._target) 
            {
                this._target.removeEventListener(starling.events.TouchEvent.TOUCH, this.target_touchHandler);
            }
            this._target = arg1;
            if (this._target) 
            {
                this._touchPointID = -1;
                this._target.addEventListener(starling.events.TouchEvent.TOUCH, this.target_touchHandler);
            }
            return;
        }

        public function get longPressDuration():Number
        {
            return this._longPressDuration;
        }

        public function set longPressDuration(arg1:Number):void
        {
            this._longPressDuration = arg1;
            return;
        }

        public function get isEnabled():Boolean
        {
            return this._isEnabled;
        }

        public function set isEnabled(arg1:Boolean):void
        {
            if (this._isEnabled === arg1) 
            {
                return;
            }
            this._isEnabled = arg1;
            if (!arg1) 
            {
                this._touchPointID = -1;
            }
            return;
        }

        public function get tapToTrigger():feathers.utils.touch.TapToTrigger
        {
            return this._tapToTrigger;
        }

        public function set tapToTrigger(arg1:feathers.utils.touch.TapToTrigger):void
        {
            this._tapToTrigger = arg1;
            return;
        }

        public function get tapToSelect():feathers.utils.touch.TapToSelect
        {
            return this._tapToSelect;
        }

        public function set tapToSelect(arg1:feathers.utils.touch.TapToSelect):void
        {
            this._tapToSelect = arg1;
            return;
        }

        public function get customHitTest():Function
        {
            return this._customHitTest;
        }

        public function set customHitTest(arg1:Function):void
        {
            this._customHitTest = arg1;
            return;
        }

        protected function target_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=false;
            if (!this._isEnabled) 
            {
                this._touchPointID = -1;
                return;
            }
            if (this._touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this._target, null, this._touchPointID);
                if (!loc1) 
                {
                    return;
                }
                if (loc1.phase != starling.events.TouchPhase.MOVED) 
                {
                    if (loc1.phase == starling.events.TouchPhase.ENDED) 
                    {
                        this._target.removeEventListener(starling.events.Event.ENTER_FRAME, this.target_enterFrameHandler);
                        if (this._tapToTrigger) 
                        {
                            this._tapToTrigger.isEnabled = true;
                        }
                        if (this._tapToSelect) 
                        {
                            this._tapToSelect.isEnabled = true;
                        }
                        this._touchPointID = -1;
                    }
                }
                else 
                {
                    this._touchLastGlobalPosition.x = loc1.globalX;
                    this._touchLastGlobalPosition.y = loc1.globalY;
                }
                return;
            }
            loc1 = arg1.getTouch(starling.display.DisplayObject(this._target), starling.events.TouchPhase.BEGAN);
            if (!loc1) 
            {
                return;
            }
            if (this._customHitTest !== null) 
            {
                loc2 = starling.utils.Pool.getPoint();
                loc1.getLocation(starling.display.DisplayObject(this._target), loc2);
                loc3 = this._customHitTest(loc2);
                starling.utils.Pool.putPoint(loc2);
                if (!loc3) 
                {
                    return;
                }
            }
            this._touchPointID = loc1.id;
            this._touchLastGlobalPosition.x = loc1.globalX;
            this._touchLastGlobalPosition.y = loc1.globalY;
            this._touchBeginTime = flash.utils.getTimer();
            this._target.addEventListener(starling.events.Event.ENTER_FRAME, this.target_enterFrameHandler);
            return;
        }

        protected function target_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc2:*=null;
            var loc3:*=false;
            var loc1:*=(flash.utils.getTimer() - this._touchBeginTime) / 1000;
            if (loc1 >= this._longPressDuration) 
            {
                this._target.removeEventListener(starling.events.Event.ENTER_FRAME, this.target_enterFrameHandler);
                loc2 = this._target.stage;
                if (this._target is starling.display.DisplayObjectContainer) 
                {
                    loc3 = starling.display.DisplayObjectContainer(this._target).contains(loc2.hitTest(this._touchLastGlobalPosition));
                }
                else 
                {
                    loc3 = this._target === loc2.hitTest(this._touchLastGlobalPosition);
                }
                if (loc3) 
                {
                    if (this._tapToTrigger) 
                    {
                        this._tapToTrigger.isEnabled = false;
                    }
                    if (this._tapToSelect) 
                    {
                        this._tapToSelect.isEnabled = false;
                    }
                    this._target.dispatchEventWith(feathers.events.FeathersEventType.LONG_PRESS);
                }
            }
            return;
        }

        protected var _target:starling.display.DisplayObject;

        protected var _longPressDuration:Number=0.5;

        protected var _touchPointID:int=-1;

        protected var _touchLastGlobalPosition:flash.geom.Point;

        protected var _touchBeginTime:int;

        protected var _isEnabled:Boolean=true;

        protected var _tapToTrigger:feathers.utils.touch.TapToTrigger;

        protected var _tapToSelect:feathers.utils.touch.TapToSelect;

        protected var _customHitTest:Function;
    }
}


//    class TapToSelect
package feathers.utils.touch 
{
    import feathers.core.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class TapToSelect extends Object
    {
        public function TapToSelect(arg1:feathers.core.IToggle=null)
        {
            super();
            this.target = arg1;
            return;
        }

        public function get target():feathers.core.IToggle
        {
            return this._target;
        }

        public function set target(arg1:feathers.core.IToggle):void
        {
            if (this._target == arg1) 
            {
                return;
            }
            if (this._target) 
            {
                this._target.removeEventListener(starling.events.TouchEvent.TOUCH, this.target_touchHandler);
            }
            this._target = arg1;
            if (this._target) 
            {
                this._touchPointID = -1;
                this._target.addEventListener(starling.events.TouchEvent.TOUCH, this.target_touchHandler);
            }
            return;
        }

        public function get isEnabled():Boolean
        {
            return this._isEnabled;
        }

        public function set isEnabled(arg1:Boolean):void
        {
            if (this._isEnabled === arg1) 
            {
                return;
            }
            this._isEnabled = arg1;
            if (!arg1) 
            {
                this._touchPointID = -1;
            }
            return;
        }

        public function get tapToDeselect():Boolean
        {
            return this._tapToDeselect;
        }

        public function set tapToDeselect(arg1:Boolean):void
        {
            this._tapToDeselect = arg1;
            return;
        }

        public function get customHitTest():Function
        {
            return this._customHitTest;
        }

        public function set customHitTest(arg1:Function):void
        {
            this._customHitTest = arg1;
            return;
        }

        protected function target_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=false;
            if (!this._isEnabled) 
            {
                this._touchPointID = -1;
                return;
            }
            if (this._touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(starling.display.DisplayObject(this._target), null, this._touchPointID);
                if (!loc1) 
                {
                    return;
                }
                if (loc1.phase == starling.events.TouchPhase.ENDED) 
                {
                    loc2 = this._target.stage;
                    if (loc2 !== null) 
                    {
                        loc3 = starling.utils.Pool.getPoint();
                        loc1.getLocation(loc2, loc3);
                        if (this._target is starling.display.DisplayObjectContainer) 
                        {
                            loc4 = starling.display.DisplayObjectContainer(this._target).contains(loc2.hitTest(loc3));
                        }
                        else 
                        {
                            loc4 = this._target === loc2.hitTest(loc3);
                        }
                        starling.utils.Pool.putPoint(loc3);
                        if (loc4) 
                        {
                            if (this._tapToDeselect) 
                            {
                                this._target.isSelected = !this._target.isSelected;
                            }
                            else 
                            {
                                this._target.isSelected = true;
                            }
                        }
                    }
                    this._touchPointID = -1;
                }
                return;
            }
            loc1 = arg1.getTouch(starling.display.DisplayObject(this._target), starling.events.TouchPhase.BEGAN);
            if (!loc1) 
            {
                return;
            }
            if (this._customHitTest !== null) 
            {
                loc3 = starling.utils.Pool.getPoint();
                loc1.getLocation(starling.display.DisplayObject(this._target), loc3);
                loc4 = this._customHitTest(loc3);
                starling.utils.Pool.putPoint(loc3);
                if (!loc4) 
                {
                    return;
                }
            }
            this._touchPointID = loc1.id;
            return;
        }

        protected var _target:feathers.core.IToggle;

        protected var _touchPointID:int=-1;

        protected var _isEnabled:Boolean=true;

        protected var _tapToDeselect:Boolean=false;

        protected var _customHitTest:Function;
    }
}


//    class TapToTrigger
package feathers.utils.touch 
{
    import flash.geom.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class TapToTrigger extends Object
    {
        public function TapToTrigger(arg1:starling.display.DisplayObject=null)
        {
            super();
            this.target = arg1;
            return;
        }

        public function get target():starling.display.DisplayObject
        {
            return this._target;
        }

        public function set target(arg1:starling.display.DisplayObject):void
        {
            if (this._target == arg1) 
            {
                return;
            }
            if (this._target) 
            {
                this._target.removeEventListener(starling.events.TouchEvent.TOUCH, this.target_touchHandler);
            }
            this._target = arg1;
            if (this._target) 
            {
                this._touchPointID = -1;
                this._target.addEventListener(starling.events.TouchEvent.TOUCH, this.target_touchHandler);
            }
            return;
        }

        public function get isEnabled():Boolean
        {
            return this._isEnabled;
        }

        public function set isEnabled(arg1:Boolean):void
        {
            if (this._isEnabled === arg1) 
            {
                return;
            }
            this._isEnabled = arg1;
            if (!arg1) 
            {
                this._touchPointID = -1;
            }
            return;
        }

        public function get customHitTest():Function
        {
            return this._customHitTest;
        }

        public function set customHitTest(arg1:Function):void
        {
            this._customHitTest = arg1;
            return;
        }

        protected function target_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=false;
            if (!this._isEnabled) 
            {
                this._touchPointID = -1;
                return;
            }
            if (this._touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this._target, null, this._touchPointID);
                if (!loc1) 
                {
                    return;
                }
                if (loc1.phase == starling.events.TouchPhase.ENDED) 
                {
                    loc2 = this._target.stage;
                    if (loc2 !== null) 
                    {
                        loc3 = starling.utils.Pool.getPoint();
                        loc1.getLocation(loc2, loc3);
                        if (this._target is starling.display.DisplayObjectContainer) 
                        {
                            loc4 = starling.display.DisplayObjectContainer(this._target).contains(loc2.hitTest(loc3));
                        }
                        else 
                        {
                            loc4 = this._target === loc2.hitTest(loc3);
                        }
                        starling.utils.Pool.putPoint(loc3);
                        if (loc4) 
                        {
                            this._target.dispatchEventWith(starling.events.Event.TRIGGERED);
                        }
                    }
                    this._touchPointID = -1;
                }
                return;
            }
            loc1 = arg1.getTouch(starling.display.DisplayObject(this._target), starling.events.TouchPhase.BEGAN);
            if (!loc1) 
            {
                return;
            }
            if (this._customHitTest !== null) 
            {
                loc3 = starling.utils.Pool.getPoint();
                loc1.getLocation(starling.display.DisplayObject(this._target), loc3);
                loc4 = this._customHitTest(loc3);
                starling.utils.Pool.putPoint(loc3);
                if (!loc4) 
                {
                    return;
                }
            }
            this._touchPointID = loc1.id;
            return;
        }

        protected var _target:starling.display.DisplayObject;

        protected var _touchPointID:int=-1;

        protected var _isEnabled:Boolean=true;

        protected var _customHitTest:Function;
    }
}


