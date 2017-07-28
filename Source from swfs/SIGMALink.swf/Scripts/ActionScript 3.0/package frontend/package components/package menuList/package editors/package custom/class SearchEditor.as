//class SearchEditor
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


