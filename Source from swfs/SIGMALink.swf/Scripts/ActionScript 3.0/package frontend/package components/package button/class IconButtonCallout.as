//class IconButtonCallout
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


