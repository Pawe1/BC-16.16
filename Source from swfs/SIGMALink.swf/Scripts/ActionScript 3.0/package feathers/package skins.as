//package skins
//  class AddOnFunctionStyleProvider
package feathers.skins 
{
    import feathers.core.*;
    
    public class AddOnFunctionStyleProvider extends Object implements feathers.skins.IStyleProvider
    {
        public function AddOnFunctionStyleProvider(arg1:feathers.skins.IStyleProvider=null, arg2:Function=null)
        {
            super();
            this._originalStyleProvider = arg1;
            this._addOnFunction = arg2;
            return;
        }

        public function get originalStyleProvider():feathers.skins.IStyleProvider
        {
            return this._originalStyleProvider;
        }

        public function set originalStyleProvider(arg1:feathers.skins.IStyleProvider):void
        {
            this._originalStyleProvider = arg1;
            return;
        }

        public function get addOnFunction():Function
        {
            return this._addOnFunction;
        }

        public function set addOnFunction(arg1:Function):void
        {
            this._addOnFunction = arg1;
            return;
        }

        public function get callBeforeOriginalStyleProvider():Boolean
        {
            return this._callBeforeOriginalStyleProvider;
        }

        public function set callBeforeOriginalStyleProvider(arg1:Boolean):void
        {
            this._callBeforeOriginalStyleProvider = arg1;
            return;
        }

        public function applyStyles(arg1:feathers.core.IFeathersControl):void
        {
            if (this._callBeforeOriginalStyleProvider && !(this._addOnFunction === null)) 
            {
                this._addOnFunction(arg1);
            }
            if (this._originalStyleProvider) 
            {
                this._originalStyleProvider.applyStyles(arg1);
            }
            if (!this._callBeforeOriginalStyleProvider && !(this._addOnFunction === null)) 
            {
                this._addOnFunction(arg1);
            }
            return;
        }

        protected var _originalStyleProvider:feathers.skins.IStyleProvider;

        protected var _addOnFunction:Function;

        protected var _callBeforeOriginalStyleProvider:Boolean=false;
    }
}


//  class ConditionalStyleProvider
package feathers.skins 
{
    import feathers.core.*;
    
    public class ConditionalStyleProvider extends Object implements feathers.skins.IStyleProvider
    {
        public function ConditionalStyleProvider(arg1:Function, arg2:feathers.skins.IStyleProvider=null, arg3:feathers.skins.IStyleProvider=null)
        {
            super();
            this._conditionalFunction = arg1;
            this._trueStyleProvider = arg2;
            this._falseStyleProvider = arg3;
            return;
        }

        public function get trueStyleProvider():feathers.skins.IStyleProvider
        {
            return this._trueStyleProvider;
        }

        public function set trueStyleProvider(arg1:feathers.skins.IStyleProvider):void
        {
            this._trueStyleProvider = arg1;
            return;
        }

        public function get falseStyleProvider():feathers.skins.IStyleProvider
        {
            return this._falseStyleProvider;
        }

        public function set falseStyleProvider(arg1:feathers.skins.IStyleProvider):void
        {
            this._falseStyleProvider = arg1;
            return;
        }

        public function get conditionalFunction():Function
        {
            return this._conditionalFunction;
        }

        public function set conditionalFunction(arg1:Function):void
        {
            this._conditionalFunction = arg1;
            return;
        }

        public function applyStyles(arg1:feathers.core.IFeathersControl):void
        {
            var loc1:*=false;
            if (this._conditionalFunction !== null) 
            {
                loc1 = this._conditionalFunction(arg1) as Boolean;
            }
            if (loc1 !== true) 
            {
                if (this._falseStyleProvider !== null) 
                {
                    this._falseStyleProvider.applyStyles(arg1);
                }
            }
            else if (this._trueStyleProvider !== null) 
            {
                this._trueStyleProvider.applyStyles(arg1);
            }
            return;
        }

        protected var _trueStyleProvider:feathers.skins.IStyleProvider;

        protected var _falseStyleProvider:feathers.skins.IStyleProvider;

        protected var _conditionalFunction:Function;
    }
}


