//class SearchEditorItemRenderer
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


