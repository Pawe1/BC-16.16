//package text
//  class TextEditorIMEClient
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


//  class TextInputNavigation
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


//  class TextInputRestrict
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


