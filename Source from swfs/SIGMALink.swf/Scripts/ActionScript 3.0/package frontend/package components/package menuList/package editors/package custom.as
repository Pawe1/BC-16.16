//package custom
//  class GPSLocationEditor
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


//  class SearchEditor
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


//  class SearchEditorItemRenderer
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


//  class SportAndNameEditor
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


//  class SportMultiSelectEditor
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


//  class SportMultiSelectItemRenderer
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


//  class SportSingleSelectEditor
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


//  class SportSingleSelectItemRenderer
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


//  class StringMultiSelectEditor
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


//  class StringMultiSelectItemRenderer
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


//  class UnitEditor
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


