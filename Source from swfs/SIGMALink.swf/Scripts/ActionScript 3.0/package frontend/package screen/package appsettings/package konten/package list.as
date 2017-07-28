//package list
//  class AutoShareHeaderRenderer
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


//  class AutoShareListGroup
package frontend.screen.appsettings.konten.list 
{
    public class AutoShareListGroup extends Object
    {
        public function AutoShareListGroup()
        {
            this.children = new Array();
            super();
            return;
        }

        public function addItem(arg1:frontend.screen.appsettings.konten.list.AutoShareListItem):void
        {
            if (arg1) 
            {
                this.children.push(arg1);
            }
            return;
        }

        public var children:Array;

        public var header:frontend.screen.appsettings.konten.list.AutoShareListGroupHeader;
    }
}


//  class AutoShareListGroupHeader
package frontend.screen.appsettings.konten.list 
{
    public class AutoShareListGroupHeader extends Object
    {
        public function AutoShareListGroupHeader()
        {
            super();
            return;
        }

        public var name:String;

        public var selected:Boolean;
    }
}


//  class AutoShareListItem
package frontend.screen.appsettings.konten.list 
{
    import configCache.*;
    
    public class AutoShareListItem extends Object
    {
        public function AutoShareListItem()
        {
            super();
            return;
        }

        public function get selected():Boolean
        {
            if (this.key != "") 
            {
                return configCache.ConfigCache.getInstance().getValue(this.key, true);
            }
            return this._selected;
        }

        public function set selected(arg1:Boolean):void
        {
            if (this.key == "") 
            {
                this._selected = arg1;
            }
            else 
            {
                configCache.ConfigCache.getInstance().setValue(this.key, arg1);
            }
            return;
        }

        public var key:String="";

        public var label:String="";

        internal var _selected:Boolean=false;

        public var sportId:uint=0;

        public var userId:uint=0;
    }
}


//  class AutoShareListItemRenderer
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


