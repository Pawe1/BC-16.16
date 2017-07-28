//package list
//  class CustomGroupedList
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


//  class CustomList
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


//  class ListLoader
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


//  class ListSetting
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


//  class ListSortItem
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


//  class ListStateHandler
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


//  class SelectableGroupedListItemRenderer
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


//  class SelectableListEvent
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


//  class SelectableListItem
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


//  class SelectableListItemRenderer
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


