//class TopValuesListHeaderRenderer
package frontend.screen.topvalues.list 
{
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import frontend.components.*;
    import starling.display.*;
    
    public class TopValuesListHeaderRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function TopValuesListHeaderRenderer()
        {
            super();
            height = ROW_HEIGHT;
            padding = 0;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this.holderGroup = new feathers.controls.LayoutGroup();
            this.holderGroup.layout = new feathers.layout.AnchorLayout();
            this.holderGroup.height = ROW_HEIGHT;
            this.holderGroup.width = SIGMALink.appWidth;
            this.icon = new frontend.components.TextureImage();
            this.icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ipadding, NaN, 0);
            this.holderGroup.addChild(this.icon);
            addChild(this.holderGroup);
            return;
        }

        protected override function commitData():void
        {
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.topvalues.list.TopValuesListGroupHeader;
            this.icon.textureName = loc1.iconSource;
            this.holderGroup.backgroundSkin = new starling.display.Quad(1, 1, loc1.color);
            return;
        }

        
        {
            COL_ICON_WIDTH = 80 * SIGMALink.scaleFactor;
            ROW_HEIGHT = 45 * SIGMALink.scaleFactor;
            ipadding = 17 * SIGMALink.scaleFactor;
        }

        internal var holderGroup:feathers.controls.LayoutGroup;

        internal var icon:frontend.components.TextureImage;

        internal static var COL_ICON_WIDTH:uint;

        internal static var ROW_HEIGHT:Number;

        internal static var ipadding:Number;
    }
}


