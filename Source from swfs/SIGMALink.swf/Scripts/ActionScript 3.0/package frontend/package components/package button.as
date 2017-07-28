//package button
//  class DevicePictureButton
package frontend.components.button 
{
    import core.general.*;
    import debug.*;
    import frontend.*;
    
    public class DevicePictureButton extends frontend.components.button.IconButton
    {
        public function DevicePictureButton()
        {
            super();
            return;
        }

        public override function set image(arg1:String):void
        {
            debug.Debug.error("Image darf nicht von außen gesetzt werden!");
            throw new Error("Image darf nicht von außen gesetzt werden!");
        }

        public function get unitType():core.general.UnitType
        {
            return this._unitType;
        }

        public function set unitType(arg1:core.general.UnitType):void
        {
            this._unitType = arg1;
            var loc1:*=frontend.Textures.getUnitTexture(arg1);
            super.image = loc1;
            return;
        }

        internal var _unitType:core.general.UnitType;
    }
}


//  class IconButton
package frontend.components.button 
{
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.skins.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class IconButton extends feathers.controls.Button implements feathers.binding.IBindingClient
    {
        public function IconButton()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._IconButton_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_components_button_IconButtonWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return IconButton[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.touchGroup = true;
            this.addEventListener("initialize", this.___IconButton_Button1_initialize);
            this.addEventListener("touch", this.___IconButton_Button1_touch);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            IconButton._watcherSetupUtil = arg1;
            return;
        }

        public function get highlight():Boolean
        {
            return this._highlight;
        }

        public function set highlight(arg1:Boolean):void
        {
            this._highlight = arg1;
            if (this._highlight) 
            {
                downSkin = this.getDefaultDownSkin();
            }
            else 
            {
                downSkin = null;
            }
            return;
        }

        public static function get outerPadding():Number
        {
            return IconButton._138560278outerPadding;
        }

        public function get image():String
        {
            return this._image;
        }

        internal function set _100313435image(arg1:String):void
        {
            if (arg1 != this._image) 
            {
                this._image = arg1;
                if (!this._initialized) 
                {
                    return;
                }
                this.styleProvider = this.createCustomStyleProvider();
            }
            return;
        }

        public static function set outerPadding(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=IconButton._138560278outerPadding;
            if (loc1 !== arg1) 
            {
                IconButton._138560278outerPadding = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "outerPadding", loc1, arg1, IconButton);
                loc3 = IconButton.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get imageDisabled():String
        {
            return this._imageDisabled;
        }

        internal function set _1637203191imageDisabled(arg1:String):void
        {
            if (arg1 != this._imageDisabled) 
            {
                this._imageDisabled = arg1;
                if (!this._initialized) 
                {
                    return;
                }
                this.styleProvider = this.createCustomStyleProvider();
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _138560278outerPadding = 10 * SIGMALink.scaleFactor;
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal function createCustomStyleProvider():feathers.skins.IStyleProvider
        {
            styleProvider = null;
            return new feathers.skins.AddOnFunctionStyleProvider(styleProvider, this.setButtonStyles);
        }

        internal function setButtonStyles(arg1:feathers.controls.Button):void
        {
            if (this._imageDisabled == null || this._imageDisabled == "") 
            {
                this._imageDisabled = this._image;
            }
            arg1.defaultIcon = new starling.display.Image(frontend.AssetsManagerCustom.getInstance().getTexture(this.image));
            arg1.disabledIcon = new starling.display.Image(frontend.AssetsManagerCustom.getInstance().getTexture(this.imageDisabled));
            if (this._imageDisabled == this._image) 
            {
                arg1.disabledIcon.alpha = 0.4;
            }
            return;
        }

        internal function getDefaultButtonSkin():starling.display.DisplayObject
        {
            var loc1:*=new starling.display.Quad(1, 1);
            loc1.alpha = 0;
            return loc1;
        }

        internal function getDefaultDownSkin():starling.display.DisplayObject
        {
            var loc1:*=new starling.display.Quad(1, 1);
            loc1.alpha = 0.5;
            return loc1;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (!isEnabled) 
            {
                return;
            }
            if (this.touchHandler != null) 
            {
                this.touchHandler(arg1);
            }
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            this.styleProvider = this.createCustomStyleProvider();
            this._initialized = true;
            return;
        }

        public function ___IconButton_Button1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___IconButton_Button1_touch(arg1:starling.events.TouchEvent):void
        {
            this.onTouch(arg1);
            return;
        }

        internal function _IconButton_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return getDefaultButtonSkin();
            }, null, "this.defaultSkin")
            result[1] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return getDefaultDownSkin();
            }, null, "this.downSkin")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return outerPadding;
            }, null, "this.padding")
            result[3] = new feathers.binding.Binding(this, function ():feathers.skins.IStyleProvider
            {
                return createCustomStyleProvider();
            }, null, "this.styleProvider")
            return result;
        }

        public function set image(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.image;
            if (loc1 !== arg1) 
            {
                this._100313435image = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "image", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set imageDisabled(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.imageDisabled;
            if (loc1 !== arg1) 
            {
                this._1637203191imageDisabled = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "imageDisabled", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal var _highlight:Boolean=true;

        internal var _image:String;

        internal var _imageDisabled:String="";

        public var touchHandler:Function;

        internal var _initialized:Boolean=false;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        mx_internal var _watchers:Array;

        internal static var _138560278outerPadding:Number;
    }
}


//  class IconButtonCallout
package frontend.components.button 
{
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.*;
    import frontend.components.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class IconButtonCallout extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function IconButtonCallout()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._IconButtonCallout_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_components_button_IconButtonCalloutWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return IconButtonCallout[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._IconButtonCallout_LayoutGroup2_i(), this._IconButtonCallout_TextureImage1_i(), this._IconButtonCallout_Label1_i()];
            this.addEventListener("initialize", this.___IconButtonCallout_LayoutGroup1_initialize);
            this.addEventListener("removedFromStage", this.___IconButtonCallout_LayoutGroup1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _IconButtonCallout_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, 0, NaN);
            }, null, "this.layoutData")
            result[2] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.infoLayerArrow;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "calloutArrow.textureName")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_DARKLABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "calloutLabel.styleName")
            return result;
        }

        public function get calloutArrow():frontend.components.TextureImage
        {
            return this._30175673calloutArrow;
        }

        public function set calloutArrow(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._30175673calloutArrow;
            if (loc1 !== arg1) 
            {
                this._30175673calloutArrow = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "calloutArrow", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get calloutBackground():feathers.controls.LayoutGroup
        {
            return this._1780704638calloutBackground;
        }

        public function set calloutBackground(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1780704638calloutBackground;
            if (loc1 !== arg1) 
            {
                this._1780704638calloutBackground = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "calloutBackground", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get calloutText():String
        {
            return this._calloutText;
        }

        internal function set _1109905789calloutText(arg1:String):void
        {
            this._calloutText = arg1;
            flash.utils.clearTimeout(this.showTimeout);
            this.showTimeout = flash.utils.setTimeout(this.validateCalloutSize, 350);
            return;
        }

        public override function set visible(arg1:Boolean):void
        {
            if (arg1) 
            {
                flash.utils.clearTimeout(this.showTimeout);
                this.showTimeout = flash.utils.setTimeout(this.validateCalloutSize, 350);
            }
            else 
            {
                alpha = 0;
            }
            super.visible = arg1;
            return;
        }

        public function get calloutLabel():feathers.controls.Label
        {
            return this._39812260calloutLabel;
        }

        public function set calloutLabel(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._39812260calloutLabel;
            if (loc1 !== arg1) 
            {
                this._39812260calloutLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "calloutLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set calloutText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.calloutText;
            if (loc1 !== arg1) 
            {
                this._1109905789calloutText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "calloutText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            IconButtonCallout._watcherSetupUtil = arg1;
            return;
        }

        internal function onInit():void
        {
            alpha = 0;
            width = SIGMALink.appWidth;
            minHeight = 2 * this.PADDING;
            this._bg = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.infoLayerBackground);
            this._bgArrow = frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.infoLayerArrow);
            var loc1:*=new starling.display.Image(this._bg);
            loc1.scale9Grid = new flash.geom.Rectangle(this._bg.width / 2, this._bg.height / 2, 0, 0);
            this.calloutBackground.backgroundSkin = loc1;
            this.calloutBackground.layoutData = new feathers.layout.AnchorLayoutData(0, this.PADDING, this._bgArrow.height - 2 * SIGMALink.scaleFactor, this.PADDING);
            return;
        }

        internal function validateCalloutSize():void
        {
            var pt:flash.geom.Point;
            var ctween:starling.animation.Tween;

            var loc1:*;
            pt = null;
            ctween = null;
            if (handler.ViewHandler.getInstance().navigator.isTransitionActive) 
            {
                this.showTimeout = flash.utils.setTimeout(this.validateCalloutSize, 350);
                return;
            }
            this.calloutLabel.text = this.calloutText;
            this.calloutLabel.width = width - 2 * this.PADDING;
            this.calloutLabel.layoutData = new feathers.layout.AnchorLayoutData(this.PADDING, 2 * this.PADDING, this.PADDING + this._bgArrow.height, 2 * this.PADDING);
            this.calloutLabel.validate();
            height = this.calloutLabel.height + 2 * this.PADDING + this._bgArrow.height;
            if (this.anchor) 
            {
                this.anchor.validate();
                pt = this.anchor.localToGlobal(new flash.geom.Point(0, 0));
                this.calloutArrow.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, 1 * SIGMALink.scaleFactor, pt.x + this.anchor.width / 2 - this._bgArrow.width / 2);
                this.calloutArrow.validate();
                ctween = new starling.animation.Tween(this, 0.8, starling.animation.Transitions.EASE_IN_OUT);
                ctween.animate("alpha", 1);
                ctween.onComplete = function ():void
                {
                    starling.core.Starling.juggler.remove(ctween);
                    return;
                }
                starling.core.Starling.juggler.add(ctween);
            }
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            flash.utils.clearTimeout(this.showTimeout);
            return;
        }

        internal function _IconButtonCallout_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "calloutBackground";
            this.calloutBackground = loc1;
            feathers.binding.BindingManager.executeBindings(this, "calloutBackground", this.calloutBackground);
            return loc1;
        }

        internal function _IconButtonCallout_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "calloutArrow";
            this.calloutArrow = loc1;
            feathers.binding.BindingManager.executeBindings(this, "calloutArrow", this.calloutArrow);
            return loc1;
        }

        internal function _IconButtonCallout_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "calloutLabel";
            this.calloutLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "calloutLabel", this.calloutLabel);
            return loc1;
        }

        public function ___IconButtonCallout_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        public function ___IconButtonCallout_LayoutGroup1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal const PADDING:Number=17 * SIGMALink.scaleFactor;

        internal var _30175673calloutArrow:frontend.components.TextureImage;

        internal var _1780704638calloutBackground:feathers.controls.LayoutGroup;

        internal var _39812260calloutLabel:feathers.controls.Label;

        public var anchor:frontend.components.button.IconButton;

        internal var _calloutText:String="Info";

        internal var _bg:starling.textures.Texture;

        internal var _bgArrow:starling.textures.Texture;

        internal var showTimeout:uint=0;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class SharingAccountButton
package frontend.components.button 
{
    import feathers.controls.*;
    
    public class SharingAccountButton extends feathers.controls.LayoutGroup
    {
        public function SharingAccountButton()
        {
            super();
            return;
        }
    }
}


