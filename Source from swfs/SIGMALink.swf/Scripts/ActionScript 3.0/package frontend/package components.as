//package components
//  package button
//    class DevicePictureButton
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


//    class IconButton
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


//    class IconButtonCallout
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


//    class SharingAccountButton
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


//  package charts
//    class ColumnChartItem
package frontend.components.charts 
{
    public class ColumnChartItem extends Object
    {
        public function ColumnChartItem()
        {
            this.activityGUIDs = [];
            this.yValues = [];
            this.yValuesFormat = [];
            super();
            return;
        }

        public var activityGUIDs:Array;

        public var color:uint=13046322;

        public var date:Date;

        public var label:String="";

        public var sortField:String="";

        public var xValue:String="";

        public var ySum:Number=0;

        public var yValues:Array;

        public var yValuesFormat:Array;
    }
}


//    class ColumnChartItemProps
package frontend.components.charts 
{
    public class ColumnChartItemProps extends Object
    {
        public function ColumnChartItemProps()
        {
            super();
            return;
        }

        public static const SORT_FIELD_PROPERTY:String="sportsIndex";

        public var color:uint;

        public var sportId:int;

        public var sportsIndex:int;

        public var value:Number;
    }
}


//    class ColumnChartList
package frontend.components.charts 
{
    import __AS3__.vec.*;
    import core.general.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.events.*;
    import flash.utils.*;
    import frontend.screen.statistic.tabs.*;
    import handler.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import utils.sort.*;
    
    public class ColumnChartList extends feathers.controls.LayoutGroup
    {
        public function ColumnChartList()
        {
            this.bgGroup = new feathers.controls.LayoutGroup();
            this.labelGroup = new feathers.controls.LayoutGroup();
            this.shapesGroup = new feathers.controls.LayoutGroup();
            super();
            layoutData = new feathers.layout.AnchorLayoutData(HEADER_HEIGHT);
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }

        internal function drawBackground():void
        {
            var loc1:*=0;
            var loc2:*=null;
            debug.Debug.debug("drawBackground - " + this.item.title + ", " + this.item.type);
            if (this.rtBg) 
            {
                this.rtBg.clear();
            }
            else 
            {
                this.rtBg = new frontend.components.charts.CustomRenderTexture(width, height);
            }
            loc2 = new starling.display.Quad(width, FOOTER_LINES_HEIGHT, core.general.Colors.DARKGREY);
            loc2.x = 0;
            loc2.y = int(this._columnMaxHeight);
            this.rtBg.draw(loc2, null, 1, 3);
            loc1 = 1;
            while (loc1 <= this._gridLines) 
            {
                loc2 = new starling.display.Quad(width, COLUMN_BOTTOM_LINE_HEIGHT, core.general.Colors.LIGHTGREY);
                loc2.x = 0;
                loc2.y = int(this._columnMaxHeight - loc1 * this._gridGap);
                this.rtBg.draw(loc2, null, 1, 3);
                loc2.dispose();
                ++loc1;
            }
            this.disposeChildren(this.bgGroup);
            this.bgGroup.addChild(new starling.display.Image(this.rtBg));
            return;
        }

        internal function validateShapes():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=null;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=null;
            var loc12:*=NaN;
            var loc13:*=NaN;
            var loc14:*=null;
            var loc16:*=false;
            var loc18:*=false;
            var loc19:*=null;
            debug.Debug.debug("validateShapes - " + this.item.title + ", " + this.item.type);
            var loc2:*=this.item.dataProvider.length;
            var loc5:*=0;
            var loc15:*=TWEEN_DURATION > 0;
            var loc17:*=0;
            this.shapes = new Vector.<Array>();
            if (this.rtLabels) 
            {
                this.rtLabels.clear();
            }
            else 
            {
                this.rtLabels = new frontend.components.charts.CustomRenderTexture(width, height);
            }
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc5 = loc1 * (this._columnWidth + COLUMN_H_GAP);
                loc3 = this.item.dataProvider.getItemAt(loc1) as frontend.components.charts.ColumnChartItem;
                loc7 = loc3.yValues.length;
                loc9 = this._columnMaxHeight;
                loc10 = this._columnPaddingSide;
                loc3.yValues.sort(sortOnSortField);
                loc16 = this.dropLabels ? (loc1 + 1) % (DROP_LABELS_MINIMUM + 1) == 0 : true;
                if (loc7 == 0 || this.item.hidden) 
                {
                    loc4 = new frontend.screen.statistic.tabs.CustomShape();
                    loc4.showLabel = loc16;
                    loc4.color = 16777215;
                    loc4.xFrom = loc10;
                    loc4.yFrom = this._columnMaxHeight;
                    loc4.widthFrom = this._columnQuadWidth;
                    loc4.heightFrom = 0.1;
                    loc4.label = loc3.label;
                    loc4.heightTo = 0.1;
                    loc4.yTo = this._columnMaxHeight;
                    this.shapes.push([loc4]);
                }
                else 
                {
                    loc19 = [];
                    loc6 = 0;
                    while (loc6 < loc7) 
                    {
                        loc14 = loc3.yValues[loc6] as frontend.components.charts.ColumnChartItemProps;
                        if (loc14.value != 0) 
                        {
                            loc12 = loc14.value * this._columnQuadHeightFactor;
                            loc13 = loc9 - loc12;
                            loc4 = new frontend.screen.statistic.tabs.CustomShape();
                            loc4.chartItem = loc3;
                            loc4.showLabel = loc16;
                            loc4.color = loc14.color;
                            loc4.xFrom = loc10;
                            loc4.yFrom = this._columnMaxHeight;
                            loc4.widthFrom = this._columnQuadWidth;
                            loc4.heightFrom = 0.1;
                            loc4.label = loc3.label;
                            loc4.heightTo = loc12;
                            loc4.yTo = loc13;
                            loc19.push(loc4);
                            loc9 = loc13;
                        }
                        ++loc6;
                    }
                    this.shapes.push(loc19);
                }
                loc18 = true;
                if (this.dropLabels) 
                {
                    loc18 = (loc1 + 1) % (DROP_LABELS_MINIMUM + 1) == 0;
                }
                if (loc18) 
                {
                    loc11 = new feathers.controls.Label();
                    loc11.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
                    loc11.text = loc3.label;
                    loc11.wordWrap = false;
                    loc11.validate();
                    loc11.x = loc5 + (this._columnWidth - loc11.width >> 1);
                    loc11.y = this._columnMaxHeight + COLUMN_BOTTOM_LINE_HEIGHT + (FOOTER_HEIGHT - loc11.height >> 1);
                    if (loc11.x < 0 && this.dropLabels) 
                    {
                        loc11.x = 0;
                    }
                    if (loc1 == (loc2 - 1) && this.dropLabels) 
                    {
                        loc11.x = loc5 + this._columnWidth - loc11.width;
                    }
                    if (loc11.x > loc17) 
                    {
                        this.rtLabels.draw(loc11, null, 1, 2);
                        loc17 = loc11.x + loc11.width;
                        loc11.dispose();
                    }
                }
                ++loc1;
            }
            this.disposeChildren(this.labelGroup);
            this.labelGroup.addChild(new starling.display.Image(this.rtLabels));
            return;
        }

        public function validateItem():void
        {
            this._columnWidth = width / this.item.dataProvider.length - COLUMN_H_GAP;
            this._columnMaxHeight = this.parentHeight - HEADER_HEIGHT - FOOTER_HEIGHT;
            this._columnPaddingSide = COLUMN_PADDING >> 1;
            this._columnQuadWidth = this._columnWidth - COLUMN_PADDING;
            this._columnQuadHeightFactor = this._columnMaxHeight / this.item.yMax;
            this._gridLines = Math.floor(this.item.yMax / this.item.yInterval);
            this._gridGap = this._columnMaxHeight / this._gridLines;
            this.drawBackground();
            this.validateShapes();
            this.drawWithQuads();
            return;
        }

        internal function onRemovedFromStage(arg1:starling.events.Event):void
        {
            if (this.item) 
            {
                this.item.dataChanged = true;
            }
            if (this.shapesGroup) 
            {
                this.shapesGroup.removeEventListener(starling.events.TouchEvent.TOUCH, this.onShapesGroupTouch);
            }
            return;
        }

        internal function disposeChildren(arg1:feathers.controls.LayoutGroup):void
        {
            var loc1:*=0;
            var loc3:*=null;
            debug.Debug.debug("disposeChilden");
            var loc2:*=arg1.numChildren;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = arg1.getChildAt(loc1);
                loc3.dispose();
                ++loc1;
            }
            arg1.removeChildren();
            return;
        }

        internal function onShapesGroupTouch(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=arg1.target as starling.display.Image;
            if (loc1) 
            {
                loc2 = arg1.getTouch(loc1);
                loc3 = loc2.globalX;
                loc4 = loc2.globalY;
                var loc8:*=0;
                var loc9:*=this.calloutInfo;
                for (loc5 in loc9) 
                {
                    loc6 = this.calloutInfo[loc5];
                    if (!(loc3 >= int(loc5) && loc3 <= int(loc5) + this._columnWidth)) 
                    {
                        continue;
                    }
                    debug.Debug.debug("treffer");
                    this._calloutAnchor.x = int(loc5) + this._columnWidth / 2;
                    this._calloutAnchor.y = this._columnMaxHeight - this.calloutInfoY[loc5];
                    loc7 = new frontend.components.charts.StatisticColumnChartCallout();
                    loc7.applyitem(loc6);
                    feathers.controls.Callout.show(loc7, this._calloutAnchor, null, false, this.calloutFactory);
                    return;
                }
            }
            return;
        }

        internal function calloutFactory():feathers.controls.Callout
        {
            var loc1:*=new feathers.controls.Callout();
            loc1.closeOnTouchBeganOutside = true;
            return loc1;
        }

        internal function onAddedToStage(arg1:starling.events.Event):void
        {
            height = this.parentHeight;
            width = SIGMALink.appWidth;
            COLUMN_H_GAP = 0.5 * SIGMALink.scaleFactor;
            this.bgGroup.width = width;
            this.bgGroup.height = height;
            addChild(this.bgGroup);
            this.labelGroup.width = width;
            this.labelGroup.height = height;
            addChild(this.labelGroup);
            this.shapesGroup.width = width;
            this.shapesGroup.height = height;
            this.shapesGroup.addEventListener(starling.events.TouchEvent.TOUCH, this.onShapesGroupTouch);
            addChild(this.shapesGroup);
            this._calloutAnchor = new feathers.controls.LayoutGroup();
            this._calloutAnchor.width = 1;
            this._calloutAnchor.height = 1;
            addChild(this._calloutAnchor);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (this.labelGroup) 
            {
                this.disposeChildren(this.labelGroup);
            }
            if (this.bgGroup) 
            {
                this.disposeChildren(this.bgGroup);
            }
            if (this.shapesGroup) 
            {
                this.shapesGroup.removeEventListener(starling.events.TouchEvent.TOUCH, this.onShapesGroupTouch);
                this.disposeChildren(this.shapesGroup);
            }
            if (this.rtBg) 
            {
                this.rtBg.dispose();
                this.rtBg = null;
            }
            if (this.rtLabels) 
            {
                this.rtLabels.dispose();
                this.rtLabels = null;
            }
            if (this.rtShapes) 
            {
                this.rtShapes.dispose();
                this.rtShapes = null;
            }
            if (this._calloutAnchor) 
            {
                this.disposeChildren(this._calloutAnchor);
            }
            removeChildren();
            return;
        }

        internal static function sortOnSortField(arg1:frontend.components.charts.ColumnChartItemProps, arg2:frontend.components.charts.ColumnChartItemProps):Number
        {
            return utils.sort.SortUtil.sortOnString(arg1, arg2, frontend.components.charts.ColumnChartItemProps.SORT_FIELD_PROPERTY, true);
        }

        
        {
            HEADER_HEIGHT = 62 * SIGMALink.scaleFactor;
            COLUMN_H_GAP = 1 * SIGMALink.scaleFactor;
            COLUMN_PADDING = 6 * SIGMALink.scaleFactor;
        }

        public function scaleOut(arg1:flash.events.TimerEvent=null):void
        {
            debug.Debug.debug("remove - " + this.item.title + ", " + this.item.type);
            this.disposeChildren(this.shapesGroup);
            return;
        }

        public function scaleIn(arg1:flash.events.TimerEvent=null):void
        {
            var p_event:flash.events.TimerEvent=null;
            var targetHeight:Number;
            var ctween:starling.animation.Tween;

            var loc1:*;
            ctween = null;
            p_event = arg1;
            if (this._img) 
            {
                this.disposeChildren(this.shapesGroup);
                this.drawWithQuads();
            }
            if (!this._img) 
            {
                this.disposeChildren(this.shapesGroup);
                return;
            }
            debug.Debug.debug("scaleIn - " + this.item.title + ", " + this.item.type);
            this.disposeChildren(this.shapesGroup);
            this.shapesGroup.addChild(this._img);
            targetHeight = this._img.height;
            this._img.height = 0;
            this._img.y = this._columnMaxHeight;
            ctween = new starling.animation.Tween(this._img, 0.8, starling.animation.Transitions.EASE_IN_OUT);
            ctween.animate("height", targetHeight);
            ctween.animate("y", 0);
            ctween.onComplete = function ():void
            {
                starling.core.Starling.juggler.remove(ctween);
                return;
            }
            starling.core.Starling.juggler.add(ctween);
            return;
        }

        internal function drawWithQuads():void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=null;
            debug.Debug.debug("drawWithQuads - " + this.item.title + ", " + this.item.type);
            var loc2:*=this.shapes.length;
            var loc4:*=0;
            var loc5:*=0;
            var loc11:*=0;
            if (this.rtShapes) 
            {
                this.rtShapes.clear();
            }
            else 
            {
                this.rtShapes = new frontend.components.charts.CustomRenderTexture(width, height);
            }
            this.calloutInfo = new flash.utils.Dictionary();
            this.calloutInfoY = new flash.utils.Dictionary();
            loc4 = 0;
            while (loc4 < loc2) 
            {
                loc3 = this.shapes[loc4];
                loc5 = 0;
                while (loc5 < loc3.length) 
                {
                    loc1 = loc3[loc5] as frontend.screen.statistic.tabs.CustomShape;
                    if (loc1.heightTo > 0.1) 
                    {
                        loc6 = loc4 * this._columnWidth + loc1.xFrom;
                        loc7 = loc1.yTo;
                        loc8 = loc1.widthFrom;
                        loc9 = loc1.heightTo;
                        this.calloutInfo[loc6] = loc1.chartItem;
                        if (!this.calloutInfoY[loc6]) 
                        {
                            this.calloutInfoY[loc6] = 0;
                        }
                        this.calloutInfoY[loc6] = Math.max(loc1.yFrom - loc1.yTo, this.calloutInfoY[loc6]);
                        loc10 = new starling.display.Quad(loc8, loc9, loc1.color);
                        loc10.x = loc6;
                        loc10.y = loc7;
                        this.rtShapes.draw(loc10, null, 1, 3);
                        loc10.dispose();
                        ++loc11;
                    }
                    ++loc5;
                }
                ++loc4;
            }
            this._img = loc11 > 0 ? new starling.display.Image(this.rtShapes) : null;
            return;
        }

        internal static const FOOTER_LINES_HEIGHT:Number=3 * SIGMALink.scaleFactor;

        internal static const COLUMN_BOTTOM_LINE_HEIGHT:Number=2 * SIGMALink.scaleFactor;

        internal static const DP_CHANGED:String="dpChangedEvent";

        internal static const DROP_LABELS_MINIMUM:int=3;

        internal static const FOOTER_HEIGHT:Number=48 * SIGMALink.scaleFactor;

        internal static const FOOTER_LINES_LABEL_PADDING:Number=6 * SIGMALink.scaleFactor;

        internal static const LANDSCAPE_COLUMN_COUNT:int=16;

        internal static const TWEEN_DURATION:Number=0.75;

        public var bgGroup:feathers.controls.LayoutGroup;

        public var dropLabels:Boolean=false;

        public var item:frontend.screen.statistic.tabs.StatisticTabItem;

        public var labelGroup:feathers.controls.LayoutGroup;

        public var shapes:__AS3__.vec.Vector.<Array>;

        public var shapesGroup:feathers.controls.LayoutGroup;

        internal var _calloutAnchor:feathers.controls.LayoutGroup;

        internal var _columnMaxHeight:Number;

        internal var _gridGap:Number;

        internal var _columnWidth:Number;

        internal var _columnQuadWidth:Number;

        public static var HEADER_HEIGHT:Number;

        internal var rtShapes:frontend.components.charts.CustomRenderTexture;

        internal var _columnQuadHeightFactor:Number;

        internal static var COLUMN_PADDING:Number;

        internal var rtLabels:frontend.components.charts.CustomRenderTexture;

        internal var rtBg:frontend.components.charts.CustomRenderTexture;

        internal var calloutInfo:flash.utils.Dictionary;

        public var parentHeight:Number=0;

        internal var calloutInfoY:flash.utils.Dictionary;

        internal var _img:starling.display.Image;

        internal var _gridLines:int;

        internal var _columnPaddingSide:Number;

        internal static var COLUMN_H_GAP:Number;
    }
}


//    class CustomRenderTexture
package frontend.components.charts 
{
    import starling.textures.*;
    
    public class CustomRenderTexture extends starling.textures.RenderTexture
    {
        public function CustomRenderTexture(arg1:int, arg2:int, arg3:Boolean=true, arg4:Number=-1, arg5:String="bgra")
        {
            super(arg1, arg2, arg3, arg4, arg5);
            return;
        }
    }
}


//    class StatisticColumnChartCallout
package frontend.components.charts 
{
    import backend.utils.*;
    import configCache.*;
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
    import frontend.components.*;
    import frontend.formatter.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import statistic.*;
    import utils.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    use namespace mx_internal;
    
    public class StatisticColumnChartCallout extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function StatisticColumnChartCallout()
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
            bindings = this._StatisticColumnChartCallout_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_components_charts_StatisticColumnChartCalloutWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return StatisticColumnChartCallout[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.layout = this._StatisticColumnChartCallout_VerticalLayout1_c();
            this.mxmlContent = [this._StatisticColumnChartCallout_LayoutGroup2_i(), this._StatisticColumnChartCallout_LayoutGroup3_i(), this._StatisticColumnChartCallout_LayoutGroup4_i(), this._StatisticColumnChartCallout_LayoutGroup5_i()];
            this.addEventListener("initialize", this.___StatisticColumnChartCallout_LayoutGroup1_initialize);
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

        public function get calloutTitel():String
        {
            return this._47456054calloutTitel;
        }

        public function set calloutTitel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._47456054calloutTitel;
            if (loc1 !== arg1) 
            {
                this._47456054calloutTitel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "calloutTitel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _calloutWidth():Number
        {
            return this._2053270187_calloutWidth;
        }

        internal function set _calloutWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2053270187_calloutWidth;
            if (loc1 !== arg1) 
            {
                this._2053270187_calloutWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_calloutWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function getDataTipLabel(arg1:frontend.components.charts.ColumnChartItem, arg2:String):String
        {
            var loc1:*="";
            if (arg1) 
            {
                var loc2:*=arg2;
                switch (loc2) 
                {
                    case statistic.Statistic.X_YEAR:
                    {
                        loc1 = arg1.date.fullYear.toString();
                        break;
                    }
                    case statistic.Statistic.X_MONTH:
                    {
                        loc1 = backend.utils.DataUtils.monthLabelsLong[arg1.date.month];
                        break;
                    }
                    case statistic.Statistic.X_WEEK:
                    {
                        loc1 = utils.LanguageManager.getString("WEEKS_SHORT") + " " + arg1.label;
                        break;
                    }
                }
            }
            return loc1;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            StatisticColumnChartCallout._watcherSetupUtil = arg1;
            return;
        }

        public function applyitem(arg1:frontend.components.charts.ColumnChartItem):void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=NaN;
            var loc7:*=null;
            var loc11:*=null;
            var loc12:*=0;
            var loc13:*=0;
            var loc14:*=null;
            var loc15:*=null;
            var loc16:*=null;
            var loc17:*=null;
            var loc18:*=null;
            var loc19:*=null;
            var loc20:*=NaN;
            var loc21:*=null;
            var loc22:*=null;
            this.calloutTitel = getDataTipLabel(arg1, configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheObject.STATISTIC_SELECTED_TAB, statistic.Statistic.X_WEEK));
            var loc2:*=statistic.Statistic.VALUES.length;
            var loc8:*=new feathers.layout.HorizontalLayout();
            loc8.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc8.horizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc8.paddingLeft = 4 * SIGMALink.scaleFactor;
            loc8.paddingRight = 8 * SIGMALink.scaleFactor;
            loc8.gap = 4 * SIGMALink.scaleFactor;
            var loc9:*=0;
            var loc10:*=0;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc11 = statistic.Statistic.VALUES[loc1];
                if (arg1.xValue.indexOf(loc11.value) != -1) 
                {
                    var loc23:*=loc11.value;
                    switch (loc23) 
                    {
                        case statistic.Statistic.TRAINING_TIME:
                        {
                            loc3 = " " + backend.utils.DataUtils.unitStringTimeHours;
                            loc4 = backend.utils.DataUtils.timeFormatterHHMM;
                            loc5 = null;
                            break;
                        }
                        case statistic.Statistic.DISTANCE:
                        {
                            loc3 = " " + backend.utils.DataUtils.unitStringDistance;
                            loc4 = backend.utils.DataUtils.distanceFormatter;
                            loc5 = backend.utils.DataUtils.distanceConverter;
                            break;
                        }
                        case statistic.Statistic.ALTITUDE_UPHILL:
                        case statistic.Statistic.ALTITUDE_DOWNHILL:
                        {
                            loc3 = " " + backend.utils.DataUtils.unitStringAltitude;
                            loc4 = backend.utils.DataUtils.altitudeFormatter;
                            loc5 = backend.utils.DataUtils.altitudeConverter;
                            break;
                        }
                        case statistic.Statistic.CALORIES:
                        {
                            loc3 = " " + backend.utils.DataUtils.unitStringCalories;
                            loc4 = backend.utils.DataUtils.caloriesFormatter;
                            loc5 = null;
                            break;
                        }
                        case statistic.Statistic.TRAININGS:
                        case statistic.Statistic.STEPS:
                        {
                            loc3 = "";
                            loc4 = null;
                            loc5 = null;
                            break;
                        }
                    }
                    loc13 = arg1.yValues.length;
                    loc14 = [];
                    loc12 = 0;
                    while (loc12 < loc13) 
                    {
                        loc15 = new feathers.controls.LayoutGroup();
                        loc15.layout = loc8;
                        this.list.addChild(loc15);
                        loc16 = new frontend.components.SportIcon();
                        loc16.sportId = (arg1.yValues[loc12] as frontend.components.charts.ColumnChartItemProps).sportId;
                        loc15.addChild(loc16);
                        loc16.validate();
                        loc17 = new feathers.controls.Label();
                        loc17.paddingLeft = 20 * SIGMALink.scaleFactor;
                        loc17.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
                        if (loc5) 
                        {
                            loc6 = loc5.convert((arg1.yValues[loc12] as frontend.components.charts.ColumnChartItemProps).value);
                        }
                        else 
                        {
                            loc6 = (arg1.yValues[loc12] as frontend.components.charts.ColumnChartItemProps).value;
                        }
                        if (loc4 is utils.interfaces.ICustomFormatter) 
                        {
                            loc7 = (loc4 as utils.interfaces.ICustomFormatter).format(loc6);
                        }
                        else if (loc4 is frontend.formatter.NumberFormatter) 
                        {
                            loc7 = (loc4 as frontend.formatter.NumberFormatter).format(loc6);
                        }
                        else 
                        {
                            loc7 = loc6.toString();
                        }
                        loc17.text = loc7;
                        loc15.addChild(loc17);
                        loc17.validate();
                        loc18 = new feathers.controls.Label();
                        loc18.text = loc3;
                        loc15.addChild(loc18);
                        loc18.validate();
                        loc10 = Math.max(loc17.width, loc10);
                        loc14.push(loc17);
                        loc9 = loc16.width + loc18.width;
                        ++loc12;
                    }
                    loc12 = 0;
                    while (loc12 < loc13) 
                    {
                        (loc14[loc12] as feathers.controls.Label).width = loc10;
                        ++loc12;
                    }
                    if (loc13 > 1) 
                    {
                        loc19 = new feathers.controls.Label();
                        loc19.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
                        loc20 = 0;
                        loc21 = "";
                        if (loc5) 
                        {
                            loc20 = loc5.convert(arg1.ySum);
                        }
                        else 
                        {
                            loc20 = arg1.ySum;
                        }
                        if (loc4 is utils.interfaces.ICustomFormatter) 
                        {
                            loc21 = (loc4 as utils.interfaces.ICustomFormatter).format(loc20);
                        }
                        else if (loc4 is frontend.formatter.NumberFormatter) 
                        {
                            loc21 = (loc4 as frontend.formatter.NumberFormatter).format(loc20);
                        }
                        else 
                        {
                            loc21 = loc20.toString();
                        }
                        loc19.text = loc21;
                        this.sum.layout = loc8;
                        this.sum.addChild(loc19);
                        loc22 = new feathers.controls.Label();
                        loc22.text = loc3;
                        this.sum.addChild(loc22);
                    }
                }
                ++loc1;
            }
            this.titleLabel.validate();
            this._calloutWidth = Math.max(this.titleLabel.width, loc10 + loc9 + 3 * loc8.gap + loc8.paddingLeft + loc8.paddingRight);
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            width = this._calloutWidth;
            return;
        }

        internal function _StatisticColumnChartCallout_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            return loc1;
        }

        internal function _StatisticColumnChartCallout_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._StatisticColumnChartCallout_Label1_i()];
            loc1.id = "header";
            this.header = loc1;
            feathers.binding.BindingManager.executeBindings(this, "header", this.header);
            return loc1;
        }

        internal function _StatisticColumnChartCallout_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "titleLabel";
            this.titleLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "titleLabel", this.titleLabel);
            return loc1;
        }

        internal function _StatisticColumnChartCallout_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._StatisticColumnChartCallout_VerticalLayout2_i();
            loc1.id = "list";
            this.list = loc1;
            feathers.binding.BindingManager.executeBindings(this, "list", this.list);
            return loc1;
        }

        internal function _StatisticColumnChartCallout_VerticalLayout2_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            this._StatisticColumnChartCallout_VerticalLayout2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_StatisticColumnChartCallout_VerticalLayout2", this._StatisticColumnChartCallout_VerticalLayout2);
            return loc1;
        }

        internal function _StatisticColumnChartCallout_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "_StatisticColumnChartCallout_LayoutGroup4";
            this._StatisticColumnChartCallout_LayoutGroup4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_StatisticColumnChartCallout_LayoutGroup4", this._StatisticColumnChartCallout_LayoutGroup4);
            return loc1;
        }

        internal function _StatisticColumnChartCallout_LayoutGroup5_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "sum";
            this.sum = loc1;
            feathers.binding.BindingManager.executeBindings(this, "sum", this.sum);
            return loc1;
        }

        public function ___StatisticColumnChartCallout_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _StatisticColumnChartCallout_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.RED);
            }, null, "header.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return _calloutWidth;
            }, null, "header.width")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return 8 * SIGMALink.scaleFactor;
            }, null, "titleLabel.padding")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_WHITE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "titleLabel.styleName")
            result[4] = new feathers.binding.Binding(this, null, null, "titleLabel.text", "calloutTitel");
            result[5] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "list.backgroundSkin")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return _calloutWidth;
            }, null, "list.width")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return 4 * SIGMALink.scaleFactor;
            }, null, "_StatisticColumnChartCallout_VerticalLayout2.gap")
            result[8] = new feathers.binding.Binding(this, function ():Number
            {
                return 4 * SIGMALink.scaleFactor;
            }, null, "_StatisticColumnChartCallout_VerticalLayout2.padding")
            result[9] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_StatisticColumnChartCallout_LayoutGroup4.backgroundSkin")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return 1 * SIGMALink.scaleFactor;
            }, null, "_StatisticColumnChartCallout_LayoutGroup4.height")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return _calloutWidth;
            }, null, "_StatisticColumnChartCallout_LayoutGroup4.width")
            result[12] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "sum.backgroundSkin")
            result[13] = new feathers.binding.Binding(this, function ():Number
            {
                return _calloutWidth;
            }, null, "sum.width")
            return result;
        }

        public function get header():feathers.controls.LayoutGroup
        {
            return this._1221270899header;
        }

        public function set header(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1221270899header;
            if (loc1 !== arg1) 
            {
                this._1221270899header = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "header", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get list():feathers.controls.LayoutGroup
        {
            return this._3322014list;
        }

        public function set list(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3322014list;
            if (loc1 !== arg1) 
            {
                this._3322014list = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "list", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get sum():feathers.controls.LayoutGroup
        {
            return this._114251sum;
        }

        public function set sum(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._114251sum;
            if (loc1 !== arg1) 
            {
                this._114251sum = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "sum", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var _StatisticColumnChartCallout_LayoutGroup4:feathers.controls.LayoutGroup;

        public var _StatisticColumnChartCallout_VerticalLayout2:feathers.layout.VerticalLayout;

        internal var _1221270899header:feathers.controls.LayoutGroup;

        internal var _3322014list:feathers.controls.LayoutGroup;

        internal var _114251sum:feathers.controls.LayoutGroup;

        internal var _1791483012titleLabel:feathers.controls.Label;

        internal var _47456054calloutTitel:String;

        internal var _2053270187_calloutWidth:Number;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  package core
//    class CustomLayout
package frontend.components.core 
{
    import feathers.controls.*;
    
    public class CustomLayout extends Object
    {
        public function CustomLayout(arg1:feathers.controls.LayoutGroup)
        {
            super();
            this._control = arg1;
            return;
        }

        public function get gap():Number
        {
            return this._gap;
        }

        public function set gap(arg1:Number):void
        {
            this._gap = arg1;
            this.setLayoutProp("gap", arg1);
            return;
        }

        public function get horizontalAlign():String
        {
            return this._horizontalAlign;
        }

        public function set horizontalAlign(arg1:String):void
        {
            this._horizontalAlign = arg1;
            this.setLayoutProp("horizontalAlign", arg1);
            return;
        }

        public function get padding():Number
        {
            return this._paddingTop;
        }

        public function set padding(arg1:Number):void
        {
            this.paddingTop = arg1;
            this.paddingRight = arg1;
            this.paddingBottom = arg1;
            this.paddingLeft = arg1;
            return;
        }

        public function get paddingBottom():Number
        {
            return this._paddingBottom;
        }

        public function set paddingBottom(arg1:Number):void
        {
            this._paddingBottom = arg1;
            this.setLayoutProp("paddingBottom", arg1);
            return;
        }

        public function get paddingLeft():Number
        {
            return this._paddingLeft;
        }

        public function set paddingLeft(arg1:Number):void
        {
            this._paddingLeft = arg1;
            this.setLayoutProp("paddingLeft", arg1);
            return;
        }

        public function get paddingRight():Number
        {
            return this._paddingRight;
        }

        public function set paddingRight(arg1:Number):void
        {
            this._paddingRight = arg1;
            this.setLayoutProp("paddingRight", arg1);
            return;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function set paddingTop(arg1:Number):void
        {
            this._paddingTop = arg1;
            this.setLayoutProp("paddingTop", arg1);
            return;
        }

        public function get verticalAlign():String
        {
            return this._verticalAlign;
        }

        public function set verticalAlign(arg1:String):void
        {
            this._verticalAlign = arg1;
            this.setLayoutProp("verticalAlign", arg1);
            return;
        }

        protected function setLayoutProp(arg1:String, arg2:*):void
        {
            if (this._control.layout && Object(this._control.layout).hasOwnProperty(arg1) && (arg2 is Number && !isNaN(arg2) || arg2 is String && !(arg2 == ""))) 
            {
                this._control.layout[arg1] = arg2;
            }
            return;
        }

        internal var _gap:Number=NaN;

        internal var _horizontalAlign:String;

        internal var _paddingBottom:Number=NaN;

        internal var _paddingLeft:Number=NaN;

        internal var _paddingRight:Number=NaN;

        internal var _paddingTop:Number=NaN;

        internal var _verticalAlign:String;

        internal var _control:feathers.controls.LayoutGroup;
    }
}


//    class CustomLayoutData
package frontend.components.core 
{
    import feathers.controls.*;
    import feathers.layout.*;
    import starling.events.*;
    
    public class CustomLayoutData extends Object
    {
        public function CustomLayoutData(arg1:feathers.layout.ILayoutDisplayObject)
        {
            super();
            this._control = arg1;
            if (this._control.stage) 
            {
                this.initLayoutData();
            }
            else 
            {
                this._control.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStageHandler);
            }
            return;
        }

        public function get bottom():Number
        {
            return this._bottom;
        }

        public function set bottom(arg1:Number):void
        {
            if (this._bottom == arg1) 
            {
                return;
            }
            this._bottom = arg1;
            this.setLayoutDataProp("bottom", arg1);
            return;
        }

        public function get horizontalCenter():Number
        {
            return this._horizontalCenter;
        }

        public function set horizontalCenter(arg1:Number):void
        {
            if (this._horizontalCenter == arg1) 
            {
                return;
            }
            this._horizontalCenter = arg1;
            this.setLayoutDataProp("horizontalCenter", arg1);
            return;
        }

        public function get left():Number
        {
            return this._left;
        }

        public function set left(arg1:Number):void
        {
            if (this._left == arg1) 
            {
                return;
            }
            this._left = arg1;
            this.setLayoutDataProp("left", arg1);
            return;
        }

        public function get percentHeight():Number
        {
            return this._percentHeight;
        }

        public function set percentHeight(arg1:Number):void
        {
            this._percentHeight = arg1;
            this.setLayoutDataProp("percentHeight", arg1);
            return;
        }

        public function get percentWidth():Number
        {
            return this._percentWidth;
        }

        public function set percentWidth(arg1:Number):void
        {
            this._percentWidth = arg1;
            this.setLayoutDataProp("percentWidth", arg1);
            return;
        }

        public function get right():Number
        {
            return this._right;
        }

        public function set right(arg1:Number):void
        {
            if (this._right == arg1) 
            {
                return;
            }
            this._right = arg1;
            this.setLayoutDataProp("right", arg1);
            return;
        }

        public function get top():Number
        {
            return this._top;
        }

        public function set top(arg1:Number):void
        {
            this._top = arg1;
            this.setLayoutDataProp("top", arg1);
            return;
        }

        public function get verticalCenter():Number
        {
            return this._verticalCenter;
        }

        public function set verticalCenter(arg1:Number):void
        {
            if (this._verticalCenter == arg1) 
            {
                return;
            }
            this._verticalCenter = arg1;
            this.setLayoutDataProp("verticalCenter", arg1);
            return;
        }

        internal function get layoutData():feathers.layout.ILayoutData
        {
            return this._control.layoutData;
        }

        internal function onAddedToStageHandler(arg1:starling.events.Event):void
        {
            this._control.removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStageHandler);
            this.initLayoutData();
            return;
        }

        internal function initLayoutData():void
        {
            if (this.layoutData) 
            {
                this.setLayoutDataProp("top", this._top);
                this.setLayoutDataProp("right", this._right);
                this.setLayoutDataProp("bottom", this._bottom);
                this.setLayoutDataProp("left", this._left);
                this.setLayoutDataProp("horizontalCenter", this._horizontalCenter);
                this.setLayoutDataProp("verticalCenter", this._verticalCenter);
            }
            else if (this._control.parent && this._control.parent is feathers.controls.LayoutGroup && feathers.controls.LayoutGroup(this._control.parent).layout) 
            {
                if (feathers.controls.LayoutGroup(this._control.parent).layout is feathers.layout.AnchorLayout) 
                {
                    this._control.layoutData = new feathers.layout.AnchorLayoutData(this._top, this._right, this._bottom, this._left, this._horizontalCenter, this._verticalCenter);
                }
                else if (feathers.controls.LayoutGroup(this._control.parent).layout is feathers.layout.VerticalLayout || feathers.controls.LayoutGroup(this._control.parent).layout is feathers.layout.HorizontalLayout) 
                {
                    this._control.layoutData = feathers.controls.LayoutGroup(this._control.parent).layout is feathers.layout.VerticalLayout ? new feathers.layout.VerticalLayoutData() : new feathers.layout.HorizontalLayoutData();
                }
            }
            else 
            {
                this._control.layoutData = new feathers.layout.AnchorLayoutData(this._top, this._right, this._bottom, this._left, this._horizontalCenter, this._verticalCenter);
            }
            this.setLayoutDataProp("percentWidth", this._percentWidth);
            this.setLayoutDataProp("percentHeight", this._percentHeight);
            return;
        }

        internal function setLayoutDataProp(arg1:String, arg2:*):void
        {
            if (this.layoutData && Object(this.layoutData).hasOwnProperty(arg1) && !isNaN(arg2)) 
            {
                this.layoutData[arg1] = arg2;
            }
            return;
        }

        protected var _bottom:Number=NaN;

        protected var _horizontalCenter:Number=NaN;

        protected var _left:Number=NaN;

        internal var _percentHeight:Number=NaN;

        internal var _percentWidth:Number=NaN;

        protected var _right:Number=NaN;

        protected var _top:Number=NaN;

        protected var _verticalCenter:Number=NaN;

        internal var _control:feathers.layout.ILayoutDisplayObject;
    }
}


//    class Group
package frontend.components.core 
{
    import feathers.controls.*;
    import feathers.layout.*;
    
    public class Group extends feathers.controls.LayoutGroup
    {
        public function Group()
        {
            super();
            this._customLayout = new frontend.components.core.CustomLayout(this);
            this.initLayout();
            return;
        }

        public function get bottom():Number
        {
            return this.customLayoutData.bottom;
        }

        public function set bottom(arg1:Number):void
        {
            this.customLayoutData.bottom = arg1;
            return;
        }

        public override function set height(arg1:Number):void
        {
            super.height = arg1;
            return;
        }

        public function get horizontalCenter():Number
        {
            return this.customLayoutData.horizontalCenter;
        }

        public function set horizontalCenter(arg1:Number):void
        {
            this.customLayoutData.horizontalCenter = arg1;
            return;
        }

        public function get left():Number
        {
            return this.customLayoutData.left;
        }

        public function set left(arg1:Number):void
        {
            this.customLayoutData.left = arg1;
            return;
        }

        public function get percentHeight():Number
        {
            return this.customLayoutData.percentHeight;
        }

        public function set percentHeight(arg1:Number):void
        {
            this.customLayoutData.percentHeight = arg1;
            return;
        }

        public function get percentWidth():Number
        {
            return this.customLayoutData.percentWidth;
        }

        public function set percentWidth(arg1:Number):void
        {
            this.customLayoutData.percentWidth = arg1;
            return;
        }

        public function get right():Number
        {
            return this.customLayoutData.right;
        }

        public function set right(arg1:Number):void
        {
            this.customLayoutData.right = arg1;
            return;
        }

        public function get top():Number
        {
            return this.customLayoutData.top;
        }

        public function set top(arg1:Number):void
        {
            this.customLayoutData.top = arg1;
            return;
        }

        public function get verticalCenter():Number
        {
            return this.customLayoutData.verticalCenter;
        }

        public function set verticalCenter(arg1:Number):void
        {
            this.customLayoutData.verticalCenter = arg1;
            return;
        }

        public override function set width(arg1:Number):void
        {
            super.width = arg1;
            return;
        }

        internal function get customLayoutData():frontend.components.core.CustomLayoutData
        {
            if (this._customLayoutData == null) 
            {
                this._customLayoutData = new frontend.components.core.CustomLayoutData(this);
            }
            return this._customLayoutData;
        }

        protected override function draw():void
        {
            var loc1:*=SIGMALink.scaleFactor;
            SIGMALink.scaleFactor = NaN;
            super.draw();
            SIGMALink.scaleFactor = loc1;
            return;
        }

        protected function initLayout():void
        {
            layout = new feathers.layout.AnchorLayout();
            return;
        }

        protected var _customLayout:frontend.components.core.CustomLayout;

        internal var _customLayoutData:frontend.components.core.CustomLayoutData;
    }
}


//    class Spacer
package frontend.components.core 
{
    import feathers.controls.*;
    
    public class Spacer extends feathers.controls.LayoutGroup
    {
        public function Spacer()
        {
            super();
            height = 10;
            width = 10;
            return;
        }
    }
}


//    class TouchLayoutGroup
package frontend.components.core 
{
    import __AS3__.vec.*;
    import feathers.controls.*;
    import feathers.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.events.*;
    
    public class TouchLayoutGroup extends feathers.controls.LayoutGroup
    {
        public function TouchLayoutGroup()
        {
            new Vector.<String>(4)[0] = STATE_UP;
            new Vector.<String>(4)[1] = STATE_DOWN;
            new Vector.<String>(4)[2] = STATE_HOVER;
            new Vector.<String>(4)[3] = STATE_DISABLED;
            this._stateNames = new Vector.<String>(4);
            super();
            addEventListener(starling.events.TouchEvent.TOUCH, this.touchHandler);
            return;
        }

        public function get currentState():String
        {
            return this._currentState;
        }

        public override function set isEnabled(arg1:Boolean):void
        {
            if (this._isEnabled == arg1) 
            {
                return;
            }
            super.isEnabled = arg1;
            if (this._isEnabled) 
            {
                if (this._currentState == STATE_DISABLED) 
                {
                    this.changeState(STATE_UP);
                }
                this.touchable = true;
            }
            else 
            {
                this.touchable = false;
                this.changeState(STATE_DISABLED);
                this.touchPointID = -1;
            }
            return;
        }

        public function get isLongPressEnabled():Boolean
        {
            return this._isLongPressEnabled;
        }

        public function set isLongPressEnabled(arg1:Boolean):void
        {
            this._isLongPressEnabled = arg1;
            if (!arg1) 
            {
                this.removeEventListener(starling.events.Event.ENTER_FRAME, this.longPress_enterFrameHandler);
            }
            return;
        }

        protected function get stateNames():__AS3__.vec.Vector.<String>
        {
            return this._stateNames;
        }

        protected function touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=false;
            if (!this._isEnabled) 
            {
                this.touchPointID = -1;
                return;
            }
            if (this.touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this, null, this.touchPointID);
                if (!loc1) 
                {
                    return;
                }
                if (!this.stage) 
                {
                    return;
                }
                loc1.getLocation(this.stage, HELPER_POINT);
                loc2 = this.contains(this.stage.hitTest(HELPER_POINT));
                if (loc1.phase != starling.events.TouchPhase.MOVED) 
                {
                    if (loc1.phase == starling.events.TouchPhase.ENDED) 
                    {
                        this.resetTouchState(loc1);
                        if (!this._hasLongPressed && loc2) 
                        {
                            arg1.stopPropagation();
                            this.trigger();
                        }
                    }
                }
                else 
                {
                    if (this._isLongPressEnabled) 
                    {
                        this._longPressGlobalPosition.x = loc1.globalX;
                        this._longPressGlobalPosition.y = loc1.globalY;
                    }
                    if (loc2 || this.keepDownStateOnRollOut) 
                    {
                        this.changeState(STATE_DOWN);
                    }
                    else 
                    {
                        this.changeState(STATE_UP);
                    }
                }
                return;
            }
            loc1 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
            if (loc1) 
            {
                this.changeState(STATE_DOWN);
                this.touchPointID = loc1.id;
                if (this._isLongPressEnabled) 
                {
                    this._touchBeginTime = flash.utils.getTimer();
                    if (this._longPressGlobalPosition) 
                    {
                        this._longPressGlobalPosition.x = loc1.globalX;
                        this._longPressGlobalPosition.y = loc1.globalY;
                    }
                    else 
                    {
                        this._longPressGlobalPosition = new flash.geom.Point(loc1.globalX, loc1.globalY);
                    }
                    this._hasLongPressed = false;
                    this.addEventListener(starling.events.Event.ENTER_FRAME, this.longPress_enterFrameHandler);
                }
                return;
            }
            loc1 = arg1.getTouch(this, starling.events.TouchPhase.HOVER);
            if (loc1) 
            {
                this.changeState(STATE_HOVER);
                return;
            }
            this.changeState(STATE_UP);
            return;
        }

        protected function longPress_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc2:*=false;
            var loc1:*=(flash.utils.getTimer() - this._touchBeginTime) / 1000;
            if (loc1 >= this._longPressDuration) 
            {
                this.removeEventListener(starling.events.Event.ENTER_FRAME, this.longPress_enterFrameHandler);
                loc2 = this.contains(this.stage.hitTest(this._longPressGlobalPosition));
                if (loc2) 
                {
                    this._hasLongPressed = true;
                    this.dispatchEventWith(feathers.events.FeathersEventType.LONG_PRESS);
                }
            }
            return;
        }

        protected function changeState(arg1:String):void
        {
            if (this._currentState == arg1) 
            {
                return;
            }
            if (this.stateNames.indexOf(arg1) < 0) 
            {
                throw new ArgumentError("Invalid state: " + arg1 + ".");
            }
            this._currentState = arg1;
            this.invalidate(INVALIDATION_FLAG_STATE);
            this.dispatchEventWith(feathers.events.FeathersEventType.STATE_CHANGE);
            return;
        }

        protected function resetTouchState(arg1:starling.events.Touch=null):void
        {
            this.touchPointID = -1;
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.longPress_enterFrameHandler);
            if (this._isEnabled) 
            {
                this.changeState(STATE_UP);
            }
            else 
            {
                this.changeState(STATE_DISABLED);
            }
            return;
        }

        protected function trigger():void
        {
            this.dispatchEventWith(starling.events.Event.TRIGGERED);
            return;
        }

        public static const STATE_DISABLED:String="disabled";

        public static const STATE_DOWN:String="down";

        public static const STATE_HOVER:String="hover";

        public static const STATE_UP:String="up";

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        protected var _currentState:String="up";

        protected var _isLongPressEnabled:Boolean=false;

        public var keepDownStateOnRollOut:Boolean=false;

        protected var _hasLongPressed:Boolean=false;

        protected var _longPressDuration:Number=0.5;

        protected var _longPressGlobalPosition:flash.geom.Point;

        protected var _touchBeginTime:int;

        protected var _stateNames:__AS3__.vec.Vector.<String>;

        protected var touchPointID:int=-1;
    }
}


//    class VGroup
package frontend.components.core 
{
    import feathers.layout.*;
    
    public class VGroup extends frontend.components.core.VHGroup
    {
        public function VGroup()
        {
            super();
            return;
        }

        protected override function initLayout():void
        {
            layout = new feathers.layout.VerticalLayout();
            return;
        }
    }
}


//    class VHGroup
package frontend.components.core 
{
    public class VHGroup extends frontend.components.core.Group
    {
        public function VHGroup()
        {
            super();
            return;
        }

        public function get gap():Number
        {
            return _customLayout.gap;
        }

        public function set gap(arg1:Number):void
        {
            _customLayout.gap = arg1;
            return;
        }

        public function get horizontalAlign():String
        {
            return _customLayout.horizontalAlign;
        }

        public function set horizontalAlign(arg1:String):void
        {
            _customLayout.horizontalAlign = arg1;
            return;
        }

        public function get padding():Number
        {
            return _customLayout.padding;
        }

        public function set padding(arg1:Number):void
        {
            _customLayout.padding = arg1;
            return;
        }

        public function get paddingBottom():Number
        {
            return _customLayout.paddingBottom;
        }

        public function set paddingBottom(arg1:Number):void
        {
            _customLayout.paddingBottom = arg1;
            return;
        }

        public function get paddingLeft():Number
        {
            return _customLayout.paddingLeft;
        }

        public function set paddingLeft(arg1:Number):void
        {
            _customLayout.paddingLeft = arg1;
            return;
        }

        public function get paddingRight():Number
        {
            return _customLayout.paddingRight;
        }

        public function set paddingRight(arg1:Number):void
        {
            _customLayout.paddingRight = arg1;
            return;
        }

        public function get paddingTop():Number
        {
            return _customLayout.paddingTop;
        }

        public function set paddingTop(arg1:Number):void
        {
            _customLayout.paddingTop = arg1;
            return;
        }

        public function get verticalAlign():String
        {
            return _customLayout.verticalAlign;
        }

        public function set verticalAlign(arg1:String):void
        {
            _customLayout.verticalAlign = arg1;
            return;
        }
    }
}


//  package list
//    class CustomGroupedList
package frontend.components.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import starling.display.*;
    
    public class CustomGroupedList extends feathers.controls.GroupedList
    {
        public function CustomGroupedList()
        {
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            clipContent = frontend.components.list.ListSetting.CLIP_CONTENT;
            autoHideBackground = frontend.components.list.ListSetting.AUTO_HIDE_BACKGROUND;
            useFixedThrowDuration = frontend.components.list.ListSetting.USE_FIXED_THROW_DURATION;
            horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_OFF;
            return;
        }

        public override function set layout(arg1:feathers.layout.ILayout):void
        {
            if (arg1 is feathers.layout.VerticalLayout) 
            {
                (arg1 as feathers.layout.VerticalLayout).stickyHeader = this.stickyHeader;
                (arg1 as feathers.layout.VerticalLayout).useVirtualLayout = this.useVirtualLayout;
            }
            super.layout = arg1;
            return;
        }

        protected override function throwVertically(arg1:Number):void
        {
            arg1 = arg1 + arg1 * frontend.components.list.ListSetting.SCROLL_ACCELERATION_FACTOR;
            super.throwVertically(arg1);
            return;
        }

        public var stickyHeader:Boolean=true;

        public var useVirtualLayout:Boolean=true;
    }
}


//    class CustomList
package frontend.components.list 
{
    import feathers.controls.*;
    import feathers.layout.*;
    import handler.*;
    import starling.events.*;
    
    public class CustomList extends feathers.controls.List
    {
        public function CustomList()
        {
            super();
            clipContent = frontend.components.list.ListSetting.CLIP_CONTENT;
            autoHideBackground = frontend.components.list.ListSetting.AUTO_HIDE_BACKGROUND;
            useFixedThrowDuration = frontend.components.list.ListSetting.USE_FIXED_THROW_DURATION;
            horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_OFF;
            styleProvider = null;
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }

        public override function set layout(arg1:feathers.layout.ILayout):void
        {
            if (arg1 is feathers.layout.VerticalLayout) 
            {
                (arg1 as feathers.layout.VerticalLayout).useVirtualLayout = this.useVirtualLayout;
            }
            super.layout = arg1;
            return;
        }

        protected override function throwVertically(arg1:Number):void
        {
            if (this.useCustomAcceleration) 
            {
                arg1 = arg1 + arg1 * frontend.components.list.ListSetting.SCROLL_ACCELERATION_FACTOR;
            }
            super.throwVertically(arg1);
            return;
        }

        protected override function feathersControl_addedToStageHandler(arg1:starling.events.Event):void
        {
            super.feathersControl_addedToStageHandler(arg1);
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.POPUP_MODE_CHANGED, this.onPopUpModeChanged);
            return;
        }

        protected override function feathersControl_removedFromStageHandler(arg1:starling.events.Event):void
        {
            super.feathersControl_removedFromStageHandler(arg1);
            handler.ViewHandler.getInstance().removeEventListener(handler.ViewHandler.POPUP_MODE_CHANGED, this.onPopUpModeChanged);
            return;
        }

        internal function onAddedToStage(arg1:starling.events.Event):void
        {
            this.validateScrollPolicy();
            return;
        }

        internal function onPopUpModeChanged(arg1:starling.events.Event):void
        {
            this.validateScrollPolicy();
            return;
        }

        public function validateScrollPolicy():void
        {
            if (this.allowScrollingInPopUpMode) 
            {
                verticalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_ON;
            }
            else 
            {
                verticalScrollPolicy = handler.ViewHandler.getInstance().popUpMode ? feathers.controls.Scroller.SCROLL_POLICY_OFF : feathers.controls.Scroller.SCROLL_POLICY_ON;
            }
            return;
        }

        public var allowScrollingInPopUpMode:Boolean=false;

        public var useCustomAcceleration:Boolean=true;

        public var useVirtualLayout:Boolean=true;
    }
}


//    class ListLoader
package frontend.components.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.utils.*;
    import frontend.*;
    import frontend.components.button.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.textures.*;
    import utils.*;
    
    public class ListLoader extends feathers.controls.LayoutGroup
    {
        public function ListLoader()
        {
            this._noResultText = utils.LanguageManager.getString("LISTLOADER_DEFAULT_NORESULT_TEXT");
            this._loadingAtlas = frontend.AssetsManagerCustom.getInstance().getTextureAtlas("loaderAnimation");
            this._noDataCallout = new frontend.components.button.IconButtonCallout();
            super();
            layout = new feathers.layout.AnchorLayout();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            layoutData = new feathers.layout.AnchorLayoutData(0, 0, 0, 0);
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }

        internal function init():void
        {
            if (this._initialized) 
            {
                return;
            }
            if (this._list == null) 
            {
                flash.utils.setTimeout(this.init, 100);
                return;
            }
            addChild(this._list);
            addChild(this._noResult);
            addChild(this._movie);
            validate();
            this.startLoading();
            addChild(this._noDataCallout);
            return;
        }

        public function set list(arg1:feathers.controls.Scroller):void
        {
            if (!arg1) 
            {
                return;
            }
            this._list = arg1;
            this.listStateHandler = new frontend.components.list.ListStateHandler(this._list);
            this.init();
            return;
        }

        public function startLoading():void
        {
            if (this._loadingAtlas) 
            {
                if (!this._movieClip || this._movieClip.isPlaying) 
                {
                    return;
                }
                this._movieClip = new starling.display.MovieClip(this._loadingAtlas.getTextures("frame_"), 30);
                this._movie.addChild(this._movieClip);
                this._movieClip.play();
                if (!starling.core.Starling.juggler.contains(this._movieClip)) 
                {
                    starling.core.Starling.juggler.add(this._movieClip);
                }
                this.loading = true;
            }
            return;
        }

        public function stopLoading():void
        {
            this.loading = false;
            if (!this._movieClip || !this._movieClip.isPlaying) 
            {
                return;
            }
            if (this._movieClip) 
            {
                this._movieClip.stop();
                if (starling.core.Starling.juggler.contains(this._movieClip)) 
                {
                    starling.core.Starling.juggler.remove(this._movieClip);
                }
            }
            this._movie.removeChildren();
            return;
        }

        public function get loading():Boolean
        {
            return this._loading;
        }

        public function set loading(arg1:Boolean):void
        {
            this._loading = arg1;
            this._list.visible = !this._loading;
            this._list.includeInLayout = !this._loading;
            this._movie.visible = this._loading;
            this._movie.includeInLayout = this._loading;
            this.checkDataProvider();
            return;
        }

        public override function set mxmlContent(arg1:Array):void
        {
            super.mxmlContent = arg1;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._noResult = new feathers.controls.Label();
            this._noResult.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            this._noResult.maxWidth = SIGMALink.appWidth;
            this._noResult.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            this._noResult.text = this._noResultText;
            this._noResult.wordWrap = true;
            this._movie = new feathers.controls.LayoutGroup();
            this._movie.includeInLayout = true;
            this._movie.visible = true;
            this._movie.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            return;
        }

        public function get noDataIconButtonAnchor():frontend.components.button.IconButton
        {
            return this._noDataIconButtonAnchor;
        }

        internal function set _66501941noDataIconButtonAnchor(arg1:frontend.components.button.IconButton):void
        {
            this._noDataIconButtonAnchor = arg1;
            this._noDataCallout.anchor = this.noDataIconButtonAnchor;
            this.checkDataProvider();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            removeChildren();
            return;
        }

        public function get listStateHandler():frontend.components.list.ListStateHandler
        {
            return this._873259721listStateHandler;
        }

        public function set noResultText(arg1:String):void
        {
            this._noResultText = arg1;
            if (this._noResult != null) 
            {
                this._noResult.text = this._noResultText;
            }
            return;
        }

        public function set listStateHandler(arg1:frontend.components.list.ListStateHandler):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._873259721listStateHandler;
            if (loc1 !== arg1) 
            {
                this._873259721listStateHandler = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "listStateHandler", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set noDataIconButtonAnchor(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.noDataIconButtonAnchor;
            if (loc1 !== arg1) 
            {
                this._66501941noDataIconButtonAnchor = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "noDataIconButtonAnchor", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get noDataText():String
        {
            return this._1346902824noDataText;
        }

        public function set noDataText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1346902824noDataText;
            if (loc1 !== arg1) 
            {
                this._1346902824noDataText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "noDataText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function setNormalState():void
        {
            if (this.listStateHandler != null) 
            {
                this.listStateHandler.setNormalState();
            }
            return;
        }

        public function swapState():void
        {
            if (this.listStateHandler != null) 
            {
                this.listStateHandler.swapState();
            }
            return;
        }

        public function checkDataProvider():void
        {
            var loc1:*=0;
            if (this._list != null) 
            {
                if (this._list is feathers.controls.List) 
                {
                    if ((this._list as feathers.controls.List).dataProvider != null) 
                    {
                        loc1 = (this._list as feathers.controls.List).dataProvider.length;
                    }
                }
                else if (this._list is feathers.controls.GroupedList) 
                {
                    if ((this._list as feathers.controls.GroupedList).dataProvider != null) 
                    {
                        loc1 = (this._list as feathers.controls.GroupedList).dataProvider.getLength();
                    }
                }
            }
            var loc2:*;
            this._noResult.includeInLayout = loc2 = false;
            this._noResult.visible = loc2;
            if (this._noDataCallout) 
            {
                this._noDataCallout.includeInLayout = loc2 = false;
                this._noDataCallout.visible = loc2;
            }
            if (loc1 == 0) 
            {
                this._noResult.includeInLayout = loc2 = true;
                this._noResult.visible = loc2;
                if (this._noDataCallout && this.noDataIconButtonAnchor) 
                {
                    this._noDataCallout.calloutText = this.noDataText;
                    this._noDataCallout.includeInLayout = loc2 = true;
                    this._noDataCallout.visible = loc2;
                }
            }
            return;
        }

        internal function onAddedToStage(arg1:starling.events.Event):void
        {
            this.init();
            if (this.listStateHandler != null) 
            {
                this.listStateHandler.setNormalState();
            }
            return;
        }

        internal var _list:feathers.controls.Scroller;

        internal var _873259721listStateHandler:frontend.components.list.ListStateHandler;

        internal var _loading:Boolean=true;

        internal var _noDataIconButtonAnchor:frontend.components.button.IconButton;

        internal var _1346902824noDataText:String="";

        internal var _noResultText:String;

        internal var _initialized:Boolean=false;

        internal var _loadingAtlas:starling.textures.TextureAtlas;

        internal var _movie:feathers.controls.LayoutGroup;

        internal var _noResult:feathers.controls.Label;

        internal var _showNoDataTimeout:uint=0;

        internal var _noDataCallout:frontend.components.button.IconButtonCallout;

        internal var _movieClip:starling.display.MovieClip;
    }
}


//    class ListSetting
package frontend.components.list 
{
    public class ListSetting extends Object
    {
        public function ListSetting()
        {
            super();
            return;
        }

        public static const AUTO_HIDE_BACKGROUND:Boolean=true;

        public static const CLIP_CONTENT:Boolean=false;

        public static const SCROLL_ACCELERATION_FACTOR:Number=0.8;

        public static const USE_FIXED_THROW_DURATION:Boolean=false;
    }
}


//    class ListSortItem
package frontend.components.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import frontend.components.*;
    import frontend.components.core.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ListSortItem extends frontend.components.core.Group
    {
        public function ListSortItem(arg1:String, arg2:String, arg3:Boolean)
        {
            super();
            this.text = arg1;
            this.sortField = arg2;
            this.ascending = arg3;
            this.validateLayout();
            this.validateSortItem();
            addEventListener(starling.events.TouchEvent.TOUCH, this.itemTouch_handler);
            return;
        }

        public function get ascending():Boolean
        {
            return this._ascending;
        }

        public function set ascending(arg1:Boolean):void
        {
            if (this._ascending != arg1) 
            {
                this._ascending = arg1;
                this.validateSortItem();
            }
            return;
        }

        public function get selected():Boolean
        {
            return this._selected;
        }

        public function set selected(arg1:Boolean):void
        {
            if (this._selected != arg1) 
            {
                this._selected = arg1;
                this.validateSortItem();
            }
            return;
        }

        protected function validateLayout():void
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.gap = ITEM_GAP;
            loc1.horizontalAlign = feathers.layout.HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
            loc1.verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            layout = loc1;
            height = ITEM_HEIGHT;
            percentWidth = 100;
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        internal function validateSkin():void
        {
            height = ITEM_HEIGHT;
            return;
        }

        protected function validateSortItem():void
        {
            removeChildren(0);
            var loc1:*=new feathers.controls.Label();
            loc1.text = this.text;
            addChild(loc1);
            if (this.selected) 
            {
                this.icon = new frontend.components.TextureImage();
                this.icon.textureName = this.ascending ? "iconup" : "icondown";
                var loc2:*;
                this.icon.scaleY = loc2 = 0.5;
                this.icon.scaleX = loc2;
                addChild(this.icon);
                backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }
            else 
            {
                backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }
            return;
        }

        internal function itemTouch_handler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.selected) 
            {
                this.ascending = !this.ascending;
            }
            else 
            {
                this.selected = true;
            }
            if (this.sortFunction != null) 
            {
                this.sortFunction(this);
            }
            return;
        }

        
        {
            ITEM_GAP = 16 * SIGMALink.scaleFactor;
            ITEM_HEIGHT = 65 * SIGMALink.scaleFactor;
        }

        internal var _ascending:Boolean=true;

        public var icon:frontend.components.TextureImage;

        internal var _selected:Boolean=true;

        public var sortField:String;

        public var sortFunction:Function;

        public var text:String;

        public static var ITEM_GAP:Number;

        public static var ITEM_HEIGHT:Number;
    }
}


//    class ListStateHandler
package frontend.components.list 
{
    import feathers.controls.*;
    import feathers.events.*;
    import starling.events.*;
    
    public class ListStateHandler extends starling.events.EventDispatcher
    {
        public function ListStateHandler(arg1:feathers.controls.Scroller)
        {
            super();
            this._currentListState = frontend.components.list.SelectableListEvent.STATE_NORMAL;
            this._multiStateList = arg1;
            return;
        }

        public function swapState():void
        {
            var loc2:*=this._currentListState;
            switch (loc2) 
            {
                case frontend.components.list.SelectableListEvent.STATE_SELECTABLE:
                {
                    this._currentListState = frontend.components.list.SelectableListEvent.STATE_NORMAL;
                    this.editState = false;
                    break;
                }
                case frontend.components.list.SelectableListEvent.STATE_NORMAL:
                {
                    this._currentListState = frontend.components.list.SelectableListEvent.STATE_SELECTABLE;
                    this.editState = true;
                    break;
                }
            }
            frontend.components.list.SelectableListItem.reset();
            var loc1:*=new frontend.components.list.SelectableListEvent(frontend.components.list.SelectableListEvent.CHANGE_STATE, this._currentListState);
            this.onListStateChanged(loc1);
            return;
        }

        public function setNormalState():void
        {
            this._currentListState = frontend.components.list.SelectableListEvent.STATE_NORMAL;
            this.editState = false;
            frontend.components.list.SelectableListItem.reset();
            var loc1:*=new frontend.components.list.SelectableListEvent(frontend.components.list.SelectableListEvent.CHANGE_STATE, this._currentListState);
            this.onListStateChanged(loc1);
            return;
        }

        protected function onListStateChanged(arg1:frontend.components.list.SelectableListEvent):void
        {
            if (this._multiStateList) 
            {
                this._multiStateList.dispatchEvent(arg1);
            }
            return;
        }

        public function get editState():Boolean
        {
            return this._1877107545editState;
        }

        public function set editState(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1877107545editState;
            if (loc1 !== arg1) 
            {
                this._1877107545editState = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "editState", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal var _1877107545editState:Boolean=false;

        protected var _currentListState:String;

        protected var _multiStateList:feathers.controls.Scroller;
    }
}


//    class SelectableGroupedListItemRenderer
package frontend.components.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import frontend.components.menuList.*;
    import starling.display.*;
    import starling.events.*;
    
    public class SelectableGroupedListItemRenderer extends feathers.controls.renderers.DefaultGroupedListItemRenderer
    {
        public function SelectableGroupedListItemRenderer()
        {
            this.editGroupWidth = 75 * SIGMALink.scaleFactor;
            super();
            height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_TOP;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            return;
        }

        public override function set owner(arg1:feathers.controls.GroupedList):void
        {
            super.owner = arg1;
            if (owner) 
            {
                owner.addEventListener(frontend.components.list.SelectableListEvent.CHANGE_STATE, this.multiStateChange_handler);
            }
            return;
        }

        public override function dispose():void
        {
            if (owner && owner.hasEventListener(frontend.components.list.SelectableListEvent.CHANGE_STATE)) 
            {
                owner.removeEventListener(frontend.components.list.SelectableListEvent.CHANGE_STATE, this.multiStateChange_handler);
            }
            super.dispose();
            return;
        }

        protected override function initialize():void
        {
            var loc1:*=null;
            super.initialize();
            loc1 = new feathers.layout.VerticalLayout();
            loc1.gap = 5;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            this.editGroup = new feathers.controls.LayoutGroup();
            this.editGroup.visible = false;
            this.editGroup.width = this.editGroupWidth;
            this.editGroup.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this.editGroup.layout = loc1;
            this.editGroup.layoutData = new feathers.layout.VerticalLayoutData(100, 100);
            this.editGroup.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.MIDGREY);
            addChild(this.editGroup);
            this.checkbox = new feathers.controls.Check();
            this.checkbox.label = "";
            this.checkbox.hasLabelTextRenderer = false;
            this.checkbox.defaultLabelProperties = null;
            this.checkbox.addEventListener(starling.events.Event.CHANGE, this.check_changeHandler);
            this.editGroup.addChild(this.checkbox);
            return;
        }

        protected function check_changeHandler(arg1:starling.events.Event):void
        {
            return;
        }

        protected override function commitData():void
        {
            if (!data) 
            {
                return;
            }
            return;
        }

        protected function multiStateChange_handler(arg1:frontend.components.list.SelectableListEvent):void
        {
            invalidate(INVALIDATION_FLAG_STATE);
            validate();
            return;
        }

        protected static const PADDING:Number=17 * SIGMALink.scaleFactor;

        protected var checkbox:feathers.controls.Check;

        protected var editGroup:feathers.controls.LayoutGroup;

        protected var editGroupWidth:Number;
    }
}


//    class SelectableListEvent
package frontend.components.list 
{
    import starling.events.*;
    
    public class SelectableListEvent extends starling.events.Event
    {
        public function SelectableListEvent(arg1:String, arg2:String, arg3:Boolean=false, arg4:Boolean=false)
        {
            super(arg1, arg3, arg4);
            this.newState = arg2;
            return;
        }

        public static const CHANGE_STATE:String="changeStateEvent";

        public static const STATE_SELECTABLE:String="selectableState";

        public static const STATE_NORMAL:String="normalState";

        public var newState:String;
    }
}


//    class SelectableListItem
package frontend.components.list 
{
    import flash.utils.*;
    import starling.events.*;
    
    public class SelectableListItem extends starling.events.EventDispatcher
    {
        public function SelectableListItem()
        {
            super();
            return;
        }

        public function isSelected():Boolean
        {
            return !(selectedItems[this.GUID] == null);
        }

        public function addSelection():void
        {
            selectedItems[this.GUID] = this;
            return;
        }

        public function removeSelection():void
        {
            if (selectedItems[this.GUID] != null) 
            {
                delete selectedItems[this.GUID];
            }
            return;
        }

        public function currentSelected():void
        {
            reset();
            selectedItems[this.GUID] = this;
            return;
        }

        public static function reset():void
        {
            selectedItems = new flash.utils.Dictionary();
            return;
        }

        public static function isGUIDSelected(arg1:String):Boolean
        {
            return !(selectedItems[arg1] == null);
        }

        
        {
            selectedItems = new flash.utils.Dictionary();
        }

        public var GUID:String;

        public static var selectedItems:flash.utils.Dictionary;
    }
}


//    class SelectableListItemRenderer
package frontend.components.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import frontend.components.menuList.*;
    import starling.display.*;
    import starling.events.*;
    
    public class SelectableListItemRenderer extends feathers.controls.renderers.DefaultListItemRenderer
    {
        public function SelectableListItemRenderer()
        {
            this.editGroupWidth = 75 * SIGMALink.scaleFactor;
            super();
            height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_TOP;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            return;
        }

        public override function set owner(arg1:feathers.controls.List):void
        {
            super.owner = arg1;
            if (owner) 
            {
                owner.addEventListener(frontend.components.list.SelectableListEvent.CHANGE_STATE, this.multiStateChange_handler);
            }
            return;
        }

        public override function dispose():void
        {
            if (owner && owner.hasEventListener(frontend.components.list.SelectableListEvent.CHANGE_STATE)) 
            {
                owner.removeEventListener(frontend.components.list.SelectableListEvent.CHANGE_STATE, this.multiStateChange_handler);
            }
            super.dispose();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this.editGroup = new feathers.controls.LayoutGroup();
            this.editGroup.visible = false;
            this.editGroup.width = this.editGroupWidth;
            this.editGroup.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this.editGroup.layout = new feathers.layout.AnchorLayout();
            this.editGroup.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.MIDGREY);
            addChild(this.editGroup);
            if (this.allowMultiSelection) 
            {
                this.checkbox = new feathers.controls.Check();
                this.checkbox.label = null;
                this.checkbox.hasLabelTextRenderer = false;
                this.checkbox.defaultLabelProperties = null;
                this.checkbox.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, PADDING, NaN, 0);
                this.checkbox.addEventListener(starling.events.Event.CHANGE, this.check_changeHandler);
                this.editGroup.addChild(this.checkbox);
            }
            else 
            {
                this.radio = new feathers.controls.Radio();
                this.radio.label = null;
                this.radio.isSelected = false;
                this.radio.hasLabelTextRenderer = false;
                this.radio.defaultLabelProperties = null;
                this.radio.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, PADDING, NaN, 0);
                if (toggleGroup) 
                {
                    this.radio.toggleGroup = toggleGroup;
                    toggleGroup.addEventListener(starling.events.Event.CHANGE, this.check_changeHandler);
                }
                else 
                {
                    this.radio.addEventListener(starling.events.Event.TRIGGERED, this.check_changeHandler);
                }
                this.editGroup.addChild(this.radio);
            }
            return;
        }

        protected function check_changeHandler(arg1:starling.events.Event):void
        {
            return;
        }

        protected override function commitData():void
        {
            if (!data) 
            {
                return;
            }
            return;
        }

        protected function multiStateChange_handler(arg1:frontend.components.list.SelectableListEvent):void
        {
            invalidate(INVALIDATION_FLAG_STATE);
            validate();
            return;
        }

        protected static const PADDING:Number=17 * SIGMALink.scaleFactor;

        public var allowMultiSelection:Boolean=true;

        protected var checkbox:feathers.controls.Check;

        protected var editGroup:feathers.controls.LayoutGroup;

        protected var editGroupWidth:Number;

        protected var radio:feathers.controls.Radio;
    }
}


//  package map
//    class GeoUtils
package frontend.components.map 
{
    import flash.geom.*;
    
    public class GeoUtils extends Object
    {
        public function GeoUtils()
        {
            super();
            return;
        }

        public static function x2lon(arg1:Number):Number
        {
            return arg1 * C_LONGITUDE - 180;
        }

        public static function lon2x(arg1:Number):Number
        {
            return (arg1 + 180) / C_LONGITUDE;
        }

        public static function y2lat(arg1:Number):Number
        {
            return Math.atan(sinh(PI - C_LATITUDE * arg1)) * RAD_DEG;
        }

        public static function lat2y(arg1:Number):Number
        {
            var loc1:*=arg1 * DEG_RAD;
            return (1 - Math.log(Math.tan(loc1) + 1 / Math.cos(loc1)) / PI) * C_LATITUDE2;
        }

        public static function sinh(arg1:Number):Number
        {
            return (Math.exp(arg1) - Math.exp(-arg1)) / 2;
        }

        public static function distance(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            var loc1:*=Math.cos(arg2) * Math.cos(arg4) * Math.cos(arg3 - arg1) + Math.sin(arg2) * Math.sin(arg4);
            return loc1 > 1 ? 0 : EARTH_RADIUS * Math.acos(loc1);
        }

        public static function distanceDeg(arg1:Number, arg2:Number, arg3:Number, arg4:Number):Number
        {
            return distance(arg1 * DEG_RAD, arg2 * DEG_RAD, arg3 * DEG_RAD, arg4 * DEG_RAD);
        }

        public static function destination(arg1:Number, arg2:Number, arg3:Number, arg4:Number):flash.geom.Point
        {
            var loc1:*=arg4 / EARTH_RADIUS;
            var loc2:*=Math.asin(Math.sin(arg2) * Math.cos(loc1) + Math.cos(arg2) * Math.sin(loc1) * Math.cos(arg3));
            var loc3:*=arg1 + Math.atan2(Math.sin(arg3) * Math.sin(loc1) * Math.cos(arg2), Math.cos(loc1) - Math.sin(arg2) * Math.sin(loc2));
            return new flash.geom.Point(loc3, loc2);
        }

        public static function destionationDeg(arg1:Number, arg2:Number, arg3:Number, arg4:Number):flash.geom.Point
        {
            var loc1:*=destination(arg1 * DEG_RAD, arg2 * DEG_RAD, arg3 * DEG_RAD, arg4);
            loc1.x = loc1.x * RAD_DEG;
            loc1.y = loc1.y * RAD_DEG;
            return loc1;
        }

        public static function lonAtDistanceDeg(arg1:Number, arg2:Number, arg3:Number):Number
        {
            return destionationDeg(arg1, arg2, 90, arg3).x;
        }

        public static function latAtDistanceDeg(arg1:Number, arg2:Number):Number
        {
            arg1 = arg1 * DEG_RAD;
            var loc1:*=arg2 / EARTH_RADIUS;
            return Math.asin(Math.sin(arg1) * Math.cos(loc1) + Math.cos(arg1) * Math.sin(loc1)) * RAD_DEG;
        }

        public static function pixelsPerMeter(arg1:Number):Number
        {
            var loc1:*=lat2y(arg1) - lat2y(Math.asin(Math.sin(arg1 * DEG_RAD) * COS_1_EARTH_RADIUS + Math.cos(arg1 * DEG_RAD) * SIN_1_EARTH_RADIUS) * RAD_DEG);
            return loc1 < 0 ? -loc1 : loc1;
        }

        public static function pixelPerMeterByCenter(arg1:flash.geom.Point):Number
        {
            return pixelsPerMeter(y2lat(arg1.y));
        }

        public static function pixelsPerMeterPrecise(arg1:Number, arg2:Number):Number
        {
            var loc1:*=destionationDeg(arg1, arg2, 45, 1);
            var loc2:*=lon2x(arg1) - lon2x(loc1.x);
            var loc3:*=lat2y(arg2) - lat2y(loc1.y);
            return Math.sqrt(loc2 * loc2 + loc3 * loc3);
        }

        public static const DEG_RAD:Number=PI / 180;

        public static const EARTH_RADIUS:uint=6371000;

        public static const MAX_LATITUDE:uint=67108864;

        public static const MAX_LONGITUDE:uint=67108864;

        public static const RAD_DEG:Number=180 / PI;

        internal static const COS_1_EARTH_RADIUS:Number=Math.cos(1 / EARTH_RADIUS);

        internal static const C_LATITUDE:Number=2 * PI / MAX_LATITUDE;

        internal static const C_LATITUDE2:Number=MAX_LATITUDE / 2;

        internal static const C_LONGITUDE:Number=360 / MAX_LONGITUDE;

        internal static const PI:Number=Math.PI;

        internal static const SIN_1_EARTH_RADIUS:Number=Math.sin(1 / EARTH_RADIUS);
    }
}


//    class LoaderOptimizer
package frontend.components.map 
{
    import com.adobe.images.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import helper.*;
    
    public class LoaderOptimizer extends Object
    {
        public function LoaderOptimizer(arg1:frontend.components.map.URLRequestBuffer=null)
        {
            this.created = new flash.utils.Dictionary(true);
            this.released = new flash.utils.Dictionary(true);
            super();
            this.buffer = arg1 ? arg1 : new frontend.components.map.URLRequestBuffer(6, 15000);
            helper.File_helper.createDirIfNotExist(frontend.components.map.MapLayerOptions.CACHE_DIRECTORY);
            return;
        }

        internal function xyzByUrlString(arg1:String):frontend.components.map.MapXyzPartition
        {
            if (arg1 == null || arg1.length <= 0) 
            {
                return null;
            }
            var loc1:*=arg1;
            var loc2:*=loc1.replace(frontend.components.map.MapLayerOptions.URL_MAP, "");
            var loc3:*=loc2.split("/");
            var loc4:*=loc3.pop();
            var loc5:*=loc3.pop();
            var loc6:*=loc3.pop();
            return new frontend.components.map.MapXyzPartition(loc6, loc5, loc4);
        }

        public function load(arg1:flash.net.URLRequest, arg2:flash.system.LoaderContext):flash.display.Loader
        {
            var loc2:*=null;
            var loc3:*=null;
            if (frontend.components.map.MapLayerOptions.CACHING_ENABLED) 
            {
                loc2 = this.xyzByUrlString(arg1.url);
                if (loc2) 
                {
                    loc3 = new flash.filesystem.File(frontend.components.map.MapLayerOptions.CACHE_DIRECTORY + loc2.getPath());
                    if (loc3.exists) 
                    {
                        arg1.url = loc3.url;
                    }
                }
            }
            var loc1:*=this.createLoader();
            this.buffer.push(loc1, arg1, arg2);
            return loc1;
        }

        public function release(arg1:flash.display.Loader):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            if (frontend.components.map.MapLayerOptions.CACHING_ENABLED) 
            {
                loc2 = arg1.contentLoaderInfo.url;
                if (loc2 && loc2.substr(0, 4) == "http") 
                {
                    loc3 = this.xyzByUrlString(loc2);
                    if (loc3) 
                    {
                        loc4 = new flash.filesystem.File(frontend.components.map.MapLayerOptions.CACHE_DIRECTORY + loc3.getPath());
                        if (!loc4.exists) 
                        {
                            loc5 = com.adobe.images.PNGEncoder.encode((arg1.contentLoaderInfo.content as flash.display.Bitmap).bitmapData);
                            loc6 = new flash.filesystem.FileStream();
                            loc6.open(loc4, flash.filesystem.FileMode.WRITE);
                            loc6.writeBytes(loc5, 0, loc5.length);
                            loc6.close();
                        }
                    }
                }
            }
            loc1 = this.buffer.getWaitingByLoader(arg1);
            if (loc1) 
            {
                this.buffer.removeWaitingById(loc1.id);
            }
            loc1 = this.buffer.getActiveByLoader(arg1);
            if (loc1) 
            {
                this.buffer.removeActiveById(loc1.id);
            }
            else if (this.released) 
            {
                this.removeLoaderListeners(arg1);
                this.released[arg1] = true;
            }
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this.created;
            for (loc1 in loc4) 
            {
                loc2 = loc1 as flash.display.Loader;
                this.release(loc2);
                this.removeLoaderListeners(loc2);
                loc2.unloadAndStop(true);
            }
            this.created = null;
            this.released = null;
            this.buffer = null;
            return;
        }

        internal function removeLoaderListeners(arg1:flash.display.Loader):void
        {
            arg1.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, this.onLoaderComplete, false);
            arg1.contentLoaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onLoaderIOError, false);
            return;
        }

        internal function addLoaderListeners(arg1:flash.display.Loader):void
        {
            arg1.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.onLoaderComplete, false, -10, true);
            arg1.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onLoaderIOError, false, -10, true);
            return;
        }

        internal function createLoader():flash.display.Loader
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this.released;
            for (loc2 in loc4) 
            {
                loc1 = loc2 as flash.display.Loader;
                delete this.released[loc1];
                break;
            }
            if (!loc1) 
            {
                loc1 = new flash.display.Loader();
                this.created[loc1] = true;
            }
            this.addLoaderListeners(loc1);
            return loc1;
        }

        internal function onLoaderComplete(arg1:flash.events.Event):void
        {
            this.release(flash.display.LoaderInfo(arg1.target).loader);
            return;
        }

        internal function onLoaderIOError(arg1:flash.events.IOErrorEvent):void
        {
            this.release(flash.display.LoaderInfo(arg1.target).loader);
            return;
        }

        internal var buffer:frontend.components.map.URLRequestBuffer;

        internal var created:flash.utils.Dictionary;

        internal var released:flash.utils.Dictionary;
    }
}


//    class MapHelperMain
package frontend.components.map 
{
    import __AS3__.vec.*;
    import configCache.*;
    import flash.events.*;
    import flash.geom.*;
    import handler.*;
    import sk.yoz.ycanvas.map.*;
    import sk.yoz.ycanvas.map.display.*;
    import sk.yoz.ycanvas.map.events.*;
    import sk.yoz.ycanvas.map.layers.*;
    import sk.yoz.ycanvas.map.managers.*;
    import sk.yoz.ycanvas.map.partitions.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    import starling.display.*;
    import starling.events.*;
    
    public class MapHelperMain extends Object
    {
        public function MapHelperMain(arg1:Number, arg2:Number)
        {
            super();
            sk.yoz.ycanvas.map.layers.LayerFactory.CUSTOM_TILE_SCALE = SIGMALink.scaleFactor;
            sk.yoz.ycanvas.map.layers.LayerFactory.CUSTOM_SCALE_STEPS = 0.1;
            var loc1:*=new sk.yoz.ycanvas.map.valueObjects.Transformation();
            loc1.centerX = frontend.components.map.GeoUtils.lon2x(arg2);
            loc1.centerY = frontend.components.map.GeoUtils.lat2y(arg1);
            loc1.rotation = 0;
            loc1.scale = 1;
            var loc2:*=new sk.yoz.ycanvas.map.valueObjects.Limit();
            loc2.minScale = SIGMALink.scaleFactor;
            loc2.maxScale = 1 / 65536;
            this.strokeLayer = new sk.yoz.ycanvas.map.display.StrokeLayer();
            this.strokeLayer.autoUpdateThickness = true;
            this.markerLayer = new sk.yoz.ycanvas.map.display.MarkerLayer();
            var loc3:*=createMapConfig();
            var loc4:*=new frontend.components.map.PartitionLoader();
            var loc5:*=new flash.events.EventDispatcher();
            this.map = new sk.yoz.ycanvas.map.YCanvasMap(loc3, loc1, TILE_WIDTH, 3);
            this.map.partitionFactory = new sk.yoz.ycanvas.map.partitions.PartitionFactory(loc3, loc5, loc4);
            this.map.addEventListener(sk.yoz.ycanvas.map.events.CanvasEvent.TRANSFORMATION_FINISHED, this.onMapTransformationFinished);
            this.map.addMapLayer(this.strokeLayer);
            this.map.addMapLayer(this.markerLayer);
            if (this.map.config.forTouch) 
            {
                this.transformationManager = new sk.yoz.ycanvas.map.managers.TouchTransformationManager(this.map, loc2);
            }
            else 
            {
                this.transformationManager = new sk.yoz.ycanvas.map.managers.MouseTransformationManager(this.map, loc2);
            }
            return;
        }

        public function updateCenter(arg1:Number, arg2:Number):void
        {
            var loc1:*=new sk.yoz.ycanvas.map.valueObjects.Transformation();
            loc1.centerX = frontend.components.map.GeoUtils.lon2x(arg2);
            loc1.centerY = frontend.components.map.GeoUtils.lat2y(arg1);
            loc1.rotation = 0;
            loc1.scale = 1;
            this.map.center = new flash.geom.Point(loc1.centerX, loc1.centerY);
            this.map.scale = loc1.scale;
            this.map.rotation = loc1.rotation;
            return;
        }

        public function updateConfig():void
        {
            this.map.config = createMapConfig();
            this.map.render();
            return;
        }

        public function addTouchEvents():void
        {
            this.transformationManager.allowMove = true;
            this.transformationManager.allowZoom = true;
            this.transformationManager.allowRotate = false;
            return;
        }

        public function removeTouchEvents():void
        {
            this.transformationManager.allowMove = false;
            this.transformationManager.allowZoom = false;
            this.transformationManager.allowRotate = false;
            return;
        }

        public function addMarkerTouchEvent():void
        {
            this.markerLayer.addEventListener(starling.events.TouchEvent.TOUCH, this.onMarkerLayerTouch);
            return;
        }

        public function dispose():void
        {
            this.markerLayer.removeEventListener(starling.events.TouchEvent.TOUCH, this.onMarkerLayerTouch);
            this.map.removeEventListener(sk.yoz.ycanvas.map.events.CanvasEvent.TRANSFORMATION_FINISHED, this.onMapTransformationFinished);
            this.map.dispose();
            this.map = null;
            this.removeTouchEvents();
            this.transformationManager.dispose();
            this.transformationManager = null;
            this.strokeLayer = null;
            this.markerLayer = null;
            return;
        }

        internal function onMapTransformationFinished(arg1:sk.yoz.ycanvas.map.events.CanvasEvent):void
        {
            if (!this.strokeLayer.autoUpdateThickness) 
            {
                this.strokeLayer.updateThickness();
            }
            return;
        }

        internal function onMarkerLayerTouch(arg1:starling.events.TouchEvent):void
        {
            if (arg1.getTouch(this.map.display, starling.events.TouchPhase.ENDED)) 
            {
                if (this.markerTouchFunction != null) 
                {
                    this.markerTouchFunction(arg1.target as starling.display.DisplayObject);
                }
            }
            return;
        }

        public static function get LAYER_CACHE_SUBDIR():String
        {
            _LAYER_CACHE_SUBDIR = configCache.ConfigCache.getInstance().getValue(frontend.components.map.MapLayerOptions.CONFIG_LAYER_CACHE_SUBDIR, frontend.components.map.MapLayerOptions.URL_DEFAULT);
            return _LAYER_CACHE_SUBDIR;
        }

        public static function set LAYER_CACHE_SUBDIR(arg1:String):void
        {
            _LAYER_CACHE_SUBDIR = arg1;
            configCache.ConfigCache.getInstance().setValue(frontend.components.map.MapLayerOptions.CONFIG_LAYER_CACHE_SUBDIR, arg1);
            return;
        }

        public static function get LAYER_OPTION():String
        {
            _LAYER_OPTION = configCache.ConfigCache.getInstance().getValue(frontend.components.map.MapLayerOptions.CONFIG_ID, frontend.components.map.MapLayerOptions.URL_MAP + frontend.components.map.MapLayerOptions.URL_DEFAULT);
            return _LAYER_OPTION;
        }

        public static function set LAYER_OPTION(arg1:String):void
        {
            _LAYER_OPTION = arg1;
            configCache.ConfigCache.getInstance().setValue(frontend.components.map.MapLayerOptions.CONFIG_ID, arg1);
            return;
        }

        internal static function createMapConfig():sk.yoz.ycanvas.map.valueObjects.MapConfig
        {
            var loc1:*=new sk.yoz.ycanvas.map.valueObjects.MapConfig();
            loc1.urlTemplates = Vector.<String>([frontend.components.map.MapLayerOptions.getLayerURL(LAYER_OPTION)]);
            loc1.tileWidth = TILE_WIDTH;
            loc1.tileHeight = TILE_WIDTH;
            loc1.forTouch = !handler.ApplicationHandler.isSimulator;
            return loc1;
        }

        internal static const TILE_WIDTH:Number=256;

        public var map:sk.yoz.ycanvas.map.YCanvasMap;

        public var markerLayer:sk.yoz.ycanvas.map.display.MarkerLayer;

        public var markerTouchFunction:Function;

        public var strokeLayer:sk.yoz.ycanvas.map.display.StrokeLayer;

        public var transformationManager:sk.yoz.ycanvas.map.managers.AbstractTransformationManager;

        internal static var _LAYER_CACHE_SUBDIR:String;

        internal static var _LAYER_OPTION:String;
    }
}


//    class MapLayerOptions
package frontend.components.map 
{
    import __AS3__.vec.*;
    import configCache.*;
    import flash.filesystem.*;
    import utils.*;
    
    public class MapLayerOptions extends Object
    {
        public function MapLayerOptions()
        {
            super();
            return;
        }

        public static function get BASE_CACHE_DIRECTORY():String
        {
            return flash.filesystem.File.cacheDirectory.nativePath + "/mapcache/";
        }

        public static function get CACHE_DIRECTORY():String
        {
            return BASE_CACHE_DIRECTORY + frontend.components.map.MapHelperMain.LAYER_CACHE_SUBDIR + "/";
        }

        public static function get CACHING_ENABLED():Boolean
        {
            return configCache.ConfigCache.getInstance().getValue(configCache.ConfigCacheAttributeNames.ENABLE_MAP_CACHING, true) as Boolean;
        }

        public static function getLayerVector():__AS3__.vec.Vector.<Object>
        {
            var loc1:*=new Vector.<Object>();
            var loc2:*=new Object();
            loc2.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT");
            loc2.data = URL_MAP + URL_DEFAULT;
            loc2.layer = URL_DEFAULT;
            loc1.push(loc2);
            var loc3:*=new Object();
            loc3.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT_HILLSHADING");
            loc3.data = URL_MAP + URL_DEFAULT_HILLSHADING;
            loc3.layer = URL_DEFAULT_HILLSHADING;
            loc1.push(loc3);
            var loc4:*=new Object();
            loc4.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT_ALTITUDE_LAYER");
            loc4.data = URL_MAP + URL_DEFAULT_ALTITUDE_LAYER;
            loc4.layer = URL_DEFAULT_ALTITUDE_LAYER;
            loc1.push(loc4);
            var loc5:*=new Object();
            loc5.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT_CYCLEWAYS");
            loc5.data = URL_MAP + URL_DEFAULT_CYCLEWAYS;
            loc5.layer = URL_DEFAULT_CYCLEWAYS;
            loc1.push(loc5);
            var loc6:*=new Object();
            loc6.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT_HILLSHADING_ALTITUDE");
            loc6.data = URL_MAP + URL_DEFAULT_HILLSHADING_ALTITUDE;
            loc6.layer = URL_DEFAULT_HILLSHADING_ALTITUDE;
            loc1.push(loc6);
            var loc7:*=new Object();
            loc7.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT_HILLSHADING_CYCLEWAYS");
            loc7.data = URL_MAP + URL_DEFAULT_HILLSHADING_CYCLEWAYS;
            loc7.layer = URL_DEFAULT_HILLSHADING_CYCLEWAYS;
            loc1.push(loc7);
            var loc8:*=new Object();
            loc8.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT_ALTITUDE_CYCLEWAYS");
            loc8.data = URL_MAP + URL_DEFAULT_ALTITUDE_CYCLEWAYS;
            loc8.layer = URL_DEFAULT_ALTITUDE_CYCLEWAYS;
            loc1.push(loc8);
            var loc9:*=new Object();
            loc9.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_DEFAULT_HILLSHADING_ALTITUDE_CYCLEWAYS");
            loc9.data = URL_MAP + URL_DEFAULT_HILLSHADING_ALTITUDE_CYCLEWAYS;
            loc9.layer = URL_DEFAULT_HILLSHADING_ALTITUDE_CYCLEWAYS;
            loc1.push(loc9);
            var loc10:*=new Object();
            loc10.label = utils.LanguageManager.getString("MAP_LAYER_OPTION_MAPBOX");
            loc10.data = URL_MAP_BOX;
            loc10.layer = URL_DEFAULT_MAP_BOX_LAYERDIR;
            loc1.push(loc10);
            return loc1;
        }

        public static function getLayerURL(arg1:String):Array
        {
            var loc1:*=[];
            var loc2:*="${z}/${x}/${y}.png";
            loc1.push(arg1 + loc2);
            return loc1;
        }

        public static const ALTITUDE_LINES:String="AltitudeLines";

        public static const BING_MAP:String="SatteliteBing";

        public static const CONFIG_ID:String="mapLayer";

        public static const CONFIG_LAYER_CACHE_SUBDIR:String="mapLayerCacheSubDir";

        public static const CYCLEWAYS:String="Cycleways";

        public static const DEFAULT:String="Default";

        public static const HILLSHADING:String="Hillshading";

        public static const MAP_BOX_SATTELITE:String="SatteliteMapBox";

        public static const MAP_LIST_GPSIES_TRACKS:String="gpsiesTracks";

        public static const MAP_LIST_OWN_TRACKS:String="ownTracks";

        public static const OVERLAY_CYCLEWAYS:String="OverlayCycleways";

        public static const OVERLAY_NONE:String="OverlayNone";

        public static const OVERLAY_STREETS:String="OverlayStreets";

        public static const URL_DEFAULT:String="layer1/";

        public static const URL_DEFAULT_ALTITUDE_CYCLEWAYS:String="layer7/";

        public static const URL_DEFAULT_ALTITUDE_LAYER:String="layer3/";

        public static const URL_DEFAULT_CYCLEWAYS:String="layer4/";

        public static const URL_DEFAULT_HILLSHADING:String="layer2/";

        public static const URL_DEFAULT_HILLSHADING_ALTITUDE:String="layer5/";

        public static const URL_DEFAULT_HILLSHADING_ALTITUDE_CYCLEWAYS:String="layer8/";

        public static const URL_DEFAULT_HILLSHADING_CYCLEWAYS:String="layer6/";

        public static const URL_DEFAULT_MAP_BOX_LAYERDIR:String="mapbox/";

        public static const URL_MAP:String="https://tiles1.sigma-dc-control.com/";

        public static const URL_MAP_BOX:String="https://api.tiles.mapbox.com/v2/sigmasport.map-ivt2yzq4/";

        public static const URL_MAP_BOX_STREET:String="layer9/";
    }
}


//    class MapView
package frontend.components.map 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import configCache.*;
    import core.general.*;
    import core.marker.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.popup.*;
    import handler.*;
    import sk.yoz.ycanvas.map.display.*;
    import sk.yoz.ycanvas.map.layers.*;
    import sk.yoz.ycanvas.map.managers.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.textures.*;
    import utils.*;
    
    public class MapView extends feathers.controls.LayoutGroup
    {
        public function MapView()
        {
            super();
            layout = new feathers.layout.AnchorLayout();
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }

        public function focusTrack():void
        {
            if (this.track) 
            {
                this.focusElement(this.track);
            }
            return;
        }

        public function showStartMarker(arg1:Number, arg2:Number):void
        {
            if (!this.startMarker) 
            {
                this.startMarker = this.createMarker(frontend.Textures.mapstarticon, arg1, arg2);
            }
            if (this.startMarker && !mapMain.markerLayer.contains(this.startMarker)) 
            {
                mapMain.markerLayer.add(this.startMarker);
            }
            return;
        }

        public function get mapLockActivated():Boolean
        {
            return this._mapLockActivated;
        }

        public function set mapLockActivated(arg1:Boolean):void
        {
            this._mapLockActivated = arg1;
            this.validateMapTouch();
            return;
        }

        public function showEndMarker(arg1:Number, arg2:Number):void
        {
            if (!this.endMarker) 
            {
                this.endMarker = this.createMarker(frontend.Textures.mapstopicon, arg1, arg2);
            }
            if (this.endMarker && !mapMain.markerLayer.contains(this.endMarker)) 
            {
                mapMain.markerLayer.add(this.endMarker);
            }
            return;
        }

        public function setPointNavigationMarker(arg1:Number, arg2:Number):void
        {
            if (!this.pointNavigationMarker) 
            {
                this.pointNavigationMarker = this.createMarker(frontend.Textures.mapstopicon, arg1, arg2);
            }
            if (this.pointNavigationMarker) 
            {
                if (mapMain.markerLayer.contains(this.pointNavigationMarker)) 
                {
                    this.updateMarkerPos(this.pointNavigationMarker as starling.display.Image, arg1, arg2);
                }
                else 
                {
                    mapMain.markerLayer.add(this.pointNavigationMarker);
                }
            }
            return;
        }

        public function showActivityMarkers(arg1:__AS3__.vec.Vector.<core.marker.Marker>):void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc2:*=arg1.length;
            var loc4:*="";
            this._markerDic = new flash.utils.Dictionary();
            this._calloutDic = new flash.utils.Dictionary();
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = arg1[loc1];
                var loc8:*=loc3.type;
                switch (loc8) 
                {
                    case core.general.MarkerType.LAP:
                    {
                        loc5 = frontend.Textures.maplapbubble;
                        loc4 = (loc3.number + 1).toString();
                        break;
                    }
                    case core.general.MarkerType.AUTO_LAP:
                    {
                        loc5 = frontend.Textures.autoLapBubble;
                        loc4 = (loc3.number + 1).toString();
                        break;
                    }
                }
                loc6 = this.createMarker(loc5, loc3.latitude, loc3.longitude, loc4);
                if (loc6) 
                {
                    mapMain.markerLayer.add(loc6);
                    this._markerDic[loc6] = loc3;
                    loc7 = this.createCallout(loc3);
                    if (loc7) 
                    {
                        mapMain.markerLayer.add(loc7);
                        this._calloutDic[loc6] = loc7;
                    }
                }
                ++loc1;
            }
            return;
        }

        public function setMapCenterToPointNavigation():void
        {
            if (!this.pointNavigationMarker) 
            {
                return;
            }
            mapMain.transformationManager.showBoundsTween(this.pointNavigationMarker.bounds.left, this.pointNavigationMarker.bounds.right, this.pointNavigationMarker.bounds.top, this.pointNavigationMarker.bounds.bottom + this.pointNavigationMarker.height);
            return;
        }

        internal function createMarker(arg1:String, arg2:Number, arg3:Number, arg4:String=""):starling.display.DisplayObject
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (arg2 == 0 && arg3 == 0) 
            {
                return null;
            }
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTexture(arg1);
            if (loc1) 
            {
                loc3 = new starling.display.Image(loc1);
                if (arg4 == "") 
                {
                    loc2 = loc3;
                }
                else 
                {
                    loc4 = new feathers.controls.Label();
                    loc4.text = arg4;
                    loc4.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                    loc5 = new feathers.controls.LayoutGroup();
                    loc5.touchGroup = true;
                    loc5.addChild(loc3);
                    loc5.addChild(loc4);
                    loc4.validate();
                    loc4.x = (loc1.width - loc4.width) / 2;
                    loc4.y = 8 * SIGMALink.scaleFactor;
                    loc2 = loc5;
                }
            }
            loc2.x = frontend.components.map.GeoUtils.lon2x(arg3);
            loc2.y = frontend.components.map.GeoUtils.lat2y(arg2);
            loc2.pivotX = loc1.width / 2;
            loc2.pivotY = loc1.height;
            return loc2;
        }

        internal function updateMarkerPos(arg1:starling.display.DisplayObject, arg2:Number, arg3:Number):void
        {
            arg1.x = frontend.components.map.GeoUtils.lon2x(arg3);
            arg1.y = frontend.components.map.GeoUtils.lat2y(arg2);
            if (arg1 is starling.display.Image) 
            {
                arg1.pivotX = (arg1 as starling.display.Image).texture.width / 2;
                arg1.pivotY = (arg1 as starling.display.Image).texture.height;
            }
            return;
        }

        internal function createCallout(arg1:core.marker.Marker):starling.display.DisplayObject
        {
            var loc5:*=null;
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.markerPopUpBackground);
            var loc2:*=new flash.geom.Rectangle(loc1.width - BORDER_RADIUS * 2, BORDER_RADIUS, BORDER_RADIUS, loc1.height - BORDER_RADIUS - ARROW_HEIGHT);
            var loc3:*=SIGMALink.appWidth - 2 * OUTER_PADDING;
            var loc4:*=new starling.display.Image(loc1);
            loc4.scale9Grid = loc2;
            var loc6:*=new feathers.controls.LayoutGroup();
            loc6.layout = new feathers.layout.HorizontalLayout();
            (loc6.layout as feathers.layout.HorizontalLayout).gap = 3 * BORDER_RADIUS;
            (loc6.layout as feathers.layout.HorizontalLayout).verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            var loc7:*=new feathers.controls.Label();
            loc7.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_LAP") + " " + (arg1.number + 1);
            loc7.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            loc6.addChild(loc7);
            var loc8:*=new feathers.controls.LayoutGroup();
            loc8.layout = new feathers.layout.HorizontalLayout();
            (loc8.layout as feathers.layout.HorizontalLayout).gap = 3 * BORDER_RADIUS;
            (loc8.layout as feathers.layout.HorizontalLayout).verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            var loc9:*=new feathers.controls.Label();
            loc9.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DISTANCE");
            loc9.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_ITALIC;
            loc8.addChild(loc9);
            var loc10:*=new feathers.controls.Label();
            loc10.text = arg1.distanceOutputString;
            loc10.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            loc8.addChild(loc10);
            var loc11:*=new feathers.controls.Label();
            loc11.text = backend.utils.DataUtils.unitStringDistance;
            loc11.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            loc8.addChild(loc11);
            loc8.validate();
            var loc12:*=new feathers.controls.LayoutGroup();
            loc12.layout = new feathers.layout.HorizontalLayout();
            (loc12.layout as feathers.layout.HorizontalLayout).gap = 3 * BORDER_RADIUS;
            (loc12.layout as feathers.layout.HorizontalLayout).paddingBottom = 3 * BORDER_RADIUS;
            (loc12.layout as feathers.layout.HorizontalLayout).verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            var loc13:*=new feathers.controls.Label();
            loc13.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_LAPTIME");
            loc13.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_ITALIC;
            loc12.addChild(loc13);
            var loc14:*=new feathers.controls.Label();
            loc14.text = arg1.timeOutputString;
            loc14.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            loc12.addChild(loc14);
            var loc15:*=new feathers.controls.Label();
            loc15.text = backend.utils.DataUtils.unitStringTimeHours;
            loc15.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            loc12.addChild(loc15);
            loc12.validate();
            var loc16:*=new feathers.layout.VerticalLayout();
            loc16.padding = 3 * BORDER_RADIUS;
            loc16.gap = 3 * BORDER_RADIUS;
            var loc17:*=new starling.display.Quad(1, 1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            var loc18:*=new starling.display.Quad(1, 1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            var loc19:*=new feathers.controls.LayoutGroup();
            loc19.layout = loc16;
            loc19.backgroundSkin = loc4;
            loc19.touchGroup = true;
            loc19.addChild(loc6);
            loc19.addChild(loc17);
            loc19.addChild(loc8);
            loc19.addChild(loc18);
            loc19.addChild(loc12);
            loc19.validate();
            var loc20:*=loc19.width - loc16.padding * 2 - (loc8.layout as feathers.layout.HorizontalLayout).gap * 2 - loc10.width - loc11.width;
            var loc21:*=loc19.width - loc16.padding * 2 - (loc12.layout as feathers.layout.HorizontalLayout).gap * 2 - loc14.width - loc15.width;
            var loc22:*=Math.max(loc20, loc21);
            var loc23:*=loc10.width;
            var loc24:*=loc14.width;
            var loc25:*=Math.max(loc23, loc24);
            var loc26:*=loc11.width;
            var loc27:*=loc15.width;
            var loc28:*=Math.max(loc26, loc27);
            loc9.width = loc22;
            loc10.width = loc25;
            loc13.width = loc22;
            loc14.width = loc25;
            var loc29:*;
            loc18.width = loc29 = loc22 + loc25 + loc28 + (loc8.layout as feathers.layout.HorizontalLayout).gap * 2;
            loc17.width = loc29;
            loc5 = loc19;
            loc5.x = frontend.components.map.GeoUtils.lon2x(arg1.longitude);
            loc5.y = frontend.components.map.GeoUtils.lat2y(arg1.latitude);
            loc5.pivotX = loc1.width / 2;
            loc5.pivotY = loc19.height;
            loc5.visible = false;
            return loc5;
        }

        internal function markerCallout(arg1:starling.display.DisplayObject):void
        {
            var loc3:*=null;
            if (!this._calloutDic) 
            {
                return;
            }
            if (!(this._currentCallout == null) && this._calloutDic[this._currentCallout]) 
            {
                this._calloutDic[this._currentCallout].visible = false;
            }
            var loc1:*=this._calloutDic[arg1] as starling.display.DisplayObject;
            var loc2:*=this._markerDic[arg1] as core.marker.Marker;
            if (loc1) 
            {
                mapMain.markerLayer.swapChildrenAt(mapMain.markerLayer.getChildIndex(loc1), (mapMain.markerLayer.numChildren - 1));
                loc1.visible = true;
                this.focusElement(loc1);
                this._currentCallout = arg1;
            }
            else if (this.markerCalloutTouchCallback != null) 
            {
                loc3 = this._markerDic[this._currentCallout];
                this.markerCalloutTouchCallback(loc3);
            }
            return;
        }

        public function showControls():void
        {
            if (this.showLockButton) 
            {
                this.iconLockButton = new frontend.components.button.IconButton();
                this.iconLockButton.image = frontend.Textures.lockbutton;
                this.iconLockButton.touchHandler = this.onLockButtonTouch;
                this.iconLockButton.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING, PADDING);
                addChild(this.iconLockButton);
            }
            if (this.showFocusButton) 
            {
                this.focusButton = new frontend.components.button.IconButton();
                this.focusButton.image = frontend.Textures.focusTrackButton;
                this.focusButton.touchHandler = this.onFocusButtonTouch;
                this.focusButton.layoutData = new feathers.layout.AnchorLayoutData(PADDING, PADDING);
                addChild(this.focusButton);
            }
            if (this.showLayerButton) 
            {
                this.layerButton = new frontend.components.button.IconButton();
                this.layerButton.image = frontend.Textures.mapLayerButton;
                this.layerButton.touchHandler = this.onLayerButtonTouch;
                this.layerButton.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, PADDING, PADDING);
                addChild(this.layerButton);
            }
            if (this.showSearchButton) 
            {
                this.searchButton = new frontend.components.button.IconButton();
                this.searchButton.image = frontend.Textures.locationSearchIcon;
                this.searchButton.touchHandler = this.onSearchButtonTouch;
                this.searchButton.layoutData = new feathers.layout.AnchorLayoutData(PADDING, NaN, NaN, PADDING);
                addChild(this.searchButton);
            }
            if (this._validateMapTouchFlag) 
            {
                this.validateMapTouch();
            }
            return;
        }

        internal function removeTrack():void
        {
            if (this.track) 
            {
                if (mapMain.strokeLayer.contains(this.track)) 
                {
                    mapMain.strokeLayer.remove(this.track);
                }
                this.track.dispose();
                this.track = null;
            }
            return;
        }

        internal function removeMarkers():void
        {
            var loc1:*=undefined;
            if (this.startMarker && mapMain.markerLayer.contains(this.startMarker)) 
            {
                mapMain.markerLayer.remove(this.startMarker);
            }
            if (this.endMarker && mapMain.markerLayer.contains(this.endMarker)) 
            {
                mapMain.markerLayer.remove(this.endMarker);
            }
            if (this.pointNavigationMarker && mapMain.markerLayer.contains(this.pointNavigationMarker)) 
            {
                mapMain.markerLayer.remove(this.pointNavigationMarker);
            }
            var loc2:*=0;
            var loc3:*=this._markerDic;
            for (loc1 in loc3) 
            {
                mapMain.markerLayer.remove(loc1);
                delete this._markerDic[loc1];
            }
            loc2 = 0;
            loc3 = this._calloutDic;
            for (loc1 in loc3) 
            {
                mapMain.markerLayer.remove(this._calloutDic[loc1]);
                delete this._calloutDic[loc1];
            }
            this.startMarker = null;
            this.endMarker = null;
            return;
        }

        internal function removeMap():void
        {
            if (!mapMain) 
            {
                return;
            }
            this.mapLockActivated = false;
            removeChild(mapMain.map.display);
            mapMain.dispose();
            mapMain = null;
            return;
        }

        internal function removeControls():void
        {
            if (contains(this.iconLockButton)) 
            {
                removeChild(this.iconLockButton);
            }
            if (contains(this.focusButton)) 
            {
                removeChild(this.focusButton);
            }
            if (contains(this.layerButton)) 
            {
                removeChild(this.layerButton);
            }
            if (contains(this.zoomOutButton)) 
            {
                removeChild(this.zoomOutButton);
            }
            if (contains(this.zoomInButton)) 
            {
                removeChild(this.zoomInButton);
            }
            return;
        }

        internal function validateMapTouch():void
        {
            if (!mapMain) 
            {
                this._validateMapTouchFlag = true;
                return;
            }
            this._validateMapTouchFlag = false;
            if (this._mapLockActivated || this.leftMenuOpen) 
            {
                mapMain.removeTouchEvents();
                if (this.iconLockButton) 
                {
                    this.iconLockButton.image = frontend.Textures.lockbutton;
                }
            }
            else 
            {
                mapMain.addTouchEvents();
                if (this.iconLockButton) 
                {
                    this.iconLockButton.image = frontend.Textures.unlockbutton;
                }
            }
            dispatchEvent(new starling.events.Event(MAP_LOCK_CHANGED));
            return;
        }

        internal function onZoomInButtonTriggered():void
        {
            mapMain.transformationManager.scaleByTween(sk.yoz.ycanvas.map.layers.LayerFactory.CUSTOM_SCALE_STEPS);
            return;
        }

        internal function onZoomOutButtonTriggered():void
        {
            mapMain.transformationManager.scaleByTween(1 / sk.yoz.ycanvas.map.layers.LayerFactory.CUSTOM_SCALE_STEPS);
            return;
        }

        internal function onLockButtonTouch(arg1:starling.events.TouchEvent):void
        {
            this.mapLockActivated = !this.mapLockActivated;
            return;
        }

        internal function onFocusButtonTouch(arg1:starling.events.TouchEvent):void
        {
            if (this.mapFocusCallback == null) 
            {
                this.focusElement(this.track);
            }
            else 
            {
                this.mapFocusCallback();
            }
            return;
        }

        internal function onLayerButtonTouch(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=new frontend.components.menuList.editors.SpinnerEditor();
            loc1.dataProvider = new feathers.data.ListCollection(frontend.components.map.MapLayerOptions.getLayerVector());
            loc1.owner = new frontend.components.menuList.MenuListItem();
            loc1.rawValue = configCache.ConfigCache.getInstance().getValue(frontend.components.map.MapLayerOptions.CONFIG_ID, frontend.components.map.MapLayerOptions.DEFAULT);
            loc1.title = utils.LanguageManager.getString("LAYER_SELECT_POPUP_TITLE");
            loc1.saveCompleteCallback = this.onLayerSelectionChanged;
            frontend.components.popup.PopUpBase.showModalPopUp(loc1, true, false);
            return;
        }

        internal function onSearchButtonTouch(arg1:starling.events.TouchEvent):void
        {
            if (this.mapSearchCallback != null) 
            {
                this.mapSearchCallback();
            }
            return;
        }

        public function focusElement(arg1:starling.display.DisplayObject):void
        {
            if (!arg1) 
            {
                return;
            }
            var loc1:*=3000 * SIGMALink.scaleFactor;
            mapMain.transformationManager.showBoundsTween(arg1.bounds.left - loc1, arg1.bounds.right + loc1, arg1.bounds.top - loc1, arg1.bounds.bottom + loc1);
            return;
        }

        internal function mapTouchHandler(arg1:flash.events.MouseEvent):void
        {
            if (this._calloutDic && this._calloutDic[this._currentCallout]) 
            {
                this._calloutDic[this._currentCallout].visible = false;
            }
            return;
        }

        public override function dispose():void
        {
            removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            starling.core.Starling.current.nativeStage.removeEventListener(flash.events.MouseEvent.CLICK, this.mapTouchHandler);
            super.dispose();
            return;
        }

        internal function onAddedToStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.EVENT_LEFT_MENU_TOGGLE_CHANGED, this.onLeftMenuToggleChanged);
            starling.core.Starling.current.nativeStage.addEventListener(flash.events.MouseEvent.CLICK, this.mapTouchHandler, false, 100);
            sk.yoz.ycanvas.map.managers.AbstractTransformationManager.yStartCorrection = this.yStartCorrection;
            this.mapLockActivated = this.showLockButton ? true : false;
            return;
        }

        internal function onRemovedFromStage(arg1:starling.events.Event):void
        {
            sk.yoz.ycanvas.map.managers.AbstractTransformationManager.yStartCorrection = 0;
            this.removeTrack();
            this.removeMarkers();
            this.removeMap();
            this.removeControls();
            starling.core.Starling.current.nativeStage.removeEventListener(flash.events.MouseEvent.CLICK, this.mapTouchHandler);
            handler.ViewHandler.getInstance().removeEventListener(handler.ViewHandler.EVENT_LEFT_MENU_TOGGLE_CHANGED, this.onLeftMenuToggleChanged);
            return;
        }

        internal function onLeftMenuToggleChanged(arg1:starling.events.Event):void
        {
            this.leftMenuOpen = arg1.data as Boolean;
            this.validateStarlingClickEvent();
            return;
        }

        internal function validateStarlingClickEvent():void
        {
            if (this.leftMenuOpen) 
            {
                touchable = false;
                hideFocus();
                handler.ViewHandler.getInstance().openMainMenuOnSwipe(false);
            }
            else 
            {
                touchable = true;
                showFocus();
                handler.ViewHandler.getInstance().openMainMenuOnSwipe(true);
            }
            return;
        }

        public function showMap(arg1:Number, arg2:Number):void
        {
            if (mapMain) 
            {
                mapMain.dispose();
            }
            mapMain = new frontend.components.map.MapHelperMain(arg1, arg2);
            mapMain.map.display.width = width;
            mapMain.map.display.height = height;
            mapMain.markerTouchFunction = this.markerCallout;
            addChild(mapMain.map.display);
            mapMain.addMarkerTouchEvent();
            return;
        }

        public function getCenterLatitude():Number
        {
            return frontend.components.map.GeoUtils.y2lat(mapMain.map.center.y);
        }

        public function getCenterLongitude():Number
        {
            return frontend.components.map.GeoUtils.x2lon(mapMain.map.center.x);
        }

        internal function onLayerSelectionChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            frontend.components.map.MapHelperMain.LAYER_OPTION = arg2.rawValue.toString();
            frontend.components.map.MapHelperMain.LAYER_CACHE_SUBDIR = arg2.selectedDataProviderItem.layer;
            mapMain.updateConfig();
            return;
        }

        public function setMapCenterToLocation(arg1:Number, arg2:Number):void
        {
            var loc1:*=frontend.components.map.GeoUtils.lon2x(arg2);
            var loc2:*=frontend.components.map.GeoUtils.lat2y(arg1);
            mapMain.transformationManager.showBoundsTween(loc1, loc1, loc2, loc2);
            return;
        }

        public function showActivityTrack(arg1:__AS3__.vec.Vector.<core.activities.ActivityEntry>):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            if (!this.track) 
            {
                loc2 = arg1.length;
                loc3 = new Vector.<Number>();
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    if (!(arg1[loc1].longitude == 0) && !(arg1[loc1].latitude == 0)) 
                    {
                        loc3 = this.addTrackPoint(loc3, arg1[loc1].longitude, arg1[loc1].latitude);
                    }
                    ++loc1;
                }
                if (loc3.length == 0) 
                {
                    return;
                }
                this.createTrack(loc3);
            }
            if (!mapMain.strokeLayer.contains(this.track)) 
            {
                mapMain.strokeLayer.add(this.track);
            }
            this.focusElement(this.track);
            return;
        }

        public function showRouteTrack(arg1:__AS3__.vec.Vector.<core.route.RoutePoint>):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            if (!this.track) 
            {
                loc2 = arg1.length;
                loc3 = new Vector.<Number>();
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    if (!(arg1[loc1].longitude == 0) && !(arg1[loc1].latitude == 0)) 
                    {
                        loc3 = this.addTrackPoint(loc3, arg1[loc1].longitude, arg1[loc1].latitude);
                    }
                    ++loc1;
                }
                if (loc3.length == 0) 
                {
                    return;
                }
                this.createTrack(loc3);
            }
            if (!mapMain.strokeLayer.contains(this.track)) 
            {
                mapMain.strokeLayer.add(this.track);
            }
            this.focusElement(this.track);
            return;
        }

        internal function createTrack(arg1:__AS3__.vec.Vector.<Number>):void
        {
            this.track = new sk.yoz.ycanvas.map.display.MapStroke(arg1, 5 * SIGMALink.scaleFactor, core.general.Colors.DARK_BLUE, 0.6);
            this.track.simplifyTolerance = 1;
            return;
        }

        internal function addTrackPoint(arg1:__AS3__.vec.Vector.<Number>, arg2:Number, arg3:Number):__AS3__.vec.Vector.<Number>
        {
            arg1.push(frontend.components.map.GeoUtils.lon2x(arg2));
            arg1.push(frontend.components.map.GeoUtils.lat2y(arg3));
            return arg1;
        }

        public static const MAP_LOCK_CHANGED:String="mapLockChanged";

        internal static const ARROW_HEIGHT:Number=30 * SIGMALink.scaleFactor;

        internal static const BORDER_RADIUS:Number=5 * SIGMALink.scaleFactor;

        internal static const OUTER_PADDING:Number=50 * SIGMALink.scaleFactor;

        internal static const PADDING:Number=10 * SIGMALink.scaleFactor;

        public var mapFocusCallback:Function;

        internal var _mapLockActivated:Boolean=true;

        public var mapSearchCallback:Function;

        public var markerCalloutTouchCallback:Function;

        public var showFocusButton:Boolean=true;

        public var showLockButton:Boolean=true;

        public var showSearchButton:Boolean=false;

        public var yStartCorrection:Number=0;

        internal var _calloutDic:flash.utils.Dictionary;

        internal var _currentCallout:starling.display.DisplayObject;

        internal var _markerDic:flash.utils.Dictionary;

        internal var _validateMapTouchFlag:Boolean=false;

        internal var endMarker:starling.display.DisplayObject;

        internal var focusButton:frontend.components.button.IconButton;

        internal var iconLockButton:frontend.components.button.IconButton;

        internal var layerButton:frontend.components.button.IconButton;

        internal var leftMenuOpen:Boolean=false;

        internal var pointNavigationMarker:starling.display.DisplayObject;

        internal var searchButton:frontend.components.button.IconButton;

        internal var startMarker:starling.display.DisplayObject;

        internal var track:sk.yoz.ycanvas.map.display.MapStroke;

        internal var zoomInButton:feathers.controls.Button;

        internal var zoomOutButton:feathers.controls.Button;

        public var showLayerButton:Boolean=true;

        internal static var mapMain:frontend.components.map.MapHelperMain;
    }
}


//    class MapXyzPartition
package frontend.components.map 
{
    public class MapXyzPartition extends Object
    {
        public function MapXyzPartition(arg1:String, arg2:String, arg3:String)
        {
            super();
            var loc1:*=arg3.split(".");
            this._dir1 = arg1;
            this._dir2 = arg2;
            this._extension = loc1.pop();
            this._filename = loc1.join("");
            return;
        }

        public function get dir1():String
        {
            return this._dir1;
        }

        public function get dir2():String
        {
            return this._dir2;
        }

        public function get extension():String
        {
            return this._extension;
        }

        public function get filename():String
        {
            return this._filename;
        }

        public function getPath():String
        {
            return this._dir1 + "/" + this._dir2 + "/" + this._filename + "." + this._extension;
        }

        internal var _dir1:String;

        internal var _dir2:String;

        internal var _extension:String;

        internal var _filename:String;
    }
}


//    class PartitionLoader
package frontend.components.map 
{
    import flash.display.*;
    import sk.yoz.ycanvas.map.partitions.*;
    
    public class PartitionLoader extends frontend.components.map.LoaderOptimizer implements sk.yoz.ycanvas.map.partitions.IPartitionLoader
    {
        public function PartitionLoader()
        {
            super();
            return;
        }

        public function disposeLoader(arg1:flash.display.Loader):void
        {
            release(arg1);
            return;
        }
    }
}


//    class URLRequestBuffer
package frontend.components.map 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    
    public class URLRequestBuffer extends flash.events.EventDispatcher
    {
        public function URLRequestBuffer(arg1:uint, arg2:uint=3000)
        {
            this.activeList = new Vector.<frontend.components.map.URLRequestBufferItem>();
            this.waitingList = new Vector.<frontend.components.map.URLRequestBufferItem>();
            super();
            this.maxRequests = Math.max(1, arg1);
            this.timeout = arg2;
            return;
        }

        public function get countActive():uint
        {
            return this.activeList.length;
        }

        public function get countWaiting():uint
        {
            return this.waitingList.length;
        }

        protected function get firstWaitingReadyItem():frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=null;
            var loc2:*=this.countWaiting;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1 = this.waitingList[loc3];
                if (loc1.ready) 
                {
                    return loc1;
                }
                ++loc3;
            }
            return null;
        }

        public function push(arg1:flash.events.EventDispatcher, arg2:flash.net.URLRequest, arg3:flash.system.LoaderContext=null, arg4:uint=0, arg5:uint=0):frontend.components.map.URLRequestBufferItem
        {
            var loc4:*;
            var loc5:*=((loc4 = this).nextID + 1);
            loc4.nextID = loc5;
            var loc1:*=this.getIndexForPriority(arg4);
            var loc2:*=new frontend.components.map.URLRequestBufferItem(this, this.nextID, arg1, arg2, arg3, arg4, arg5);
            this.waitingList.splice(loc1, 0, loc2);
            var loc3:*=frontend.components.map.URLRequestBufferEvent.WAITING_REQUEST_ADDED;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc3, false, false, loc2));
            this.loadNext();
            return loc2;
        }

        public function getWaitingItem(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            return this.waitingList[arg1];
        }

        public function getActiveItem(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            return this.activeList[arg1];
        }

        protected function getIndexForPriority(arg1:uint):uint
        {
            var loc1:*=this.countWaiting;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (arg1 > this.waitingList[loc2].priority) 
                {
                    return loc2;
                }
                ++loc2;
            }
            return loc1;
        }

        public function loadNext():void
        {
            if (this.countActive >= this.maxRequests || !this.countWaiting) 
            {
                return;
            }
            var loc1:*=this.firstWaitingReadyItem;
            if (!loc1) 
            {
                return;
            }
            this.removeWaitingById(loc1.id);
            this.createListeners(loc1.dispatcher);
            loc1.load();
            this.activeList.push(loc1);
            flash.utils.setTimeout(this.onTimeout, this.timeout, loc1.id);
            var loc2:*=frontend.components.map.URLRequestBufferEvent.ACTIVE_REQUEST_ADDED;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc2, false, false, loc1));
            this.loadNext();
            return;
        }

        protected function createListeners(arg1:flash.events.EventDispatcher):void
        {
            arg1.addEventListener(flash.events.Event.COMPLETE, this.onComplete);
            arg1.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onIOError);
            return;
        }

        protected function removeListeners(arg1:flash.events.EventDispatcher):void
        {
            arg1.removeEventListener(flash.events.Event.COMPLETE, this.onComplete);
            arg1.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onIOError);
            return;
        }

        protected function onComplete(arg1:flash.events.Event):void
        {
            var loc1:*=frontend.components.map.URLRequestBufferItem.getLoader(arg1);
            var loc2:*=this.getActiveByLoader(loc1);
            if (loc2) 
            {
                this.removeActiveById(loc2.id);
            }
            this.loadNext();
            return;
        }

        protected function onIOError(arg1:flash.events.IOErrorEvent):void
        {
            var loc1:*=frontend.components.map.URLRequestBufferItem.getLoader(arg1);
            var loc2:*=this.getActiveByLoader(loc1);
            if (loc2) 
            {
                this.removeActiveById(loc2.id);
            }
            this.loadNext();
            return;
        }

        protected function onTimeout(arg1:uint):void
        {
            var loc1:*=this.getActiveById(arg1);
            if (!loc1) 
            {
                return;
            }
            this.removeActiveById(arg1);
            var loc2:*=frontend.components.map.URLRequestBufferEvent.REQUEST_TIMEOUT;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc2, false, false, loc1));
            return;
        }

        public function getWaitingById(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.countWaiting;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this.waitingList[loc2].id == arg1) 
                {
                    return this.waitingList[loc2];
                }
                ++loc2;
            }
            return null;
        }

        public function getWaitingByLoader(arg1:flash.events.EventDispatcher):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.countWaiting;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this.waitingList[loc2].loader == arg1) 
                {
                    return this.waitingList[loc2];
                }
                ++loc2;
            }
            return null;
        }

        public function removeWaitingById(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.getWaitingById(arg1);
            if (!loc1) 
            {
                return null;
            }
            this.waitingList.splice(this.waitingList.indexOf(loc1), 1);
            var loc2:*=frontend.components.map.URLRequestBufferEvent.WAITING_REQUEST_REMOVED;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc2, false, false, loc1));
            return loc1;
        }

        public function getActiveById(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.countActive;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this.activeList[loc2].id == arg1) 
                {
                    return this.activeList[loc2];
                }
                ++loc2;
            }
            return null;
        }

        public function getActiveByLoader(arg1:flash.events.EventDispatcher):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.countActive;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this.activeList[loc2].loader == arg1) 
                {
                    return this.activeList[loc2];
                }
                ++loc2;
            }
            return null;
        }

        public function removeActiveById(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.getActiveById(arg1);
            if (!loc1) 
            {
                return null;
            }
            this.removeListeners(loc1.dispatcher);
            loc1.close();
            this.activeList.splice(this.activeList.indexOf(loc1), 1);
            var loc2:*=frontend.components.map.URLRequestBufferEvent.ACTIVE_REQUEST_REMOVED;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc2, false, false, loc1));
            this.loadNext();
            return loc1;
        }

        internal var activeList:__AS3__.vec.Vector.<frontend.components.map.URLRequestBufferItem>;

        internal var maxRequests:uint=2;

        internal var nextID:uint=0;

        internal var timeout:uint;

        internal var waitingList:__AS3__.vec.Vector.<frontend.components.map.URLRequestBufferItem>;
    }
}


//    class URLRequestBufferEvent
package frontend.components.map 
{
    import flash.events.*;
    
    public class URLRequestBufferEvent extends flash.events.Event
    {
        public function URLRequestBufferEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false, arg4:frontend.components.map.URLRequestBufferItem=null)
        {
            super(arg1, arg2, arg3);
            this._item = arg4;
            return;
        }

        public function get item():frontend.components.map.URLRequestBufferItem
        {
            return this._item;
        }

        public override function clone():flash.events.Event
        {
            return new frontend.components.map.URLRequestBufferEvent(type, bubbles, cancelable, this.item);
        }

        public static const ACTIVE_REQUEST_ADDED:String="URLRequestBufferActiveRequestAdded";

        public static const ACTIVE_REQUEST_REMOVED:String="URLRequestBufferActiveRequestRemoved";

        public static const REQUEST_TIMEOUT:String="URLRequestBufferRequestTimeout";

        public static const WAITING_REQUEST_ADDED:String="URLRequestBufferWaitingRequestAdded";

        public static const WAITING_REQUEST_REMOVED:String="URLRequestBufferWaitingRequestRemoved";

        internal var _item:frontend.components.map.URLRequestBufferItem;
    }
}


//    class URLRequestBufferItem
package frontend.components.map 
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    
    public class URLRequestBufferItem extends Object
    {
        public function URLRequestBufferItem(arg1:frontend.components.map.URLRequestBuffer, arg2:uint, arg3:flash.events.EventDispatcher, arg4:flash.net.URLRequest, arg5:flash.system.LoaderContext, arg6:uint, arg7:uint=0)
        {
            super();
            if (!(arg3 is flash.display.Loader || arg3 is flash.net.URLLoader)) 
            {
                throw new Error("loader must be instance of Loader or " + "URLLoader class");
            }
            this.buffer = arg1;
            this.id = arg2;
            this.loader = arg3;
            this.request = arg4;
            this.context = arg5;
            this.priority = arg6;
            this.delay = arg7;
            this._ready = arg7 ? false : true;
            if (arg7) 
            {
                flash.utils.setTimeout(this.onDelay, arg7);
            }
            return;
        }

        public function get dispatcher():flash.events.EventDispatcher
        {
            return this.loader is flash.display.Loader ? (this.loader as flash.display.Loader).contentLoaderInfo : this.loader as flash.net.URLLoader;
        }

        public function get ready():Boolean
        {
            return this._ready;
        }

        public function load():void
        {
            if (this.loader is flash.display.Loader) 
            {
                (this.loader as flash.display.Loader).load(this.request, this.context);
            }
            else if (this.loader is flash.net.URLLoader) 
            {
                (this.loader as flash.net.URLLoader).load(this.request);
            }
            return;
        }

        public function close():void
        {
            try 
            {
                if (this.loader is flash.display.Loader) 
                {
                    (this.loader as flash.display.Loader).close();
                }
                else if (this.loader is flash.net.URLLoader) 
                {
                    (this.loader as flash.net.URLLoader).close();
                }
            }
            catch (error:Error)
            {
            };
            return;
        }

        protected function onDelay(arg1:flash.events.TimerEvent):void
        {
            this._ready = true;
            this.buffer.loadNext();
            return;
        }

        public static function getLoader(arg1:flash.events.Event):flash.events.EventDispatcher
        {
            return arg1.target is flash.display.LoaderInfo ? (arg1.target as flash.display.LoaderInfo).loader : arg1.target as flash.net.URLLoader;
        }

        public var buffer:frontend.components.map.URLRequestBuffer;

        public var context:flash.system.LoaderContext;

        public var delay:uint;

        public var id:uint;

        public var loader:flash.events.EventDispatcher;

        public var priority:uint;

        protected var _ready:Boolean;

        public var request:flash.net.URLRequest;
    }
}


//  package menuList
//    package editors
//      package base
//        class EditorBase
package frontend.components.menuList.editors.base 
{
    import __AS3__.vec.*;
    import core.general.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.menuList.*;
    import frontend.components.popup.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class EditorBase extends feathers.controls.LayoutGroup
    {
        public function EditorBase()
        {
            this._dataProvider = new feathers.data.ListCollection();
            this._1973788148minItemHeight = 68 * SIGMALink.scaleFactor;
            this._806339567padding = 2 * SIGMALink.scaleFactor;
            this._titlePadding = 12 * SIGMALink.scaleFactor;
            super();
            layout = new feathers.layout.AnchorLayout();
            var loc2:*;
            this.editorWidth = loc2 = SIGMALink.appWidth;
            width = loc2;
            this.editorHeight = loc2 = SIGMALink.appHeight;
            height = loc2;
            x = 0;
            y = 0;
            this.rightHeaderText = utils.LanguageManager.getString("EDITOR_SAVE");
            var loc1:*=new starling.display.Quad(1, 1, core.general.Colors.BLACK);
            loc1.alpha = 0;
            backgroundSkin = loc1;
            return;
        }

        protected function setEditorWidth(arg1:Number):void
        {
            return;
        }

        public function get dataProvider():feathers.data.ListCollection
        {
            return this._dataProvider;
        }

        internal function set _339742651dataProvider(arg1:feathers.data.ListCollection):void
        {
            this._dataProvider = arg1;
            return;
        }

        public function get owner():frontend.components.menuList.MenuListItem
        {
            return this._106164915owner;
        }

        public function set owner(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._106164915owner;
            if (loc1 !== arg1) 
            {
                this._106164915owner = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "owner", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get editorHeight():Number
        {
            return this._1386997516editorHeight;
        }

        protected function createVerticalContentGroup():void
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            loc1.paddingBottom = this.padding;
            this.contentGroup = new feathers.controls.LayoutGroup();
            this.contentGroup.layout = loc1;
            this.contentGroup.width = SIGMALink.appWidth;
            this.contentGroup.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            return;
        }

        protected function set editorHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1386997516editorHeight;
            if (loc1 !== arg1) 
            {
                this._1386997516editorHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "editorHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get padding():uint
        {
            return this._806339567padding;
        }

        public function set padding(arg1:uint):void
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

        public function get rawValue():Object
        {
            return this._rawValue;
        }

        internal function set _494715433rawValue(arg1:Object):void
        {
            this._rawValue = arg1;
            return;
        }

        protected function get editorWidth():Number
        {
            return this._1000605607editorWidth;
        }

        protected function set editorWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1000605607editorWidth;
            if (loc1 !== arg1) 
            {
                this._1000605607editorWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "editorWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set rawValue(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.rawValue;
            if (loc1 !== arg1) 
            {
                this._494715433rawValue = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "rawValue", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get minItemHeight():Number
        {
            return this._1973788148minItemHeight;
        }

        public function set minItemHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1973788148minItemHeight;
            if (loc1 !== arg1) 
            {
                this._1973788148minItemHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "minItemHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set dataProvider(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.dataProvider;
            if (loc1 !== arg1) 
            {
                this._339742651dataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "dataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set saveCompleteCallback(arg1:Function):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._346085435saveCompleteCallback;
            if (loc1 !== arg1) 
            {
                this._346085435saveCompleteCallback = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "saveCompleteCallback", loc1, arg1, this);
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

        
        {
            gap = 17 * SIGMALink.scaleFactor;
        }

        protected function getRightHeaderContent():starling.display.DisplayObject
        {
            var loc1:*=new feathers.controls.Button();
            loc1.addEventListener(starling.events.TouchEvent.TOUCH, this.saveButtonTouchHandler);
            loc1.label = this.rightHeaderText;
            loc1.styleName = feathers.themes.CustomSIGMATheme.BUTTON_STYLE_REDBUTTON;
            var loc2:*=new feathers.layout.AnchorLayoutData();
            loc2.right = this.padding;
            loc2.verticalCenter = 0;
            loc1.layoutData = loc2;
            return loc1;
        }

        protected override function initialize():void
        {
            super.initialize();
            addEventListener(starling.events.TouchEvent.TOUCH, this.onTouch);
            this.addContentGroup();
            return;
        }

        protected function onOutsideTouch(arg1:starling.events.TouchEvent):void
        {
            this.closeEditor();
            return;
        }

        protected function onEditorTouch(arg1:starling.events.TouchEvent):void
        {
            debug.Debug.debug("onEditorTouch");
            return;
        }

        protected function getEditor():starling.display.DisplayObject
        {
            return new feathers.controls.LayoutGroup();
        }

        protected function getContentGroupLayoutData():feathers.layout.AnchorLayoutData
        {
            var ald:feathers.layout.AnchorLayoutData;

            var loc1:*;
            ald = null;
            ald = new feathers.layout.AnchorLayoutData();
            var loc2:*=this.orientation;
            switch (loc2) 
            {
                case ORIENTATION_INLINE:
                {
                    try 
                    {
                        ald.top = this.owner.getBounds(stage).top;
                    }
                    catch (e:Error)
                    {
                        ald.verticalCenter = 0;
                    }
                    break;
                }
                case ORIENTATION_CENTERED:
                {
                    ald.verticalCenter = 0;
                    break;
                }
            }
            return ald;
        }

        protected function getLeftHeaderContent():starling.display.DisplayObject
        {
            var loc1:*=new feathers.controls.Label();
            loc1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc1.text = this.title;
            var loc2:*=new feathers.layout.AnchorLayoutData();
            loc2.left = this._titlePadding;
            loc2.verticalCenter = 0;
            loc1.layoutData = loc2;
            return loc1;
        }

        public function get saveCompleteCallback():Function
        {
            return this._346085435saveCompleteCallback;
        }

        protected function saveButtonTouchHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.saveValue();
            this.closeEditor();
            return;
        }

        protected function saveValue():void
        {
            if (this.editorReturnObject && this.owner) 
            {
                this.owner.handleReturnValue(this.editorReturnObject);
            }
            if (this.saveCompleteCallback != null) 
            {
                this.saveCompleteCallback(this.owner, this.editorReturnObject);
            }
            return;
        }

        protected function closeEditor():void
        {
            frontend.components.popup.PopUpBase.removePopUps(this, true);
            return;
        }

        internal function onTouch(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=arg1.getTouches(arg1.target as starling.display.DisplayObject, starling.events.TouchPhase.BEGAN);
            if (loc1.length == 0) 
            {
                return;
            }
            if (arg1.target as feathers.controls.LayoutGroup == this) 
            {
                this.onOutsideTouch(arg1);
            }
            return;
        }

        protected function addContentGroup():void
        {
            this.addHeader();
            this.addContent();
            return;
        }

        protected function addHeader():void
        {
            this.headerGroup = new feathers.controls.LayoutGroup();
            this.headerGroup.layout = new feathers.layout.AnchorLayout();
            this.headerGroup.width = SIGMALink.appWidth;
            this.headerGroup.height = this.minItemHeight;
            this.headerGroup.addChild(this.getLeftHeaderContent());
            if (this.showSaveButton) 
            {
                this.headerGroup.addChild(this.getRightHeaderContent());
            }
            return;
        }

        protected function createHorizontalContentGroup():void
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            loc1.paddingBottom = this.padding;
            this.contentGroup = new feathers.controls.LayoutGroup();
            this.contentGroup.layout = loc1;
            this.contentGroup.width = SIGMALink.appWidth;
            this.contentGroup.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            return;
        }

        protected function addContent():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            this.createVerticalContentGroup();
            this.contentGroup.addChild(this.headerGroup);
            if (this.unitString == "") 
            {
                this.editorInputWidth = SIGMALink.appWidth - 2 * this.padding;
                this.contentGroup.addChild(this.getEditor());
            }
            else 
            {
                loc1 = new feathers.controls.Label();
                loc1.text = this.unitString;
                loc1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                loc2 = new feathers.layout.HorizontalLayout();
                loc2.gap = gap;
                loc2.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
                loc3 = new feathers.controls.LayoutGroup();
                loc3.layout = loc2;
                loc3.width = SIGMALink.appWidth - 2 * this.padding;
                loc3.addChild(loc1);
                this.contentGroup.addChild(loc3);
                loc1.validate();
                this.editorInputWidth = loc3.width - Math.max(50 * SIGMALink.scaleFactor, loc1.width) - gap;
                loc3.addChildAt(this.getEditor(), 0);
            }
            addChild(this.contentGroup);
            this.contentGroup.validate();
            this.contentGroup.layoutData = this.getContentGroupLayoutData();
            return;
        }

        public static const ORIENTATION_CENTERED:String="centered";

        public static const ORIENTATION_INLINE:String="inline";

        protected var _dataProvider:feathers.data.ListCollection;

        public var editorInputWidth:Number;

        public var editorReturnObject:frontend.components.menuList.editors.base.EditorReturnObject;

        internal var _1973788148minItemHeight:Number;

        internal var _106164915owner:frontend.components.menuList.MenuListItem;

        internal var _806339567padding:uint;

        internal var _rawValue:Object;

        public var rightHeaderText:String="";

        internal var _346085435saveCompleteCallback:Function;

        public var showSaveButton:Boolean=true;

        internal var _110371416title:String="";

        public var unitString:String="";

        public var useTween:Boolean=true;

        protected var _titlePadding:uint;

        protected var contentGroup:feathers.controls.LayoutGroup;

        protected var _1386997516editorHeight:Number;

        protected var _1000605607editorWidth:Number;

        protected var headerGroup:feathers.controls.LayoutGroup;

        public static var gap:Number;

        public var orientation:String="centered";
    }
}


//        class EditorClasses
package frontend.components.menuList.editors.base 
{
    import flash.utils.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.*;
    import frontend.components.menuList.editors.custom.*;
    
    public class EditorClasses extends Object
    {
        public function EditorClasses()
        {
            super();
            return;
        }

        internal static function initEditorClasses():void
        {
            editorClasses = new flash.utils.Dictionary();
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD] = frontend.components.menuList.editors.TextEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_AREA] = frontend.components.menuList.editors.TextAreaEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RADIO] = frontend.components.menuList.editors.RadioEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RATING] = frontend.components.menuList.editors.RatingEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CHECKBOX_MULTI] = frontend.components.menuList.editors.CheckBoxMultiEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATE] = frontend.components.menuList.editors.DateEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME] = frontend.components.menuList.editors.TimeEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATEIME] = frontend.components.menuList.editors.DateTimeEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER] = frontend.components.menuList.editors.SpinnerEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_SPORT] = frontend.components.menuList.editors.custom.SportMultiSelectEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT] = frontend.components.menuList.editors.custom.SportSingleSelectEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPORT_AND_NAME] = frontend.components.menuList.editors.custom.SportAndNameEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_UNIT_SELECTOR] = frontend.components.menuList.editors.custom.UnitEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_STRING] = frontend.components.menuList.editors.custom.StringMultiSelectEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER] = frontend.components.menuList.editors.NumberEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_ZONE] = frontend.components.menuList.editors.ZoneEditor;
            return;
        }

        public static function getEditor(arg1:String):*
        {
            if (editorClasses == null) 
            {
                initEditorClasses();
            }
            if (editorClasses.hasOwnProperty(arg1)) 
            {
                return editorClasses[arg1];
            }
            return null;
        }

        internal static var editorClasses:flash.utils.Dictionary;
    }
}


//        class EditorReturnObject
package frontend.components.menuList.editors.base 
{
    public class EditorReturnObject extends Object
    {
        public function EditorReturnObject()
        {
            super();
            return;
        }

        public var dispatchCompleteEvent:Boolean=false;

        public var rawValue:Object;

        public var selectedDataProviderItem:Object;

        public var selectedIndex:uint;

        public var value:String;
    }
}


//        class OnOffToggleButton
package frontend.components.menuList.editors.base 
{
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
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
    import frontend.components.button.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class OnOffToggleButton extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function OnOffToggleButton()
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
            bindings = this._OnOffToggleButton_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_components_menuList_editors_base_OnOffToggleButtonWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return OnOffToggleButton[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._OnOffToggleButton_IconButton1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get checked():Boolean
        {
            return this._checked;
        }

        internal function set _742313895checked(arg1:Boolean):void
        {
            this._checked = arg1;
            this.texture = this._checked ? frontend.Textures.toggleon : frontend.Textures.toggleoff;
            debug.Debug.debug(this._checked ? frontend.Textures.toggleon : frontend.Textures.toggleoff);
            return;
        }

        protected function onIconButtonTouched():void
        {
            if (!this.iconbutton.touchable) 
            {
                return;
            }
            this.checked = !this.checked;
            if (this.toggleChangedFunction != null) 
            {
                this.toggleChangedFunction(this.checked);
            }
            return;
        }

        internal function _OnOffToggleButton_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.highlight = false;
            loc1.addEventListener("triggered", this.__iconbutton_triggered);
            loc1.id = "iconbutton";
            this.iconbutton = loc1;
            feathers.binding.BindingManager.executeBindings(this, "iconbutton", this.iconbutton);
            return loc1;
        }

        public function __iconbutton_triggered(arg1:starling.events.Event):void
        {
            this.onIconButtonTouched();
            return;
        }

        internal function _OnOffToggleButton_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=texture;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "iconbutton.image")
            result[1] = new feathers.binding.Binding(this, null, null, "iconbutton.touchable", "editable");
            return result;
        }

        public function get iconbutton():frontend.components.button.IconButton
        {
            return this._66558741iconbutton;
        }

        public function set iconbutton(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._66558741iconbutton;
            if (loc1 !== arg1) 
            {
                this._66558741iconbutton = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconbutton", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set checked(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.checked;
            if (loc1 !== arg1) 
            {
                this._742313895checked = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "checked", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get editable():Boolean
        {
            return this._1602416228editable;
        }

        public function set editable(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1602416228editable;
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

        internal function get texture():String
        {
            return this._1417816805texture;
        }

        internal function set texture(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1417816805texture;
            if (loc1 !== arg1) 
            {
                this._1417816805texture = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "texture", loc1, arg1, this);
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
            OnOffToggleButton._watcherSetupUtil = arg1;
            return;
        }

        public static const EVENT_TOGGLE_BUTTON_SWITCHED:String="texture";

        internal var _66558741iconbutton:frontend.components.button.IconButton;

        internal var _checked:Boolean=false;

        internal var _1602416228editable:Boolean=true;

        public var toggleChangedFunction:Function;

        internal var _1417816805texture:String="toggleoff";

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//      package custom
//        class GPSLocationEditor
package frontend.components.menuList.editors.custom 
{
    import core.general.*;
    import core.gps.*;
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.layout.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.mydevices.pointNavigation.locationEditorTabs.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class GPSLocationEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function GPSLocationEditor()
        {
            this.stageTextEditorFunc = function ():feathers.core.ITextEditor
            {
                var loc1:*=new feathers.controls.text.StageTextTextEditor();
                loc1.autoCorrect = false;
                loc1.multiline = false;
                loc1.minHeight = 30 * SIGMALink.scaleFactor;
                return loc1;
            }
            super();
            orientation = ORIENTATION_INLINE;
            useTween = false;
            showSaveButton = false;
            this._tabContainer = new frontend.components.tab.TabContainer();
            this._tabContainer.useIconTabs = false;
            this._tabContainer.width = SIGMALink.appWidth;
            return;
        }

        protected override function getContentGroupLayoutData():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.top = owner.getBounds(stage).top + owner.height;
            return loc1;
        }

        protected override function addContent():void
        {
            var loc1:*=NaN;
            var loc3:*=null;
            loc1 = 16 * SIGMALink.scaleFactor;
            createVerticalContentGroup();
            contentGroup.addChild(headerGroup);
            editorInputWidth = SIGMALink.appWidth - 2 * padding;
            this._tabContainer.removeChildren();
            contentGroup.addChild(this._tabContainer);
            this._tabDecimal = new frontend.screen.mydevices.pointNavigation.locationEditorTabs.TabDecimal();
            this._tabDecimal.pointChangedCallback = this.onDezimalDegreesChanged;
            this._tabDecimal.label = utils.LanguageManager.getString("POINT_NAVIGATION_LOCATION_INPUT_DECIMAL");
            this._tabDecimal.currentMode = frontend.screen.mydevices.pointNavigation.locationEditorTabs.TabDecimal.MODE_DECIMAL;
            this._tabDecimal.point = this.point;
            this._tabDecimal.createLayout();
            this._tabDMS = new frontend.screen.mydevices.pointNavigation.locationEditorTabs.TabDecimal();
            this._tabDMS.pointChangedCallback = this.onDegreesMinutesSecondsChanged;
            this._tabDMS.label = utils.LanguageManager.getString("POINT_NAVIGATION_LOCATION_INPUT_DEGREES_MIN_SEC");
            this._tabDMS.currentMode = frontend.screen.mydevices.pointNavigation.locationEditorTabs.TabDecimal.MODE_DEGREES_MINUTES_SECONDS;
            this._tabDMS.point = this.point;
            this._tabDMS.createLayout();
            this._tabContainer.height = Math.max(this._tabDecimal.height, this._tabDMS.height);
            this._tabContainer.addTab(this._tabDecimal as frontend.components.tabbarbase.ITabLayoutContainer, true);
            this._tabContainer.addTab(this._tabDMS as frontend.components.tabbarbase.ITabLayoutContainer);
            this._saveButton = new feathers.controls.Button();
            this._saveButton.label = utils.LanguageManager.getString("POINT_NAVIGATION_LOCATION_INPUT_OK");
            this._saveButton.addEventListener(starling.events.Event.TRIGGERED, this.saveButton_triggeredHandler);
            var loc2:*=new feathers.layout.HorizontalLayout();
            loc2.paddingRight = loc1;
            loc2.paddingBottom = loc1;
            loc2.horizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc3 = new feathers.controls.LayoutGroup();
            loc3.layout = loc2;
            loc3.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc3.width = SIGMALink.appWidth;
            loc3.addChild(this._saveButton);
            contentGroup.addChild(loc3);
            addChild(contentGroup);
            contentGroup.validate();
            contentGroup.layoutData = this.getContentGroupLayoutData();
            return;
        }

        public function updatePoint(arg1:core.gps.LatLon):void
        {
            this.point = arg1;
            if (this._tabDecimal) 
            {
                this._tabDecimal.point = this.point;
                this._tabDecimal.updateInputs();
            }
            if (this._tabDMS) 
            {
                this._tabDMS.point = this.point;
                this._tabDMS.updateInputs();
            }
            return;
        }

        internal function onDegreesMinutesSecondsChanged():void
        {
            if (!this._tabDecimal) 
            {
                return;
            }
            this._tabDecimal.point = this._tabDMS.point;
            this._tabDecimal.updateInputs();
            return;
        }

        internal function onDezimalDegreesChanged():void
        {
            if (!this._tabDMS) 
            {
                return;
            }
            this._tabDMS.point = this._tabDecimal.point;
            this._tabDMS.updateInputs();
            return;
        }

        internal function saveButton_triggeredHandler(arg1:starling.events.Event):void
        {
            this.point = this._tabContainer.tabbar.selectedIndex != 0 ? this._tabDMS.point : this._tabDecimal.point;
            this.closeEditor();
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            return null;
        }

        protected override function saveValue():void
        {
            return;
        }

        internal function onFocus(arg1:starling.events.Event):void
        {
            return;
        }

        internal function onTextInputChange(arg1:starling.events.Event=null):void
        {
            return;
        }

        internal function onEnterPress(arg1:starling.events.Event=null):void
        {
            return;
        }

        protected override function onOutsideTouch(arg1:starling.events.TouchEvent):void
        {
            this.point = null;
            super.onOutsideTouch(arg1);
            return;
        }

        public override function dispose():void
        {
            if (this._saveButton) 
            {
                this._saveButton.removeEventListener(starling.events.Event.TRIGGERED, this.saveButton_triggeredHandler);
            }
            super.dispose();
            return;
        }

        protected override function closeEditor():void
        {
            super.closeEditor();
            dispatchEventWith(CLOSED);
            return;
        }

        public static const CLOSED:String="closedEvent";

        public var point:core.gps.LatLon;

        internal var _saveButton:feathers.controls.Button;

        internal var _tabContainer:frontend.components.tab.TabContainer;

        internal var _tabDMS:frontend.screen.mydevices.pointNavigation.locationEditorTabs.TabDecimal;

        internal var _tabDecimal:frontend.screen.mydevices.pointNavigation.locationEditorTabs.TabDecimal;

        internal var stageTextEditorFunc:Function;

        internal var ti:feathers.controls.TextInput;
    }
}


//        class SearchEditor
package frontend.components.menuList.editors.custom 
{
    import __AS3__.vec.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import handler.*;
    import service.openstreetmap.*;
    import starling.display.*;
    import starling.events.*;
    
    public class SearchEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function SearchEditor()
        {
            this.stageTextEditorFunc = function ():feathers.core.ITextEditor
            {
                var loc1:*=new feathers.controls.text.StageTextTextEditor();
                loc1.autoCorrect = true;
                loc1.multiline = false;
                loc1.minHeight = 30 * SIGMALink.scaleFactor;
                return loc1;
            }
            super();
            orientation = ORIENTATION_INLINE;
            useTween = false;
            showSaveButton = false;
            this._list = new frontend.components.list.CustomList();
            this._list.itemRendererType = frontend.components.menuList.editors.custom.SearchEditorItemRenderer;
            this._list.clipContent = true;
            this._list.allowMultipleSelection = false;
            this._list.addEventListener(starling.events.Event.SELECT, this.onResultSelected);
            this._searchEngine = new service.openstreetmap.MapSearchEngine();
            this._searchEngine.addEventListener(service.openstreetmap.MapSearchEvent.SEARCH_RESULT, this.onMapSearchResult);
            return;
        }

        public function get maxChars():uint
        {
            return this._maxChars;
        }

        public function set maxChars(arg1:uint):void
        {
            this._maxChars = arg1;
            if (this.ti != null) 
            {
                this.ti.maxChars = this.maxChars;
            }
            return;
        }

        protected override function getContentGroupLayoutData():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.top = owner.getBounds(stage).top + owner.height;
            return loc1;
        }

        protected override function addContent():void
        {
            var loc1:*=NaN;
            var loc2:*=null;
            var loc3:*=null;
            loc1 = 20 * SIGMALink.scaleFactor;
            createVerticalContentGroup();
            contentGroup.addChild(headerGroup);
            editorInputWidth = SIGMALink.appWidth - 2 * padding;
            loc2 = this.getEditor() as feathers.controls.TextInput;
            loc3 = new frontend.components.TextureImage();
            loc3.textureName = frontend.Textures.searchEditorIcon;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, loc1, NaN, NaN, NaN, 0);
            loc3.addEventListener(starling.events.TouchEvent.TOUCH, this.onSearchIconTriggered);
            var loc4:*=new feathers.controls.LayoutGroup();
            loc4.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc4.width = editorInputWidth;
            loc4.layout = new feathers.layout.AnchorLayout();
            loc4.addChild(loc2);
            loc4.addChild(loc3);
            contentGroup.addChild(loc4);
            contentGroup.addChild(this._list);
            addChild(contentGroup);
            contentGroup.validate();
            contentGroup.layoutData = this.getContentGroupLayoutData();
            loc4.height = loc2.height + padding;
            loc2.width = loc2.width - (2 * loc1 + loc3.width);
            return;
        }

        internal function onSearchIconTriggered(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.onEnterPress();
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            this.ti = new feathers.controls.TextInput();
            this.ti.addEventListener(starling.events.Event.CHANGE, this.onTextInputChange);
            this.ti.addEventListener(feathers.events.FeathersEventType.ENTER, this.onEnterPress);
            this.ti.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.onFocus);
            this.ti.styleName = "TEXTINPUT";
            this.ti.width = SIGMALink.appWidth - 2 * padding;
            this.ti.text = rawValue.toString();
            this.ti.textEditorFactory = this.stageTextEditorFunc;
            this.ti.setFocus();
            this.ti.selectRange(0, this.ti.text.length);
            this.ti.maxChars = this.maxChars;
            return this.ti;
        }

        protected override function saveValue():void
        {
            this._searchEngine.search(this.ti.text);
            return;
        }

        internal function onFocus(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.TextInput;
            loc1.selectRange(0, loc1.text.length);
            return;
        }

        internal function onTextInputChange(arg1:starling.events.Event=null):void
        {
            rawValue = this.ti.text;
            return;
        }

        internal function onEnterPress(arg1:starling.events.Event=null):void
        {
            if (arg1) 
            {
                arg1.stopPropagation();
            }
            this.saveValue();
            return;
        }

        protected override function onOutsideTouch(arg1:starling.events.TouchEvent):void
        {
            this.selectedItem = null;
            super.onOutsideTouch(arg1);
            return;
        }

        internal function onResultSelected(arg1:starling.events.Event):void
        {
            this.selectedItem = this._list.selectedItem as service.openstreetmap.MapSearchResult;
            dispatchEventWith(RESULT_SELECTED);
            this.closeEditor();
            return;
        }

        public override function dispose():void
        {
            if (this.ti) 
            {
                this.ti.removeEventListener(starling.events.Event.CHANGE, this.onTextInputChange);
                this.ti.removeEventListener(feathers.events.FeathersEventType.ENTER, this.onEnterPress);
                this.ti.removeEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.onFocus);
                this.ti.clearFocus();
            }
            if (this._list) 
            {
                this._list.removeEventListener(starling.events.Event.SELECT, this.onResultSelected);
            }
            if (this._searchEngine) 
            {
                this._searchEngine.removeEventListener(service.openstreetmap.MapSearchEvent.SEARCH_RESULT, this.onMapSearchResult);
            }
            super.dispose();
            return;
        }

        protected override function closeEditor():void
        {
            dispatchEventWith(CLOSED);
            super.closeEditor();
            return;
        }

        internal function onMapSearchResult(arg1:service.openstreetmap.MapSearchEvent):void
        {
            this._list.width = editorInputWidth;
            this._list.dataProvider = new feathers.data.ListCollection(arg1.data as Vector.<service.openstreetmap.MapSearchResult>);
            this._list.height = Math.min(4, this._list.dataProvider.length) * frontend.components.menuList.MenuList.ROW_HEIGHT;
            return;
        }

        public static const CLOSED:String="closedEvent";

        public static const RESULT_SELECTED:String="resultSelectedEvent";

        internal var _maxChars:uint=0;

        public var selectedItem:service.openstreetmap.MapSearchResult;

        internal var _list:frontend.components.list.CustomList;

        internal var _searchEngine:service.openstreetmap.MapSearchEngine;

        internal var stageTextEditorFunc:Function;

        internal var ti:feathers.controls.TextInput;
    }
}


//        class SearchEditorItemRenderer
package frontend.components.menuList.editors.custom 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.menuList.*;
    import handler.*;
    import service.openstreetmap.*;
    import starling.display.*;
    import starling.events.*;
    
    public class SearchEditorItemRenderer extends feathers.controls.renderers.DefaultListItemRenderer
    {
        public function SearchEditorItemRenderer()
        {
            super();
            touchGroup = true;
            width = SIGMALink.appWidth;
            height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_TOP;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            hasLabelTextRenderer = false;
            return;
        }

        protected override function basicButton_touchHandler(arg1:starling.events.TouchEvent):void
        {
            super.basicButton_touchHandler(arg1);
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            owner.selectedItem = data;
            owner.dispatchEventWith(starling.events.Event.SELECT);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            var loc1:*=16 * SIGMALink.scaleFactor;
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth - loc1;
            this._group.height = height;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._resultLabel = new feathers.controls.Label();
            this._resultLabel.width = this._group.width - 2 * loc1;
            this._resultLabel.layoutData = new feathers.layout.AnchorLayoutData(loc1 / 2, NaN, NaN, loc1);
            this._resultLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            this._resultLabel.wordWrap = true;
            this._resultLabel.height = height - loc1;
            this._group.addChild(this._resultLabel);
            var loc2:*=new starling.display.Quad(SIGMALink.appWidth, 1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            loc2.y = height - loc2.height;
            addChild(loc2);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            this._resultLabel.text = (data as service.openstreetmap.MapSearchResult).formattedAddress;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        protected override function layoutContent():void
        {
            super.layoutContent();
            if (!data) 
            {
                return;
            }
            return;
        }

        internal var _group:feathers.controls.LayoutGroup;

        internal var _resultLabel:feathers.controls.Label;
    }
}


//        class SportAndNameEditor
package frontend.components.menuList.editors.custom 
{
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class SportAndNameEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function SportAndNameEditor()
        {
            this.placeholder = utils.LanguageManager.getString("ACTIVITYVIEW.EDIT_NAME");
            this._stageTextEditorFunc = function ():feathers.core.ITextEditor
            {
                var loc1:*=new feathers.controls.text.StageTextTextEditor();
                loc1.autoCorrect = true;
                loc1.multiline = false;
                loc1.minHeight = 30 * SIGMALink.scaleFactor;
                return loc1;
            }
            super();
            orientation = ORIENTATION_CENTERED;
            return;
        }

        internal function onEnterPress(arg1:starling.events.Event):void
        {
            this._ti.clearFocus();
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc2:*=0;
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 5 * SIGMALink.scaleFactor;
            loc1.padding = 0;
            loc1.paddingTop = 5 * SIGMALink.scaleFactor;
            this._editorGroup = new feathers.controls.LayoutGroup();
            this._editorGroup.layout = loc1;
            this._ti = new feathers.controls.TextInput();
            this._ti.addEventListener(starling.events.Event.CHANGE, this.onValuesChanged);
            this._ti.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.onFocus);
            this._ti.addEventListener(feathers.events.FeathersEventType.ENTER, this.onEnterPress);
            this._ti.styleName = "TEXTINPUT";
            this._ti.width = SIGMALink.appWidth - 2 * padding;
            this._ti.text = rawValue.name.toString();
            this._ti.textEditorFactory = this._stageTextEditorFunc;
            this._ti.selectRange(0, this._ti.text.length);
            this._ti.prompt = utils.LanguageManager.getString("ACTIVITYVIEW.EDIT_NAME_PLACEHOLDER");
            this._editorGroup.addChild(this._ti);
            this._labelSport = new feathers.controls.Label();
            this._labelSport.paddingTop = loc1.paddingTop;
            this._labelSport.paddingLeft = _titlePadding;
            this._labelSport.text = utils.LanguageManager.getString("ACTIVITYVIEW.EDIT_SPORT");
            this._labelSport.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            this._editorGroup.addChild(this._labelSport);
            this._list = new frontend.components.list.CustomList();
            this._list.allowScrollingInPopUpMode = true;
            this._list.itemRendererType = frontend.components.menuList.editors.custom.SportSingleSelectItemRenderer;
            this._list.clipContent = true;
            this._list.dataProvider = dataProvider;
            this._list.height = this.maxVisibleRows * frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            this._list.width = editorWidth - 2 * padding;
            this._list.addEventListener(starling.events.Event.CHANGE, this.onValuesChanged);
            this._list.allowMultipleSelection = false;
            this._editorGroup.addChild(this._list);
            if (dataProvider) 
            {
                loc2 = 0;
                while (loc2 < dataProvider.data.length) 
                {
                    if (rawValue.hasOwnProperty("sport") && dataProvider.data[loc2].data == rawValue.sport) 
                    {
                        this._list.selectedIndex = loc2;
                    }
                    ++loc2;
                }
            }
            return this._editorGroup;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue;
            editorReturnObject.value = this._labelValue;
            super.saveValue();
            return;
        }

        internal function onFocus(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.TextInput;
            loc1.selectRange(0, loc1.text.length);
            return;
        }

        internal function onValuesChanged(arg1:starling.events.Event=null):void
        {
            if (this._ti == null || this._list == null || this._list.selectedItem == null) 
            {
                return;
            }
            rawValue = {"name":this._ti.text, "sport":this._list.selectedItem.data};
            return;
        }

        public var placeholder:String;

        protected var maxVisibleRows:Number=5;

        internal var _editorGroup:feathers.controls.LayoutGroup;

        internal var _initalSelectedIndex:int=-1;

        internal var _labelSport:feathers.controls.Label;

        internal var _labelValue:String="";

        internal var _list:frontend.components.list.CustomList;

        internal var _stageTextEditorFunc:Function;

        internal var _ti:feathers.controls.TextInput;
    }
}


//        class SportMultiSelectEditor
package frontend.components.menuList.editors.custom 
{
    import frontend.components.list.*;
    import frontend.components.menuList.editors.*;
    import starling.display.*;
    
    public class SportMultiSelectEditor extends frontend.components.menuList.editors.MultiSelectEditor
    {
        public function SportMultiSelectEditor()
        {
            super();
            maxVisibleRows = 4.5;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc1:*=super.getEditor() as frontend.components.list.CustomList;
            loc1.allowScrollingInPopUpMode = true;
            loc1.itemRendererType = frontend.components.menuList.editors.custom.SportMultiSelectItemRenderer;
            return loc1;
        }
    }
}


//        class SportMultiSelectItemRenderer
package frontend.components.menuList.editors.custom 
{
    import core.general.*;
    import core.sport.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.menuList.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class SportMultiSelectItemRenderer extends feathers.controls.renderers.DefaultListItemRenderer
    {
        public function SportMultiSelectItemRenderer()
        {
            super();
            touchGroup = true;
            width = SIGMALink.appWidth;
            height = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_TOP;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            hasLabelTextRenderer = false;
            return;
        }

        protected override function basicButton_touchHandler(arg1:starling.events.TouchEvent):void
        {
            super.basicButton_touchHandler(arg1);
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            data.selected = !(data.selected as Boolean);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth - 16 * SIGMALink.scaleFactor;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this.checkbox = new feathers.controls.Check();
            this.checkbox.iconPosition = "left";
            this.checkbox.labelOffsetX = PADDING;
            this.checkbox.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, PADDING, NaN, 0);
            this._group.addChild(this.checkbox);
            this._icon = new frontend.components.SportIcon();
            this._icon.sportId = 1;
            this._icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING, NaN, NaN, NaN, 0);
            this._group.addChild(this._icon);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            loc1.y = height - loc1.height;
            addChild(loc1);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=handler.SportHandler.getInstance().resolveSportById(data.data as uint);
            var loc2:*=frontend.Textures.sportTextureByKeyName(loc1.keyName);
            this.checkbox.label = data.label;
            this._icon.sportId = loc1.sportId;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        protected override function layoutContent():void
        {
            super.layoutContent();
            if (!data) 
            {
                return;
            }
            this.checkbox.isSelected = data.selected as Boolean;
            this._group.backgroundSkin = this.checkbox.isSelected ? new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY) : new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        
        {
            iconGroupWidth = 65 * SIGMALink.scaleFactor;
            iconPaddingTop = 6 * SIGMALink.scaleFactor;
        }

        protected static const PADDING:Number=17 * SIGMALink.scaleFactor;

        protected var checkbox:feathers.controls.Check;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _icon:frontend.components.SportIcon;

        internal static var iconGroupWidth:Number;

        internal static var iconPaddingTop:Number;
    }
}


//        class SportSingleSelectEditor
package frontend.components.menuList.editors.custom 
{
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    
    public class SportSingleSelectEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function SportSingleSelectEditor()
        {
            super();
            orientation = ORIENTATION_CENTERED;
            this.maxVisibleRows = 4.5;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc1:*=0;
            this.list = new frontend.components.list.CustomList();
            this.list.allowScrollingInPopUpMode = true;
            this.list.itemRendererType = frontend.components.menuList.editors.custom.SportSingleSelectItemRenderer;
            this.list.clipContent = true;
            this.list.dataProvider = dataProvider;
            this.list.height = this.maxVisibleRows * frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            this.list.width = editorWidth - 2 * padding;
            this.list.addEventListener(starling.events.Event.CHANGE, this.onSpinnerValueChanged);
            this.list.allowMultipleSelection = false;
            if (dataProvider) 
            {
                loc1 = 0;
                while (loc1 < dataProvider.data.length) 
                {
                    if (dataProvider.data[loc1].data == rawValue) 
                    {
                        this.list.selectedIndex = loc1;
                    }
                    ++loc1;
                }
            }
            return this.list;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue;
            editorReturnObject.value = this.labelValue;
            super.saveValue();
            return;
        }

        internal function onSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as frontend.components.list.CustomList;
            rawValue = loc1.selectedItem.data;
            return;
        }

        protected var maxVisibleRows:Number=4;

        internal var initalSelectedIndex:int=-1;

        internal var labelValue:String="";

        internal var list:frontend.components.list.CustomList;
    }
}


//        class SportSingleSelectItemRenderer
package frontend.components.menuList.editors.custom 
{
    import core.general.*;
    import core.sport.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.menuList.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class SportSingleSelectItemRenderer extends feathers.controls.renderers.DefaultListItemRenderer
    {
        public function SportSingleSelectItemRenderer()
        {
            super();
            touchGroup = true;
            width = SIGMALink.appWidth;
            height = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_TOP;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            hasLabelTextRenderer = false;
            return;
        }

        protected override function basicButton_touchHandler(arg1:starling.events.TouchEvent):void
        {
            super.basicButton_touchHandler(arg1);
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth - 16 * SIGMALink.scaleFactor;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this.checkbox = new feathers.controls.Check();
            this.checkbox.iconPosition = "left";
            this.checkbox.labelOffsetX = PADDING;
            this.checkbox.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, PADDING, NaN, 0);
            this._group.addChild(this.checkbox);
            this._icon = new frontend.components.SportIcon();
            this._icon.sportId = 1;
            this._icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING, NaN, NaN, NaN, 0);
            this._group.addChild(this._icon);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            loc1.y = height - loc1.height;
            addChild(loc1);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=handler.SportHandler.getInstance().resolveSportById(data.data as uint);
            var loc2:*=frontend.Textures.sportTextureByKeyName(loc1.keyName);
            this.checkbox.label = data.label;
            this._icon.sportId = loc1.sportId;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        protected override function layoutContent():void
        {
            super.layoutContent();
            if (!data) 
            {
                return;
            }
            var loc1:*;
            data.selected = loc1 = isSelected;
            this.checkbox.isSelected = loc1;
            this._group.backgroundSkin = this.checkbox.isSelected ? new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY) : new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        
        {
            iconGroupWidth = 65 * SIGMALink.scaleFactor;
            iconPaddingTop = 6 * SIGMALink.scaleFactor;
        }

        protected static const PADDING:Number=17 * SIGMALink.scaleFactor;

        protected var checkbox:feathers.controls.Check;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _icon:frontend.components.SportIcon;

        internal static var iconGroupWidth:Number;

        internal static var iconPaddingTop:Number;

        internal static var selectedCheck:feathers.controls.Check;
    }
}


//        class StringMultiSelectEditor
package frontend.components.menuList.editors.custom 
{
    import frontend.components.list.*;
    import frontend.components.menuList.editors.*;
    import starling.display.*;
    
    public class StringMultiSelectEditor extends frontend.components.menuList.editors.MultiSelectEditor
    {
        public function StringMultiSelectEditor()
        {
            super();
            maxVisibleRows = 3;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc1:*=super.getEditor() as frontend.components.list.CustomList;
            loc1.allowScrollingInPopUpMode = true;
            loc1.itemRendererType = frontend.components.menuList.editors.custom.StringMultiSelectItemRenderer;
            return loc1;
        }
    }
}


//        class StringMultiSelectItemRenderer
package frontend.components.menuList.editors.custom 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import frontend.components.menuList.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class StringMultiSelectItemRenderer extends feathers.controls.renderers.DefaultListItemRenderer
    {
        public function StringMultiSelectItemRenderer()
        {
            super();
            touchGroup = true;
            width = SIGMALink.appWidth;
            height = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_MIDDLE;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            hasLabelTextRenderer = false;
            return;
        }

        protected override function basicButton_touchHandler(arg1:starling.events.TouchEvent):void
        {
            super.basicButton_touchHandler(arg1);
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            data.selected = !(data.selected as Boolean);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth - 16 * SIGMALink.scaleFactor;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this.checkbox = new feathers.controls.Check();
            this.checkbox.iconPosition = "left";
            this.checkbox.labelOffsetX = PADDING;
            this.checkbox.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, PADDING, NaN, 0);
            this._group.addChild(this.checkbox);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            loc1.y = height - loc1.height;
            addChild(loc1);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            this.checkbox.label = data[labelField];
            this.checkbox.isSelected = data.selected as Boolean;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        protected override function layoutContent():void
        {
            super.layoutContent();
            if (!data) 
            {
                return;
            }
            this.checkbox.isSelected = data.selected as Boolean;
            this._group.backgroundSkin = this.checkbox.isSelected ? new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY) : new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        
        {
            iconGroupWidth = 65 * SIGMALink.scaleFactor;
            iconPaddingTop = 6 * SIGMALink.scaleFactor;
        }

        protected static const PADDING:Number=17 * SIGMALink.scaleFactor;

        protected var checkbox:feathers.controls.Check;

        internal var _group:feathers.controls.LayoutGroup;

        internal static var iconGroupWidth:Number;

        internal static var iconPaddingTop:Number;
    }
}


//        class UnitEditor
package frontend.components.menuList.editors.custom 
{
    import feathers.controls.*;
    import feathers.data.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.screen.component.devices.*;
    import frontend.screen.mydevices.list.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class UnitEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function UnitEditor()
        {
            super();
            title = utils.LanguageManager.getString("DEVICES.SELECT_DEVICE");
            orientation = ORIENTATION_CENTERED;
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddetToStage);
            return;
        }

        public override function set dataProvider(arg1:feathers.data.ListCollection):void
        {
            super.dataProvider = arg1;
            if (this._deviceList && !(dataProvider == null)) 
            {
                this._deviceList.setUnits(dataProvider);
            }
            return;
        }

        public function get showLines():uint
        {
            return this._showLines;
        }

        public function set showLines(arg1:uint):void
        {
            if (arg1 < SHOW_LINES_MIN) 
            {
                arg1 = SHOW_LINES_MIN;
            }
            if (arg1 > SHOW_LINES_MAX) 
            {
                arg1 = SHOW_LINES_MAX;
            }
            this._showLines = arg1;
            return;
        }

        internal function onAddetToStage(arg1:starling.events.Event):void
        {
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            this._editorGroup = new feathers.controls.LayoutGroup();
            this._deviceList = new frontend.screen.component.devices.DeviceList();
            this._deviceList.triggeredHandler = this.onDeviceClicked;
            if (dataProvider) 
            {
                this._deviceList.dataProvider = _dataProvider;
                this.showLines = dataProvider.length;
            }
            this._deviceList.height = this.showLines * frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._editorGroup.height = this.showLines * frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._editorGroup.addChild(this._deviceList);
            return this._editorGroup;
        }

        internal function onDeviceClicked(arg1:frontend.screen.mydevices.list.MyDevicesListItem):void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = arg1;
            saveValue();
            closeEditor();
            return;
        }

        internal static const SHOW_LINES_MAX:uint=5;

        internal static const SHOW_LINES_MIN:uint=1;

        public var loadUnitsOnInit:Boolean=true;

        internal var _showLines:uint=1;

        internal var _deviceList:frontend.screen.component.devices.DeviceList;

        internal var _editorGroup:feathers.controls.LayoutGroup;
    }
}


//      class CheckBoxMultiEditor
package frontend.components.menuList.editors 
{
    import frontend.components.menuList.editors.base.*;
    
    public class CheckBoxMultiEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function CheckBoxMultiEditor()
        {
            super();
            return;
        }
    }
}


//      class DateEditor
package frontend.components.menuList.editors 
{
    import backend.utils.*;
    import core.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    import utils.interfaces.*;
    
    public class DateEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function DateEditor()
        {
            super();
            orientation = ORIENTATION_CENTERED;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc2:*=null;
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            loc1.gap = 8 * SIGMALink.scaleFactor;
            loc2 = new feathers.controls.LayoutGroup();
            loc2.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc2.layout = loc1;
            loc2.layoutData = new feathers.layout.HorizontalLayoutData(100, 100);
            var loc3:*=new feathers.controls.DateTimeSpinner();
            loc3.locale = core.MeasurementConfig.language;
            if (!isNaN(this.minimum)) 
            {
                loc3.minimum = new Date(this.minimum);
            }
            if (!isNaN(this.maximum)) 
            {
                loc3.maximum = new Date(this.maximum);
            }
            loc3.value = rawValue as Date;
            loc3.editingMode = feathers.controls.DateTimeSpinner.EDITING_MODE_DATE;
            loc3.width = editorWidth - 2 * padding;
            loc3.addEventListener(starling.events.Event.CHANGE, this.onSpinnerValueChanged);
            this.labelValue = backend.utils.DataUtils.dateFormatter.format(loc3.value);
            loc2.addChild(loc3);
            return loc2;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue;
            editorReturnObject.value = this.labelValue;
            super.saveValue();
            return;
        }

        internal function onSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            loc1 = arg1.currentTarget as feathers.controls.DateTimeSpinner;
            rawValue = loc1.value;
            this.labelValue = backend.utils.DataUtils.dateFormatter.format(loc1.value);
            return;
        }

        public var formatter:utils.interfaces.ICustomFormatterBase;

        public var maximum:Number;

        public var minimum:Number;

        internal var labelValue:String="";
    }
}


//      class DateTimeEditor
package frontend.components.menuList.editors 
{
    import backend.utils.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    
    public class DateTimeEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function DateTimeEditor()
        {
            super();
            orientation = ORIENTATION_CENTERED;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc2:*=null;
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            loc1.gap = 8 * SIGMALink.scaleFactor;
            loc2 = new feathers.controls.LayoutGroup();
            loc2.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc2.layout = loc1;
            loc2.layoutData = new feathers.layout.HorizontalLayoutData(100, 100);
            var loc3:*=new feathers.controls.DateTimeSpinner();
            loc3.value = rawValue as Date;
            loc3.editingMode = feathers.controls.DateTimeSpinner.EDITING_MODE_TIME;
            loc3.width = editorWidth - 2 * padding;
            loc3.addEventListener(starling.events.Event.CHANGE, this.onSpinnerValueChanged);
            this.labelValue = backend.utils.DataUtils.dateTimeFormatter.format(loc3.value);
            loc2.addChild(loc3);
            return loc2;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue;
            editorReturnObject.value = this.labelValue;
            super.saveValue();
            return;
        }

        internal function onSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.DateTimeSpinner;
            rawValue = loc1.value;
            this.labelValue = backend.utils.DataUtils.dateTimeFormatter.format(loc1.value);
            return;
        }

        internal var labelValue:String="";
    }
}


//      class MultiSelectEditor
package frontend.components.menuList.editors 
{
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    
    public class MultiSelectEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function MultiSelectEditor()
        {
            super();
            orientation = ORIENTATION_CENTERED;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc1:*=0;
            this.list = new frontend.components.list.CustomList();
            this.list.clipContent = true;
            this.list.dataProvider = dataProvider;
            this.list.height = this.maxVisibleRows * frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            this.list.width = editorWidth - 2 * padding;
            this.list.addEventListener(starling.events.Event.CHANGE, this.onSpinnerValueChanged);
            this.list.allowMultipleSelection = true;
            this.list.allowScrollingInPopUpMode = true;
            if (dataProvider) 
            {
                loc1 = 0;
                while (loc1 < dataProvider.data.length) 
                {
                    if (dataProvider.data[loc1].data == rawValue) 
                    {
                        this.list.selectedIndex = loc1;
                    }
                    ++loc1;
                }
            }
            return this.list;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue;
            editorReturnObject.value = this.labelValue;
            super.saveValue();
            return;
        }

        internal function onSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as frontend.components.list.CustomList;
            rawValue = loc1.selectedItems;
            return;
        }

        protected var maxVisibleRows:Number=4;

        internal var initalSelectedIndex:int=-1;

        internal var labelValue:String="";

        internal var list:frontend.components.list.CustomList;
    }
}


//      class NumberEditor
package frontend.components.menuList.editors 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.events.*;
    import flash.text.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class NumberEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function NumberEditor()
        {
            this.stageTextEditorFunc = function ():feathers.core.ITextEditor
            {
                var loc1:*=new feathers.controls.text.StageTextTextEditor();
                loc1.multiline = false;
                loc1.minHeight = 30 * SIGMALink.scaleFactor;
                loc1.softKeyboardType = flash.text.SoftKeyboardType.NUMBER;
                return loc1;
            }
            super();
            orientation = ORIENTATION_INLINE;
            useTween = false;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            this.ti = new feathers.controls.TextInput();
            this.ti.addEventListener(starling.events.Event.CHANGE, this.onTextInputChange);
            this.ti.addEventListener(feathers.events.FeathersEventType.ENTER, this.onEnterPress);
            this.ti.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.onFocus);
            this.ti.styleName = "TEXTINPUT";
            this.ti.width = editorInputWidth;
            this.ti.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this.ti.backgroundFocusedSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.ti.alignPivot("right", "center");
            this.ti.textEditorFactory = this.stageTextEditorFunc;
            if (this.converter) 
            {
                loc2 = Object(this.converter).constructor;
                this.backConverter = new loc2();
                this.backConverter.inputFormat = this.converter.outputFormat;
                this.backConverter.outputFormat = this.converter.inputFormat;
                this.backConverter.toInt = this.converter.toInt;
                loc1 = this.converter.convert(rawValue);
            }
            else 
            {
                loc1 = rawValue;
            }
            if (this.formatter) 
            {
                loc3 = this.formatter.format(loc1);
                loc4 = String.fromCharCode(8201);
                loc3 = loc3.replace(loc4, "");
                this.ti.text = loc3;
            }
            else 
            {
                this.ti.text = loc1.toString();
            }
            this.ti.setFocus();
            this.ti.selectRange(0, this.ti.text.length);
            return this.ti;
        }

        internal function onFocus(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.TextInput;
            loc1.selectRange(0, loc1.text.length);
            return;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue.toString();
            var loc1:*=parseFloat(rawValue.toString());
            if (this.converter) 
            {
                loc1 = this.converter.convert(loc1);
            }
            if (this.formatter) 
            {
                editorReturnObject.value = this.formatter.format(loc1);
            }
            else 
            {
                editorReturnObject.value = loc1.toString();
            }
            super.saveValue();
            return;
        }

        internal function onTextInputChange(arg1:starling.events.Event=null):void
        {
            var loc1:*=parseFloat(this.ti.text.replace(",", "."));
            if (this.backConverter) 
            {
                loc1 = this.backConverter.convert(loc1);
            }
            rawValue = this.validateMinMax(loc1);
            return;
        }

        internal function onEnterPress(arg1:starling.events.Event):void
        {
            this.ti.removeEventListener(starling.events.Event.CHANGE, this.onTextInputChange);
            this.ti.removeEventListener(feathers.events.FeathersEventType.ENTER, this.onEnterPress);
            this.saveValue();
            closeEditor();
            return;
        }

        internal function validateMinMax(arg1:Number):Number
        {
            if (!isNaN(this.maximum)) 
            {
                arg1 = Math.min(arg1, this.maximum);
            }
            if (!isNaN(this.minimum)) 
            {
                arg1 = Math.max(arg1, this.minimum);
            }
            return arg1;
        }

        public var converter:utils.converter.IConverter;

        public var formatter:utils.interfaces.ICustomFormatterBase;

        public var maximum:Number;

        public var minimum:Number;

        internal var backConverter:utils.converter.IConverter;

        internal var stageTextEditorFunc:Function;

        internal var ti:feathers.controls.TextInput;
    }
}


//      class RadioEditor
package frontend.components.menuList.editors 
{
    import frontend.components.menuList.editors.base.*;
    
    public class RadioEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function RadioEditor()
        {
            super();
            return;
        }
    }
}


//      class RatingEditor
package frontend.components.menuList.editors 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.menuList.editors.base.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class RatingEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function RatingEditor()
        {
            this.editor = new feathers.controls.LayoutGroup();
            super();
            orientation = ORIENTATION_INLINE;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            frontend.components.menuList.editors.RatingEditor.drawContent(rawValue as int, this.editor, this.onRatingChanged);
            this.editor.width = editorWidth - 2 * padding;
            this.editor.height = minItemHeight;
            return this.editor;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue;
            super.saveValue();
            return;
        }

        internal function onRatingChanged(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            var loc1:*=(arg1.currentTarget as frontend.components.TextureImage).data as int;
            if (rawValue == 1 && loc1 == 1) 
            {
                rawValue = 0;
            }
            else 
            {
                rawValue = loc1;
            }
            frontend.components.menuList.editors.RatingEditor.drawContent(rawValue as int, this.editor, this.onRatingChanged);
            return;
        }

        public static function drawContent(arg1:int, arg2:feathers.controls.LayoutGroup=null, arg3:Function=null):starling.display.DisplayObject
        {
            var loc3:*=0;
            var loc5:*=null;
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.gap = frontend.components.menuList.editors.base.EditorBase.gap;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            var loc2:*=arg2;
            if (loc2) 
            {
                loc2.removeChildren(0, -1, true);
            }
            else 
            {
                loc2 = new feathers.controls.LayoutGroup();
            }
            loc2.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc2.layout = loc1;
            var loc4:*=5;
            loc3 = 0;
            while (loc3 < loc4) 
            {
                loc5 = new frontend.components.TextureImage();
                loc5.touchGroup = true;
                loc5.data = loc3 + 1;
                loc5.textureName = arg1 >= loc5.data ? frontend.Textures.iconstarredsmall : frontend.Textures.iconstarredsmallempty;
                if (arg3 != null) 
                {
                    loc5.addEventListener(starling.events.TouchEvent.TOUCH, arg3);
                }
                loc2.addChild(loc5);
                ++loc3;
            }
            return loc2;
        }

        internal var editor:feathers.controls.LayoutGroup;
    }
}


//      class SpinnerEditor
package frontend.components.menuList.editors 
{
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import flash.utils.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    
    public class SpinnerEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function SpinnerEditor()
        {
            super();
            orientation = ORIENTATION_CENTERED;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc1:*=0;
            this.spinner = new feathers.controls.SpinnerList();
            this.spinner.dataProvider = dataProvider;
            this.spinner.pageThrowDuration = 0.25;
            this.spinner.itemRendererProperties.labelField = "label";
            this.spinner.width = editorWidth - 2 * padding;
            this.spinner.addEventListener(starling.events.Event.CHANGE, this.onSpinnerValueChanged);
            this.spinner.addEventListener(feathers.events.FeathersEventType.SCROLL_COMPLETE, this.onSpinnerScrollComplete);
            if (dataProvider) 
            {
                loc1 = 0;
                while (loc1 < dataProvider.data.length) 
                {
                    if (dataProvider.data[loc1].data == rawValue) 
                    {
                        this.spinner.selectedIndex = loc1;
                    }
                    ++loc1;
                }
            }
            return this.spinner;
        }

        protected override function saveValue():void
        {
            flash.utils.clearTimeout(this._saveTimeoutId);
            if (this.spinner.isScrolling) 
            {
                this._saveTimeoutId = flash.utils.setTimeout(this.saveValue, 100);
                return;
            }
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue;
            editorReturnObject.value = this.labelValue;
            editorReturnObject.selectedDataProviderItem = this.spinner.selectedItem;
            super.saveValue();
            return;
        }

        internal function onSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.SpinnerList;
            if (loc1.selectedItem) 
            {
                rawValue = loc1.selectedItem.data;
                this.labelValue = loc1.selectedItem.label;
            }
            return;
        }

        internal function onSpinnerScrollComplete(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.SpinnerList;
            var loc2:*=loc1.verticalScrollPosition / (loc1.layout as feathers.layout.VerticalSpinnerLayout).snapInterval % dataProvider.length;
            loc1.selectedIndex = loc2;
            return;
        }

        internal var _saveTimeoutId:uint=0;

        internal var initalSelectedIndex:int=-1;

        internal var labelValue:String="";

        internal var spinner:feathers.controls.SpinnerList;
    }
}


//      class TextAreaEditor
package frontend.components.menuList.editors 
{
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.events.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class TextAreaEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function TextAreaEditor()
        {
            this.stageTextEditorFunc = function ():feathers.core.ITextEditor
            {
                var loc1:*=new feathers.controls.text.StageTextTextEditor();
                loc1.autoCorrect = true;
                loc1.multiline = true;
                return loc1;
            }
            super();
            orientation = ORIENTATION_CENTERED;
            return;
        }

        public function get maxChars():uint
        {
            return this._maxChars;
        }

        public function set maxChars(arg1:uint):void
        {
            this._maxChars = arg1;
            if (this.ti != null) 
            {
                this.ti.maxChars = this.maxChars;
            }
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            this.ti = new feathers.controls.TextInput();
            this.ti.addEventListener(starling.events.Event.CHANGE, this.onTextInputChange);
            this.ti.addEventListener(feathers.events.FeathersEventType.ENTER, this.onEnterPress);
            this.ti.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.onFocus);
            this.ti.styleName = "TEXTINPUT";
            this.ti.width = SIGMALink.appWidth - 2 * padding;
            this.ti.height = SIGMALink.appHeight / 3;
            this.ti.text = rawValue.toString();
            this.ti.textEditorFactory = this.stageTextEditorFunc;
            this.ti.setFocus();
            this.ti.selectRange(0, this.ti.text.length);
            this.ti.maxChars = this.maxChars;
            return this.ti;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            var loc1:*=rawValue.toString();
            loc1 = starling.utils.StringUtil.trim(loc1);
            if (this.maxChars > 0) 
            {
                loc1 = loc1.slice(0, this.maxChars);
            }
            editorReturnObject.rawValue = loc1;
            editorReturnObject.value = loc1;
            super.saveValue();
            return;
        }

        internal function onFocus(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.TextInput;
            loc1.selectRange(0, loc1.text.length);
            return;
        }

        internal function onTextInputChange(arg1:starling.events.Event=null):void
        {
            rawValue = this.ti.text;
            return;
        }

        internal function onEnterPress(arg1:starling.events.Event):void
        {
            arg1.stopPropagation();
            this.ti.removeEventListener(starling.events.Event.CHANGE, this.onTextInputChange);
            this.ti.removeEventListener(feathers.events.FeathersEventType.ENTER, this.onEnterPress);
            this.ti.removeEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.onFocus);
            this.ti.clearFocus();
            this.saveValue();
            closeEditor();
            return;
        }

        internal var _maxChars:uint=0;

        internal var stageTextEditorFunc:Function;

        internal var ti:feathers.controls.TextInput;
    }
}


//      class TextEditor
package frontend.components.menuList.editors 
{
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.events.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class TextEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function TextEditor()
        {
            this.stageTextEditorFunc = function ():feathers.core.ITextEditor
            {
                var loc1:*=new feathers.controls.text.StageTextTextEditor();
                loc1.autoCorrect = true;
                loc1.multiline = false;
                loc1.minHeight = 30 * SIGMALink.scaleFactor;
                return loc1;
            }
            super();
            orientation = ORIENTATION_INLINE;
            useTween = false;
            return;
        }

        public function get maxChars():uint
        {
            return this._maxChars;
        }

        public function set maxChars(arg1:uint):void
        {
            this._maxChars = arg1;
            if (this.ti != null) 
            {
                this.ti.maxChars = this.maxChars;
            }
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            this.ti = new feathers.controls.TextInput();
            this.ti.addEventListener(starling.events.Event.CHANGE, this.onTextInputChange);
            this.ti.addEventListener(feathers.events.FeathersEventType.ENTER, this.onEnterPress);
            this.ti.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.onFocus);
            this.ti.styleName = "TEXTINPUT";
            this.ti.width = SIGMALink.appWidth - 2 * padding;
            this.ti.text = rawValue.toString();
            this.ti.textEditorFactory = this.stageTextEditorFunc;
            this.ti.setFocus();
            this.ti.selectRange(0, this.ti.text.length);
            this.ti.maxChars = this.maxChars;
            return this.ti;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            var loc1:*=rawValue.toString();
            loc1 = starling.utils.StringUtil.trim(loc1);
            if (this.maxChars > 0) 
            {
                loc1 = loc1.slice(0, this.maxChars);
            }
            editorReturnObject.rawValue = loc1;
            editorReturnObject.value = loc1;
            super.saveValue();
            return;
        }

        internal function onFocus(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.TextInput;
            loc1.selectRange(0, loc1.text.length);
            return;
        }

        internal function onTextInputChange(arg1:starling.events.Event=null):void
        {
            rawValue = this.ti.text;
            return;
        }

        internal function onEnterPress(arg1:starling.events.Event):void
        {
            arg1.stopPropagation();
            this.ti.removeEventListener(starling.events.Event.CHANGE, this.onTextInputChange);
            this.ti.removeEventListener(feathers.events.FeathersEventType.ENTER, this.onEnterPress);
            this.ti.removeEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.onFocus);
            this.ti.clearFocus();
            this.saveValue();
            closeEditor();
            return;
        }

        internal var _maxChars:uint=0;

        internal var stageTextEditorFunc:Function;

        internal var ti:feathers.controls.TextInput;
    }
}


//      class TimeEditor
package frontend.components.menuList.editors 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.formatter.*;
    import starling.display.*;
    import starling.events.*;
    
    public class TimeEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function TimeEditor()
        {
            super();
            orientation = ORIENTATION_CENTERED;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            this.checkFormatString();
            this.initValues();
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            loc1.gap = 8 * SIGMALink.scaleFactor;
            loc2 = new feathers.controls.LayoutGroup();
            loc2.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc2.layout = loc1;
            loc2.layoutData = new feathers.layout.HorizontalLayoutData(100, 100);
            if (this.hours) 
            {
                this.hoursDP = this.generateDP(this.hoursMax);
                loc3 = new feathers.controls.SpinnerList();
                loc3.dataProvider = this.hoursDP;
                loc3.itemRendererProperties.labelField = "label";
                loc3.addEventListener(starling.events.Event.CHANGE, this.onHoursSpinnerValueChanged);
                this.selectDefault(loc3, this.hoursDP, this.hoursValue);
                loc2.addChild(loc3);
            }
            if (this.minutes) 
            {
                if (loc2.numChildren > 0) 
                {
                    loc2.addChild(this.createDelimiter(":"));
                }
                this.minutesDP = this.generateDP(this.minutesMax);
                loc4 = new feathers.controls.SpinnerList();
                loc4.dataProvider = this.minutesDP;
                loc4.itemRendererProperties.labelField = "label";
                loc4.addEventListener(starling.events.Event.CHANGE, this.onMinutesSpinnerValueChanged);
                this.selectDefault(loc4, this.minutesDP, this.minutesValue);
                loc2.addChild(loc4);
            }
            if (this.seconds) 
            {
                if (loc2.numChildren > 0) 
                {
                    loc2.addChild(this.createDelimiter(":"));
                }
                this.secondsDP = this.generateDP(this.secondsMax);
                loc5 = new feathers.controls.SpinnerList();
                loc5.dataProvider = this.secondsDP;
                loc5.itemRendererProperties.labelField = "label";
                loc5.addEventListener(starling.events.Event.CHANGE, this.onSecondsSpinnerValueChanged);
                this.selectDefault(loc5, this.secondsDP, this.secondsValue);
                loc2.addChild(loc5);
            }
            if (this.decimal) 
            {
                if (loc2.numChildren > 0) 
                {
                    loc2.addChild(this.createDelimiter("."));
                }
                this.decimalDP = this.generateDP(this.decimalMax);
                loc6 = new feathers.controls.SpinnerList();
                loc6.dataProvider = this.decimalDP;
                loc6.itemRendererProperties.labelField = "label";
                loc6.addEventListener(starling.events.Event.CHANGE, this.onDecimalSpinnerValueChanged);
                this.selectDefault(loc6, this.decimalDP, this.decimalValue);
                loc2.addChild(loc6);
            }
            return loc2;
        }

        internal function checkFormatString():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            if (this.formatter.formatString) 
            {
                this.maxValue = 0;
                loc1 = (this.formatter.formatString as String).split(":");
                loc3 = loc1.length;
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    var loc4:*=loc1[loc2];
                    switch (loc4) 
                    {
                        case "H":
                        {
                            this.hours = true;
                            this.hoursMax = 9;
                            this.maxValue = this.maxValue + this.hoursMax * 3600;
                            break;
                        }
                        case "MM":
                        {
                            this.minutes = true;
                            this.minutesMax = 59;
                            this.maxValue = this.maxValue + this.minutesMax * 60;
                            break;
                        }
                        case "SS":
                        {
                            this.seconds = true;
                            this.secondsMax = 59;
                            this.maxValue = this.maxValue + this.secondsMax;
                            break;
                        }
                        case "SS.t":
                        {
                            this.seconds = true;
                            this.secondsMax = 59;
                            this.maxValue = this.maxValue + this.secondsMax;
                            this.decimal = true;
                            this.decimalMax = 9;
                            this.maxValue = this.maxValue + 0.9;
                            break;
                        }
                        case "SS.th":
                        {
                            this.seconds = true;
                            this.secondsMax = 59;
                            this.maxValue = this.maxValue + this.secondsMax;
                            this.decimal = true;
                            this.decimalMax = 99;
                            this.maxValue = this.maxValue + 0.99;
                            break;
                        }
                    }
                    ++loc2;
                }
            }
            return;
        }

        internal function createDelimiter(arg1:String):feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.text = arg1;
            loc1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_LIGHT;
            return loc1;
        }

        internal function generateDP(arg1:int):feathers.data.ListCollection
        {
            var loc2:*=0;
            var loc1:*=new Vector.<Object>();
            var loc3:*=arg1 + 1;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                if (loc2 < 10 && arg1 >= 10) 
                {
                    loc1.push({"label":"0" + loc2.toString(), "data":loc2});
                }
                else 
                {
                    loc1.push({"label":loc2.toString(), "data":loc2});
                }
                ++loc2;
            }
            return new feathers.data.ListCollection(loc1);
        }

        internal function selectDefault(arg1:feathers.controls.SpinnerList, arg2:feathers.data.ListCollection, arg3:int):void
        {
            var loc1:*=0;
            if (arg2) 
            {
                loc1 = 0;
                while (loc1 < arg2.data.length) 
                {
                    if (arg2.data[loc1].data == arg3) 
                    {
                        arg1.selectedIndex = loc1;
                    }
                    ++loc1;
                }
            }
            return;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue;
            editorReturnObject.value = backend.utils.DataUtils.countdownFormatter.format(rawValue);
            super.saveValue();
            return;
        }

        internal function onHoursSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.SpinnerList;
            this.hoursValue = loc1.selectedItem.data;
            this.validateValueAndLabel();
            return;
        }

        internal function onMinutesSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.SpinnerList;
            this.minutesValue = loc1.selectedItem.data;
            this.validateValueAndLabel();
            return;
        }

        internal function onSecondsSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.SpinnerList;
            this.secondsValue = loc1.selectedItem.data;
            this.validateValueAndLabel();
            return;
        }

        internal function onDecimalSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.SpinnerList;
            this.decimalValue = loc1.selectedItem.data;
            this.validateValueAndLabel();
            return;
        }

        internal function initValues():void
        {
            this.hoursMax = this.maxValue / 3600;
            this.minutesMax = (this.maxValue - this.hoursMax * 3600) / 60;
            this.secondsMax = this.maxValue - this.hoursMax * 3600 - this.minutesMax * 60;
            var loc1:*=parseFloat((this.maxValue - this.hoursMax * 3600 - this.minutesMax * 60 - this.secondsMax).toFixed(3));
            var loc2:*=1;
            while (loc1 % loc2 > 0) 
            {
                loc1 = loc1 * 10;
            }
            this.decimalMax = loc1;
            var loc3:*=parseInt(rawValue.toString()) / 100;
            this.hoursValue = parseInt(loc3.toString()) / 3600;
            this.minutesValue = (parseInt(loc3.toString()) - this.hoursValue * 3600) / 60;
            this.secondsValue = parseInt(loc3.toString()) - this.hoursValue * 3600 - this.minutesValue * 60;
            this.decimalValue = parseFloat(loc3.toString()) - this.hoursValue * 3600 - this.minutesValue * 60 - this.secondsValue;
            return;
        }

        internal function validateValueAndLabel():void
        {
            var loc3:*=NaN;
            this.labelValue = "";
            var loc1:*=[];
            var loc2:*=0;
            if (this.hours) 
            {
                loc2 = loc2 + this.hoursValue * 3600;
            }
            if (this.minutes) 
            {
                loc2 = loc2 + this.minutesValue * 60;
            }
            if (this.seconds) 
            {
                loc2 = loc2 + this.secondsValue;
            }
            if (this.decimal) 
            {
                loc3 = this.decimalValue / 100;
                loc2 = loc2 + loc3;
            }
            loc2 = loc2 * 100;
            rawValue = loc2;
            this.labelValue = backend.utils.DataUtils.countdownFormatter.format(loc2);
            return;
        }

        public var formatter:frontend.formatter.TimeFormatter;

        public var maxValue:Number=35999.9;

        internal var decimal:Boolean=false;

        internal var decimalDP:feathers.data.ListCollection;

        internal var decimalMax:int=99;

        internal var decimalValue:int=0;

        internal var hours:Boolean=false;

        internal var hoursDP:feathers.data.ListCollection;

        internal var hoursMax:int=9;

        internal var hoursValue:int=0;

        internal var labelValue:String="";

        internal var minutes:Boolean=false;

        internal var minutesDP:feathers.data.ListCollection;

        internal var minutesMax:int=59;

        internal var minutesValue:int=0;

        internal var seconds:Boolean=false;

        internal var secondsDP:feathers.data.ListCollection;

        internal var secondsMax:int=59;

        internal var secondsValue:int=0;
    }
}


//      class ZoneEditor
package frontend.components.menuList.editors 
{
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    import utils.interfaces.*;
    
    public class ZoneEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function ZoneEditor()
        {
            super();
            orientation = ORIENTATION_CENTERED;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc2:*=null;
            var loc1:*=editorInputWidth / 2 - gap;
            loc2 = this.getValues();
            this.ti1 = new feathers.controls.TextInput();
            this.ti1.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.onTextInput1Change);
            this.ti1.addEventListener(feathers.events.FeathersEventType.ENTER, this.onInput1EnterPress);
            this.ti1.styleName = "TEXTINPUT";
            this.ti1.width = loc1;
            this.showValue(this.ti1, loc2[0]);
            this.ti2 = new feathers.controls.TextInput();
            this.ti2.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.onTextInput2Change);
            this.ti2.addEventListener(feathers.events.FeathersEventType.ENTER, this.onInput2EnterPress);
            this.ti2.styleName = "TEXTINPUT";
            this.ti2.width = loc1;
            this.showValue(this.ti2, loc2[1]);
            var loc3:*=new feathers.controls.Label();
            loc3.text = this.delimiter;
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            var loc4:*=new feathers.layout.HorizontalLayout();
            loc4.verticalAlign = "middle";
            loc4.gap = 8 * SIGMALink.scaleFactor;
            var loc5:*=new feathers.controls.LayoutGroup();
            loc5.addChild(this.ti1);
            loc5.addChild(loc3);
            loc5.addChild(this.ti2);
            return loc5;
        }

        internal function onTextInput1Change(arg1:starling.events.Event=null):void
        {
            var loc1:*=this.getValues();
            loc1[0] = parseFloat(this.ti1.text.replace(",", "."));
            loc1[0] = Math.max(this.minimum, loc1[0]);
            loc1[0] = Math.min(loc1[1] - this.minimumDifference, loc1[0]);
            this.setValues(loc1);
            this.showValue(this.ti1, loc1[0]);
            return;
        }

        internal function onTextInput2Change(arg1:starling.events.Event=null):void
        {
            var loc1:*=this.getValues();
            loc1[1] = parseFloat(this.ti2.text.replace(",", "."));
            loc1[1] = Math.max(loc1[0] + this.minimumDifference, loc1[1]);
            loc1[1] = Math.min(this.maximum, loc1[1]);
            this.setValues(loc1);
            this.showValue(this.ti2, loc1[1]);
            return;
        }

        internal function getValues():Array
        {
            return [rawValue.start, rawValue.end];
        }

        internal function setValues(arg1:Array):void
        {
            rawValue = new Object();
            rawValue.start = arg1[0];
            rawValue.end = arg1[1];
            return;
        }

        internal function showValue(arg1:feathers.controls.TextInput, arg2:Number, arg3:Boolean=false):void
        {
            var loc2:*=null;
            var loc1:*=String.fromCharCode(8201);
            if (this.formatter) 
            {
                loc2 = this.formatter.format(arg2);
                loc2 = loc2.replace(loc1, "");
                arg1.text = loc2;
            }
            else 
            {
                arg1.text = arg2.toString();
            }
            arg1.selectRange(0, arg1.text.length);
            if (arg3) 
            {
                arg1.setFocus();
            }
            return;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue;
            super.saveValue();
            return;
        }

        internal function onInput1EnterPress(arg1:starling.events.Event):void
        {
            this.ti1.removeEventListener(starling.events.Event.CHANGE, this.onTextInput1Change);
            this.ti1.removeEventListener(feathers.events.FeathersEventType.ENTER, this.onInput1EnterPress);
            this.onTextInput1Change();
            this.saveValue();
            closeEditor();
            return;
        }

        internal function onInput2EnterPress(arg1:starling.events.Event):void
        {
            this.ti2.removeEventListener(starling.events.Event.CHANGE, this.onTextInput2Change);
            this.ti2.removeEventListener(feathers.events.FeathersEventType.ENTER, this.onInput2EnterPress);
            this.onTextInput2Change();
            this.saveValue();
            closeEditor();
            return;
        }

        public var delimiter:String=" - ";

        public var formatter:utils.interfaces.ICustomFormatterBase;

        public var maximum:Number=100;

        public var minimum:Number=0;

        public var minimumDifference:Number=1;

        public var postfix:String="";

        public var prefix:String="";

        internal var ti1:feathers.controls.TextInput;

        internal var ti2:feathers.controls.TextInput;
    }
}


//    class MenuList
package frontend.components.menuList 
{
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
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class MenuList extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function MenuList()
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
            bindings = this._MenuList_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_components_menuList_MenuListWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.components.menuList.MenuList[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.layout = this._MenuList_VerticalLayout1_c();
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get selectMode():Boolean
        {
            return this._selectMode;
        }

        public function set selectMode(arg1:Boolean):void
        {
            var loc1:*=0;
            this._selectMode = arg1;
            if (this.items && this.items.length > 0) 
            {
                loc1 = 0;
                loc1 = 0;
                while (loc1 < this.items.length) 
                {
                    if (this.items[loc1] is frontend.components.menuList.MenuListItem) 
                    {
                        (this.items[loc1] as frontend.components.menuList.MenuListItem).selectMode = this._selectMode;
                    }
                    ++loc1;
                }
            }
            return;
        }

        internal function _MenuList_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 1;
            loc1.useVirtualLayout = true;
            return loc1;
        }

        internal function _MenuList_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.components.menuList.MenuList._watcherSetupUtil = arg1;
            return;
        }

        public static function get HEADLINE_HEIGHT():Number
        {
            return frontend.components.menuList.MenuList._359756302HEADLINE_HEIGHT;
        }

        public static function set HEADLINE_HEIGHT(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.menuList.MenuList._359756302HEADLINE_HEIGHT;
            if (loc1 !== arg1) 
            {
                frontend.components.menuList.MenuList._359756302HEADLINE_HEIGHT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "HEADLINE_HEIGHT", loc1, arg1, frontend.components.menuList.MenuList);
                loc3 = frontend.components.menuList.MenuList.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get ROW_HEIGHT():Number
        {
            return frontend.components.menuList.MenuList._1852194636ROW_HEIGHT;
        }

        public static function set ROW_HEIGHT(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.menuList.MenuList._1852194636ROW_HEIGHT;
            if (loc1 !== arg1) 
            {
                frontend.components.menuList.MenuList._1852194636ROW_HEIGHT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "ROW_HEIGHT", loc1, arg1, frontend.components.menuList.MenuList);
                loc3 = frontend.components.menuList.MenuList.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get ROW_HEIGHT_SMALL():Number
        {
            return frontend.components.menuList.MenuList._1918462412ROW_HEIGHT_SMALL;
        }

        public static function set ROW_HEIGHT_SMALL(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.menuList.MenuList._1918462412ROW_HEIGHT_SMALL;
            if (loc1 !== arg1) 
            {
                frontend.components.menuList.MenuList._1918462412ROW_HEIGHT_SMALL = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "ROW_HEIGHT_SMALL", loc1, arg1, frontend.components.menuList.MenuList);
                loc3 = frontend.components.menuList.MenuList.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get SMALLER_ROW_HEIGHT():Number
        {
            return frontend.components.menuList.MenuList._1860509847SMALLER_ROW_HEIGHT;
        }

        public static function set SMALLER_ROW_HEIGHT(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.menuList.MenuList._1860509847SMALLER_ROW_HEIGHT;
            if (loc1 !== arg1) 
            {
                frontend.components.menuList.MenuList._1860509847SMALLER_ROW_HEIGHT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "SMALLER_ROW_HEIGHT", loc1, arg1, frontend.components.menuList.MenuList);
                loc3 = frontend.components.menuList.MenuList.staticEventDispatcher;
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
            _359756302HEADLINE_HEIGHT = 64 * SIGMALink.scaleFactor;
            _1852194636ROW_HEIGHT = 128 * SIGMALink.scaleFactor;
            _1918462412ROW_HEIGHT_SMALL = 64 * SIGMALink.scaleFactor;
            _1860509847SMALLER_ROW_HEIGHT = 100 * SIGMALink.scaleFactor;
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        internal var _selectMode:Boolean=false;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _359756302HEADLINE_HEIGHT:Number;

        internal static var _1852194636ROW_HEIGHT:Number;

        internal static var _1918462412ROW_HEIGHT_SMALL:Number;

        internal static var _1860509847SMALLER_ROW_HEIGHT:Number;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;
    }
}


//    class MenuListDbObject
package frontend.components.menuList 
{
    public class MenuListDbObject extends Object
    {
        public function MenuListDbObject()
        {
            super();
            return;
        }

        public function getSqlUpdateStatement():String
        {
            if (!(this.table && this.keyField && this.keyValue && this.updateField && !(this.updateValue == null))) 
            {
                return ERROR_STATEMENT_MISSING_PARAMETERS;
            }
            var loc1:*="UPDATE " + this.table + " SET " + this.updateField + " = :updateValue";
            if (this.updateField2 != "") 
            {
                loc1 = loc1 + (", " + this.updateField2 + " = :updateValue2");
            }
            if (this.updateModificationDate) 
            {
                loc1 = loc1 + (", modificationDate = \'" + new Date().time + "\'");
            }
            loc1 = loc1 + (" WHERE " + this.keyField + " = :keyValue");
            return loc1;
        }

        public function getParams():Object
        {
            var loc1:*=new Object();
            if (this.dateAsString) 
            {
                loc1[":updateValue"] = (this.updateValue as Date).toString();
            }
            else 
            {
                loc1[":updateValue"] = this.updateValue;
            }
            if (this.updateField2 != "") 
            {
                loc1[":updateValue2"] = this.updateValue2;
            }
            loc1[":keyValue"] = this.keyValue;
            return loc1;
        }

        
        {
            ERROR_STATEMENT_MISSING_PARAMETERS = "ERROR_STATEMENT_MISSING_PARAMETERS";
        }

        public var classAttributeName:String="";

        public var completeCallback:Function;

        public var dateAsString:Boolean=false;

        public var errorCallback:Function;

        public var keyField:String;

        public var keyValue:String;

        public var table:String;

        public var updateField:String;

        public var updateField2:String="";

        public var updateModificationDate:Boolean=true;

        public var updateValue:Object;

        public var updateValue2:Object;

        public static var ERROR_STATEMENT_MISSING_PARAMETERS:String="ERROR_STATEMENT_MISSING_PARAMETERS";
    }
}


//    class MenuListHeadline
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


//    class MenuListItem
package frontend.components.menuList 
{
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.general.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.data.*;
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
    import frontend.components.core.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.popup.*;
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
    import utils.converter.*;
    import utils.interfaces.*;
    
    use namespace mx_internal;
    
    public class MenuListItem extends frontend.components.core.TouchLayoutGroup implements feathers.binding.IBindingClient
    {
        public function MenuListItem()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._1761778276customBackgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this._2146088563itemWidth = SIGMALink.appWidth;
            this._229163114maxRightLabelWidth = SIGMALink.appWidth;
            this._1973788148minItemHeight = 65 * SIGMALink.scaleFactor;
            this._806339567padding = 20 * SIGMALink.scaleFactor;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._MenuListItem_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_components_menuList_MenuListItemWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.components.menuList.MenuListItem[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.touchGroup = true;
            this.layout = this._MenuListItem_AnchorLayout1_c();
            this.mxmlContent = [this._MenuListItem_LayoutGroup1_i(), this._MenuListItem_LayoutGroup2_i(), this._MenuListItem_LayoutGroup3_i(), this._MenuListItem_TextureImage2_i(), this._MenuListItem_LayoutGroup4_i(), this._MenuListItem_LayoutGroup5_i()];
            this.addEventListener("initialize", this.___MenuListItem_TouchLayoutGroup1_initialize);
            this.addEventListener("touch", this.___MenuListItem_TouchLayoutGroup1_touch);
            this.addEventListener("triggered", this.___MenuListItem_TouchLayoutGroup1_triggered);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get leftLabel():feathers.controls.Label
        {
            return this._1723849517leftLabel;
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

        public function get leftLablGroup():feathers.controls.LayoutGroup
        {
            return this._166888697leftLablGroup;
        }

        public function set leftLablGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._166888697leftLablGroup;
            if (loc1 !== arg1) 
            {
                this._166888697leftLablGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "leftLablGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get leftSubLabel():feathers.controls.Label
        {
            return this._138659259leftSubLabel;
        }

        public function set leftSubLabel(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._138659259leftSubLabel;
            if (loc1 !== arg1) 
            {
                this._138659259leftSubLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "leftSubLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get leftSubLabel2():feathers.controls.Label
        {
            return this._3469783leftSubLabel2;
        }

        public function set leftSubLabel2(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3469783leftSubLabel2;
            if (loc1 !== arg1) 
            {
                this._3469783leftSubLabel2 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "leftSubLabel2", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get rightGroup():feathers.controls.LayoutGroup
        {
            return this._1409862205rightGroup;
        }

        public function set rightGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1409862205rightGroup;
            if (loc1 !== arg1) 
            {
                this._1409862205rightGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "rightGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get rightLabel():feathers.controls.Label
        {
            return this._1405764040rightLabel;
        }

        public function set rightLabel(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1405764040rightLabel;
            if (loc1 !== arg1) 
            {
                this._1405764040rightLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "rightLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get selector():feathers.controls.LayoutGroup
        {
            return this._1191572447selector;
        }

        public function set selector(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1191572447selector;
            if (loc1 !== arg1) 
            {
                this._1191572447selector = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "selector", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get toggleBtn():frontend.components.menuList.editors.base.OnOffToggleButton
        {
            return this._942316136toggleBtn;
        }

        public function set toggleBtn(arg1:frontend.components.menuList.editors.base.OnOffToggleButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._942316136toggleBtn;
            if (loc1 !== arg1) 
            {
                this._942316136toggleBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "toggleBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get checkable():Boolean
        {
            return this._398964322checkable;
        }

        public function set checkable(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._398964322checkable;
            if (loc1 !== arg1) 
            {
                this._398964322checkable = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "checkable", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get checked():Boolean
        {
            return this._742313895checked;
        }

        public function set checked(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._742313895checked;
            if (loc1 !== arg1) 
            {
                this._742313895checked = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "checked", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get clickCallback():Function
        {
            return this._134069779clickCallback;
        }

        public function get dataProvider():feathers.data.ListCollection
        {
            return this._dataProvider;
        }

        internal function set _339742651dataProvider(arg1:feathers.data.ListCollection):void
        {
            this._dataProvider = arg1;
            if (this._dataProvider == null) 
            {
                this.hasDataProvider = false;
            }
            else 
            {
                this.hasDataProvider = true;
            }
            return;
        }

        public function set clickCallback(arg1:Function):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._134069779clickCallback;
            if (loc1 !== arg1) 
            {
                this._134069779clickCallback = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "clickCallback", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get customBackgroundSkin():starling.display.Quad
        {
            return this._1761778276customBackgroundSkin;
        }

        public function set customBackgroundSkin(arg1:starling.display.Quad):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1761778276customBackgroundSkin;
            if (loc1 !== arg1) 
            {
                this._1761778276customBackgroundSkin = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "customBackgroundSkin", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set maxChars(arg1:uint):void
        {
            this._maxChars = arg1;
            if (this.editor != null) 
            {
                this.editor.maxChars = this.maxChars;
            }
            return;
        }

        public function set dataProvider(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.dataProvider;
            if (loc1 !== arg1) 
            {
                this._339742651dataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "dataProvider", loc1, arg1, this);
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

        public function get editable():Boolean
        {
            return this._editable;
        }

        internal function set _1602416228editable(arg1:Boolean):void
        {
            this._editable = arg1;
            if (this.editIcon) 
            {
                var loc1:*;
                this.editIcon.includeInLayout = loc1 = this.editable && !this.selectMode && !(this.type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
                this.editIcon.visible = loc1;
            }
            return;
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

        public function set functionButtonLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.functionButtonLabel;
            if (loc1 !== arg1) 
            {
                this._1158351894functionButtonLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "functionButtonLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get functionButtonLabel():String
        {
            return this._functionButtonLabel;
        }

        internal function set _1158351894functionButtonLabel(arg1:String):void
        {
            if (this._functionButtonLabel != arg1) 
            {
                this._functionButtonLabel = arg1;
                if (this._initialized) 
                {
                    this._functionBtnText = this._useLocalesForText ? utils.LanguageManager.getString(this.functionButtonLabel) : this.functionButtonLabel;
                }
            }
            return;
        }

        public function get functionButtonVisible():Boolean
        {
            return this._249692184functionButtonVisible;
        }

        public function set functionButtonVisible(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._249692184functionButtonVisible;
            if (loc1 !== arg1) 
            {
                this._249692184functionButtonVisible = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "functionButtonVisible", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get hasTouchEvents():Boolean
        {
            return this._1186943550hasTouchEvents;
        }

        public function set hasTouchEvents(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1186943550hasTouchEvents;
            if (loc1 !== arg1) 
            {
                this._1186943550hasTouchEvents = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "hasTouchEvents", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get iconTexture():String
        {
            return this._iconTexture;
        }

        internal function set _2057836958iconTexture(arg1:String):void
        {
            this._iconTexture = arg1;
            if (this._iconTexture == null) 
            {
                this.iconGroup.removeChild(this.icon);
                this.icon = null;
                this.hasIcon = false;
            }
            else if (this.icon) 
            {
                this.icon.source = frontend.AssetsManagerCustom.getInstance().getTexture(this._iconTexture);
            }
            else 
            {
                this.icon = new feathers.controls.ImageLoader();
                this.icon.source = frontend.AssetsManagerCustom.getInstance().getTexture(this._iconTexture);
                this.iconGroup.addChildAt(this.icon, 0);
                this.hasIcon = true;
            }
            this.validateSizesAndPositions();
            return;
        }

        public function set iconTexture(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.iconTexture;
            if (loc1 !== arg1) 
            {
                this._2057836958iconTexture = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconTexture", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get isSelected():Boolean
        {
            return this._398301669isSelected;
        }

        public function set isSelected(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._398301669isSelected;
            if (loc1 !== arg1) 
            {
                this._398301669isSelected = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "isSelected", loc1, arg1, this);
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

        public function get leftSubLabelText():String
        {
            return this._leftSubLabelText;
        }

        internal function set _290204040leftSubLabelText(arg1:String):void
        {
            if (this._leftSubLabelText != arg1) 
            {
                this._leftSubLabelText = arg1;
                this._displaySubText = this.leftSubLabelText.length > 0;
            }
            return;
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

        public function get leftSubLabelText2():String
        {
            return this._leftSubLabelText2;
        }

        internal function set _406390698leftSubLabelText2(arg1:String):void
        {
            if (this._leftSubLabelText2 != arg1) 
            {
                this._leftSubLabelText2 = arg1;
                this._displaySubText2 = this.leftSubLabelText2.length > 0;
            }
            return;
        }

        public function set leftSubLabelText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.leftSubLabelText;
            if (loc1 !== arg1) 
            {
                this._290204040leftSubLabelText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "leftSubLabelText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get maxChars():uint
        {
            return this._maxChars;
        }

        public function set leftSubLabelText2(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.leftSubLabelText2;
            if (loc1 !== arg1) 
            {
                this._406390698leftSubLabelText2 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "leftSubLabelText2", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get maxRightLabelWidth():Number
        {
            return this._229163114maxRightLabelWidth;
        }

        public function set maxRightLabelWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._229163114maxRightLabelWidth;
            if (loc1 !== arg1) 
            {
                this._229163114maxRightLabelWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "maxRightLabelWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get minItemHeight():Number
        {
            return this._1973788148minItemHeight;
        }

        public function set minItemHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1973788148minItemHeight;
            if (loc1 !== arg1) 
            {
                this._1973788148minItemHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "minItemHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
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

        public function get preClickCallback():Function
        {
            return this._139960310preClickCallback;
        }

        public function set preClickCallback(arg1:Function):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._139960310preClickCallback;
            if (loc1 !== arg1) 
            {
                this._139960310preClickCallback = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "preClickCallback", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get saveCompleteCallback():Function
        {
            return this._346085435saveCompleteCallback;
        }

        public function set saveCompleteCallback(arg1:Function):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._346085435saveCompleteCallback;
            if (loc1 !== arg1) 
            {
                this._346085435saveCompleteCallback = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "saveCompleteCallback", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set selectMode(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.selectMode;
            if (loc1 !== arg1) 
            {
                this._1656159041selectMode = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "selectMode", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
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

        public function get selectMode():Boolean
        {
            return this._selectMode;
        }

        internal function set _1656159041selectMode(arg1:Boolean):void
        {
            this._selectMode = arg1;
            this.validateSizesAndPositions();
            return;
        }

        public function get title():String
        {
            return this._110371416title;
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

        public function get text():String
        {
            return this._text;
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

        public function get type():String
        {
            return this._3575610type;
        }

        public function set type(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3575610type;
            if (loc1 !== arg1) 
            {
                this._3575610type = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "type", loc1, arg1, this);
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

        public function get useLocalesForTitle():Boolean
        {
            return this._1077721343useLocalesForTitle;
        }

        public function set useLocalesForTitle(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1077721343useLocalesForTitle;
            if (loc1 !== arg1) 
            {
                this._1077721343useLocalesForTitle = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "useLocalesForTitle", loc1, arg1, this);
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
                    this._functionBtnText = this._useLocalesForText ? utils.LanguageManager.getString(this.functionButtonLabel) : this.functionButtonLabel;
                }
            }
            return;
        }

        internal function get _displaySubText():Boolean
        {
            return this._1238976138_displaySubText;
        }

        internal function set _displaySubText(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1238976138_displaySubText;
            if (loc1 !== arg1) 
            {
                this._1238976138_displaySubText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_displaySubText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get value():Object
        {
            return this._value;
        }

        public function set value(arg1:Object):void
        {
            if (arg1 == null || arg1 is String && arg1 === "") 
            {
                if (this.type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_SPORT || this.type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_STRING) 
                {
                    arg1 = this.defaultValues;
                }
                else if (this.type != frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD) 
                {
                    if (this.defaultValue != null) 
                    {
                        arg1 = this.defaultValue;
                    }
                }
                else if (arg1 == null) 
                {
                    arg1 = this.defaultValue;
                }
            }
            this._value = arg1;
            this.format(this._value);
            return;
        }

        internal function _MenuListItem_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "iconGroup";
            this.iconGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "iconGroup", this.iconGroup);
            return loc1;
        }

        internal function get _displaySubText2():Boolean
        {
            return this._246445336_displaySubText2;
        }

        internal function set _displaySubText2(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._246445336_displaySubText2;
            if (loc1 !== arg1) 
            {
                this._246445336_displaySubText2 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_displaySubText2", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _functionBtnText():String
        {
            return this._949723250_functionBtnText;
        }

        internal function set _functionBtnText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._949723250_functionBtnText;
            if (loc1 !== arg1) 
            {
                this._949723250_functionBtnText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_functionBtnText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
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

        internal function get formattedValue():String
        {
            return this._1695807979formattedValue;
        }

        internal function set formattedValue(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1695807979formattedValue;
            if (loc1 !== arg1) 
            {
                this._1695807979formattedValue = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "formattedValue", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get hasChild():Boolean
        {
            return this._114623138hasChild;
        }

        internal function set hasChild(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._114623138hasChild;
            if (loc1 !== arg1) 
            {
                this._114623138hasChild = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "hasChild", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get hasIcon():Boolean
        {
            return this._696608307hasIcon;
        }

        internal function set hasIcon(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._696608307hasIcon;
            if (loc1 !== arg1) 
            {
                this._696608307hasIcon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "hasIcon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get showValue():Boolean
        {
            return this._1912202124showValue;
        }

        internal function set showValue(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1912202124showValue;
            if (loc1 !== arg1) 
            {
                this._1912202124showValue = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "showValue", loc1, arg1, this);
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
            frontend.components.menuList.MenuListItem._watcherSetupUtil = arg1;
            return;
        }

        protected override function changeState(arg1:String):void
        {
            super.changeState(arg1);
            if (this.showDownStateSkin) 
            {
                if (currentState == STATE_DOWN && this.editable) 
                {
                    backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
                }
                else 
                {
                    backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
                }
            }
            return;
        }

        internal function format(arg1:Object):void
        {
            var loc1:*=this.converter ? this.converter.convert(arg1) : arg1;
            if (this.formatter == null) 
            {
                if (this.dataProvider) 
                {
                    this.formattedValue = this.getValueFromDataProvider(loc1.toString());
                }
                else 
                {
                    this.formattedValue = loc1.toString();
                }
            }
            else if (arg1.hasOwnProperty("start") && arg1.hasOwnProperty("end")) 
            {
                this.formattedValue = this.formatter.format(arg1.start) + " - " + this.formatter.format(arg1.end);
            }
            else 
            {
                this.formattedValue = this.formatter.format(loc1) as String;
            }
            if (this.unitString != "") 
            {
                this.formattedValue = this.formattedValue + (" " + this.unitString);
            }
            return;
        }

        protected function triggeredHandler(arg1:starling.events.Event):void
        {
            if (!this.hasTouchEvents) 
            {
                return;
            }
            if (this.selectMode) 
            {
                this.isSelected = !this.isSelected;
                return;
            }
            debug.Debug.debug("MenuItem clicked " + (this.useLocalesForText ? utils.LanguageManager.getString(this.text) : this.text));
            if (this.type == null) 
            {
                debug.Debug.error("Kein MenuItem-Typ (type) definiert: Abbruch!");
                return;
            }
            var loc1:*=this.type;
            switch (loc1) 
            {
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU:
                {
                    if (this.destination == null) 
                    {
                        return;
                    }
                    handler.ViewHandler.getInstance().showScreen(this.destination, this.destinationObject, handler.ViewHandler.slideToLeftTransition());
                    return;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CLICK_CALLBACK:
                {
                    if (this.clickCallback != null) 
                    {
                        this.clickCallback();
                        return;
                    }
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE:
                {
                    this.onToggleChanged(!this.checked);
                    return;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_BUTTON:
                {
                    if (this.functionButtonCallback != null) 
                    {
                        this.functionButtonCallback();
                    }
                    break;
                }
            }
            if (this.editable) 
            {
                this.showEditor();
            }
            return;
        }

        public function showEditor():void
        {
            if (!this.editorClass) 
            {
                this.editorClass = frontend.components.menuList.editors.base.EditorClasses.getEditor(this.type);
            }
            this.editor = new this.editorClass();
            this.editor.unitString = this.unitString;
            var loc1:*=this.type;
            switch (loc1) 
            {
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_SPORT:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_STRING:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPORT_AND_NAME:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_UNIT_SELECTOR:
                {
                    this.editor.dataProvider = this.dataProvider;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER:
                {
                    this.editor.converter = this.converter;
                    this.editor.formatter = this.formatter;
                    this.editor.minimum = this.minimum;
                    this.editor.maximum = this.maximum;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATE:
                {
                    this.editor.formatter = this.formatter;
                    this.editor.minimum = this.minimum;
                    this.editor.maximum = this.maximum;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_ZONE:
                {
                    this.editor.formatter = this.formatter;
                    this.editor.minimumDifference = this.minimumDifference;
                    this.editor.minimum = this.minimum;
                    this.editor.maximum = this.maximum;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME:
                {
                    this.editor.formatter = this.formatter;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_AREA:
                {
                    this.editor.maxChars = this.maxChars;
                    break;
                }
            }
            this.editor.owner = this;
            this.editor.rawValue = this.value;
            this.editor.title = this.useLocalesForTitle ? utils.LanguageManager.getString(this.title) : this.title;
            this.editor.saveCompleteCallback = this.saveCompleteCallback;
            frontend.components.popup.PopUpBase.showModalPopUp(this.editor, true, (this.editor as frontend.components.menuList.editors.base.EditorBase).useTween);
            return;
        }

        public function validateSizesAndPositions():void
        {
            this.rightGroup_resizeHandler();
            this.rightLabel.maxWidth = this.itemWidth - this.leftLabel.width - 2 * this.padding - (this._selectMode ? editGroupWidth : 0) - this.padding;
            if (this.displayText) 
            {
                this.rightLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, this.padding, NaN, NaN, NaN, 0);
            }
            else 
            {
                this.rightLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, this.padding, NaN, (this._selectMode ? editGroupWidth : 0) + this.padding, NaN, 0);
            }
            var loc1:*;
            this.editIcon.includeInLayout = loc1 = this.editable && !this.selectMode && !(this.type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            this.editIcon.visible = loc1;
            return;
        }

        public function onInit(arg1:starling.events.Event=null):void
        {
            var loc1:*=null;
            this._initialized = true;
            if (this.text.length > 0) 
            {
                this._leftLabelText = this._useLocalesForText ? utils.LanguageManager.getString(this.text) : this.text;
            }
            if (this.functionButtonLabel.length > 0) 
            {
                this._functionBtnText = this._useLocalesForText ? utils.LanguageManager.getString(this.functionButtonLabel) : this.functionButtonLabel;
            }
            this.validateSizesAndPositions();
            var loc2:*=this.type;
            switch (loc2) 
            {
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU:
                {
                    this.hasChild = true;
                    this.showValue = false;
                    this.editable = false;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CLICK_CALLBACK:
                {
                    this.editable = false;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_AREA:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RADIO:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CHECKBOX_MULTI:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATE:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATEIME:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RATING:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_ZONE:
                {
                    if (this.useConfigCache && !(this.configCacheAttribute == "")) 
                    {
                        loc1 = configCache.ConfigCache.getInstance().getValue(this.configCacheAttribute, "");
                    }
                    else 
                    {
                        loc1 = this.defaultValue;
                    }
                    if (loc1 != null) 
                    {
                        this.value = loc1;
                    }
                    if (this.type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RATING) 
                    {
                        this.showValue = false;
                    }
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPORT_AND_NAME:
                {
                    loc1 = this.defaultValue;
                    if (loc1 != null) 
                    {
                        this.value = loc1;
                    }
                    if (this.type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT) 
                    {
                        this.showValue = false;
                    }
                    if (this.type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPORT_AND_NAME) 
                    {
                        this.showValue = false;
                    }
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_UNIT_SELECTOR:
                {
                    loc1 = this.defaultValue;
                    if (loc1 != null) 
                    {
                        this.value = loc1;
                    }
                    this.showValue = false;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_SPORT:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_STRING:
                {
                    loc1 = this.defaultValues;
                    if (loc1 != null) 
                    {
                        this.value = loc1;
                    }
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE:
                {
                    this.hasChild = false;
                    this.showValue = false;
                    if (this.useConfigCache && !(this.configCacheAttribute == "")) 
                    {
                        loc1 = configCache.ConfigCache.getInstance().getValue(this.configCacheAttribute, this.defaultValue as Boolean) as Boolean;
                    }
                    else 
                    {
                        loc1 = this.defaultValue as Boolean;
                    }
                    if (loc1 != null) 
                    {
                        this.checked = loc2 = loc1;
                        this.value = loc2;
                    }
                    break;
                }
                default:
                {
                    this.hasChild = false;
                    this.showValue = false;
                    this.editable = false;
                    break;
                }
            }
            return;
        }

        internal function getValueFromDataProvider(arg1:String):String
        {
            var loc1:*=0;
            var loc2:*="";
            if (this.dataProvider) 
            {
                loc1 = 0;
                while (loc1 < this.dataProvider.data.length) 
                {
                    if (this.dataProvider.data[loc1].data.toString() == arg1) 
                    {
                        loc2 = this.dataProvider.data[loc1].label;
                        this.selectedIndex = loc1;
                        return loc2;
                    }
                    ++loc1;
                }
            }
            return loc2;
        }

        internal function onToggleChanged(arg1:Boolean):void
        {
            if (!this.editable) 
            {
                return;
            }
            debug.Debug.debug("onToggleChanged: " + arg1);
            this.checked = arg1;
            var loc1:*=new frontend.components.menuList.editors.base.EditorReturnObject();
            loc1.rawValue = this.checked;
            loc1.dispatchCompleteEvent = true;
            this.handleReturnValue(loc1);
            if (this.saveCompleteCallback != null) 
            {
                this.saveCompleteCallback(this, loc1);
            }
            return;
        }

        public function handleReturnValue(arg1:frontend.components.menuList.editors.base.EditorReturnObject=null):void
        {
            var p_editorReturnObject:frontend.components.menuList.editors.base.EditorReturnObject=null;
            var onInsertComplete:Function;
            var onInsertError:Function;

            var loc1:*;
            p_editorReturnObject = arg1;
            if (p_editorReturnObject == null) 
            {
                return;
            }
            var loc2:*=this.type;
            switch (loc2) 
            {
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD:
                {
                    this.value = p_editorReturnObject.rawValue as String;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_AREA:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RADIO:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CHECKBOX_MULTI:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATE:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATEIME:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_SPORT:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_STRING:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RATING:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_ZONE:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE:
                {
                    this.value = p_editorReturnObject.rawValue;
                    break;
                }
            }
            if (this.useConfigCache && !(this.configCacheAttribute == "")) 
            {
                configCache.ConfigCache.getInstance().setValue(this.configCacheAttribute, this.value);
                if (p_editorReturnObject.dispatchCompleteEvent) 
                {
                    dispatchEvent(new starling.events.Event("completeEvent"));
                }
            }
            else if (this.saveToDbUseUpdate && !(this.saveToDbUseUpdateObject == null)) 
            {
                onInsertComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                {
                    if (saveToDbUseUpdateObject.completeCallback != null) 
                    {
                        saveToDbUseUpdateObject.completeCallback(value);
                    }
                    if (p_editorReturnObject.dispatchCompleteEvent) 
                    {
                        dispatchEvent(new starling.events.Event("completeEvent"));
                    }
                    return;
                }
                onInsertError = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                {
                    if (saveToDbUseUpdateObject.errorCallback != null) 
                    {
                        saveToDbUseUpdateObject.errorCallback(value);
                    }
                    return;
                }
                if (this.type != frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_ZONE) 
                {
                    if (p_editorReturnObject.rawValue is core.general.TireSize) 
                    {
                        this.saveToDbUseUpdateObject.updateValue = p_editorReturnObject.rawValue.data;
                    }
                    else 
                    {
                        this.saveToDbUseUpdateObject.updateValue = p_editorReturnObject.rawValue;
                    }
                }
                else 
                {
                    this.saveToDbUseUpdateObject.updateValue = p_editorReturnObject.rawValue.start;
                    this.saveToDbUseUpdateObject.updateValue2 = p_editorReturnObject.rawValue.end;
                }
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, this.saveToDbUseUpdateObject.getSqlUpdateStatement(), onInsertComplete, onInsertError, null, null, this.saveToDbUseUpdateObject.getParams());
            }
            else 
            {
                dispatchEvent(new starling.events.Event("completeEvent"));
            }
            return;
        }

        protected function rightGroup_resizeHandler(arg1:starling.events.Event=null):void
        {
            if (this.leftLabelAlignTop) 
            {
                this.leftLablGroup.layoutData = new feathers.layout.AnchorLayoutData(this.padding, this.rightGroup.width + this.padding, NaN, this.hasIcon ? this.ICON_GROUP_WIDTH + 2 * this.padding : this.padding);
            }
            else 
            {
                this.leftLablGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, this.rightGroup.width + this.padding, NaN, this.hasIcon ? this.ICON_GROUP_WIDTH + 2 * this.padding : this.padding, NaN, 0);
            }
            this.leftLablGroup.validate();
            this.leftLabel.maxWidth = this.itemWidth - (this._selectMode ? editGroupWidth : 0) - this.padding - this.rightGroup.width;
            this.leftLabel.validate();
            this.leftSubLabel.maxWidth = this.itemWidth - (this._selectMode ? editGroupWidth : 0) - this.padding - this.rightGroup.width;
            this.leftSubLabel.validate();
            this.leftSubLabel2.maxWidth = this.itemWidth - (this._selectMode ? editGroupWidth : 0) - this.padding - this.rightGroup.width;
            this.leftSubLabel2.validate();
            return;
        }

        internal function _MenuListItem_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        public function set customLayoutContent(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1777226238customLayoutContent;
            if (loc1 !== arg1) 
            {
                this._1777226238customLayoutContent = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "customLayoutContent", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _MenuListItem_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._MenuListItem_VerticalLayout1_c();
            loc1.mxmlContent = [this._MenuListItem_Label1_i(), this._MenuListItem_Label2_i(), this._MenuListItem_Label3_i()];
            loc1.id = "leftLablGroup";
            this.leftLablGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "leftLablGroup", this.leftLablGroup);
            return loc1;
        }

        internal function _MenuListItem_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 2;
            return loc1;
        }

        internal function _MenuListItem_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "leftLabel";
            this.leftLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "leftLabel", this.leftLabel);
            return loc1;
        }

        internal function _MenuListItem_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "leftSubLabel";
            this.leftSubLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "leftSubLabel", this.leftSubLabel);
            return loc1;
        }

        internal function _MenuListItem_Label3_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "leftSubLabel2";
            this.leftSubLabel2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "leftSubLabel2", this.leftSubLabel2);
            return loc1;
        }

        internal function _MenuListItem_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._MenuListItem_AnchorLayout2_c();
            loc1.mxmlContent = [this._MenuListItem_TextureImage1_i(), this._MenuListItem_Label4_i(), this._MenuListItem_OnOffToggleButton1_i(), this._MenuListItem_Button1_i()];
            loc1.addEventListener("resize", this.__rightGroup_resize);
            loc1.id = "rightGroup";
            this.rightGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "rightGroup", this.rightGroup);
            return loc1;
        }

        internal function _MenuListItem_AnchorLayout2_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _MenuListItem_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.touchable = false;
            loc1.id = "_MenuListItem_TextureImage1";
            this._MenuListItem_TextureImage1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MenuListItem_TextureImage1", this._MenuListItem_TextureImage1);
            return loc1;
        }

        internal function _MenuListItem_Label4_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "rightLabel";
            this.rightLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "rightLabel", this.rightLabel);
            return loc1;
        }

        internal function _MenuListItem_OnOffToggleButton1_i():frontend.components.menuList.editors.base.OnOffToggleButton
        {
            var loc1:*=new frontend.components.menuList.editors.base.OnOffToggleButton();
            loc1.id = "toggleBtn";
            this.toggleBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "toggleBtn", this.toggleBtn);
            return loc1;
        }

        internal function _MenuListItem_Button1_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.id = "functionBtn";
            this.functionBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "functionBtn", this.functionBtn);
            return loc1;
        }

        public function __rightGroup_resize(arg1:starling.events.Event):void
        {
            this.rightGroup_resizeHandler(arg1);
            return;
        }

        internal function _MenuListItem_TextureImage2_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "editIcon";
            this.editIcon = loc1;
            feathers.binding.BindingManager.executeBindings(this, "editIcon", this.editIcon);
            return loc1;
        }

        internal function _MenuListItem_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._MenuListItem_AnchorLayout3_c();
            loc1.mxmlContent = [this._MenuListItem_Check1_i()];
            loc1.id = "selector";
            this.selector = loc1;
            feathers.binding.BindingManager.executeBindings(this, "selector", this.selector);
            return loc1;
        }

        internal function _MenuListItem_AnchorLayout3_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _MenuListItem_Check1_i():feathers.controls.Check
        {
            var loc1:*=new feathers.controls.Check();
            loc1.hasLabelTextRenderer = false;
            loc1.verticalAlign = "middle";
            loc1.id = "_MenuListItem_Check1";
            this._MenuListItem_Check1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MenuListItem_Check1", this._MenuListItem_Check1);
            return loc1;
        }

        internal function _MenuListItem_LayoutGroup5_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.includeInLayout = false;
            loc1.visible = false;
            loc1.id = "customLayoutContent";
            this.customLayoutContent = loc1;
            feathers.binding.BindingManager.executeBindings(this, "customLayoutContent", this.customLayoutContent);
            return loc1;
        }

        public function ___MenuListItem_TouchLayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___MenuListItem_TouchLayoutGroup1_touch(arg1:starling.events.TouchEvent):void
        {
            touchHandler(arg1);
            return;
        }

        public function ___MenuListItem_TouchLayoutGroup1_triggered(arg1:starling.events.Event):void
        {
            this.triggeredHandler(arg1);
            return;
        }

        internal function _MenuListItem_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, null, null, "this.backgroundSkin", "customBackgroundSkin");
            result[1] = new feathers.binding.Binding(this, null, null, "this.minHeight", "minItemHeight");
            result[2] = new feathers.binding.Binding(this, null, null, "this.width", "itemWidth");
            result[3] = new feathers.binding.Binding(this, function ():Boolean
            {
                return hasIcon;
            }, null, "iconGroup.includeInLayout")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, padding, NaN, 0);
            }, null, "iconGroup.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():Boolean
            {
                return hasIcon;
            }, null, "iconGroup.visible")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return ICON_GROUP_WIDTH;
            }, null, "iconGroup.width")
            result[7] = new feathers.binding.Binding(this, null, null, "leftLabel.includeInLayout", "displayText");
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "leftLabel.styleName")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_leftLabelText;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "leftLabel.text")
            result[10] = new feathers.binding.Binding(this, null, null, "leftLabel.visible", "displayText");
            result[11] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _displaySubText;
            }, null, "leftSubLabel.includeInLayout")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "leftSubLabel.styleName")
            result[13] = new feathers.binding.Binding(this, null, null, "leftSubLabel.text", "leftSubLabelText");
            result[14] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _displaySubText;
            }, null, "leftSubLabel.visible")
            result[15] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _displaySubText2;
            }, null, "leftSubLabel2.includeInLayout")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "leftSubLabel2.styleName")
            result[17] = new feathers.binding.Binding(this, null, null, "leftSubLabel2.text", "leftSubLabelText2");
            result[18] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _displaySubText2;
            }, null, "leftSubLabel2.visible")
            result[19] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, 0, NaN, NaN, NaN, 0);
            }, null, "rightGroup.layoutData")
            result[20] = new feathers.binding.Binding(this, function ():Boolean
            {
                return hasChild;
            }, null, "_MenuListItem_TextureImage1.includeInLayout")
            result[21] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, padding, NaN, NaN, NaN, 0);
            }, null, "_MenuListItem_TextureImage1.layoutData")
            result[22] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.pfeilmitbg;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MenuListItem_TextureImage1.textureName")
            result[23] = new feathers.binding.Binding(this, function ():Boolean
            {
                return hasChild;
            }, null, "_MenuListItem_TextureImage1.visible")
            result[24] = new feathers.binding.Binding(this, function ():Boolean
            {
                return showValue;
            }, null, "rightLabel.includeInLayout")
            result[25] = new feathers.binding.Binding(this, null, null, "rightLabel.isEnabled", "editable");
            result[26] = new feathers.binding.Binding(this, null, null, "rightLabel.maxWidth", "maxRightLabelWidth");
            result[27] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUVALUE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "rightLabel.styleName")
            result[28] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=formattedValue;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "rightLabel.text")
            result[29] = new feathers.binding.Binding(this, function ():Boolean
            {
                return showValue;
            }, null, "rightLabel.visible")
            result[30] = new feathers.binding.Binding(this, function ():Boolean
            {
                return type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_AREA;
            }, null, "rightLabel.wordWrap")
            result[31] = new feathers.binding.Binding(this, null, null, "toggleBtn.checked", "checked");
            result[32] = new feathers.binding.Binding(this, null, null, "toggleBtn.editable", "editable");
            result[33] = new feathers.binding.Binding(this, function ():Boolean
            {
                return type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE;
            }, null, "toggleBtn.includeInLayout")
            result[34] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, 0, NaN, NaN, NaN, 0);
            }, null, "toggleBtn.layoutData")
            result[35] = new feathers.binding.Binding(this, function ():Boolean
            {
                return type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE;
            }, null, "toggleBtn.visible")
            result[36] = new feathers.binding.Binding(this, function ():Boolean
            {
                return type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_BUTTON == functionButtonVisible == true;
            }, null, "functionBtn.includeInLayout")
            result[37] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_functionBtnText;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "functionBtn.label")
            result[38] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, padding, NaN, NaN, NaN, 0);
            }, null, "functionBtn.layoutData")
            result[39] = new feathers.binding.Binding(this, function ():Boolean
            {
                return type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_BUTTON == functionButtonVisible == true;
            }, null, "functionBtn.visible")
            result[40] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(1, 1);
            }, null, "editIcon.layoutData")
            result[41] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.linkiconsmall;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "editIcon.textureName")
            result[42] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.MIDGREY);
            }, null, "selector.backgroundSkin")
            result[43] = new feathers.binding.Binding(this, null, null, "selector.height", "minItemHeight");
            result[44] = new feathers.binding.Binding(this, null, null, "selector.includeInLayout", "selectMode");
            result[45] = new feathers.binding.Binding(this, null, null, "selector.visible", "selectMode");
            result[46] = new feathers.binding.Binding(this, function ():Number
            {
                return editGroupWidth;
            }, null, "selector.width")
            result[47] = new feathers.binding.Binding(this, null, null, "_MenuListItem_Check1.isSelected", "isSelected");
            result[48] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, padding, NaN, 0);
            }, null, "_MenuListItem_Check1.layoutData")
            result[49] = new feathers.binding.Binding(this, null, null, "customLayoutContent.minHeight", "minItemHeight");
            return result;
        }

        public function get customLayoutContent():feathers.controls.LayoutGroup
        {
            return this._1777226238customLayoutContent;
        }

        public function get editIcon():frontend.components.TextureImage
        {
            return this._1601702307editIcon;
        }

        public function set editIcon(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1601702307editIcon;
            if (loc1 !== arg1) 
            {
                this._1601702307editIcon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "editIcon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get functionBtn():feathers.controls.Button
        {
            return this._1946492060functionBtn;
        }

        public function set functionBtn(arg1:feathers.controls.Button):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1946492060functionBtn;
            if (loc1 !== arg1) 
            {
                this._1946492060functionBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "functionBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
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

        internal const ICON_GROUP_WIDTH:Number=50 * SIGMALink.scaleFactor;

        internal static const editGroupWidth:Number=75 * SIGMALink.scaleFactor;

        internal var _1777226238customLayoutContent:feathers.controls.LayoutGroup;

        internal var _1601702307editIcon:frontend.components.TextureImage;

        internal var _1946492060functionBtn:feathers.controls.Button;

        internal var _1412649594iconGroup:feathers.controls.LayoutGroup;

        internal var _1723849517leftLabel:feathers.controls.Label;

        internal var _166888697leftLablGroup:feathers.controls.LayoutGroup;

        internal var _138659259leftSubLabel:feathers.controls.Label;

        internal var _3469783leftSubLabel2:feathers.controls.Label;

        internal var _1409862205rightGroup:feathers.controls.LayoutGroup;

        internal var _1405764040rightLabel:feathers.controls.Label;

        internal var _1191572447selector:feathers.controls.LayoutGroup;

        internal var _942316136toggleBtn:frontend.components.menuList.editors.base.OnOffToggleButton;

        internal var _398964322checkable:Boolean=false;

        internal var _742313895checked:Boolean=false;

        internal var _134069779clickCallback:Function;

        public var configCacheAttribute:String;

        public var converter:utils.converter.IConverter;

        internal var _1761778276customBackgroundSkin:starling.display.Quad;

        internal var _dataProvider:feathers.data.ListCollection;

        public var defaultValue:Object;

        public var defaultValues:Array;

        public var destination:String;

        internal var _1714331919displayText:Boolean=true;

        internal var _editable:Boolean=false;

        public var formatter:utils.interfaces.ICustomFormatterBase;

        public var functionButtonCallback:Function;

        internal var _functionButtonLabel:String="";

        internal var _249692184functionButtonVisible:Boolean=true;

        internal var _1186943550hasTouchEvents:Boolean=true;

        public var helperObject:Object;

        internal var _iconTexture:String;

        internal var _398301669isSelected:Boolean=false;

        internal var _2146088563itemWidth:Number;

        public var leftLabelAlignTop:Boolean=false;

        internal var _leftSubLabelText:String="";

        internal var _leftSubLabelText2:String="";

        internal var _maxChars:uint=0;

        public var destinationObject:Object;

        internal var _229163114maxRightLabelWidth:Number;

        public var maximum:Number;

        internal var _1973788148minItemHeight:Number;

        public var minimum:Number;

        public var minimumDifference:Number=1;

        public var onChanged:Function;

        internal var _806339567padding:Number;

        internal var _139960310preClickCallback:Function;

        internal var _346085435saveCompleteCallback:Function;

        public var saveToDbUseUpdate:Boolean=false;

        public var saveToDbUseUpdateObject:frontend.components.menuList.MenuListDbObject;

        internal var _selectMode:Boolean=false;

        public var showDownStateSkin:Boolean=true;

        internal var _text:String="";

        internal var _110371416title:String="";

        internal var _3575610type:String;

        public var unitString:String="";

        public var useConfigCache:Boolean=false;

        internal var _useLocalesForText:Boolean=true;

        internal var _1077721343useLocalesForTitle:Boolean=true;

        internal var _value:Object;

        internal var _1238976138_displaySubText:Boolean=false;

        internal var _246445336_displaySubText2:Boolean=false;

        internal var _949723250_functionBtnText:String="";

        internal var _initialized:Boolean=false;

        internal var _783677445_leftLabelText:String="";

        internal var _moving:Boolean=false;

        internal var editor:*;

        internal var editorClass:*;

        internal var _1695807979formattedValue:String="";

        internal var _114623138hasChild:Boolean=false;

        internal var hasDataProvider:Boolean=false;

        internal var _696608307hasIcon:Boolean=false;

        internal var icon:feathers.controls.ImageLoader;

        internal var selectedIndex:uint;

        internal var _1912202124showValue:Boolean=true;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        public var _MenuListItem_Check1:feathers.controls.Check;

        mx_internal var _watchers:Array;

        public var _MenuListItem_TextureImage1:frontend.components.TextureImage;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//    class MenuListItemTypes
package frontend.components.menuList 
{
    public class MenuListItemTypes extends Object
    {
        public function MenuListItemTypes()
        {
            super();
            return;
        }

        public static const ITEM_TYPE_AREA:String="ITEM_TYPE_AREA";

        public static const ITEM_TYPE_BUTTON:String="ITEM_TYPE_BUTTON";

        public static const ITEM_TYPE_CHECKBOX_MULTI:String="ITEM_TYPE_CHECKBOX_MULTI";

        public static const ITEM_TYPE_CLICK_CALLBACK:String="ITEM_TYPE_CLICK_CALLBACK";

        public static const ITEM_TYPE_DATE:String="ITEM_TYPE_DATE";

        public static const ITEM_TYPE_DATEIME:String="ITEM_TYPE_DATEIME";

        public static const ITEM_TYPE_MULTI_SELECT_SPORT:String="ITEM_TYPE_MULTI_SELECT_SPORT";

        public static const ITEM_TYPE_MULTI_SELECT_STRING:String="ITEM_TYPE_MULTI_SELECT_STRING";

        public static const ITEM_TYPE_NUMBER:String="ITEM_TYPE_NUMBER";

        public static const ITEM_TYPE_RADIO:String="ITEM_TYPE_RADIO";

        public static const ITEM_TYPE_RATING:String="ITEM_TYPE_RATING";

        public static const ITEM_TYPE_SINGLE_SELECT_SPORT:String="ITEM_TYPE_SINGLE_SELECT_SPORT";

        public static const ITEM_TYPE_SPINNER:String="ITEM_TYPE_SPINNER";

        public static const ITEM_TYPE_SPORT_AND_NAME:String="ITEM_TYPE_SPORT_AND_NAME";

        public static const ITEM_TYPE_SUBMENU:String="ITEM_TYPE_SUBMENU";

        public static const ITEM_TYPE_TEXTFIELD:String="ITEM_TYPE_TEXTFIELD";

        public static const ITEM_TYPE_TIME:String="ITEM_TYPE_TIME";

        public static const ITEM_TYPE_TOGGLE:String="ITEM_TYPE_TOGGLE";

        public static const ITEM_TYPE_UNIT_SELECTOR:String="ITEM_TYPE_UNIT_SELECTOR";

        public static const ITEM_TYPE_ZONE:String="ITEM_TYPE_ZONE";
    }
}


//  package popup
//    package oauth
//      class CustomOAuth
package frontend.components.popup.oauth 
{
    import debug.*;
    import feathers.core.*;
    import feathers.events.*;
    import flash.events.*;
    import flash.media.*;
    import flash.utils.*;
    import frontend.components.popup.*;
    import service.oauth.*;
    import starling.events.*;
    
    public class CustomOAuth extends service.oauth.CommonOAuth
    {
        public function CustomOAuth(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            this.pleaseWaitAdded = false;
            this.waitForCall = false;
            if (this.webView) 
            {
                lastLocation = "";
                if (feathers.core.PopUpManager.isPopUp(this.oauthPopUP)) 
                {
                    frontend.components.popup.PopUpBase.removePopUps(this.oauthPopUP, false);
                }
                this.webView.removeEventListener(feathers.events.FeathersEventType.LOCATION_CHANGE, this.onWebViewLocationChange);
                this.webView.removeEventListener(starling.events.Event.COMPLETE, this.onWebViewComplete);
                this.webView = null;
            }
            this.oauthPopUP = null;
            return;
        }

        public override function logout():void
        {
            debug("logout");
            this.webView = new frontend.components.popup.oauth.CustomWebView();
            this.webView.addEventListener(starling.events.Event.COMPLETE, this.handleLogout);
            this.webView.addEventListener(feathers.events.FeathersEventType.LOCATION_CHANGE, this.handleLogout);
            this.webView.addEventListener(feathers.events.FeathersEventType.ERROR, this.handleLogoutError);
            this.webView.loadURL(LOGOUT_URL);
            return;
        }

        public override function showWebViewer(arg1:Boolean):void
        {
            debug("show web viewer");
            if (this.webView) 
            {
                if (!this.oauthPopUP) 
                {
                    this.oauthPopUP = new frontend.components.popup.OAuthPopUp();
                }
                this.oauthPopUP.title = popupTitle;
                this.oauthPopUP.oauth = this;
                this.webView.validate();
                this.getStageWebView().addEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE, this.onNativeStageSoftKeyboardActivate);
                this.getStageWebView().addEventListener(flash.events.SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE, this.onNativeStageSoftKeyboardDeactivate);
                if (!feathers.core.PopUpManager.isPopUp(this.oauthPopUP) && showWebViewOnCheckLogin) 
                {
                    this.waitForCall = true;
                    frontend.components.popup.PopUpBase.showModalPopUp(this.oauthPopUP, showWebViewOnCheckLogin, false);
                }
            }
            return;
        }

        protected override function doOAuthCall(arg1:flash.media.StageWebView):void
        {
            if (this.waitForCall) 
            {
                this.waitForCall = false;
                this.oauthPopUP.addPleaseWait();
                this.pleaseWaitAdded = true;
                this.webView.visible = false;
                this.oauthPopUP.setWebView(this.webView);
                this.reloadTimeout = flash.utils.setTimeout(this.doOAuthCall, 1000, arg1);
                return;
            }
            if (showWebViewOnCheckLogin && this.pleaseWaitAdded) 
            {
                this.webView.visible = true;
                super.doOAuthCall(arg1);
                this.oauthPopUP.removePleaseWait();
            }
            else if (!showWebViewOnCheckLogin) 
            {
                super.doOAuthCall(arg1);
            }
            return;
        }

        internal function onNativeStageSoftKeyboardActivate(arg1:flash.events.SoftKeyboardEvent):void
        {
            debug.Debug.debug("onNativeStageSoftKeyboardActivate");
            return;
        }

        internal function onNativeStageSoftKeyboardDeactivate(arg1:flash.events.SoftKeyboardEvent):void
        {
            debug.Debug.debug("onNativeStageSoftKeyboardDeactivate");
            return;
        }

        protected override function getStageWebView():flash.media.StageWebView
        {
            var loc1:*=this.webView.getStageWebView() as flash.media.StageWebView;
            return loc1;
        }

        protected override function initWebView():void
        {
            this.webView = new frontend.components.popup.oauth.CustomWebView();
            this.webView.addEventListener(feathers.events.FeathersEventType.LOCATION_CHANGE, this.onWebViewLocationChange);
            this.webView.addEventListener(flash.events.Event.COMPLETE, this.onWebViewComplete);
            return;
        }

        protected function onWebViewLocationChange(arg1:starling.events.Event):void
        {
            lastLocation = (arg1.target as frontend.components.popup.oauth.CustomWebView).location;
            debug("onWebViewLocationChange");
            return;
        }

        protected function onWebViewComplete(arg1:starling.events.Event):void
        {
            return;
        }

        internal function handleLogout(arg1:starling.events.Event):void
        {
            if (this.webView && (arg1.target as frontend.components.popup.oauth.CustomWebView).location == LOGOUT_COMPLETE_URL) 
            {
                debug("handleLogout > ok");
                this.webView.removeEventListener(starling.events.Event.COMPLETE, this.handleLogout);
                this.webView.removeEventListener(feathers.events.FeathersEventType.LOCATION_CHANGE, this.handleLogout);
                this.webView.removeEventListener(feathers.events.FeathersEventType.ERROR, this.handleLogoutError);
                this.webView.dispose();
                this.webView = null;
                doLogout();
            }
            else 
            {
                debug("handleLogout > failed");
            }
            return;
        }

        internal function handleLogoutError(arg1:starling.events.Event):void
        {
            debug("handleLogout > error: errorId = " + arg1.toString());
            if (this.webView) 
            {
                this.webView.removeEventListener(starling.events.Event.COMPLETE, this.handleLogout);
                this.webView.removeEventListener(feathers.events.FeathersEventType.LOCATION_CHANGE, this.handleLogout);
                this.webView.removeEventListener(feathers.events.FeathersEventType.ERROR, this.handleLogoutError);
                this.webView.dispose();
                this.webView = null;
            }
            doLogout();
            return;
        }

        protected var oauthPopUP:frontend.components.popup.OAuthPopUp;

        protected var pleaseWaitAdded:Boolean=false;

        protected var reloadTimeout:uint=0;

        protected var waitForCall:Boolean=false;

        protected var webView:frontend.components.popup.oauth.CustomWebView;
    }
}


//      class CustomWebView
package frontend.components.popup.oauth 
{
    import feathers.controls.*;
    import flash.geom.*;
    import flash.media.*;
    
    public class CustomWebView extends feathers.controls.WebView
    {
        public function CustomWebView()
        {
            super();
            createStageWebView();
            return;
        }

        public function getStageWebView():Object
        {
            return stageWebView;
        }

        public function setViewPort(arg1:feathers.controls.LayoutGroup):void
        {
            setSize(arg1.width, arg1.height);
            (this.getStageWebView() as flash.media.StageWebView).viewPort = new flash.geom.Rectangle(arg1.x, arg1.y, arg1.width, arg1.height);
            return;
        }
    }
}


//    class CustomFullscreenContentPopUp
package frontend.components.popup 
{
    import __AS3__.vec.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.ui.*;
    import frontend.*;
    import frontend.components.button.*;
    import frontend.screen.component.*;
    import handler.*;
    import helper.*;
    import starling.display.*;
    import starling.events.*;
    
    public class CustomFullscreenContentPopUp extends frontend.components.popup.PopUpBase
    {
        public function CustomFullscreenContentPopUp(arg1:feathers.controls.LayoutGroup, arg2:Boolean=true, arg3:Function=null, arg4:Function=null)
        {
            super();
            this.popupIgnoresBackButton = true;
            _backgroundSkinColor = core.general.Colors.RED;
            height = SIGMALink.appHeight;
            width = SIGMALink.appWidth;
            this._contentGroup = arg1;
            this._showOkButton = arg2;
            this.okCallback = arg3;
            this.cancelCallback = arg4;
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            return;
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            var loc2:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            loc2 = new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = HEADER_HEIGHT;
            loc2.layoutData = headerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Label();
            loc3.text = this.headline;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc2.addChild(loc3);
            var loc4:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.darkenColor(core.general.Colors.RED, 15));
            loc4.y = (HEADER_HEIGHT - 1);
            loc2.addChild(loc4);
            return loc1;
        }

        protected override function androidBackButtonHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (!helper.Capabilities_helper.isAndroid()) 
            {
                return;
            }
            if (arg1.keyCode == flash.ui.Keyboard.BACK) 
            {
                arg1.preventDefault();
                arg1.stopImmediatePropagation();
                if (this.cancelCallback != null) 
                {
                    this.cancelCallback(this);
                }
            }
            return;
        }

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=new Vector.<frontend.components.button.IconButton>();
            if (!helper.Capabilities_helper.isAndroid()) 
            {
                loc4 = new frontend.components.button.IconButton();
                loc4.touchHandler = this.cancelButton_handler;
                loc4.image = frontend.Textures.backbutton;
                loc1.push(loc4);
            }
            if (this._showOkButton) 
            {
                loc5 = new frontend.components.button.IconButton();
                loc5.touchHandler = this.okButton_handler;
                loc5.image = this.okButtonTexture;
                loc1.push(loc5);
            }
            var loc2:*=new frontend.screen.component.Footer();
            loc2.showBackButton = false;
            loc2.forceRightButton = true;
            loc2.setButtonGroup(loc1);
            var loc3:*=new feathers.controls.LayoutGroup();
            loc3.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc3.layout = new feathers.layout.AnchorLayout();
            loc3.addChild(loc2);
            return loc3;
        }

        protected override function addContent():void
        {
            super.addContent();
            if (!this._contentGroup) 
            {
                return;
            }
            this._contentGroup.maxWidth = SIGMALink.appWidth - (_layoutGap << 1);
            this._contentGroup.layoutData = new feathers.layout.AnchorLayoutData(0, 0, 0, 0, NaN, 0);
            contentHolder.height = height;
            contentHolder.addChild(this._contentGroup);
            return;
        }

        public override function validate():void
        {
            super.validate();
            return;
        }

        internal function okButton_handler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.okCallback != null) 
            {
                this.okCallback(this);
            }
            return;
        }

        internal function cancelButton_handler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.cancelCallback != null) 
            {
                this.cancelCallback(this);
            }
            return;
        }

        public function get headline():String
        {
            return this._1115058732headline;
        }

        public function set headline(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1115058732headline;
            if (loc1 !== arg1) 
            {
                this._1115058732headline = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "headline", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get okButtonTexture():String
        {
            return this._2082819827okButtonTexture;
        }

        public function set okButtonTexture(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2082819827okButtonTexture;
            if (loc1 !== arg1) 
            {
                this._2082819827okButtonTexture = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "okButtonTexture", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var cancelCallback:Function;

        internal var _1115058732headline:String="INFO";

        internal var _2082819827okButtonTexture:String="arrowRight";

        public var okCallback:Function;

        internal var _contentGroup:feathers.controls.LayoutGroup;

        internal var _showOkButton:Boolean=true;
    }
}


//    class DeletePopUp
package frontend.components.popup 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class DeletePopUp extends frontend.components.popup.PopUpBase
    {
        public function DeletePopUp()
        {
            this.closeBtnLabel = utils.LanguageManager.getString("CANCEL_BUTTON");
            this.deleteBtnLabel = utils.LanguageManager.getString("DELETE_BUTTON");
            this.description = new feathers.controls.Label();
            super();
            _backgroundSkinColor = core.general.Colors.RED;
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            height = SIGMALink.appHeight * 0.33;
            return;
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc4:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            loc2 = new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = HEADER_HEIGHT;
            loc2.layoutData = headerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Label();
            loc3.text = title;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc2.addChild(loc3);
            loc4 = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.darkenColor(core.general.Colors.RED, 15));
            loc4.y = (HEADER_HEIGHT - 1);
            loc2.addChild(loc4);
            return loc1;
        }

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc1.layout = new feathers.layout.AnchorLayout();
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = FOOTER_HEIGHT;
            loc2.width = SIGMALink.appWidth;
            loc2.layoutData = footerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Button();
            loc3.label = this.deleteBtnLabel;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, _layoutGap, NaN, 0);
            loc3.addEventListener(starling.events.Event.TRIGGERED, this.deleteButton_triggeredHandler);
            loc2.addChild(loc3);
            var loc4:*=new feathers.controls.Button();
            loc4.label = this.closeBtnLabel;
            loc4.layoutData = new feathers.layout.AnchorLayoutData(NaN, _layoutGap, NaN, NaN, NaN, 0);
            loc4.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
            loc2.addChild(loc4);
            return loc1;
        }

        protected override function addContent():void
        {
            super.addContent();
            this.description.maxWidth = SIGMALink.appWidth - (_layoutGap << 1);
            this.description.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, _layoutGap, NaN, 0);
            this.description.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this.description.wordWrap = true;
            contentHolder.addChild(this.description);
            return;
        }

        public override function validate():void
        {
            super.validate();
            this.validatePopUpContent();
            return;
        }

        protected function validatePopUpContent():void
        {
            this.description.text = this.text;
            return;
        }

        internal function deleteButton_triggeredHandler(arg1:starling.events.Event):void
        {
            if (this.deleteCallback != null) 
            {
                this.deleteCallback();
            }
            return;
        }

        protected override function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            super.closeButton_triggeredHandler(arg1);
            if (this.cancelCallback != null) 
            {
                this.cancelCallback();
            }
            return;
        }

        public var cancelCallback:Function;

        public var deleteCallback:Function;

        public var text:String;

        protected var closeBtnLabel:String;

        protected var deleteBtnLabel:String;

        protected var description:feathers.controls.Label;
    }
}


//    class FirmwarePopUp
package frontend.components.popup 
{
    import core.general.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.layout.*;
    import frontend.*;
    import starling.display.*;
    import starling.events.*;
    
    public class FirmwarePopUp extends frontend.components.popup.PopUpBase
    {
        public function FirmwarePopUp()
        {
            super();
            _backgroundSkinColor = core.general.Colors.RED;
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            height = 215 * SIGMALink.scaleFactor;
            return;
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            var loc2:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            loc2 = new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = 3;
            loc2.layoutData = headerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.darkenColor(core.general.Colors.RED, 15));
            loc3.y = 2;
            loc2.addChild(loc3);
            return loc1;
        }

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            var loc4:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc1.layout = new feathers.layout.AnchorLayout();
            var loc2:*=new feathers.layout.VerticalLayout();
            loc2.gap = BUTTON_PADDING;
            loc2.padding = BUTTON_PADDING;
            var loc3:*=SIGMALink.appWidth - 2 * BUTTON_PADDING;
            loc4 = new feathers.controls.LayoutGroup();
            loc4.layout = loc2;
            loc4.width = SIGMALink.appWidth;
            loc4.layoutData = footerLayoutData;
            loc1.addChild(loc4);
            var loc5:*=new feathers.controls.Button();
            loc5.width = loc3;
            loc5.label = frontend.Locales.getString("DEVICEVIEW.GENERAL_FIRMWARE_WHATS_NEW");
            loc5.addEventListener(starling.events.Event.TRIGGERED, this.whatsNewButton_triggeredHandler);
            loc4.addChild(loc5);
            var loc6:*=new feathers.controls.Button();
            loc6.width = loc3;
            loc6.label = frontend.Locales.getString("DEVICEVIEW.GENERAL_FIRMWARE_UPDATE");
            loc6.addEventListener(starling.events.Event.TRIGGERED, this.updateButton_triggeredHandler);
            loc4.addChild(loc6);
            var loc7:*=new feathers.controls.Button();
            loc7.width = loc3;
            loc7.label = frontend.Locales.getString("DEVICEVIEW.GENERAL_FIRMWARE_CANCEL");
            loc7.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
            loc4.addChild(loc7);
            return loc1;
        }

        protected function whatsNewButton_triggeredHandler(arg1:starling.events.Event):void
        {
            debug.Debug.debug("whats new?");
            return;
        }

        protected function updateButton_triggeredHandler(arg1:starling.events.Event):void
        {
            debug.Debug.debug("Update!");
            return;
        }

        protected override function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            super.closeButton_triggeredHandler(arg1);
            frontend.components.popup.PopUpBase.closePopUp();
            return;
        }

        internal static const BUTTON_PADDING:uint=10;

        public var cancelCallback:Function;
    }
}


//    class InfoPopUp
package frontend.components.popup 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class InfoPopUp extends frontend.components.popup.PopUpBase
    {
        public function InfoPopUp(arg1:Boolean=true, arg2:Boolean=true, arg3:Function=null, arg4:Function=null)
        {
            this._1642565809_cancelBtnLabel = utils.LanguageManager.getString("CANCEL_BUTTON");
            this._description = new feathers.controls.Label();
            this._1513957997_okBtnLabel = utils.LanguageManager.getString("OK_BUTTON");
            super();
            this.popupIgnoresBackButton = true;
            _backgroundSkinColor = core.general.Colors.RED;
            this._showOkButton = arg1;
            this._showCancelButton = arg2;
            this.okCallback = arg3;
            this.cancelCallback = arg4;
            return;
        }

        public function setOkButtonLabel(arg1:String, arg2:Boolean=true):void
        {
            if (arg2) 
            {
                this._okBtnLabel = utils.LanguageManager.getString(arg1);
            }
            else 
            {
                this._okBtnLabel = arg1;
            }
            return;
        }

        public function setCancelButtonLabel(arg1:String, arg2:Boolean=true):void
        {
            if (arg2) 
            {
                this._cancelBtnLabel = utils.LanguageManager.getString(arg1);
            }
            else 
            {
                this._cancelBtnLabel = arg1;
            }
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            height = SIGMALink.appHeight * 0.45;
            return;
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = HEADER_HEIGHT;
            loc2.layoutData = headerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Label();
            loc3.text = this.headline;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc2.addChild(loc3);
            var loc4:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.darkenColor(core.general.Colors.RED, 15));
            loc4.y = (HEADER_HEIGHT - 1);
            loc2.addChild(loc4);
            return loc1;
        }

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc1.layout = new feathers.layout.AnchorLayout();
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = FOOTER_HEIGHT;
            loc2.width = SIGMALink.appWidth;
            loc2.layoutData = footerLayoutData;
            loc1.addChild(loc2);
            if (this._showOkButton) 
            {
                loc3 = new feathers.controls.Button();
                loc3.label = this._okBtnLabel;
                loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, _layoutGap, NaN, 0);
                loc3.addEventListener(starling.events.Event.TRIGGERED, this.okButton_triggeredHandler);
                loc2.addChild(loc3);
            }
            if (this._showCancelButton) 
            {
                loc4 = new feathers.controls.Button();
                loc4.label = this._cancelBtnLabel;
                loc4.layoutData = new feathers.layout.AnchorLayoutData(NaN, _layoutGap, NaN, NaN, NaN, 0);
                loc4.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
                loc2.addChild(loc4);
            }
            return loc1;
        }

        protected override function addContent():void
        {
            super.addContent();
            this._description.maxWidth = SIGMALink.appWidth - (_layoutGap << 1);
            this._description.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, _layoutGap, NaN, 0);
            this._description.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._description.wordWrap = true;
            contentHolder.addChild(this._description);
            return;
        }

        public override function validate():void
        {
            super.validate();
            this.validatePopUpContent();
            return;
        }

        protected function validatePopUpContent():void
        {
            this._description.text = this.text;
            return;
        }

        internal function okButton_triggeredHandler(arg1:starling.events.Event):void
        {
            if (this.okCallback != null) 
            {
                this.okCallback(this);
            }
            return;
        }

        protected override function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            super.closeButton_triggeredHandler(arg1);
            if (this.cancelCallback != null) 
            {
                this.cancelCallback(this);
            }
            return;
        }

        public function get headline():String
        {
            return this._1115058732headline;
        }

        public function set headline(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1115058732headline;
            if (loc1 !== arg1) 
            {
                this._1115058732headline = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "headline", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _cancelBtnLabel():String
        {
            return this._1642565809_cancelBtnLabel;
        }

        internal function set _cancelBtnLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1642565809_cancelBtnLabel;
            if (loc1 !== arg1) 
            {
                this._1642565809_cancelBtnLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_cancelBtnLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _okBtnLabel():String
        {
            return this._1513957997_okBtnLabel;
        }

        internal function set _okBtnLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1513957997_okBtnLabel;
            if (loc1 !== arg1) 
            {
                this._1513957997_okBtnLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_okBtnLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public var cancelCallback:Function;

        public var data:Object;

        internal var _1115058732headline:String="INFO";

        public var okCallback:Function;

        public var text:String;

        internal var _1642565809_cancelBtnLabel:String;

        internal var _description:feathers.controls.Label;

        internal var _1513957997_okBtnLabel:String;

        internal var _showCancelButton:Boolean=true;

        internal var _showOkButton:Boolean=true;
    }
}


//    class OAuthPopUp
package frontend.components.popup 
{
    import feathers.controls.*;
    import feathers.layout.*;
    import frontend.components.popup.oauth.*;
    import starling.events.*;
    import utils.*;
    
    public class OAuthPopUp extends frontend.components.popup.PopUpBase
    {
        public function OAuthPopUp()
        {
            super();
            return;
        }

        protected override function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            super.closeButton_triggeredHandler(arg1);
            this.cancel(arg1);
            return;
        }

        internal function cancel(arg1:starling.events.Event):void
        {
            if (this.cancelFunc != null) 
            {
                this.cancelFunc();
            }
            this.oauth.destructor();
            return;
        }

        public function setWebView(arg1:feathers.controls.WebView, arg2:Boolean=true):void
        {
            if (contentHolder) 
            {
                contentHolder.addChild(arg1);
                if (arg1 is frontend.components.popup.oauth.CustomWebView) 
                {
                    (arg1 as frontend.components.popup.oauth.CustomWebView).setViewPort(contentHolder);
                }
            }
            return;
        }

        public function addPleaseWait():void
        {
            this._pleaseWaitLabel = new feathers.controls.Label();
            this._pleaseWaitLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            this._pleaseWaitLabel.text = utils.LanguageManager.getString("OAUTH_PLEASE_WAIT");
            contentHolder.addChild(this._pleaseWaitLabel);
            return;
        }

        public function removePleaseWait():void
        {
            if (contentHolder.contains(this._pleaseWaitLabel)) 
            {
                contentHolder.removeChild(this._pleaseWaitLabel);
                this._pleaseWaitLabel = null;
            }
            return;
        }

        public var oauth:frontend.components.popup.oauth.CustomOAuth;

        internal var _pleaseWaitLabel:feathers.controls.Label;

        internal var _reload:Boolean=true;

        internal var cancelFunc:Function;
    }
}


//    class PopUpBase
package frontend.components.popup 
{
    import core.general.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    import frontend.*;
    import frontend.components.button.*;
    import handler.*;
    import helper.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    import utils.*;
    
    public class PopUpBase extends feathers.controls.Panel
    {
        public function PopUpBase()
        {
            super();
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }

        protected function set _layoutGap(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1431588301_layoutGap;
            if (loc1 !== arg1) 
            {
                this._1431588301_layoutGap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_layoutGap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function closePopUp():void
        {
            var loc1:*=undefined;
            var loc2:*=0;
            var loc3:*=currentPopUps;
            for (loc1 in loc3) 
            {
                removePopUps(loc1, loc1 is frontend.components.popup.PopUpBase);
            }
            checkPopUpMode();
            return;
        }

        public static function showModalPopUp(arg1:starling.display.DisplayObject, arg2:Boolean=true, arg3:Boolean=true, arg4:Boolean=true, arg5:Boolean=false):void
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            handler.ViewHandler.getInstance().popUpMode = true;
            currentPopUps[arg1] = frontend.components.popup.PopUpBase;
            closeOnTouchOutside = arg5;
            var loc1:*=CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP;
            if (arg1 is frontend.components.popup.PopUpBase) 
            {
                loc1 = (arg1 as frontend.components.popup.PopUpBase).closeTweenDirection;
            }
            feathers.core.PopUpManager.addPopUp(arg1, arg2, !arg3, createCustomOverlayFactory);
            if (arg3) 
            {
                loc2 = 0;
                loc3 = 0;
                var loc4:*=loc1;
                switch (loc4) 
                {
                    case CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP:
                    {
                        arg1.y = SIGMALink.appHeight;
                        loc2 = SIGMALink.appHeight - arg1.height;
                        if (!arg4) 
                        {
                            loc2 = loc2 - SIGMALink.footerHeight;
                        }
                        starling.core.Starling.juggler.tween(arg1, TWEEN_DURATION, {"y":loc2});
                        break;
                    }
                    case CUSTOM_TWEEN_DIRECTION_RIGHT_TO_LEFT:
                    {
                        arg1.y = 0;
                        arg1.x = SIGMALink.appWidth;
                        starling.core.Starling.juggler.tween(arg1, TWEEN_DURATION, {"y":loc2, "x":loc3});
                        break;
                    }
                    case CUSTOM_TWEEN_DIRECTION_LEFT_TO_RIGHT:
                    {
                        arg1.y = 0;
                        arg1.x = SIGMALink.appWidth * -1;
                        starling.core.Starling.juggler.tween(arg1, TWEEN_DURATION, {"y":loc2, "x":loc3});
                        break;
                    }
                }
            }
            return;
        }

        internal static function removePopUp(arg1:starling.display.DisplayObject, arg2:Function=null):void
        {
            var p_popup:starling.display.DisplayObject;
            var p_callback:Function=null;

            var loc1:*;
            p_popup = arg1;
            p_callback = arg2;
            try 
            {
                feathers.core.PopUpManager.removePopUp(p_popup);
            }
            catch (e:Error)
            {
                debug.Debug.error("Versuch PopUp zu schließen fehlgeschlagen. PopUp existiert nicht mehr.");
            }
            finally
            {
                if (p_callback != null) 
                {
                    p_callback();
                }
            }
            return;
        }

        public function get popupIgnoresBackButton():Boolean
        {
            return this._popupIgnoresBackButton;
        }

        public function set popupIgnoresBackButton(arg1:Boolean):void
        {
            this._popupIgnoresBackButton = arg1;
            if (stage != null) 
            {
                if (this._popupIgnoresBackButton) 
                {
                    stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
                }
                else 
                {
                    stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
                }
            }
            return;
        }

        protected function customDraw():void
        {
            if (this._validate) 
            {
                if (header && !(header.height == HEADER_HEIGHT)) 
                {
                    header.height = HEADER_HEIGHT;
                    header.validate();
                }
                if (footer && !(footer.height == FOOTER_HEIGHT)) 
                {
                    footer.height = FOOTER_HEIGHT;
                    footer.validate();
                }
                backgroundSkin = new starling.display.Quad(1, 1, this._backgroundSkinColor);
                outerPadding = 0;
                padding = 0;
                this._validate = false;
            }
            return;
        }

        public static function removePopUps(arg1:starling.display.DisplayObject, arg2:Boolean=true, arg3:Function=null):void
        {
            var p_popup:starling.display.DisplayObject;
            var p_tween:Boolean=true;
            var p_callback:Function=null;
            var yTo:Number;
            var xTo:Number;
            var tweenDirection:String;

            var loc1:*;
            yTo = NaN;
            xTo = NaN;
            tweenDirection = null;
            p_popup = arg1;
            p_tween = arg2;
            p_callback = arg3;
            if (feathers.core.PopUpManager.isPopUp(p_popup)) 
            {
                if (p_tween) 
                {
                    yTo = 0;
                    xTo = 0;
                    tweenDirection = CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP;
                    if (p_popup is frontend.components.popup.PopUpBase) 
                    {
                        tweenDirection = (p_popup as frontend.components.popup.PopUpBase).closeTweenDirection;
                    }
                    var loc2:*=tweenDirection;
                    switch (loc2) 
                    {
                        case CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP:
                        {
                            yTo = SIGMALink.appHeight;
                            xTo = p_popup.x;
                            break;
                        }
                        case CUSTOM_TWEEN_DIRECTION_RIGHT_TO_LEFT:
                        {
                            xTo = SIGMALink.appWidth * -1;
                            break;
                        }
                        case CUSTOM_TWEEN_DIRECTION_LEFT_TO_RIGHT:
                        {
                            xTo = SIGMALink.appWidth;
                            break;
                        }
                    }
                    starling.core.Starling.juggler.tween(p_popup, TWEEN_DURATION, {"y":yTo, "x":xTo, "onComplete":function ():void
                    {
                        removePopUp(p_popup, p_callback);
                        return;
                    }})
                }
                else 
                {
                    removePopUp(p_popup, p_callback);
                }
            }
            if (currentPopUps[p_popup] != null) 
            {
                delete currentPopUps[p_popup];
            }
            checkPopUpMode();
            return;
        }

        internal static function checkPopUpMode():void
        {
            var loc2:*=undefined;
            var loc1:*=0;
            var loc3:*=0;
            var loc4:*=currentPopUps;
            for (loc2 in loc4) 
            {
                ++loc1;
            }
            handler.ViewHandler.getInstance().popUpMode = loc1 > 0;
            return;
        }

        internal static function onTouchOutside(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (closeOnTouchOutside) 
            {
                closePopUp();
            }
            closeOnTouchOutside = false;
            return;
        }

        internal static function createCustomOverlayFactory():starling.display.DisplayObject
        {
            var quad:starling.display.Quad;

            var loc1:*;
            quad = null;
            quad = new starling.display.Quad(1, 1, starling.utils.Color.BLACK);
            quad.alpha = 0;
            quad.addEventListener(starling.events.Event.ADDED_TO_STAGE, function ():void
            {
                starling.core.Starling.juggler.tween(quad, TWEEN_DURATION, {"alpha":MODAL_ALPHA});
                quad.addEventListener(starling.events.TouchEvent.TOUCH, onTouchOutside);
                return;
            })
            quad.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, function ():void
            {
                quad.alpha = 0;
                quad.removeEventListener(starling.events.TouchEvent.TOUCH, onTouchOutside);
                return;
            })
            return quad;
        }

        public static function get FOOTER_HEIGHT():int
        {
            return frontend.components.popup.PopUpBase._253748299FOOTER_HEIGHT;
        }

        public static function get HEADER_HEIGHT():int
        {
            return frontend.components.popup.PopUpBase._907846425HEADER_HEIGHT;
        }

        public static function set HEADER_HEIGHT(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.popup.PopUpBase._907846425HEADER_HEIGHT;
            if (loc1 !== arg1) 
            {
                frontend.components.popup.PopUpBase._907846425HEADER_HEIGHT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "HEADER_HEIGHT", loc1, arg1, frontend.components.popup.PopUpBase);
                loc3 = frontend.components.popup.PopUpBase.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get OUTER_PADDING():int
        {
            return frontend.components.popup.PopUpBase._529003507OUTER_PADDING;
        }

        public static function set OUTER_PADDING(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.popup.PopUpBase._529003507OUTER_PADDING;
            if (loc1 !== arg1) 
            {
                frontend.components.popup.PopUpBase._529003507OUTER_PADDING = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "OUTER_PADDING", loc1, arg1, frontend.components.popup.PopUpBase);
                loc3 = frontend.components.popup.PopUpBase.staticEventDispatcher;
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
            closeOnTouchOutside = false;
            currentPopUps = new flash.utils.Dictionary();
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public function close():void
        {
            closePopUp();
            return;
        }

        public function show(arg1:Boolean=true, arg2:Boolean=true, arg3:Boolean=true, arg4:Boolean=false):void
        {
            frontend.components.popup.PopUpBase.showModalPopUp(this, arg1, arg2, arg3, arg4);
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            debug.Debug.debug("[POPUP] onAddedToStage");
            removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            if (helper.Capabilities_helper.isAndroid() && this.popupIgnoresBackButton) 
            {
                stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
            }
            handler.ViewHandler.getInstance().handleAndroidBackButton = !this.popupIgnoresBackButton;
            this.initLayout();
            this.addContent();
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            debug.Debug.debug("[POPUP] onRemovedFromStage");
            removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (helper.Capabilities_helper.isAndroid()) 
            {
                stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
            }
            handler.ViewHandler.getInstance().handleAndroidBackButton = true;
            if (this.closeCallback != null) 
            {
                this.closeCallback(this);
            }
            return;
        }

        protected function androidBackButtonHandler(arg1:starling.events.KeyboardEvent):void
        {
            debug.Debug.debug("[POPUP] androidBackButtonHandler");
            if (arg1.keyCode == flash.ui.Keyboard.BACK) 
            {
                arg1.preventDefault();
                arg1.stopImmediatePropagation();
            }
            return;
        }

        protected function createPopUpHeader():feathers.core.IFeathersControl
        {
            debug.Debug.debug("[POPUP] createPopUpHeader");
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, 16777215);
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = HEADER_HEIGHT;
            loc2.layoutData = this.headerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Label();
            loc3.text = title;
            loc3.layoutData = this.titleLayoutData;
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_POPUP_TITLE;
            loc2.addChild(loc3);
            var loc4:*=new frontend.components.button.IconButton();
            loc4.image = frontend.Textures.closeiconred;
            loc4.layoutData = this.closeIconLayoutData;
            loc4.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
            loc2.addChild(loc4);
            return loc1;
        }

        protected function createPopUpFooter():feathers.core.IFeathersControl
        {
            debug.Debug.debug("createPopUpFooter");
            var loc1:*=new feathers.controls.LayoutGroup();
            if (!this.showCloseButton) 
            {
                return loc1;
            }
            loc1.layout = new feathers.layout.AnchorLayout();
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = FOOTER_HEIGHT;
            loc2.layoutData = this.footerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Button();
            loc3.label = utils.LanguageManager.getString("CLOSE_BUTTON");
            loc3.layoutData = this.closeButtonLayoutData;
            loc3.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
            loc2.addChild(loc3);
            return loc1;
        }

        protected function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            return;
        }

        protected function initLayout():void
        {
            FOOTER_HEIGHT = this.showCloseButton ? 90 * SIGMALink.scaleFactor : 0;
            HEADER_HEIGHT = 100 * SIGMALink.scaleFactor;
            this._layoutGap = 20 * SIGMALink.scaleFactor;
            OUTER_PADDING = 8 * SIGMALink.scaleFactor;
            this._doublePadding = OUTER_PADDING << 1;
            this.validatePopUpSize();
            this.headerLayoutData = new feathers.layout.AnchorLayoutData(0, 0, 0, 0);
            this.titleLayoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, this._layoutGap, NaN, 0);
            this.closeIconLayoutData = new feathers.layout.AnchorLayoutData(NaN, this._layoutGap, NaN, NaN, NaN, 0);
            this.footerLayoutData = new feathers.layout.AnchorLayoutData(0, NaN, 0, NaN, 0, 0);
            this.closeButtonLayoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, this._layoutGap);
            footerFactory = this.createPopUpFooter;
            headerFactory = this.createPopUpHeader;
            layout = new feathers.layout.AnchorLayout();
            this.contentLayoutData = new feathers.layout.AnchorLayoutData(0, 0, 0, 0);
            return;
        }

        protected function validatePopUpSize():void
        {
            width = SIGMALink.appWidth - this._doublePadding;
            height = SIGMALink.appHeight - this._doublePadding;
            return;
        }

        protected function addContent():void
        {
            this.contentHolder = new feathers.controls.LayoutGroup();
            this.contentHolder.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.contentHolder.layout = new feathers.layout.AnchorLayout();
            this.contentHolder.layoutData = this.contentLayoutData;
            this.contentHolder.width = width;
            this.contentHolder.height = height - HEADER_HEIGHT - FOOTER_HEIGHT;
            this.myViewPort = new flash.geom.Rectangle(0, 0, this.contentHolder.width, this.contentHolder.height);
            addChild(this.contentHolder);
            return;
        }

        protected override function draw():void
        {
            this.customDraw();
            super.draw();
            return;
        }

        public static function set FOOTER_HEIGHT(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.popup.PopUpBase._253748299FOOTER_HEIGHT;
            if (loc1 !== arg1) 
            {
                frontend.components.popup.PopUpBase._253748299FOOTER_HEIGHT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "FOOTER_HEIGHT", loc1, arg1, frontend.components.popup.PopUpBase);
                loc3 = frontend.components.popup.PopUpBase.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get _doublePadding():int
        {
            return this._1627099903_doublePadding;
        }

        protected function set _doublePadding(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1627099903_doublePadding;
            if (loc1 !== arg1) 
            {
                this._1627099903_doublePadding = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_doublePadding", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get _layoutGap():int
        {
            return this._1431588301_layoutGap;
        }

        internal static const MODAL_ALPHA:Number=0.8;

        internal static const TWEEN_DURATION:Number=0.3;

        public static const CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP:String="tweenBottomToTop";

        public static const CUSTOM_TWEEN_DIRECTION_LEFT_TO_RIGHT:String="tweenLeftToRight";

        public static const CUSTOM_TWEEN_DIRECTION_RIGHT_TO_LEFT:String="tweenRightToLeft";

        public var closeCallback:Function;

        public var closeTweenDirection:String="tweenBottomToTop";

        public var contentHolder:feathers.controls.LayoutGroup;

        internal var _popupIgnoresBackButton:Boolean=true;

        protected var _backgroundSkinColor:uint=15658734;

        protected var _1627099903_doublePadding:int;

        protected var _1431588301_layoutGap:int;

        protected var _validate:Boolean=true;

        protected var closeButtonLayoutData:feathers.layout.AnchorLayoutData;

        protected var closeIconLayoutData:feathers.layout.AnchorLayoutData;

        protected var contentLayoutData:feathers.layout.AnchorLayoutData;

        protected var footerLayoutData:feathers.layout.AnchorLayoutData;

        protected var headerLayoutData:feathers.layout.AnchorLayoutData;

        protected var myViewPort:flash.geom.Rectangle;

        protected var titleLayoutData:feathers.layout.AnchorLayoutData;

        internal static var _907846425HEADER_HEIGHT:int;

        internal static var _529003507OUTER_PADDING:int;

        public static var closeOnTouchOutside:Boolean=false;

        public var showCloseButton:Boolean=false;

        internal static var currentPopUps:flash.utils.Dictionary;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        internal static var _253748299FOOTER_HEIGHT:int;
    }
}


//    class ProgressPopUp
package frontend.components.popup 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.utils.*;
    import frontend.components.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ProgressPopUp extends frontend.components.popup.PopUpBase
    {
        public function ProgressPopUp()
        {
            this.description = new feathers.controls.Label();
            this.headline = new feathers.controls.Label();
            this._2932247_gap = 20 * SIGMALink.scaleFactor;
            this._image = new frontend.components.TextureImage();
            this._percentageLabel = new feathers.controls.Label();
            this._progressBarHeight = 66 * SIGMALink.scaleFactor;
            this._progressBorderWidth = 9 * SIGMALink.scaleFactor;
            super();
            this.popupIgnoresBackButton = true;
            _backgroundSkinColor = core.general.Colors.RED;
            this._progressBar = new feathers.controls.ProgressBar();
            this._progressBar.styleProvider = null;
            this._progressBar.backgroundSkin = new starling.display.Quad(1, this._progressBarHeight - 4 * this._progressBorderWidth, core.general.Colors.RED);
            this._progressBar.fillSkin = new starling.display.Quad(1, this._progressBarHeight - 4 * this._progressBorderWidth, core.general.Colors.WHITE);
            return;
        }

        public function get imageTexture():String
        {
            return this._imageTexture;
        }

        internal function set _819554496imageTexture(arg1:String):void
        {
            this._imageTexture = arg1;
            if (this._image != null) 
            {
                this._image.includeInLayout = !(this._imageTexture == null);
            }
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            height = SIGMALink.appHeight * 0.33;
            return;
        }

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            return new feathers.controls.LayoutGroup();
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            return new feathers.controls.LayoutGroup();
        }

        protected override function addContent():void
        {
            super.addContent();
            contentHolder.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = this._gap;
            var loc2:*=new feathers.layout.HorizontalLayout();
            loc2.gap = this._gap;
            loc2.padding = this._gap;
            var loc3:*=new feathers.controls.LayoutGroup();
            loc3.layout = loc2;
            loc3.width = width;
            var loc4:*=new feathers.controls.LayoutGroup();
            loc4.layout = loc1;
            if (this._imageTexture == null) 
            {
                this._image.includeInLayout = false;
            }
            else 
            {
                this._image.textureName = this._imageTexture;
                this._image.includeInLayout = true;
            }
            contentHolder.addChild(loc3);
            loc3.addChild(this._image);
            loc3.addChild(loc4);
            this._image.validate();
            loc4.width = width - this._image.width - this._gap * 3;
            this.headline = new feathers.controls.Label();
            this.headline.text = title;
            this.description.maxWidth = loc4.width;
            this.headline.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_RED_POPUP_TITLE;
            loc4.addChild(this.headline);
            this.description.maxWidth = loc4.width;
            this.description.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            this.description.wordWrap = true;
            loc4.addChild(this.description);
            var loc5:*=new feathers.controls.LayoutGroup();
            loc5.width = loc4.width;
            loc5.height = this._progressBarHeight;
            loc5.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc5.layout = new feathers.layout.AnchorLayout();
            var loc6:*=new feathers.controls.LayoutGroup();
            loc6.width = loc5.width - 2 * this._progressBorderWidth;
            loc6.height = loc5.height - 2 * this._progressBorderWidth;
            loc6.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            loc6.layout = new feathers.layout.AnchorLayout();
            loc6.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc5.addChild(loc6);
            this._progressBar.minimum = 0;
            this._progressBar.maximum = 100;
            this._progressBar.value = 0;
            this._progressBar.width = loc6.width - 2 * this._progressBorderWidth;
            this._progressBar.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc6.addChild(this._progressBar);
            loc4.addChild(loc5);
            this._percentageLabel.text = "";
            this._percentageLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc4.addChild(this._percentageLabel);
            return;
        }

        public function setProgressPercentage(arg1:uint):void
        {
            var loc1:*=NaN;
            if (this._progressBar == null) 
            {
                return;
            }
            if (arg1 > 100) 
            {
                arg1 = 100;
            }
            if (arg1 != 100) 
            {
                loc1 = arg1;
            }
            else 
            {
                loc1 = this._progressBar.value + arg1 / this._prgressAnimateToCompleteDuration;
            }
            if (loc1 > 100) 
            {
                loc1 = 100;
            }
            this._progressBar.value = loc1;
            this._progressBar.fillSkin.width = this._progressBar.width * this._progressBar.value / 100;
            this._percentageLabel.text = this._progressBar.value + "%";
            if (arg1 == 100) 
            {
                if (this._progressBar.value < 100) 
                {
                    flash.utils.setTimeout(this.setProgressPercentage, this._prgressAnimateToCompleteDuration, arg1);
                }
                else 
                {
                    flash.utils.setTimeout(this.onProgressComplete, this._prgressAnimateToCompleteDuration);
                }
            }
            return;
        }

        internal function onProgressComplete():void
        {
            dispatchEventWith(PROGRESS_COMPLETE);
            return;
        }

        public override function validate():void
        {
            super.validate();
            this.validatePopUpContent();
            return;
        }

        public function validatePopUpContent():void
        {
            this.headline.text = title;
            this.description.text = this.text;
            return;
        }

        public function set imageTexture(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.imageTexture;
            if (loc1 !== arg1) 
            {
                this._819554496imageTexture = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "imageTexture", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _gap():Number
        {
            return this._2932247_gap;
        }

        internal function set _gap(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2932247_gap;
            if (loc1 !== arg1) 
            {
                this._2932247_gap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_gap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static const PROGRESS_COMPLETE:String="progressCompleteEvent";

        internal var _imageTexture:String;

        public var text:String;

        protected var description:feathers.controls.Label;

        protected var headline:feathers.controls.Label;

        internal var _2932247_gap:Number;

        internal var _image:frontend.components.TextureImage;

        internal var _percentageLabel:feathers.controls.Label;

        internal var _prgressAnimateToCompleteDuration:uint=10;

        internal var _progressBar:feathers.controls.ProgressBar;

        internal var _progressBarHeight:Number;

        internal var _progressBorderWidth:Number;
    }
}


//    class SortPopUp
package frontend.components.popup 
{
    import __AS3__.vec.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.list.*;
    import starling.display.*;
    import utils.*;
    
    public class SortPopUp extends frontend.components.popup.PopUpBase
    {
        public function SortPopUp(arg1:__AS3__.vec.Vector.<frontend.components.list.ListSortItem>, arg2:String, arg3:Boolean=false)
        {
            this.sortItems = arg1;
            this.currentSortField = arg2;
            this.currentSortAscending = arg3;
            super();
            title = utils.LanguageManager.getString("SORT_POPUP.TITLE");
            _backgroundSkinColor = core.general.Colors.WHITE;
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 0;
            HEADER_HEIGHT = 65 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth * 0.6;
            height = SIGMALink.appHeight * 0.33;
            minWidth = 240;
            minHeight = 240;
            x = (SIGMALink.appWidth - width) / 2;
            return;
        }

        protected override function initLayout():void
        {
            super.initLayout();
            footerFactory = null;
            return;
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            var loc1:*=null;
            loc1 = new feathers.controls.LayoutGroup();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.height = HEADER_HEIGHT;
            loc1.layoutData = headerLayoutData;
            var loc2:*=new feathers.controls.Label();
            loc2.text = title;
            loc2.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc2.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc1.addChild(loc2);
            return loc1;
        }

        protected override function addContent():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc4:*=null;
            super.addContent();
            loc1 = new feathers.layout.VerticalLayout();
            loc1.gap = 1;
            contentHolder.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            contentHolder.layout = loc1;
            var loc3:*=this.sortItems.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = this.sortItems[loc2];
                loc4.ascending = loc4.sortField != this.currentSortField ? false : this.currentSortAscending;
                loc4.selected = loc4.sortField == this.currentSortField;
                loc4.sortFunction = this.applySort;
                contentHolder.addChild(loc4);
                ++loc2;
            }
            this.validatePopUpHeight();
            return;
        }

        protected function validatePopUpHeight():void
        {
            if (contentHolder.numChildren == 0) 
            {
                return;
            }
            var loc1:*=contentHolder.layout as feathers.layout.VerticalLayout;
            var loc2:*=contentHolder.getChildAt(0) as frontend.components.list.ListSortItem;
            height = HEADER_HEIGHT + contentHolder.numChildren * loc2.height + loc1.gap * (contentHolder.numChildren - 1);
            return;
        }

        internal function applySort(arg1:frontend.components.list.ListSortItem):void
        {
            var loc1:*=0;
            var loc2:*=this.sortItems.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (this.sortItems[loc1] != arg1) 
                {
                    this.sortItems[loc1].selected = false;
                }
                ++loc1;
            }
            if (this.sortCallback != null) 
            {
                this.sortCallback(arg1);
            }
            return;
        }

        public var sortCallback:Function;

        protected var sortItems:__AS3__.vec.Vector.<frontend.components.list.ListSortItem>;

        internal var currentSortAscending:Boolean=false;

        internal var currentSortField:String;
    }
}


//  package screenNavigator
//    class CustomScreenNavigatorItem
package frontend.components.screenNavigator 
{
    import feathers.controls.*;
    
    public class CustomScreenNavigatorItem extends feathers.controls.ScreenNavigatorItem
    {
        public function CustomScreenNavigatorItem(arg1:Object=null, arg2:Object=null, arg3:Object=null)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function set properties(arg1:Object):void
        {
            var value:Object;

            var loc1:*;
            value = arg1;
            try 
            {
                super.properties = value;
            }
            catch (e:Error)
            {
                throw new Error(e.message);
            }
            return;
        }

        protected var pushEventsObj:Object;

        protected var transition:Function;
    }
}


//  package scrollContainer
//    class CustomHScrollContainer
package frontend.components.scrollContainer 
{
    import core.general.*;
    import feathers.controls.*;
    import frontend.components.list.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class CustomHScrollContainer extends feathers.controls.ScrollContainer
    {
        public function CustomHScrollContainer()
        {
            super();
            clipContent = frontend.components.list.ListSetting.CLIP_CONTENT;
            autoHideBackground = frontend.components.list.ListSetting.AUTO_HIDE_BACKGROUND;
            useFixedThrowDuration = frontend.components.list.ListSetting.USE_FIXED_THROW_DURATION;
            verticalScrollPolicy = feathers.controls.ScrollContainer.SCROLL_POLICY_OFF;
            if (!autoHideBackground) 
            {
                backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }
            return;
        }

        protected override function throwVertically(arg1:Number):void
        {
            arg1 = arg1 + arg1 * SCROLL_ACCELERATION_FACTOR;
            super.throwVertically(arg1);
            return;
        }

        protected override function feathersControl_addedToStageHandler(arg1:starling.events.Event):void
        {
            super.feathersControl_addedToStageHandler(arg1);
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.POPUP_MODE_CHANGED, this.onPopUpModeChanged);
            return;
        }

        protected override function feathersControl_removedFromStageHandler(arg1:starling.events.Event):void
        {
            super.feathersControl_removedFromStageHandler(arg1);
            handler.ViewHandler.getInstance().removeEventListener(handler.ViewHandler.POPUP_MODE_CHANGED, this.onPopUpModeChanged);
            return;
        }

        internal function onPopUpModeChanged(arg1:starling.events.Event):void
        {
            if (handler.ViewHandler.getInstance().popUpMode) 
            {
                if (horizontalScrollPolicy == feathers.controls.Scroller.SCROLL_POLICY_OFF) 
                {
                    this._scrollPolicyOffOnPopUpClose = true;
                }
                horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_OFF;
            }
            else 
            {
                if (this._scrollPolicyOffOnPopUpClose) 
                {
                    horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_OFF;
                }
                else 
                {
                    horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_ON;
                }
                this._scrollPolicyOffOnPopUpClose = false;
            }
            return;
        }

        internal static const SCROLL_ACCELERATION_FACTOR:Number=0.8;

        internal var _scrollPolicyOffOnPopUpClose:Boolean=false;
    }
}


//    class CustomVScrollContainer
package frontend.components.scrollContainer 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import frontend.components.list.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class CustomVScrollContainer extends feathers.controls.ScrollContainer
    {
        public function CustomVScrollContainer()
        {
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 1;
            layout = loc1;
            clipContent = frontend.components.list.ListSetting.CLIP_CONTENT;
            autoHideBackground = frontend.components.list.ListSetting.AUTO_HIDE_BACKGROUND;
            useFixedThrowDuration = frontend.components.list.ListSetting.USE_FIXED_THROW_DURATION;
            horizontalScrollPolicy = feathers.controls.ScrollContainer.SCROLL_POLICY_OFF;
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }

        protected override function throwVertically(arg1:Number):void
        {
            arg1 = arg1 + arg1 * SCROLL_ACCELERATION_FACTOR;
            super.throwVertically(arg1);
            return;
        }

        protected override function feathersControl_addedToStageHandler(arg1:starling.events.Event):void
        {
            super.feathersControl_addedToStageHandler(arg1);
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.POPUP_MODE_CHANGED, this.onPopUpModeChanged);
            return;
        }

        protected override function feathersControl_removedFromStageHandler(arg1:starling.events.Event):void
        {
            super.feathersControl_removedFromStageHandler(arg1);
            handler.ViewHandler.getInstance().removeEventListener(handler.ViewHandler.POPUP_MODE_CHANGED, this.onPopUpModeChanged);
            return;
        }

        internal function onAddedToStage(arg1:starling.events.Event):void
        {
            this.validateScrollPolicy();
            return;
        }

        internal function onPopUpModeChanged(arg1:starling.events.Event):void
        {
            this.validateScrollPolicy();
            return;
        }

        internal function validateScrollPolicy():void
        {
            if (this.ignoreVScrollPolicySetting) 
            {
                return;
            }
            verticalScrollPolicy = handler.ViewHandler.getInstance().popUpMode ? feathers.controls.Scroller.SCROLL_POLICY_OFF : feathers.controls.Scroller.SCROLL_POLICY_ON;
            return;
        }

        internal static const SCROLL_ACCELERATION_FACTOR:Number=0.8;

        public var ignoreVScrollPolicySetting:Boolean=false;
    }
}


//  package tab
//    class TabContainer
package frontend.components.tab 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import flash.utils.*;
    import frontend.components.scrollContainer.*;
    import frontend.components.tabbarbase.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class TabContainer extends feathers.controls.LayoutGroup
    {
        public function TabContainer()
        {
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            layout = new feathers.layout.AnchorLayout();
            return;
        }

        internal function onInit():void
        {
            var loc1:*=NaN;
            loc1 = TAB_HEIGHT;
            this.customScroller = new frontend.components.scrollContainer.CustomHScrollContainer();
            this.customScroller.clipContent = true;
            this.customScroller.layout = new feathers.layout.HorizontalLayout();
            this.customScroller.layoutData = new feathers.layout.AnchorLayoutData(loc1);
            this.customScroller.snapToPages = true;
            this.customScroller.hasElasticEdges = false;
            this.customScroller.autoHideBackground = true;
            this.customScroller.scrollBarDisplayMode = feathers.controls.List.SCROLL_BAR_DISPLAY_MODE_NONE;
            this.customScroller.horizontalScrollPolicy = feathers.controls.List.SCROLL_POLICY_ON;
            this.customScroller.verticalScrollPolicy = feathers.controls.List.SCROLL_POLICY_OFF;
            this.customScroller.addEventListener(feathers.events.FeathersEventType.SCROLL_COMPLETE, this.list_scrollHandler);
            this.customScroller.width = width;
            this.customScroller.height = height - TAB_HEIGHT;
            this.customScroller.pageWidth = width;
            addChild(this.customScroller);
            this.tabbar = new feathers.controls.TabBar();
            this.tabbar.dataProvider = new feathers.data.ListCollection();
            this.tabbar.height = TAB_HEIGHT;
            this.tabbar.width = width;
            this.tabbar.layoutData = new feathers.layout.AnchorLayoutData(0, 0, NaN, 0);
            this.tabbar.styleProvider = null;
            this.tabbar.tabFactory = this.useIconTabs ? frontend.components.tabbarbase.TabBarBase.getIconTabFactory : frontend.components.tabbarbase.TabBarBase.getLabelTabFactory;
            this.tabbar.addEventListener(starling.events.Event.CHANGE, this.onTabSelectionChange);
            addChild(this.tabbar);
            return;
        }

        public function addTab(arg1:frontend.components.tabbarbase.ITabLayoutContainer, arg2:Boolean=false):void
        {
            if (!this.tabbar) 
            {
                this.onInit();
            }
            var loc1:*=new frontend.components.tabbarbase.TabBarDataProviderObject(arg1);
            if (this.useIconTabs) 
            {
                loc1.defaultTexture = arg1.icon;
            }
            this.tabbar.dataProvider.push(loc1);
            if (arg2) 
            {
                this.tabbar.selectedIndex = (this.tabbar.dataProvider.length - 1);
            }
            if (loc1.instance) 
            {
                loc1.instance.width = width;
                loc1.instance.height = height - TAB_HEIGHT;
                this.customScroller.addChild(loc1.instance as starling.display.DisplayObject);
            }
            return;
        }

        public function removeTabs():void
        {
            var loc1:*=0;
            var loc3:*=null;
            if (!this.customScroller) 
            {
                return;
            }
            var loc2:*=this.tabbar.dataProvider.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = (this.tabbar.dataProvider.getItemAt(loc1) as frontend.components.tabbarbase.TabBarDataProviderObject).instance as starling.display.DisplayObject;
                loc3.dispose();
                ++loc1;
            }
            this.tabbar.dataProvider = new feathers.data.ListCollection();
            this.customScroller.removeChildren();
            this.tabbar.selectedIndex = -1;
            return;
        }

        protected function list_scrollHandler(arg1:starling.events.Event):void
        {
            this.tabbar.selectedIndex = this.customScroller.horizontalPageIndex;
            return;
        }

        protected function onTabSelectionChange(arg1:starling.events.Event):void
        {
            if (this._checkTabLater != 0) 
            {
                flash.utils.clearTimeout(this._checkTabLater);
                this._checkTabLater = 0;
            }
            this.customScroller.scrollToPageIndex(this.tabbar.selectedIndex, 0, handler.ViewHandler.ANIMATION_DURATION);
            this._checkTabLater = flash.utils.setTimeout(this.commitCurrentPageIndex, handler.ViewHandler.ANIMATION_DURATION * 1000);
            return;
        }

        internal function commitCurrentPageIndex():void
        {
            var loc1:*=this.selectedItem();
            if (!loc1) 
            {
                return;
            }
            if (this.tabbarSubHeaderLabel) 
            {
                this.tabbarSubHeaderLabel.text = loc1.label;
            }
            var loc2:*=new frontend.components.tab.TabEvent(frontend.components.tab.TabEvent.CHANGED, loc1.instance, loc1);
            dispatchEvent(loc2);
            return;
        }

        public function selectedItem():frontend.components.tabbarbase.TabBarDataProviderObject
        {
            if (this.tabbar.dataProvider && !(this.tabbar.selectedIndex == -1)) 
            {
                return this.tabbar.dataProvider.getItemAt(this.tabbar.selectedIndex) as frontend.components.tabbarbase.TabBarDataProviderObject;
            }
            return null;
        }

        public static const SUB_HEADER_HEIGHT:Number=55 * SIGMALink.scaleFactor;

        public static const TAB_HEIGHT:Number=80 * SIGMALink.scaleFactor;

        internal static const PADDING:Number=20 * SIGMALink.scaleFactor;

        public var customScroller:frontend.components.scrollContainer.CustomHScrollContainer;

        public var tabbar:feathers.controls.TabBar;

        public var useIconTabs:Boolean=false;

        internal var _checkTabLater:uint;

        internal var tabbarSubHeader:feathers.controls.LayoutGroup;

        internal var tabbarSubHeaderLabel:feathers.controls.Label;
    }
}


//    class TabEvent
package frontend.components.tab 
{
    import frontend.components.tabbarbase.*;
    import starling.events.*;
    
    public class TabEvent extends starling.events.Event
    {
        public function TabEvent(arg1:String, arg2:frontend.components.tabbarbase.ITabLayoutContainer=null, arg3:frontend.components.tabbarbase.TabBarDataProviderObject=null, arg4:Object=null)
        {
            if (arg2) 
            {
                this.instance = arg2;
            }
            this.dpObj = arg3;
            super(arg1, arg4, false);
            return;
        }

        public static const CHANGED:String="tabChanged";

        public var dpObj:frontend.components.tabbarbase.TabBarDataProviderObject;

        public var instance:frontend.components.tabbarbase.ITabLayoutContainer=null;
    }
}


//  package tabbar
//    class TextTabBar
package frontend.components.tabbar 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.themes.*;
    import starling.display.*;
    
    public class TextTabBar extends feathers.controls.TabBar
    {
        public function TextTabBar()
        {
            super();
            tabFactory = this.customTabfactory;
            return;
        }

        protected override function layoutTabs():void
        {
            var loc1:*=null;
            super.layoutTabs();
            var loc2:*=0;
            var loc3:*=this.activeTabs;
            for each (loc1 in loc3) 
            {
                loc1.height = loc1.isSelected ? SELECTED_HEIGHT : DEFAULT_HEIGHT;
                loc1.y = loc1.isSelected ? 0 : SELECTED_HEIGHT - DEFAULT_HEIGHT;
                loc1.gap = 0;
                loc1.labelOffsetY = -10 * SIGMALink.scaleFactor;
                loc1.verticalAlign = "bottom";
                this.validateTabStyle(loc1);
            }
            return;
        }

        public override function set selectedIndex(arg1:int):void
        {
            var loc1:*=null;
            super.selectedIndex = arg1;
            var loc2:*=0;
            var loc3:*=this.activeTabs;
            for each (loc1 in loc3) 
            {
                this.validateTabStyle(loc1);
            }
            return;
        }

        internal function validateTabStyle(arg1:feathers.controls.ToggleButton):void
        {
            arg1.customLabelStyleName = arg1.isSelected ? feathers.themes.CustomSIGMATheme.TABBAR_SELECTED_STYLE_TEXT : feathers.themes.CustomSIGMATheme.TABBAR_NORMAL_STYLE_TEXT;
            arg1.invalidate(INVALIDATION_FLAG_STYLES);
            arg1.validate();
            return;
        }

        internal function customTabfactory():feathers.controls.ToggleButton
        {
            var loc1:*=new feathers.controls.ToggleButton();
            loc1.styleProvider = null;
            loc1.defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            loc1.defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.DARKFONT);
            loc1.customLabelStyleName = feathers.themes.CustomSIGMATheme.TABBAR_NORMAL_STYLE_TEXT;
            return loc1;
        }

        public static const DEFAULT_HEIGHT:Number=40 * SIGMALink.scaleFactor;

        public static const SELECTED_HEIGHT:Number=48 * SIGMALink.scaleFactor;
    }
}


//  package tabbarbase
//    package skins
//      class TabBarDefaultSkin
package frontend.components.tabbarbase.skins 
{
    import core.general.*;
    import starling.display.*;
    
    public class TabBarDefaultSkin extends starling.display.Sprite
    {
        public function TabBarDefaultSkin()
        {
            super();
            var loc1:*=new starling.display.Quad(1, 19 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            var loc2:*=new starling.display.Quad(1, 2 * SIGMALink.scaleFactor, core.general.Colors.MIDGREY);
            loc2.y = 19 * SIGMALink.scaleFactor;
            addChild(loc2);
            addChild(loc1);
            return;
        }
    }
}


//      class TabBarSelectedSkin
package frontend.components.tabbarbase.skins 
{
    import core.general.*;
    import starling.display.*;
    
    public class TabBarSelectedSkin extends starling.display.Sprite
    {
        public function TabBarSelectedSkin()
        {
            super();
            var loc1:*=new starling.display.Quad(1, 19 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            var loc2:*=new starling.display.Quad(1, 2 * SIGMALink.scaleFactor, core.general.Colors.RED);
            loc2.y = 19 * SIGMALink.scaleFactor;
            addChild(loc2);
            addChild(loc1);
            return;
        }
    }
}


//    class ITabLayoutContainer
package frontend.components.tabbarbase 
{
    public interface ITabLayoutContainer
    {
        function get height():Number;

        function set height(arg1:Number):void;

        function get icon():String;

        function get label():String;

        function get subHeader():String;

        function get width():Number;

        function set width(arg1:Number):void;

        function showContent():void;

        function hideContent():void;
    }
}


//    class TabBarBase
package frontend.components.tabbarbase 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.themes.*;
    import flash.text.engine.*;
    import frontend.components.tabbarbase.skins.*;
    
    public class TabBarBase extends Object
    {
        public function TabBarBase()
        {
            super();
            return;
        }

        public static function getIconTabFactory():feathers.controls.ToggleButton
        {
            var loc1:*=getTab(true);
            return loc1;
        }

        public static function getLabelTabFactory():feathers.controls.ToggleButton
        {
            var loc1:*=getTab();
            return loc1;
        }

        internal static function getTab(arg1:Boolean=false):feathers.controls.ToggleButton
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=new feathers.controls.ToggleButton();
            loc1.styleProvider = null;
            loc1.defaultSkin = new frontend.components.tabbarbase.skins.TabBarDefaultSkin();
            loc1.defaultSelectedSkin = new frontend.components.tabbarbase.skins.TabBarSelectedSkin();
            loc1.iconPosition = feathers.controls.Button.ICON_POSITION_TOP;
            if (arg1) 
            {
                loc1.hasLabelTextRenderer = false;
            }
            loc1.gap = 0;
            loc3 = new flash.text.engine.FontDescription(feathers.themes.BaseSIGMATheme.FONT_NAME_ARIAL, flash.text.engine.FontWeight.NORMAL, flash.text.engine.FontPosture.NORMAL, flash.text.engine.FontLookup.EMBEDDED_CFF, flash.text.engine.RenderingMode.CFF, flash.text.engine.CFFHinting.NONE);
            loc2 = new flash.text.engine.ElementFormat(loc3, Math.round(24 * SIGMALink.scaleFactor), core.general.Colors.DARKFONT);
            loc4 = new flash.text.engine.ElementFormat(loc3, Math.round(24 * SIGMALink.scaleFactor), core.general.Colors.DARKFONT);
            loc1.defaultLabelProperties.elementFormat = loc2;
            loc1.defaultSelectedLabelProperties.elementFormat = loc4;
            return loc1;
        }
    }
}


//    class TabBarDataProviderObject
package frontend.components.tabbarbase 
{
    import frontend.*;
    import starling.display.*;
    
    public class TabBarDataProviderObject extends Object
    {
        public function TabBarDataProviderObject(arg1:frontend.components.tabbarbase.ITabLayoutContainer)
        {
            super();
            this.instance = arg1;
            this.defaultTexture = arg1.icon;
            this.label = arg1.label;
            return;
        }

        public function get defaultTexture():String
        {
            return this._defaultTexture;
        }

        public function set defaultTexture(arg1:String):void
        {
            this._defaultTexture = arg1;
            if (this._defaultTexture && !(this._defaultTexture == "")) 
            {
                this.defaultIcon = new starling.display.Image(frontend.AssetsManagerCustom.getInstance().getTexture(this._defaultTexture));
            }
            else 
            {
                this.defaultIcon = null;
            }
            return;
        }

        public var defaultIcon:starling.display.Image;

        internal var _defaultTexture:String="";

        public var instance:frontend.components.tabbarbase.ITabLayoutContainer;

        public var label:String="";
    }
}


//    class TabLayoutGroup
package frontend.components.tabbarbase 
{
    import core.general.*;
    import feathers.controls.*;
    import starling.display.*;
    
    public class TabLayoutGroup extends feathers.controls.LayoutGroup implements frontend.components.tabbarbase.ITabLayoutContainer
    {
        public function TabLayoutGroup()
        {
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        public function get icon():String
        {
            return this._icon;
        }

        public function set icon(arg1:String):void
        {
            this._icon = arg1;
            return;
        }

        public function get label():String
        {
            return this._label;
        }

        public function set label(arg1:String):void
        {
            this._label = arg1;
            return;
        }

        public function get subHeader():String
        {
            return this._subHeader;
        }

        public function set subHeader(arg1:String):void
        {
            this._subHeader = arg1;
            return;
        }

        public function showContent():void
        {
            return;
        }

        public function hideContent():void
        {
            return;
        }

        internal var _icon:String="";

        internal var _label:String="";

        internal var _subHeader:String="";
    }
}


//    class TabLayoutScroller
package frontend.components.tabbarbase 
{
    import core.general.*;
    import frontend.components.scrollContainer.*;
    import starling.display.*;
    
    public class TabLayoutScroller extends frontend.components.scrollContainer.CustomVScrollContainer implements frontend.components.tabbarbase.ITabLayoutContainer
    {
        public function TabLayoutScroller()
        {
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        public function get icon():String
        {
            return this._icon;
        }

        public function set icon(arg1:String):void
        {
            this._icon = arg1;
            return;
        }

        public function get label():String
        {
            return this._label;
        }

        public function set label(arg1:String):void
        {
            this._label = arg1;
            return;
        }

        public function get subHeader():String
        {
            return this._subHeader;
        }

        public function set subHeader(arg1:String):void
        {
            this._subHeader = arg1;
            return;
        }

        public function showContent():void
        {
            return;
        }

        public function hideContent():void
        {
            return;
        }

        internal var _icon:String="";

        internal var _label:String="";

        internal var _subHeader:String="";
    }
}


//  class CustomPageIndicator
package frontend.components 
{
    import feathers.controls.*;
    import frontend.*;
    
    public class CustomPageIndicator extends feathers.controls.PageIndicator
    {
        public function CustomPageIndicator()
        {
            var loc1:*;
            super();
            with ({}) 
            {
            };
            
#error('pushwith') {}
            .selectedSymbolFactory = 
#error('pushwith') {}
            .selectedSymbolFactory = function ():frontend.components.TextureImage
            {
                var loc1:*=new frontend.components.TextureImage();
                loc1.textureName = frontend.Textures.pageindicatorSelected;
                return loc1;
            }
            with ({}) 
            {
            };
            
#error('pushwith') {}
            .normalSymbolFactory = 
#error('pushwith') {}
            .normalSymbolFactory = function ():frontend.components.TextureImage
            {
                var loc1:*=new frontend.components.TextureImage();
                loc1.textureName = frontend.Textures.pageindicatorNormal;
                return loc1;
            }
            return;
        }
    }
}


//  class LangLabel
package frontend.components 
{
    import feathers.controls.*;
    import utils.*;
    
    public class LangLabel extends feathers.controls.Label
    {
        public function LangLabel()
        {
            super();
            return;
        }

        public override function set text(arg1:String):void
        {
            if (this.useLanguageManager) 
            {
                super.text = utils.LanguageManager.getString(arg1);
            }
            else 
            {
                super.text = arg1;
            }
            return;
        }

        public var useLanguageManager:Boolean=true;
    }
}


//  class MainApplicationDrawer
package frontend.components 
{
    import core.general.*;
    import core.sleepScreen.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.core.*;
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
    import frontend.components.button.*;
    import frontend.screen.component.*;
    import frontend.screen.mydevices.sleepScreen.*;
    import handler.*;
    import helper.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class MainApplicationDrawer extends feathers.controls.Drawers implements feathers.binding.IBindingClient
    {
        public function MainApplicationDrawer()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._handleAndroidBackButton = helper.Capabilities_helper.isAndroid();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._MainApplicationDrawer_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_components_MainApplicationDrawerWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.components.MainApplicationDrawer[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.leftDrawerToggleEventType = "toggleLeftMenu";
            this.content = this._MainApplicationDrawer_LayoutGroup1_i();
            this.addEventListener("close", this.___MainApplicationDrawer_Drawers1_close);
            this.addEventListener("creationComplete", this.___MainApplicationDrawer_Drawers1_creationComplete);
            this.addEventListener("open", this.___MainApplicationDrawer_Drawers1_open);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set header(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1221270899header;
            if (loc1 !== arg1) 
            {
                this._1221270899header = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "header", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get icon():frontend.components.button.IconButton
        {
            return this._3226745icon;
        }

        public function set icon(arg1:frontend.components.button.IconButton):void
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

        public function get layoutGroup():feathers.controls.LayoutGroup
        {
            return this._1989375349layoutGroup;
        }

        public function set layoutGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1989375349layoutGroup;
            if (loc1 !== arg1) 
            {
                this._1989375349layoutGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "layoutGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get navigator():frontend.screen.component.CustomScreenNavigator
        {
            return this._752822871navigator;
        }

        internal function _MainApplicationDrawer_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.addEventListener("touch", this.__icon_touch);
            loc1.id = "icon";
            this.icon = loc1;
            feathers.binding.BindingManager.executeBindings(this, "icon", this.icon);
            return loc1;
        }

        public function set navigator(arg1:frontend.screen.component.CustomScreenNavigator):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._752822871navigator;
            if (loc1 !== arg1) 
            {
                this._752822871navigator = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "navigator", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set handleAndroidBackButton(arg1:Boolean):void
        {
            this._handleAndroidBackButton = arg1 && helper.Capabilities_helper.isAndroid();
            debug.Debug.debug("_handleAndroidBackButton: " + this._handleAndroidBackButton.toString());
            if (this._handleAndroidBackButton) 
            {
                stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
            }
            else 
            {
                stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
            }
            return;
        }

        public function get titleLabel():feathers.controls.Label
        {
            return this._1791483012titleLabel;
        }

        internal function get online():Boolean
        {
            return this._1012222381online;
        }

        internal function set online(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1012222381online;
            if (loc1 !== arg1) 
            {
                this._1012222381online = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "online", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get wlanOnline():Boolean
        {
            return this._1085177163wlanOnline;
        }

        internal function set wlanOnline(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1085177163wlanOnline;
            if (loc1 !== arg1) 
            {
                this._1085177163wlanOnline = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "wlanOnline", loc1, arg1, this);
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
            frontend.components.MainApplicationDrawer._watcherSetupUtil = arg1;
            return;
        }

        internal function androidBackButtonHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (arg1.keyCode == flash.ui.Keyboard.BACK) 
            {
                arg1.preventDefault();
                arg1.stopImmediatePropagation();
                handler.ViewHandler.getInstance().goBack();
            }
            return;
        }

        public function initMainApplicationDrawer():void
        {
            debug.Debug.info("initMainApplicationDrawer");
            this.initialized = true;
            return;
        }

        internal function onCreationComplete():void
        {
            if (!this.initialized) 
            {
                debug.Debug.info("App not initialized - try again later");
                flash.utils.setTimeout(this.onCreationComplete, 300);
                return;
            }
            debug.Debug.info("onCreationComplete()");
            SIGMALink.appWidth = width;
            SIGMALink.appHeight = height;
            SIGMALink.headerTop = SIGMALink.iOSHeaderCorrectur * SIGMALink.scaleFactor;
            SIGMALink.headerHeight = 85 * SIGMALink.scaleFactor + SIGMALink.headerTop;
            SIGMALink.footerHeight = 75 * SIGMALink.scaleFactor;
            SIGMALink.containerHeight = SIGMALink.appHeight - SIGMALink.headerHeight - SIGMALink.footerHeight;
            handler.ViewHandler.getInstance().drawer = this;
            handler.ViewHandler.getInstance().navigator = this.navigator;
            handler.ViewHandler.getInstance().mainLayoutGroup = this.layoutGroup;
            handler.ViewHandler.getInstance().init();
            this.titleLabel.maxWidth = SIGMALink.appWidth - 4 * padding - this.icon.width - 60 * SIGMALink.scaleFactor;
            this.handleAndroidBackButton = true;
            core.sleepScreen.SleepScreenSign.initSigns(frontend.screen.mydevices.sleepScreen.SleepScreenRenderer.SCREEN_WIDTH, frontend.screen.mydevices.sleepScreen.SleepScreenRenderer.SCREEN_HEIGHT);
            return;
        }

        protected function toggleLeftMenu(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.toggleNavi();
            return;
        }

        public function toggleNavi():void
        {
            this.layoutGroup.dispatchEventWith("toggleLeftMenu");
            return;
        }

        protected function onMenuOpen(arg1:starling.events.Event):void
        {
            this.open = true;
            handler.ViewHandler.getInstance().dispatchEvent(new starling.events.Event(handler.ViewHandler.EVENT_LEFT_MENU_TOGGLE_CHANGED, false, this.open));
            return;
        }

        protected function onMenuClose(arg1:starling.events.Event):void
        {
            this.open = false;
            handler.ViewHandler.getInstance().dispatchEvent(new starling.events.Event(handler.ViewHandler.EVENT_LEFT_MENU_TOGGLE_CHANGED, false, this.open));
            return;
        }

        internal function _MainApplicationDrawer_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._MainApplicationDrawer_AnchorLayout1_c();
            loc1.mxmlContent = [this._MainApplicationDrawer_CustomScreenNavigator1_i(), this._MainApplicationDrawer_LayoutGroup2_i()];
            loc1.id = "layoutGroup";
            this.layoutGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "layoutGroup", this.layoutGroup);
            return loc1;
        }

        internal function _MainApplicationDrawer_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _MainApplicationDrawer_CustomScreenNavigator1_i():frontend.screen.component.CustomScreenNavigator
        {
            var loc1:*=new frontend.screen.component.CustomScreenNavigator();
            loc1.id = "navigator";
            this.navigator = loc1;
            feathers.binding.BindingManager.executeBindings(this, "navigator", this.navigator);
            return loc1;
        }

        internal function _MainApplicationDrawer_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._MainApplicationDrawer_LayoutGroup3_i()];
            loc1.id = "_MainApplicationDrawer_LayoutGroup2";
            this._MainApplicationDrawer_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MainApplicationDrawer_LayoutGroup2", this._MainApplicationDrawer_LayoutGroup2);
            return loc1;
        }

        internal function _MainApplicationDrawer_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._MainApplicationDrawer_IconButton1_i(), this._MainApplicationDrawer_IconButton2_i(), this._MainApplicationDrawer_Label1_i()];
            loc1.id = "header";
            this.header = loc1;
            feathers.binding.BindingManager.executeBindings(this, "header", this.header);
            return loc1;
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

        public function __icon_touch(arg1:starling.events.TouchEvent):void
        {
            this.toggleLeftMenu(arg1);
            return;
        }

        internal function _MainApplicationDrawer_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_MainApplicationDrawer_IconButton2";
            this._MainApplicationDrawer_IconButton2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MainApplicationDrawer_IconButton2", this._MainApplicationDrawer_IconButton2);
            return loc1;
        }

        internal function _MainApplicationDrawer_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "titleLabel";
            this.titleLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "titleLabel", this.titleLabel);
            return loc1;
        }

        public function ___MainApplicationDrawer_Drawers1_close(arg1:starling.events.Event):void
        {
            this.onMenuClose(arg1);
            return;
        }

        public function ___MainApplicationDrawer_Drawers1_creationComplete(arg1:starling.events.Event):void
        {
            this.onCreationComplete();
            return;
        }

        public function ___MainApplicationDrawer_Drawers1_open(arg1:starling.events.Event):void
        {
            this.onMenuOpen(arg1);
            return;
        }

        internal function _MainApplicationDrawer_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appHeight;
            }, null, "this.height")
            result[1] = new feathers.binding.Binding(this, function ():feathers.core.IFeathersControl
            {
                return handler.ViewHandler.getInstance().navi;
            }, null, "this.leftDrawer")
            result[2] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "layoutGroup.backgroundSkin")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appHeight;
            }, null, "layoutGroup.height")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appHeight - SIGMALink.headerHeight;
            }, null, "navigator.height")
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(SIGMALink.headerHeight, 0, 0, 0);
            }, null, "navigator.layoutData")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "navigator.width")
            result[7] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.RED);
            }, null, "_MainApplicationDrawer_LayoutGroup2.backgroundSkin")
            result[8] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.headerHeight;
            }, null, "_MainApplicationDrawer_LayoutGroup2.height")
            result[9] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "_MainApplicationDrawer_LayoutGroup2.layout")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_MainApplicationDrawer_LayoutGroup2.width")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.headerHeight - SIGMALink.headerTop;
            }, null, "header.height")
            result[12] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "header.layout")
            result[13] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(SIGMALink.headerTop, 0, NaN, 0);
            }, null, "header.layoutData")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "header.width")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.menubutton;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "icon.image")
            result[16] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, padding - frontend.components.button.IconButton.outerPadding, NaN, 0);
            }, null, "icon.layoutData")
            result[17] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.sigmaminiiconwhite;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MainApplicationDrawer_IconButton2.image")
            result[18] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(0, NaN, NaN, NaN, 0, NaN);
            }, null, "_MainApplicationDrawer_IconButton2.layoutData")
            result[19] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, padding / 2, NaN, 0, NaN);
            }, null, "titleLabel.layoutData")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "titleLabel.styleName")
            result[21] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=handler.ViewHandler.getInstance().currentTitle;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "titleLabel.text")
            return result;
        }

        public function get header():feathers.controls.LayoutGroup
        {
            return this._1221270899header;
        }

        internal static const padding:Number=20 * SIGMALink.scaleFactor;

        public var _MainApplicationDrawer_IconButton2:frontend.components.button.IconButton;

        public var _MainApplicationDrawer_LayoutGroup2:feathers.controls.LayoutGroup;

        internal var _1221270899header:feathers.controls.LayoutGroup;

        internal var _3226745icon:frontend.components.button.IconButton;

        internal var _1989375349layoutGroup:feathers.controls.LayoutGroup;

        internal var _752822871navigator:frontend.screen.component.CustomScreenNavigator;

        internal var _handleAndroidBackButton:Boolean;

        public var open:Boolean=false;

        internal var initialized:Boolean=false;

        internal var _1012222381online:Boolean;

        internal var touchBeginX:uint=0;

        internal var touchBeginY:uint=0;

        internal var _1085177163wlanOnline:Boolean;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal var _1791483012titleLabel:feathers.controls.Label;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class PropertyLabel
package frontend.components 
{
    import feathers.controls.*;
    
    public class PropertyLabel extends feathers.controls.Label
    {
        public function PropertyLabel()
        {
            super();
            return;
        }

        public var property:Object;
    }
}


//  class SportIcon
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


//  class TextureImage
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


