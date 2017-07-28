//class MenuListHeadline
package frontend.components.menuList 
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
    import frontend.components.core.*;
    import helper.*;
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
    
    public class MenuListHeadline extends frontend.components.core.TouchLayoutGroup implements feathers.binding.IBindingClient
    {
        public function MenuListHeadline()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._2146088563itemWidth = SIGMALink.appWidth;
            this._806339567padding = 20 * SIGMALink.scaleFactor;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._MenuListHeadline_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_components_menuList_MenuListHeadlineWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.components.menuList.MenuListHeadline[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.layout = this._MenuListHeadline_HorizontalLayout1_i();
            this.mxmlContent = [this._MenuListHeadline_LayoutGroup1_i(), this._MenuListHeadline_Label1_i()];
            this.addEventListener("initialize", this.___MenuListHeadline_TouchLayoutGroup1_initialize);
            this.addEventListener("triggered", this.___MenuListHeadline_TouchLayoutGroup1_triggered);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set leftLabel(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1723849517leftLabel;
            if (loc1 !== arg1) 
            {
                this._1723849517leftLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "leftLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get displayText():Boolean
        {
            return this._1714331919displayText;
        }

        public function set displayText(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1714331919displayText;
            if (loc1 !== arg1) 
            {
                this._1714331919displayText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "displayText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get itemWidth():Number
        {
            return this._2146088563itemWidth;
        }

        public function set itemWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2146088563itemWidth;
            if (loc1 !== arg1) 
            {
                this._2146088563itemWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "itemWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function set _3556653text(arg1:String):void
        {
            if (this._text != arg1) 
            {
                this._text = arg1;
                if (this._initialized) 
                {
                    this._leftLabelText = this.useLocalesForText ? utils.LanguageManager.getString(arg1) : arg1;
                }
            }
            return;
        }

        public function get padding():Number
        {
            return this._806339567padding;
        }

        public function set padding(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._806339567padding;
            if (loc1 !== arg1) 
            {
                this._806339567padding = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "padding", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get showArrow():Boolean
        {
            return this._1931084020showArrow;
        }

        public function set showArrow(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1931084020showArrow;
            if (loc1 !== arg1) 
            {
                this._1931084020showArrow = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "showArrow", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.text;
            if (loc1 !== arg1) 
            {
                this._3556653text = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "text", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set useLocalesForText(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.useLocalesForText;
            if (loc1 !== arg1) 
            {
                this._173316252useLocalesForText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "useLocalesForText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get useLocalesForText():Boolean
        {
            return this._useLocalesForText;
        }

        internal function set _173316252useLocalesForText(arg1:Boolean):void
        {
            if (this._useLocalesForText != arg1) 
            {
                this._useLocalesForText = arg1;
                if (this._initialized) 
                {
                    this._leftLabelText = this._useLocalesForText ? utils.LanguageManager.getString(this.text) : this.text;
                }
            }
            return;
        }

        internal function get _leftLabelText():String
        {
            return this._783677445_leftLabelText;
        }

        internal function set _leftLabelText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._783677445_leftLabelText;
            if (loc1 !== arg1) 
            {
                this._783677445_leftLabelText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_leftLabelText", loc1, arg1, this);
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
            frontend.components.menuList.MenuListHeadline._watcherSetupUtil = arg1;
            return;
        }

        public function validateSizesAndPositions():void
        {
            this.leftLabel.maxWidth = this.itemWidth - this.padding;
            this.leftLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, this.showArrow ? this.ICON_GROUP_WIDTH + 2 * this.padding : this.padding, NaN, 0);
            this.leftLabel.validate();
            return;
        }

        protected function touchlayoutgroup1_triggeredHandler(arg1:starling.events.Event):void
        {
            if (this.clickFunction != null) 
            {
                this.clickFunction();
            }
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            this._leftLabelText = this._useLocalesForText ? utils.LanguageManager.getString(this.text) : this.text;
            this._initialized = true;
            this.validateSizesAndPositions();
            return;
        }

        internal function _MenuListHeadline_HorizontalLayout1_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.horizontalAlign = "left";
            this._MenuListHeadline_HorizontalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MenuListHeadline_HorizontalLayout1", this._MenuListHeadline_HorizontalLayout1);
            return loc1;
        }

        internal function _MenuListHeadline_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._MenuListHeadline_ImageLoader1_i()];
            loc1.id = "iconGroup";
            this.iconGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "iconGroup", this.iconGroup);
            return loc1;
        }

        internal function _MenuListHeadline_ImageLoader1_i():feathers.controls.ImageLoader
        {
            var loc1:*=new feathers.controls.ImageLoader();
            loc1.horizontalAlign = "center";
            loc1.verticalAlign = "middle";
            loc1.id = "_MenuListHeadline_ImageLoader1";
            this._MenuListHeadline_ImageLoader1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MenuListHeadline_ImageLoader1", this._MenuListHeadline_ImageLoader1);
            return loc1;
        }

        internal function _MenuListHeadline_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "leftLabel";
            this.leftLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "leftLabel", this.leftLabel);
            return loc1;
        }

        public function ___MenuListHeadline_TouchLayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___MenuListHeadline_TouchLayoutGroup1_triggered(arg1:starling.events.Event):void
        {
            this.touchlayoutgroup1_triggeredHandler(arg1);
            return;
        }

        internal function _MenuListHeadline_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.HEADLINE_HEIGHT;
            }, null, "this.height")
            result[2] = new feathers.binding.Binding(this, null, null, "_MenuListHeadline_HorizontalLayout1.gap", "padding");
            result[3] = new feathers.binding.Binding(this, null, null, "_MenuListHeadline_HorizontalLayout1.padding", "padding");
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MenuListHeadline_HorizontalLayout1.verticalAlign")
            result[5] = new feathers.binding.Binding(this, null, null, "iconGroup.includeInLayout", "showArrow");
            result[6] = new feathers.binding.Binding(this, null, null, "iconGroup.visible", "showArrow");
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return ICON_GROUP_WIDTH;
            }, null, "iconGroup.width")
            result[8] = new feathers.binding.Binding(this, function ():Number
            {
                return helper.Math_helper.deg2rad(180);
            }, null, "_MenuListHeadline_ImageLoader1.rotation")
            result[9] = new feathers.binding.Binding(this, function ():Object
            {
                return frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.kleinerpfeil);
            }, null, "_MenuListHeadline_ImageLoader1.source")
            result[10] = new feathers.binding.Binding(this, null, null, "leftLabel.includeInLayout", "displayText");
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_ITALIC;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "leftLabel.styleName")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_leftLabelText;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "leftLabel.text")
            result[13] = new feathers.binding.Binding(this, null, null, "leftLabel.visible", "displayText");
            return result;
        }

        public function get iconGroup():feathers.controls.LayoutGroup
        {
            return this._1412649594iconGroup;
        }

        public function set iconGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1412649594iconGroup;
            if (loc1 !== arg1) 
            {
                this._1412649594iconGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get leftLabel():feathers.controls.Label
        {
            return this._1723849517leftLabel;
        }

        internal const ICON_GROUP_WIDTH:Number=50 * SIGMALink.scaleFactor;

        public var _MenuListHeadline_HorizontalLayout1:feathers.layout.HorizontalLayout;

        public var _MenuListHeadline_ImageLoader1:feathers.controls.ImageLoader;

        internal var _1412649594iconGroup:feathers.controls.LayoutGroup;

        internal var _1723849517leftLabel:feathers.controls.Label;

        public var clickFunction:Function;

        internal var _2146088563itemWidth:Number;

        internal var _806339567padding:Number;

        internal var _1931084020showArrow:Boolean=false;

        internal var _text:String="";

        internal var _1714331919displayText:Boolean=true;

        internal var _useLocalesForText:Boolean=true;

        internal var _initialized:Boolean=false;

        internal var _783677445_leftLabelText:String="";

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


