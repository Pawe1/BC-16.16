//class MenuItemListRenderer
package frontend.screen.mydevices.settings 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import starling.display.*;
    
    public class MenuItemListRenderer extends frontend.components.list.SelectableListItemRenderer
    {
        public function MenuItemListRenderer()
        {
            super();
            height = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_TOP;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
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
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        protected override function commitData():void
        {
            var loc1:*=null;
            super.commitData();
            if (!data) 
            {
                return;
            }
            if (data is feathers.controls.Label) 
            {
                (data as feathers.controls.Label).layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, PADDING, NaN, 0);
                this._group.removeChildren();
                this._group.addChild(data as feathers.controls.Label);
                this._group.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }
            else 
            {
                loc1 = data as frontend.components.menuList.MenuListItem;
                this._group.removeChildren();
                this._group.addChild(loc1);
                this._group.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
                height = loc1.visible ? frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT : 0;
            }
            return;
        }

        internal var _bottomLine:starling.display.Quad;

        internal var _group:feathers.controls.LayoutGroup;
    }
}


