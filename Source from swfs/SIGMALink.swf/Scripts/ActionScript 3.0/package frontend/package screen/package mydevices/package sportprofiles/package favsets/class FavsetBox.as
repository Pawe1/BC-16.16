//class FavsetBox
package frontend.screen.mydevices.sportprofiles.favsets 
{
    import core.general.*;
    import core.sportprofiles.*;
    import debug.*;
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
    import flash.events.*;
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
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class FavsetBox extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function FavsetBox()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._1933458470_customLayout = new feathers.layout.VerticalLayout();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._FavsetBox_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_favsets_FavsetBoxWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.mydevices.sportprofiles.favsets.FavsetBox[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._FavsetBox_TextureImage1_i(), this._FavsetBox_Label1_i()];
            this.addEventListener("initialize", this.___FavsetBox_LayoutGroup1_initialize);
            this.addEventListener("resize", this.___FavsetBox_LayoutGroup1_resize);
            this.addEventListener("touch", this.___FavsetBox_LayoutGroup1_touch);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function checkDefaultFunctions():void
        {
            if (this.position <= 0) 
            {
                return;
            }
            if (this.defaultFunction <= 0) 
            {
                return;
            }
            if (this.defaultFunctions == null) 
            {
                return;
            }
            this.defaultFunctions[this.position] = this.defaultFunction;
            return;
        }

        protected function onResize(arg1:starling.events.Event):void
        {
            this._labelMaxWidth = this.width;
            return;
        }

        protected function onFavsetBoxTouched(arg1:starling.events.TouchEvent):void
        {
            this.touchHandler(arg1);
            if (!this.editable || !handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            debug.Debug.debug("[onFavsetBoxTouched]");
            if (this.touchFunction != null) 
            {
                this.touchFunction(this);
            }
            return;
        }

        internal function _FavsetBox_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "_FavsetBox_TextureImage1";
            this._FavsetBox_TextureImage1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavsetBox_TextureImage1", this._FavsetBox_TextureImage1);
            return loc1;
        }

        public function get currentState():String
        {
            return this._currentState;
        }

        public function set currentState(arg1:String):void
        {
            if (this._currentState == arg1) 
            {
                return;
            }
            this._currentState = arg1;
            this.invalidate(INVALIDATION_FLAG_STATE);
            return;
        }

        internal function _FavsetBox_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_FavsetBox_Label1";
            this._FavsetBox_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_FavsetBox_Label1", this._FavsetBox_Label1);
            return loc1;
        }

        public function get defaultFunction():uint
        {
            return this._defaultFunction;
        }

        public function set defaultFunction(arg1:uint):void
        {
            this._defaultFunction = arg1;
            this.checkDefaultFunctions();
            return;
        }

        public function ___FavsetBox_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInitialize(arg1);
            return;
        }

        public function get defaultFunctions():Array
        {
            return this._defaultFunctions;
        }

        public function set defaultFunctions(arg1:Array):void
        {
            this._defaultFunctions = arg1;
            this.checkDefaultFunctions();
            return;
        }

        public function ___FavsetBox_LayoutGroup1_resize(arg1:starling.events.Event):void
        {
            this.onResize(arg1);
            return;
        }

        public function get editable():Boolean
        {
            return this._editable;
        }

        internal function set _1602416228editable(arg1:Boolean):void
        {
            this._editable = arg1;
            return;
        }

        public function ___FavsetBox_LayoutGroup1_touch(arg1:starling.events.TouchEvent):void
        {
            this.onFavsetBoxTouched(arg1);
            return;
        }

        public function get favFunctionList():core.sportprofiles.FavFunctionList
        {
            return this._favFunctionList;
        }

        public function set favFunctionList(arg1:core.sportprofiles.FavFunctionList):void
        {
            if (this._favFunctionList != null) 
            {
                this._favFunctionList.removeEventListener(core.sportprofiles.FavFunctionList.EVENT_FAVFUNCTIONLIST_CHANGED, this.onFavFunctionListChanged);
            }
            this._favFunctionList = arg1;
            this._favFunctionList.addEventListener(core.sportprofiles.FavFunctionList.EVENT_FAVFUNCTIONLIST_CHANGED, this.onFavFunctionListChanged);
            this.checkLabel();
            return;
        }

        public override function set height(arg1:Number):void
        {
            if (arg1 > 0) 
            {
                super.height = arg1;
            }
            return;
        }

        internal function _FavsetBox_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return STATE_UP_BACKGROUND_SKIN;
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            result[2] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 100);
            }, null, "this.layoutData")
            result[3] = new feathers.binding.Binding(this, null, null, "this.touchable", "editable");
            result[4] = new feathers.binding.Binding(this, null, null, "_FavsetBox_TextureImage1.includeInLayout", "editable");
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(2, 2, NaN, NaN, NaN, NaN);
            }, null, "_FavsetBox_TextureImage1.layoutData")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.linkiconsmall;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_FavsetBox_TextureImage1.textureName")
            result[7] = new feathers.binding.Binding(this, null, null, "_FavsetBox_TextureImage1.visible", "editable");
            result[8] = new feathers.binding.Binding(this, null, null, "_FavsetBox_Label1.includeInLayout", "showLabel");
            result[9] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            }, null, "_FavsetBox_Label1.layoutData")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return _labelMaxWidth;
            }, null, "_FavsetBox_Label1.maxWidth")
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_NORMAL_RED;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_FavsetBox_Label1.styleName")
            result[12] = new feathers.binding.Binding(this, null, null, "_FavsetBox_Label1.text", "label");
            result[13] = new feathers.binding.Binding(this, null, null, "_FavsetBox_Label1.visible", "showLabel");
            return result;
        }

        internal function set _customLayout(arg1:feathers.layout.VerticalLayout):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1933458470_customLayout;
            if (loc1 !== arg1) 
            {
                this._1933458470_customLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_customLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set percentageHeight(arg1:uint):void
        {
            this._percentageHeight = arg1;
            this.refreshCustomLayoutData();
            return;
        }

        public function set editable(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.editable;
            if (loc1 !== arg1) 
            {
                this._1602416228editable = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "editable", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set percentageWidth(arg1:uint):void
        {
            this._percentageWidth = arg1;
            this.refreshCustomLayoutData();
            return;
        }

        internal function get _labelMaxWidth():uint
        {
            return this._1677776855_labelMaxWidth;
        }

        public function get position():uint
        {
            return this._position;
        }

        public function set position(arg1:uint):void
        {
            this._position = arg1;
            this.checkLabel();
            this.checkDefaultFunctions();
            return;
        }

        internal function set _labelMaxWidth(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1677776855_labelMaxWidth;
            if (loc1 !== arg1) 
            {
                this._1677776855_labelMaxWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_labelMaxWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get label():String
        {
            return this._102727412label;
        }

        public function set label(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._102727412label;
            if (loc1 !== arg1) 
            {
                this._102727412label = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "label", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set useHorizontalLayout(arg1:Boolean):void
        {
            this._useHorizontalLayout = arg1;
            if (this._useHorizontalLayout && !(layoutData is feathers.layout.HorizontalLayoutData)) 
            {
                layoutData = new feathers.layout.HorizontalLayoutData(this._percentageWidth, this._percentageHeight);
            }
            else if (!this._useHorizontalLayout && !(layoutData is feathers.layout.VerticalLayoutData)) 
            {
                layoutData = new feathers.layout.VerticalLayoutData(this._percentageWidth, this._percentageHeight);
            }
            return;
        }

        internal function get _customLayout():feathers.layout.VerticalLayout
        {
            return this._1933458470_customLayout;
        }

        public function get showLabel():Boolean
        {
            return this._1921447433showLabel;
        }

        public function set showLabel(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1921447433showLabel;
            if (loc1 !== arg1) 
            {
                this._1921447433showLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "showLabel", loc1, arg1, this);
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
            frontend.screen.mydevices.sportprofiles.favsets.FavsetBox._watcherSetupUtil = arg1;
            return;
        }

        internal function touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (!this.isEnabled) 
            {
                this.touchID = -1;
                this.currentState = STATE_UP;
                return;
            }
            if (this.touchID >= 0) 
            {
                loc1 = arg1.getTouch(this, null, this.touchID);
                if (!loc1) 
                {
                    return;
                }
                if (loc1.phase == starling.events.TouchPhase.ENDED) 
                {
                    this.currentState = STATE_UP;
                    this.touchID = -1;
                    this.backgroundSkin = this.STATE_UP_BACKGROUND_SKIN;
                }
                return;
            }
            loc1 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
            if (loc1) 
            {
                this.currentState = STATE_DOWN;
                this.touchID = loc1.id;
                this.backgroundSkin = this.STATE_DOWN_BACKGROUND_SKIN;
                return;
            }
            loc1 = arg1.getTouch(this, starling.events.TouchPhase.HOVER);
            if (loc1) 
            {
                this.currentState = STATE_HOVER;
                return;
            }
            this.currentState = STATE_UP;
            return;
        }

        protected function onInitialize(arg1:starling.events.Event):void
        {
            if (layout is feathers.layout.VerticalLayout) 
            {
                (layout as feathers.layout.VerticalLayout).verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
                (layout as feathers.layout.VerticalLayout).horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            }
            else if (layout is feathers.layout.HorizontalLayout) 
            {
                (layout as feathers.layout.HorizontalLayout).verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
                (layout as feathers.layout.HorizontalLayout).horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            }
            else if (!(layout is feathers.layout.AnchorLayout)) 
            {
            };
            this.refreshCustomLayoutData();
            return;
        }

        internal function refreshCustomLayoutData():void
        {
            if (this._useHorizontalLayout && (!((layoutData as feathers.layout.HorizontalLayoutData).percentHeight == this._percentageHeight) || !((layoutData as feathers.layout.HorizontalLayoutData).percentWidth == this._percentageWidth))) 
            {
                (layoutData as feathers.layout.HorizontalLayoutData).percentHeight = this._percentageHeight;
                (layoutData as feathers.layout.HorizontalLayoutData).percentWidth = this._percentageWidth;
            }
            else if (!this._useHorizontalLayout && (!((layoutData as feathers.layout.VerticalLayoutData).percentHeight == this._percentageHeight) || !((layoutData as feathers.layout.VerticalLayoutData).percentWidth == this._percentageWidth))) 
            {
                (layoutData as feathers.layout.VerticalLayoutData).percentHeight = this._percentageHeight;
                (layoutData as feathers.layout.VerticalLayoutData).percentWidth = this._percentageWidth;
            }
            return;
        }

        internal function onFavFunctionListChanged(arg1:flash.events.Event):void
        {
            this.checkLabel();
            return;
        }

        internal function checkLabel():void
        {
            if (this.position <= 0) 
            {
                return;
            }
            if (this.favFunctionList == null) 
            {
                return;
            }
            var loc1:*=this.favFunctionList.getFavFunctionlistItem((this.position - 1));
            if (loc1 == null) 
            {
                return;
            }
            if (!(this.favFunctionListItem == null) && loc1.favFuncId == this.favFunctionListItem.favFuncId) 
            {
                return;
            }
            this.favFunctionListItem = loc1;
            if (this.favFunctionListItem != null) 
            {
                this.label = utils.LanguageManager.getString("SPORTPROFILE_FUNCTION_" + this.favFunctionListItem.favFuncId);
            }
            return;
        }

        internal const STATE_DOWN_BACKGROUND_SKIN:starling.display.Quad=new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);

        internal const STATE_UP_BACKGROUND_SKIN:starling.display.Quad=new starling.display.Quad(1, 1, core.general.Colors.WHITE);

        public static const BOX_FORMAT_BIG:uint=core.sportprofiles.SportprofileFavFunctionObject.ALLOWED_BOX_FORMAT_BIG;

        public static const BOX_FORMAT_SMALL:uint=core.sportprofiles.SportprofileFavFunctionObject.ALLOWED_BOX_FORMAT_SMALL;

        public static const STATE_DOWN:String="down";

        public static const STATE_HOVER:String="hover";

        public static const STATE_UP:String="up";

        public var _FavsetBox_Label1:feathers.controls.Label;

        public var _FavsetBox_TextureImage1:frontend.components.TextureImage;

        public var boxFormat:uint=10;

        internal var _currentState:String="up";

        internal var _defaultFunction:uint=1;

        internal var _defaultFunctions:Array;

        internal var _editable:Boolean=false;

        internal var _favFunctionList:core.sportprofiles.FavFunctionList;

        internal var _102727412label:String="";

        internal var _percentageHeight:uint=100;

        internal var _percentageWidth:uint=100;

        internal var _position:uint=0;

        internal var _1921447433showLabel:Boolean=true;

        public var touchFunction:Function;

        internal var _useHorizontalLayout:Boolean=false;

        protected var touchID:int=-1;

        internal var _1933458470_customLayout:feathers.layout.VerticalLayout;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var _1677776855_labelMaxWidth:uint=400;

        mx_internal var _watchers:Array;

        mx_internal var _bindings:Array;

        internal var favFunctionListItem:core.sportprofiles.FavFunctionlistItem;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