//  class IStyleProvider
package feathers.skins 
{
    import feathers.core.*;
    
    public interface IStyleProvider
    {
        function applyStyles(arg1:feathers.core.IFeathersControl):void;
    }
}


//  class ImageSkin
package feathers.skins 
{
    import feathers.core.*;
    import feathers.events.*;
    import starling.display.*;
    import starling.events.*;
    import starling.textures.*;
    
    public class ImageSkin extends starling.display.Image implements feathers.core.IMeasureDisplayObject, feathers.core.IStateObserver
    {
        public function ImageSkin(arg1:starling.textures.Texture=null)
        {
            this._stateToTexture = {};
            this._stateToColor = {};
            super(arg1);
            this.defaultTexture = arg1;
            return;
        }

        public function set maxHeight(arg1:Number):void
        {
            if (this._explicitMaxHeight === arg1) 
            {
                return;
            }
            if (!(arg1 === arg1) && !(this._explicitMaxHeight === this._explicitMaxHeight)) 
            {
                return;
            }
            this._explicitMaxHeight = arg1;
            this.dispatchEventWith(starling.events.Event.RESIZE);
            return;
        }

        public function get defaultTexture():starling.textures.Texture
        {
            return this._defaultTexture;
        }

        public function set defaultTexture(arg1:starling.textures.Texture):void
        {
            if (this._defaultTexture === arg1) 
            {
                return;
            }
            this._defaultTexture = arg1;
            this.updateTextureFromContext();
            return;
        }

        public function getTextureForState(arg1:String):starling.textures.Texture
        {
            return this._stateToTexture[arg1] as starling.textures.Texture;
        }

        public function get disabledTexture():starling.textures.Texture
        {
            return this._disabledTexture;
        }

        public function set disabledTexture(arg1:starling.textures.Texture):void
        {
            if (this._disabledTexture === arg1) 
            {
                return;
            }
            this._disabledTexture = arg1;
            this.updateTextureFromContext();
            return;
        }

        public function setTextureForState(arg1:String, arg2:starling.textures.Texture):void
        {
            if (arg2 === null) 
            {
                delete this._stateToTexture[arg1];
            }
            else 
            {
                this._stateToTexture[arg1] = arg2;
            }
            this.updateTextureFromContext();
            return;
        }

        public function get selectedTexture():starling.textures.Texture
        {
            return this._selectedTexture;
        }

        public function set selectedTexture(arg1:starling.textures.Texture):void
        {
            if (this._selectedTexture === arg1) 
            {
                return;
            }
            this._selectedTexture = arg1;
            this.updateTextureFromContext();
            return;
        }

        public function getColorForState(arg1:String):uint
        {
            if (arg1 in this._stateToColor) 
            {
                return this._stateToColor[arg1] as uint;
            }
            return uint.MAX_VALUE;
        }

        public function get defaultColor():uint
        {
            return this._defaultColor;
        }

        public function set defaultColor(arg1:uint):void
        {
            if (this._defaultColor === arg1) 
            {
                return;
            }
            this._defaultColor = arg1;
            this.updateColorFromContext();
            return;
        }

        public function setColorForState(arg1:String, arg2:uint):void
        {
            if (arg2 === uint.MAX_VALUE) 
            {
                delete this._stateToColor[arg1];
            }
            else 
            {
                this._stateToColor[arg1] = arg2;
            }
            this.updateColorFromContext();
            return;
        }

        public function get disabledColor():uint
        {
            return this._disabledColor;
        }

        public function set disabledColor(arg1:uint):void
        {
            if (this._disabledColor === arg1) 
            {
                return;
            }
            this._disabledColor = arg1;
            this.updateColorFromContext();
            return;
        }

        public override function readjustSize(arg1:Number=-1, arg2:Number=-1):void
        {
            super.readjustSize(arg1, arg2);
            if (this._explicitWidth === this._explicitWidth) 
            {
                super.width = this._explicitWidth;
            }
            if (this._explicitHeight === this._explicitHeight) 
            {
                super.height = this._explicitHeight;
            }
            return;
        }

        public function get selectedColor():uint
        {
            return this._selectedColor;
        }

        public function set selectedColor(arg1:uint):void
        {
            if (this._selectedColor === arg1) 
            {
                return;
            }
            this._selectedColor = arg1;
            this.updateColorFromContext();
            return;
        }

        protected function updateTextureFromContext():void
        {
            var loc1:*=null;
            if (this._stateContext !== null) 
            {
                loc1 = this._stateToTexture[this._stateContext.currentState] as starling.textures.Texture;
                if (loc1 === null && !(this._disabledTexture === null) && this._stateContext is feathers.core.IFeathersControl && !feathers.core.IFeathersControl(this._stateContext).isEnabled) 
                {
                    loc1 = this._disabledTexture;
                }
                if (loc1 === null && !(this._selectedTexture === null) && this._stateContext is feathers.core.IToggle && feathers.core.IToggle(this._stateContext).isSelected) 
                {
                    loc1 = this._selectedTexture;
                }
                if (loc1 === null) 
                {
                    loc1 = this._defaultTexture;
                }
            }
            else 
            {
                loc1 = this._defaultTexture;
            }
            this.texture = loc1;
            return;
        }

        public function get stateContext():feathers.core.IStateContext
        {
            return this._stateContext;
        }

        public function set stateContext(arg1:feathers.core.IStateContext):void
        {
            if (this._stateContext === arg1) 
            {
                return;
            }
            if (this._stateContext) 
            {
                this._stateContext.removeEventListener(feathers.events.FeathersEventType.STATE_CHANGE, this.stateContext_stageChangeHandler);
            }
            this._stateContext = arg1;
            if (this._stateContext) 
            {
                this._stateContext.addEventListener(feathers.events.FeathersEventType.STATE_CHANGE, this.stateContext_stageChangeHandler);
            }
            this.updateTextureFromContext();
            this.updateColorFromContext();
            return;
        }

        protected function updateColorFromContext():void
        {
            if (this._stateContext === null) 
            {
                if (this._defaultColor !== uint.MAX_VALUE) 
                {
                    this.color = this._defaultColor;
                }
                return;
            }
            var loc1:*=uint.MAX_VALUE;
            var loc2:*=this._stateContext.currentState;
            if (loc2 in this._stateToColor) 
            {
                loc1 = this._stateToColor[loc2] as uint;
            }
            if (loc1 === uint.MAX_VALUE && !(this._disabledColor === uint.MAX_VALUE) && this._stateContext is feathers.core.IFeathersControl && !feathers.core.IFeathersControl(this._stateContext).isEnabled) 
            {
                loc1 = this._disabledColor;
            }
            if (loc1 === uint.MAX_VALUE && !(this._selectedColor === uint.MAX_VALUE) && this._stateContext is feathers.core.IToggle && feathers.core.IToggle(this._stateContext).isSelected) 
            {
                loc1 = this._selectedColor;
            }
            if (loc1 === uint.MAX_VALUE) 
            {
                loc1 = this._defaultColor;
            }
            if (loc1 !== uint.MAX_VALUE) 
            {
                this.color = loc1;
            }
            return;
        }

        public function get explicitWidth():Number
        {
            return this._explicitWidth;
        }

        public override function set width(arg1:Number):void
        {
            if (this._explicitWidth === arg1) 
            {
                return;
            }
            if (!(arg1 === arg1) && !(this._explicitWidth === this._explicitWidth)) 
            {
                return;
            }
            this._explicitWidth = arg1;
            if (arg1 !== arg1) 
            {
                if (this.texture === null) 
                {
                    this.readjustSize();
                }
                else 
                {
                    this.scaleX = 1;
                    this.readjustSize(this.texture.frameWidth);
                }
            }
            else 
            {
                super.width = arg1;
            }
            this.dispatchEventWith(starling.events.Event.RESIZE);
            return;
        }

        protected function stateContext_stageChangeHandler(arg1:starling.events.Event):void
        {
            this.updateTextureFromContext();
            this.updateColorFromContext();
            return;
        }

        public function get explicitHeight():Number
        {
            return this._explicitHeight;
        }

        public override function set height(arg1:Number):void
        {
            if (this._explicitHeight === arg1) 
            {
                return;
            }
            if (!(arg1 === arg1) && !(this._explicitHeight === this._explicitHeight)) 
            {
                return;
            }
            this._explicitHeight = arg1;
            if (arg1 !== arg1) 
            {
                if (this.texture === null) 
                {
                    this.readjustSize();
                }
                else 
                {
                    this.scaleY = 1;
                    this.readjustSize(-1, this.texture.frameHeight);
                }
            }
            else 
            {
                super.height = arg1;
            }
            this.dispatchEventWith(starling.events.Event.RESIZE);
            return;
        }

        public function get explicitMinWidth():Number
        {
            return this._explicitMinWidth;
        }

        public function get minWidth():Number
        {
            if (this._explicitMinWidth === this._explicitMinWidth) 
            {
                return this._explicitMinWidth;
            }
            return 0;
        }

        public function set minWidth(arg1:Number):void
        {
            if (this._explicitMinWidth === arg1) 
            {
                return;
            }
            if (!(arg1 === arg1) && !(this._explicitMinWidth === this._explicitMinWidth)) 
            {
                return;
            }
            this._explicitMinWidth = arg1;
            this.dispatchEventWith(starling.events.Event.RESIZE);
            return;
        }

        public function get explicitMaxWidth():Number
        {
            return this._explicitMaxWidth;
        }

        public function get maxWidth():Number
        {
            return this._explicitMaxWidth;
        }

        public function set maxWidth(arg1:Number):void
        {
            if (this._explicitMaxWidth === arg1) 
            {
                return;
            }
            if (!(arg1 === arg1) && !(this._explicitMaxWidth === this._explicitMaxWidth)) 
            {
                return;
            }
            this._explicitMaxWidth = arg1;
            this.dispatchEventWith(starling.events.Event.RESIZE);
            return;
        }

        public function get explicitMinHeight():Number
        {
            return this._explicitMinHeight;
        }

        public function get minHeight():Number
        {
            if (this._explicitMinHeight === this._explicitMinHeight) 
            {
                return this._explicitMinHeight;
            }
            return 0;
        }

        public function set minHeight(arg1:Number):void
        {
            if (this._explicitMinHeight === arg1) 
            {
                return;
            }
            if (!(arg1 === arg1) && !(this._explicitMinHeight === this._explicitMinHeight)) 
            {
                return;
            }
            this._explicitMinHeight = arg1;
            this.dispatchEventWith(starling.events.Event.RESIZE);
            return;
        }

        public function get explicitMaxHeight():Number
        {
            return this._explicitMaxHeight;
        }

        public function get maxHeight():Number
        {
            return this._explicitMaxHeight;
        }

        protected var _defaultTexture:starling.textures.Texture;

        protected var _disabledTexture:starling.textures.Texture;

        protected var _selectedTexture:starling.textures.Texture;

        protected var _defaultColor:uint=4294967295;

        protected var _disabledColor:uint=4294967295;

        protected var _selectedColor:uint=4294967295;

        protected var _stateContext:feathers.core.IStateContext;

        protected var _explicitWidth:Number=NaN;

        protected var _explicitHeight:Number=NaN;

        protected var _explicitMinWidth:Number=NaN;

        protected var _explicitMinHeight:Number=NaN;

        protected var _stateToTexture:Object;

        protected var _stateToColor:Object;

        protected var _explicitMaxHeight:Number=Infinity;

        protected var _explicitMaxWidth:Number=Infinity;
    }
}


