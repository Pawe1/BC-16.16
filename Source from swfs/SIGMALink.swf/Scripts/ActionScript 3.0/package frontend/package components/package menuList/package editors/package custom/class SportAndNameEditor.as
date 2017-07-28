//class SportAndNameEditor
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


