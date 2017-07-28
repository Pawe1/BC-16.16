//class IconButton
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


