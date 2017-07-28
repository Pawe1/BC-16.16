//class TextureImage
package frontend.components 
{
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.utils.textures.*;
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
    import frontend.components.core.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class TextureImage extends frontend.components.core.TouchLayoutGroup implements feathers.binding.IBindingClient
    {
        public function TextureImage()
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
            bindings = this._TextureImage_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_components_TextureImageWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.components.TextureImage[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._TextureImage_ImageLoader1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get source():starling.textures.Texture
        {
            return this._source;
        }

        internal function set _896505829source(arg1:starling.textures.Texture):void
        {
            this._source = arg1;
            return;
        }

        public function get textureName():String
        {
            return this._textureName;
        }

        internal function set _1613545030textureName(arg1:String):void
        {
            this._textureName = arg1;
            this.source = frontend.AssetsManagerCustom.getInstance().getTexture(this.textureName);
            return;
        }

        internal function _TextureImage_ImageLoader1_i():feathers.controls.ImageLoader
        {
            var loc1:*=new feathers.controls.ImageLoader();
            loc1.id = "_TextureImage_ImageLoader1";
            this._TextureImage_ImageLoader1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_TextureImage_ImageLoader1", this._TextureImage_ImageLoader1);
            return loc1;
        }

        internal function _TextureImage_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, null, null, "_TextureImage_ImageLoader1.source", "source");
            result[1] = new feathers.binding.Binding(this, function ():feathers.utils.textures.TextureCache
            {
                return textureCache;
            }, null, "_TextureImage_ImageLoader1.textureCache")
            return result;
        }

        public function set source(arg1:starling.textures.Texture):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.source;
            if (loc1 !== arg1) 
            {
                this._896505829source = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "source", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set textureName(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.textureName;
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
            frontend.components.TextureImage._watcherSetupUtil = arg1;
            return;
        }

        internal static function get textureCache():feathers.utils.textures.TextureCache
        {
            return frontend.components.TextureImage._1529879769textureCache;
        }

        internal static function set textureCache(arg1:feathers.utils.textures.TextureCache):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.TextureImage._1529879769textureCache;
            if (loc1 !== arg1) 
            {
                frontend.components.TextureImage._1529879769textureCache = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "textureCache", loc1, arg1, frontend.components.TextureImage);
                loc3 = frontend.components.TextureImage.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _1529879769textureCache = new feathers.utils.textures.TextureCache();
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public var _TextureImage_ImageLoader1:feathers.controls.ImageLoader;

        public var data:Object;

        internal var _source:starling.textures.Texture;

        internal var _textureName:String="noimage";

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _1529879769textureCache:feathers.utils.textures.TextureCache;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


