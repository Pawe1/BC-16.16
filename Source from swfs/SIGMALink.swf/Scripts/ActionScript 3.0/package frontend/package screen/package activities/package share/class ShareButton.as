//class ShareButton
package frontend.screen.activities.share 
{
    import core.general.*;
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
    import frontend.components.menuList.editors.base.*;
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
    
    public class ShareButton extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function ShareButton()
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
            bindings = this._ShareButton_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_share_ShareButtonWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ShareButton[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.layout = this._ShareButton_AnchorLayout1_c();
            this.mxmlContent = [this._ShareButton_TextureImage1_i(), this._ShareButton_Label1_i(), this._ShareButton_OnOffToggleButton1_i(), this._ShareButton_TextureImage2_i(), this._ShareButton_LayoutGroup2_i()];
            this.addEventListener("initialize", this.___ShareButton_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get titleLabel():feathers.controls.Label
        {
            return this._1791483012titleLabel;
        }

        public function set titleLabel(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1791483012titleLabel;
            if (loc1 !== arg1) 
            {
                this._1791483012titleLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "titleLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get loading():Boolean
        {
            return this._336650556loading;
        }

        public function set loading(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._336650556loading;
            if (loc1 !== arg1) 
            {
                this._336650556loading = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "loading", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get selected():Boolean
        {
            return this._1191572123selected;
        }

        public function set selected(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1191572123selected;
            if (loc1 !== arg1) 
            {
                this._1191572123selected = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "selected", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function onShareOptionChange(arg1:Boolean):void
        {
            this.selected = arg1;
            return;
        }

        public function get shared():Boolean
        {
            return this._903566235shared;
        }

        public function set shared(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._903566235shared;
            if (loc1 !== arg1) 
            {
                this._903566235shared = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "shared", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get textureName():String
        {
            return this._1613545030textureName;
        }

        public function set textureName(arg1:String):void
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

        public function get title():String
        {
            return this._110371416title;
        }

        internal function onInit():void
        {
            var loc1:*=new starling.display.Quad(1, ROW_HEIGHT, core.general.Colors.LIGHTGREY);
            loc1.x = SIGMALink.appWidth - COL_SHARED_WIDTH;
            addChild(loc1);
            return;
        }

        public function set title(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._110371416title;
            if (loc1 !== arg1) 
            {
                this._110371416title = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "title", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function startLoading():void
        {
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTextureAtlas("loaderAnimation");
            if (loc1) 
            {
                this.movieClip = new starling.display.MovieClip(loc1.getTextures("frame_"), 30);
                this.movie.addChild(this.movieClip);
                this.movieClip.play();
                if (!starling.core.Starling.juggler.contains(this.movieClip)) 
                {
                    starling.core.Starling.juggler.add(this.movieClip);
                }
                this.movie.layoutData = new feathers.layout.AnchorLayoutData(NaN, (COL_SHARED_WIDTH - this.movieClip.width) / 2, NaN, NaN, NaN, 0);
                this.loading = true;
                this.shared = false;
            }
            return;
        }

        public function stopLoading():void
        {
            this.loading = false;
            this.selected = false;
            if (this.movieClip) 
            {
                this.movieClip.stop();
                if (starling.core.Starling.juggler.contains(this.movieClip)) 
                {
                    starling.core.Starling.juggler.remove(this.movieClip);
                }
            }
            this.movie.removeChildren();
            return;
        }

        protected function sharedIcon_creationCompleteHandler(arg1:starling.events.Event):void
        {
            this.sharedIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, (COL_SHARED_WIDTH - this.sharedIcon.width) / 2, NaN, NaN, NaN, 0);
            return;
        }

        public function showError(arg1:String):void
        {
            this.stopLoading();
            this.titleLabel.text = arg1;
            this.titleLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            this.shareOption.visible = false;
            return;
        }

        internal function _ShareButton_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ShareButton_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "icon";
            this.icon = loc1;
            feathers.binding.BindingManager.executeBindings(this, "icon", this.icon);
            return loc1;
        }

        internal function _ShareButton_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "titleLabel";
            this.titleLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "titleLabel", this.titleLabel);
            return loc1;
        }

        internal function _ShareButton_OnOffToggleButton1_i():frontend.components.menuList.editors.base.OnOffToggleButton
        {
            var loc1:*=new frontend.components.menuList.editors.base.OnOffToggleButton();
            loc1.id = "shareOption";
            this.shareOption = loc1;
            feathers.binding.BindingManager.executeBindings(this, "shareOption", this.shareOption);
            return loc1;
        }

        internal function _ShareButton_TextureImage2_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.addEventListener("creationComplete", this.__sharedIcon_creationComplete);
            loc1.id = "sharedIcon";
            this.sharedIcon = loc1;
            feathers.binding.BindingManager.executeBindings(this, "sharedIcon", this.sharedIcon);
            return loc1;
        }

        public function __sharedIcon_creationComplete(arg1:starling.events.Event):void
        {
            this.sharedIcon_creationCompleteHandler(arg1);
            return;
        }

        internal function _ShareButton_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "movie";
            this.movie = loc1;
            feathers.binding.BindingManager.executeBindings(this, "movie", this.movie);
            return loc1;
        }

        public function ___ShareButton_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal function _ShareButton_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return ROW_HEIGHT;
            }, null, "this.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, PADDING, NaN, 0);
            }, null, "icon.layoutData")
            result[4] = new feathers.binding.Binding(this, null, null, "icon.textureName", "textureName");
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, COL_ICON_WIDTH, NaN, 0);
            }, null, "titleLabel.layoutData")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth - COL_ICON_WIDTH - PADDING;
            }, null, "titleLabel.maxWidth")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "titleLabel.styleName")
            result[8] = new feathers.binding.Binding(this, null, null, "titleLabel.text", "title");
            result[9] = new feathers.binding.Binding(this, null, null, "shareOption.checked", "selected");
            result[10] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, COL_SHARED_WIDTH, NaN, NaN, NaN, 0);
            }, null, "shareOption.layoutData")
            result[11] = new feathers.binding.Binding(this, function ():Function
            {
                return onShareOptionChange;
            }, null, "shareOption.toggleChangedFunction")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.hakenicongreen;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "sharedIcon.textureName")
            result[13] = new feathers.binding.Binding(this, null, null, "sharedIcon.visible", "shared");
            result[14] = new feathers.binding.Binding(this, null, null, "movie.visible", "loading");
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            ShareButton._watcherSetupUtil = arg1;
            return;
        }

        public function get shareOption():frontend.components.menuList.editors.base.OnOffToggleButton
        {
            return this._53796556shareOption;
        }

        public function get icon():frontend.components.TextureImage
        {
            return this._3226745icon;
        }

        public function set icon(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3226745icon;
            if (loc1 !== arg1) 
            {
                this._3226745icon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "icon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get movie():feathers.controls.LayoutGroup
        {
            return this._104087344movie;
        }

        public function set movie(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._104087344movie;
            if (loc1 !== arg1) 
            {
                this._104087344movie = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "movie", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set shareOption(arg1:frontend.components.menuList.editors.base.OnOffToggleButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._53796556shareOption;
            if (loc1 !== arg1) 
            {
                this._53796556shareOption = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "shareOption", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get sharedIcon():frontend.components.TextureImage
        {
            return this._1784634754sharedIcon;
        }

        public function set sharedIcon(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1784634754sharedIcon;
            if (loc1 !== arg1) 
            {
                this._1784634754sharedIcon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "sharedIcon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static const COL_SHARED_WIDTH:Number=80 * SIGMALink.scaleFactor;

        public static const PADDING:Number=20 * SIGMALink.scaleFactor;

        public static const ROW_HEIGHT:Number=80 * SIGMALink.scaleFactor;

        internal static const COL_ICON_WIDTH:Number=100 * SIGMALink.scaleFactor;

        internal static const EDIT_GROUP_WIDTH:Number=75 * SIGMALink.scaleFactor;

        internal var _3226745icon:frontend.components.TextureImage;

        internal var _104087344movie:feathers.controls.LayoutGroup;

        internal var _53796556shareOption:frontend.components.menuList.editors.base.OnOffToggleButton;

        internal var _1784634754sharedIcon:frontend.components.TextureImage;

        internal var _1791483012titleLabel:feathers.controls.Label;

        internal var _336650556loading:Boolean=false;

        internal var _903566235shared:Boolean=false;

        internal var _1613545030textureName:String;

        internal var _110371416title:String;

        internal var _moving:Boolean=false;

        internal var movieClip:starling.display.MovieClip;

        internal var _1191572123selected:Boolean=false;

        mx_internal var _bindings:Array;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


