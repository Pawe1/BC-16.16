//class EditorBase
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


