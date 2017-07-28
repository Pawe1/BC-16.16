//class AutoShareHeaderRenderer
package frontend.screen.appsettings.konten.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.screen.appsettings.konten.*;
    import starling.display.*;
    import utils.*;
    
    public class AutoShareHeaderRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function AutoShareHeaderRenderer()
        {
            super();
            height = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            styleProvider = null;
            padding = 0;
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            touchable = true;
            return;
        }

        protected override function itemToContent(arg1:Object):starling.display.DisplayObject
        {
            return null;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.layout = new feathers.layout.AnchorLayout();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            addChild(this._group);
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, customPadding, NaN, 0);
            this._group.addChild(this._name);
            this._check = new frontend.components.menuList.editors.base.OnOffToggleButton();
            this._check.layoutData = new feathers.layout.AnchorLayoutData(NaN, 0, NaN, NaN, NaN, 0);
            this._check.toggleChangedFunction = this.onToggleButtonChanged;
            this._group.addChild(this._check);
            this._check.validate();
            this._selectAllLabel = new feathers.controls.Label();
            this._selectAllLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            this._selectAllLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, this._check.width, NaN, NaN, NaN, 0);
            this._selectAllLabel.text = utils.LanguageManager.getString("SELECT_ALL_BUTTON_TEXT");
            this._group.addChild(this._selectAllLabel);
            return;
        }

        internal function onToggleButtonChanged(arg1:Boolean):void
        {
            var loc1:*=data as frontend.screen.appsettings.konten.list.AutoShareListGroupHeader;
            loc1.selected = arg1;
            frontend.screen.appsettings.konten.ASKontenSetting.validateChildSelection(owner as frontend.components.list.CustomGroupedList);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.appsettings.konten.list.AutoShareListGroupHeader;
            if (!loc1) 
            {
                return;
            }
            this._name.text = loc1.name;
            this._check.checked = loc1.selected;
            return;
        }

        
        {
            customPadding = 20 * SIGMALink.scaleFactor;
        }

        internal var _check:frontend.components.menuList.editors.base.OnOffToggleButton;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _name:feathers.controls.Label;

        internal var _selectAllLabel:feathers.controls.Label;

        internal static var customPadding:Number;
    }
}


