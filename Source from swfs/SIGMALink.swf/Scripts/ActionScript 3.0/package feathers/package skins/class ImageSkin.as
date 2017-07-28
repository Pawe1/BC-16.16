//class ImageSkin
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


