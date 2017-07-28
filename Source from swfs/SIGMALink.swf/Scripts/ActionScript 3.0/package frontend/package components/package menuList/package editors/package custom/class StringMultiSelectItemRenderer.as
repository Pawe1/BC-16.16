//class StringMultiSelectItemRenderer
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


