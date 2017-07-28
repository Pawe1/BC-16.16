//class AutoShareListItemRenderer
package frontend.screen.appsettings.konten.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.screen.appsettings.konten.*;
    import starling.display.*;
    
    public class AutoShareListItemRenderer extends feathers.controls.renderers.DefaultGroupedListItemRenderer
    {
        public function AutoShareListItemRenderer()
        {
            super();
            height = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_TOP;
            hasLabelTextRenderer = false;
            padding = 0;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        protected function check_changeHandler(arg1:Boolean):void
        {
            var loc1:*=data as frontend.screen.appsettings.konten.list.AutoShareListItem;
            if (!loc1) 
            {
                return;
            }
            loc1.selected = arg1;
            frontend.screen.appsettings.konten.ASKontenSetting.validateHeaderGroupSelection(owner as frontend.components.list.CustomGroupedList);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._check = new frontend.components.menuList.editors.base.OnOffToggleButton();
            this._check.layoutData = new feathers.layout.AnchorLayoutData(NaN, 0, NaN, NaN, NaN, 0);
            this._check.toggleChangedFunction = this.check_changeHandler;
            this._group.addChild(this._check);
            this._sportIcon = new frontend.components.SportIcon();
            this._sportIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, customPadding, NaN, 0);
            this._group.addChild(this._sportIcon);
            this._userIcon = new frontend.components.TextureImage();
            this._userIcon.textureName = frontend.Textures.profileicon;
            this._group.addChild(this._userIcon);
            this._userIcon.validate();
            this._userIcon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, customPadding + (iconGroupWidth - this._userIcon.width) / 2, NaN, 0);
            this._labelData = new feathers.controls.Label();
            this._labelData.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._labelData.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, customPadding * 2 + iconGroupWidth, NaN, 0);
            this._group.addChild(this._labelData);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
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
            var loc1:*=data as frontend.screen.appsettings.konten.list.AutoShareListItem;
            if (!loc1) 
            {
                return;
            }
            if (loc1.sportId == 0) 
            {
                this._userIcon.includeInLayout = loc2 = true;
                this._userIcon.visible = loc2;
                this._sportIcon.includeInLayout = loc2 = false;
                this._sportIcon.visible = loc2;
            }
            else 
            {
                var loc2:*;
                this._userIcon.includeInLayout = loc2 = false;
                this._userIcon.visible = loc2;
                this._sportIcon.includeInLayout = loc2 = true;
                this._sportIcon.visible = loc2;
                this._sportIcon.sportId = loc1.sportId;
            }
            this._labelData.text = loc1.label;
            this._check.checked = loc1.selected;
            return;
        }

        
        {
            checkBoxWidth = 50 * SIGMALink.scaleFactor;
            customPadding = 20 * SIGMALink.scaleFactor;
            iconGroupWidth = 70 * SIGMALink.scaleFactor;
            iconPaddingTop = 6 * SIGMALink.scaleFactor;
        }

        internal var _check:frontend.components.menuList.editors.base.OnOffToggleButton;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _labelData:feathers.controls.Label;

        internal var _sportIcon:frontend.components.SportIcon;

        internal var _userIcon:frontend.components.TextureImage;

        internal static var checkBoxWidth:Number;

        internal static var customPadding:Number;

        internal static var iconGroupWidth:Number;

        internal static var iconPaddingTop:Number;
    }
}


