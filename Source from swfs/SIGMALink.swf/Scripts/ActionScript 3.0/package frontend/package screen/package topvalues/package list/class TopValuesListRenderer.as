//class TopValuesListRenderer
package frontend.screen.topvalues.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import starling.display.*;
    
    public class TopValuesListRenderer extends feathers.controls.renderers.DefaultGroupedListItemRenderer
    {
        public function TopValuesListRenderer()
        {
            super();
            height = ROW_HEIGHT;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_MIDDLE;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            return;
        }

        protected override function initialize():void
        {
            var loc1:*=null;
            super.initialize();
            this.holderGroup = new feathers.controls.LayoutGroup();
            this.holderGroup.layout = new feathers.layout.AnchorLayout();
            this.holderGroup.height = ROW_HEIGHT;
            this.holderGroup.width = SIGMALink.appWidth;
            this.icon = new frontend.components.TextureImage();
            this.icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding, NaN, 0);
            this.icon.touchable = false;
            this.holderGroup.addChild(this.icon);
            loc1 = new feathers.layout.VerticalLayout();
            loc1.gap = ipadding / 2;
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            this.vg = new feathers.controls.LayoutGroup();
            this.vg.height = ROW_HEIGHT;
            this.vg.layout = loc1;
            this.vg.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding + COL_ICON_WIDTH, NaN, 0);
            this.holderGroup.addChild(this.vg);
            this.title = new feathers.controls.Label();
            this.title.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            this.title.wordWrap = true;
            this.vg.addChild(this.title);
            this.date = new feathers.controls.Label();
            this.date.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.vg.addChild(this.date);
            this.value = new feathers.controls.Label();
            this.value.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.value.layoutData = new feathers.layout.AnchorLayoutData(NaN, ipadding + COL_ICON_WIDTH, NaN, NaN, NaN, 0);
            this.holderGroup.addChild(this.value);
            this.unit = new feathers.controls.Label();
            this.unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.unit.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, SIGMALink.appWidth - COL_ICON_WIDTH, NaN, 0);
            this.holderGroup.addChild(this.unit);
            addChild(this.holderGroup);
            var loc2:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc2);
            return;
        }

        protected override function commitData():void
        {
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.topvalues.list.TopValuesListItem;
            this.icon.textureName = loc1.iconSource;
            this.title.text = loc1.title;
            this.date.text = loc1.date;
            this.value.text = loc1.value;
            this.unit.text = loc1.unit;
            invalidate(INVALIDATION_FLAG_SIZE);
            this.validate();
            return;
        }

        public override function validate():void
        {
            super.validate();
            this.value.validate();
            var loc1:*=this.vg.layoutData as feathers.layout.AnchorLayoutData;
            loc1.right = COL_ICON_WIDTH + this.value.width + (ipadding << 1);
            this.vg.validate();
            this.title.width = this.vg.width;
            return;
        }

        
        {
            COL_ICON_WIDTH = 85 * SIGMALink.scaleFactor;
            ROW_HEIGHT = 128 * SIGMALink.scaleFactor;
            ipadding = 18 * SIGMALink.scaleFactor;
        }

        internal var date:feathers.controls.Label;

        internal var holderGroup:feathers.controls.LayoutGroup;

        internal var icon:frontend.components.TextureImage;

        internal var title:feathers.controls.Label;

        internal var unit:feathers.controls.Label;

        internal var value:feathers.controls.Label;

        internal var vg:feathers.controls.LayoutGroup;

        internal static var COL_ICON_WIDTH:uint;

        internal static var ROW_HEIGHT:Number;

        internal static var ipadding:Number;
    }
}