//  class StyleNameFunctionStyleProvider
package feathers.skins 
{
    import feathers.core.*;
    
    public class StyleNameFunctionStyleProvider extends Object implements feathers.skins.IStyleProvider
    {
        public function StyleNameFunctionStyleProvider(arg1:Function=null)
        {
            super();
            this._defaultStyleFunction = arg1;
            return;
        }

        public function get defaultStyleFunction():Function
        {
            return this._defaultStyleFunction;
        }

        public function set defaultStyleFunction(arg1:Function):void
        {
            this._defaultStyleFunction = arg1;
            return;
        }

        public function setFunctionForStyleName(arg1:String, arg2:Function):void
        {
            if (!this._styleNameMap) 
            {
                this._styleNameMap = {};
            }
            this._styleNameMap[arg1] = arg2;
            return;
        }

        public function applyStyles(arg1:feathers.core.IFeathersControl):void
        {
            var loc1:*=false;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            if (this._styleNameMap) 
            {
                loc1 = false;
                loc2 = arg1.styleNameList;
                loc3 = loc2.length;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    loc5 = loc2.item(loc4);
                    loc6 = this._styleNameMap[loc5] as Function;
                    if (loc6 != null) 
                    {
                        loc1 = true;
                        loc6(arg1);
                    }
                    ++loc4;
                }
                if (loc1) 
                {
                    return;
                }
            }
            if (this._defaultStyleFunction != null) 
            {
                this._defaultStyleFunction(arg1);
            }
            return;
        }

        protected var _defaultStyleFunction:Function;

        protected var _styleNameMap:Object;
    }
}


