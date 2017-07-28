//package base
//  class EditorBase
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


//  class EditorClasses
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


//  class EditorReturnObject
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


//  class OnOffToggleButton
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


