//class SportIcon
package frontend.components 
{
    import core.sport.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
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
    
    public class SportIcon extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function SportIcon()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._1856528269_hLayout = new feathers.layout.HorizontalLayout();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._SportIcon_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_components_SportIconWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return SportIcon[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._SportIcon_TextureImage1_i()];
            this.addEventListener("initialize", this.___SportIcon_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get sportId():uint
        {
            return this._sportId;
        }

        public function set sportId(arg1:uint):void
        {
            this._sportId = arg1;
            var loc1:*=handler.SportHandler.getInstance().resolveSportById(arg1);
            if (loc1) 
            {
                this.color = loc1.color;
                this.textureName = frontend.Textures.sportTextureByKeyName(loc1.keyName);
            }
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            this._hLayout.padding = 2;
            return;
        }

        internal function _SportIcon_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=null;
            loc1 = new frontend.components.TextureImage();
            loc1.touchable = false;
            loc1.id = "_SportIcon_TextureImage1";
            this._SportIcon_TextureImage1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_SportIcon_TextureImage1", this._SportIcon_TextureImage1);
            return loc1;
        }

        public function ___SportIcon_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _SportIcon_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, color);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return _hLayout;
            }, null, "this.layout")
            result[2] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=textureName;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_SportIcon_TextureImage1.textureName")
            return result;
        }

        internal function get _hLayout():feathers.layout.HorizontalLayout
        {
            return this._1856528269_hLayout;
        }

        internal function set _hLayout(arg1:feathers.layout.HorizontalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1856528269_hLayout;
            if (loc1 !== arg1) 
            {
                this._1856528269_hLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_hLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get color():uint
        {
            return this._94842723color;
        }

        internal function set color(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._94842723color;
            if (loc1 !== arg1) 
            {
                this._94842723color = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "color", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get textureName():String
        {
            return this._1613545030textureName;
        }

        internal function set textureName(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1613545030textureName;
            if (loc1 !== arg1) 
            {
                this._1613545030textureName = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "textureName", loc1, arg1, this);
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
            SportIcon._watcherSetupUtil = arg1;
            return;
        }

        public var _SportIcon_TextureImage1:frontend.components.TextureImage;

        internal var _sportId:uint;

        internal var _1856528269_hLayout:feathers.layout.HorizontalLayout;

        internal var _94842723color:uint=15396337;

        internal var _1613545030textureName:String="noimage";

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