//  class StyleProviderRegistry
package feathers.skins 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    
    public class StyleProviderRegistry extends Object
    {
        public function StyleProviderRegistry(arg1:Boolean=true, arg2:Function=null)
        {
            this._classToStyleProvider = new flash.utils.Dictionary(true);
            super();
            this._registerGlobally = arg1;
            if (arg2 !== null) 
            {
                this._styleProviderFactory = arg2;
            }
            else 
            {
                this._styleProviderFactory = defaultStyleProviderFactory;
            }
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._classToStyleProvider;
            for (loc1 in loc4) 
            {
                loc2 = Class(loc1);
                this.clearStyleProvider(loc2);
            }
            this._classToStyleProvider = null;
            return;
        }

        public function hasStyleProvider(arg1:Class):Boolean
        {
            if (this._classToStyleProvider === null) 
            {
                return false;
            }
            return arg1 in this._classToStyleProvider;
        }

        public function getRegisteredClasses(arg1:__AS3__.vec.Vector.<Class>=null):__AS3__.vec.Vector.<Class>
        {
            var loc2:*=null;
            if (arg1 === null) 
            {
                arg1 = new Vector.<Class>(0);
            }
            else 
            {
                arg1.length = 0;
            }
            var loc1:*=0;
            var loc3:*=0;
            var loc4:*=this._classToStyleProvider;
            for (loc2 in loc4) 
            {
                arg1[loc1] = loc2 as Class;
                ++loc1;
            }
            return arg1;
        }

        public function getStyleProvider(arg1:Class):feathers.skins.IStyleProvider
        {
            this.validateComponentClass(arg1);
            var loc1:*=feathers.skins.IStyleProvider(this._classToStyleProvider[arg1]);
            if (!loc1) 
            {
                loc1 = this._styleProviderFactory();
                this._classToStyleProvider[arg1] = loc1;
                if (this._registerGlobally) 
                {
                    arg1[GLOBAL_STYLE_PROVIDER_PROPERTY_NAME] = loc1;
                }
            }
            return loc1;
        }

        public function clearStyleProvider(arg1:Class):feathers.skins.IStyleProvider
        {
            var loc1:*=null;
            this.validateComponentClass(arg1);
            if (arg1 in this._classToStyleProvider) 
            {
                loc1 = feathers.skins.IStyleProvider(this._classToStyleProvider[arg1]);
                delete this._classToStyleProvider[arg1];
                if (this._registerGlobally && arg1[GLOBAL_STYLE_PROVIDER_PROPERTY_NAME] === loc1) 
                {
                    arg1[GLOBAL_STYLE_PROVIDER_PROPERTY_NAME] = null;
                }
                return loc1;
            }
            return null;
        }

        protected function validateComponentClass(arg1:Class):void
        {
            if (!this._registerGlobally || Object(arg1).hasOwnProperty(GLOBAL_STYLE_PROVIDER_PROPERTY_NAME)) 
            {
                return;
            }
            throw ArgumentError("Class " + arg1 + " must have a " + GLOBAL_STYLE_PROVIDER_PROPERTY_NAME + " static property to support themes.");
        }

        protected static function defaultStyleProviderFactory():feathers.skins.IStyleProvider
        {
            return new feathers.skins.StyleNameFunctionStyleProvider();
        }

        protected static const GLOBAL_STYLE_PROVIDER_PROPERTY_NAME:String="globalStyleProvider";

        protected var _registerGlobally:Boolean;

        protected var _styleProviderFactory:Function;

        protected var _classToStyleProvider:flash.utils.Dictionary;
    }
}


