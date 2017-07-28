//class ActivityPhaseFooterRenderer
package frontend.screen.activities.tabs.phases 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import starling.display.*;
    import utils.*;
    
    public class ActivityPhaseFooterRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function ActivityPhaseFooterRenderer()
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
            this.holderGroup.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this.title = new feathers.controls.Label();
            this.title.text = utils.LanguageManager.getString("ACTIVITY_PHASE_PLAN_TITLE");
            this.title.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH * 2 + PADDING, NaN, NaN, NaN, 0);
            this.holderGroup.addChild(this.title);
            this.plan1Icon = new frontend.components.TextureImage();
            this.holderGroup.addChild(this.plan1Icon);
            this.plan1ValueLabel = new feathers.controls.Label();
            this.plan1ValueLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH + PADDING, NaN, NaN, NaN, 0);
            this.plan1ValueLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.holderGroup.addChild(this.plan1ValueLabel);
            this.plan1Unit = new feathers.controls.Label();
            this.plan1Unit.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH, NaN, NaN, NaN, 0);
            this.plan1Unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.holderGroup.addChild(this.plan1Unit);
            this.plan2Icon = new frontend.components.TextureImage();
            this.holderGroup.addChild(this.plan2Icon);
            this.plan2ValueLabel = new feathers.controls.Label();
            this.plan2ValueLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING, NaN, NaN, NaN, 0);
            this.plan2ValueLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.holderGroup.addChild(this.plan2ValueLabel);
            this.plan2Unit = new feathers.controls.Label();
            this.plan2Unit.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH, NaN, NaN, NaN, 0);
            this.plan2Unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.holderGroup.addChild(this.plan2Unit);
            addChild(this.holderGroup);
            return;
        }

        protected override function commitData():void
        {
            if (!data) 
            {
                return;
            }
            var loc1:*=data as frontend.screen.activities.tabs.phases.ActivityPhaseListGroupFooter;
            this.plan1ValueLabel.text = loc1.plan1Value;
            this.plan1Unit.text = loc1.plan1Unit;
            this.plan2ValueLabel.text = loc1.plan2Value;
            this.plan2Unit.text = loc1.plan2Unit;
            if (loc1.plan1Icon != "") 
            {
                this.plan1ValueLabel.validate();
                this.plan1Icon.textureName = loc1.plan1Icon;
                this.plan1Icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH + PADDING + this.plan1ValueLabel.width + ICON_GAP, NaN, NaN, NaN, 0);
            }
            if (loc1.plan2Icon != "") 
            {
                this.plan2ValueLabel.validate();
                this.plan2Icon.textureName = loc1.plan2Icon;
                this.plan2Icon.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING + this.plan2ValueLabel.width + ICON_GAP, NaN, NaN, NaN, 0);
            }
            return;
        }

        
        {
            ICON_GAP = 10 * SIGMALink.scaleFactor;
            ROW_HEIGHT = 75 * SIGMALink.scaleFactor;
        }

        internal static const COL_WIDTH:Number=SIGMALink.appWidth / 3;

        internal static const PADDING:Number=17 * SIGMALink.scaleFactor;

        internal var holderGroup:feathers.controls.LayoutGroup;

        internal var plan1Icon:frontend.components.TextureImage;

        internal var plan1Unit:feathers.controls.Label;

        internal var plan1ValueLabel:feathers.controls.Label;

        internal var plan2Icon:frontend.components.TextureImage;

        internal var plan2Unit:feathers.controls.Label;

        internal var plan2ValueLabel:feathers.controls.Label;

        internal var title:feathers.controls.Label;

        internal static var ICON_GAP:Number;

        internal static var ROW_HEIGHT:Number;
    }
}


