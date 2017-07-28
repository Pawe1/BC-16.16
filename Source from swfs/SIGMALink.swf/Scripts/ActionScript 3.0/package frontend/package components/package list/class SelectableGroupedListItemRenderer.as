//class SelectableGroupedListItemRenderer
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


