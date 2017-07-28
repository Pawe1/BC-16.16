//package editors
//  package base
//    class EditorBase
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


//    class EditorClasses
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


//    class EditorReturnObject
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


//    class OnOffToggleButton
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


//  package custom
//    class GPSLocationEditor
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


//    class SearchEditor
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


//    class SearchEditorItemRenderer
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


//    class SportAndNameEditor
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


//    class SportMultiSelectEditor
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


//    class SportMultiSelectItemRenderer
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


//    class SportSingleSelectEditor
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


//    class SportSingleSelectItemRenderer
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


//    class StringMultiSelectEditor
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


//    class StringMultiSelectItemRenderer
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


//    class UnitEditor
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


//  class CheckBoxMultiEditor
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


//  class DateEditor
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


//  class DateTimeEditor
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


//  class MultiSelectEditor
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


//  class NumberEditor
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


//  class RadioEditor
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


//  class RatingEditor
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


//  class SpinnerEditor
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


//  class TextAreaEditor
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


//  class TextEditor
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


//  class TimeEditor
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


//  class ZoneEditor
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


