//class ActivityListItemFooterRenderer
package frontend.screen.activities.list 
{
    import backend.utils.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import starling.display.*;
    
    public class ActivityListItemFooterRenderer extends feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer implements feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
    {
        public function ActivityListItemFooterRenderer()
        {
            this._group = new feathers.controls.LayoutGroup();
            super();
            touchable = false;
            height = footerHeight;
            return;
        }

        public override function set data(arg1:Object):void
        {
            super.data = arg1;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group = new feathers.controls.LayoutGroup();
            this._group.layout = new feathers.layout.AnchorLayout();
            this._group.width = SIGMALink.appWidth;
            this._group.height = footerHeight;
            this._group.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            addChild(this._group);
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.gap = customPadding;
            loc1.verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            this.statisticGroup = new feathers.controls.LayoutGroup();
            this.statisticGroup.height = footerHeight;
            this.statisticGroup.layout = loc1;
            this.statisticGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, customPadding, NaN, 0);
            this._group.addChild(this.statisticGroup);
            this._imgStatistic = new frontend.components.TextureImage();
            this.statisticGroup.addChild(this._imgStatistic);
            this._labelStatistic = new feathers.controls.Label();
            this._labelStatistic.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.statisticGroup.addChild(this._labelStatistic);
            this.distGroup = new feathers.controls.LayoutGroup();
            this.distGroup.height = footerHeight;
            this.distGroup.layout = loc1;
            this._group.addChild(this.distGroup);
            this._imgDistance = new frontend.components.TextureImage();
            this.distGroup.addChild(this._imgDistance);
            this._labelDistance = new feathers.controls.Label();
            this._labelDistance.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.distGroup.addChild(this._labelDistance);
            this._labelDistanceUnit = new feathers.controls.Label();
            this._labelDistanceUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._labelDistanceUnit.text = backend.utils.DataUtils.unitStringDistance;
            this.distGroup.addChild(this._labelDistanceUnit);
            this.timeGroup = new feathers.controls.LayoutGroup();
            this.timeGroup.height = footerHeight;
            this.timeGroup.layout = loc1;
            this.timeGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, customPadding, NaN, NaN, NaN, 0);
            this._group.addChild(this.timeGroup);
            this._imgTime = new frontend.components.TextureImage();
            this.timeGroup.addChild(this._imgTime);
            this._labelTime = new feathers.controls.Label();
            this._labelTime.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.timeGroup.addChild(this._labelTime);
            this._labelTimeUnit = new feathers.controls.Label();
            this._labelTimeUnit.width = unitWidth;
            this._labelTimeUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._labelTimeUnit.text = backend.utils.DataUtils.unitStringTimeHours;
            this.timeGroup.addChild(this._labelTimeUnit);
            var loc2:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
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
            var loc1:*=data as frontend.screen.activities.list.ActivitiesListGroupFooter;
            if (!loc1) 
            {
                return;
            }
            this._labelStatistic.text = loc1.length + "";
            this._labelDistance.text = backend.utils.DataUtils.distanceFormatter.format(backend.utils.DataUtils.distanceConverter.convert(loc1.distance));
            this._labelTime.text = backend.utils.DataUtils.timeFormatter.format(loc1.trainingTime);
            this._imgStatistic.source = loc1.statisticIcon;
            this.statisticGroup.invalidate(INVALIDATION_FLAG_SIZE);
            this.statisticGroup.validate();
            this._imgDistance.source = loc1.distanceIcon;
            this.distGroup.invalidate(INVALIDATION_FLAG_SIZE);
            this.distGroup.validate();
            this._imgTime.source = loc1.timeIcon;
            this.timeGroup.invalidate(INVALIDATION_FLAG_SIZE);
            this.timeGroup.validate();
            var loc2:*=(SIGMALink.appWidth - this.statisticGroup.width - this.distGroup.width - this.timeGroup.width - 4 * customPadding) / 2;
            loc2 = loc2 + (customPadding * 2 + this.statisticGroup.width);
            this.distGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, loc2, NaN, 0);
            return;
        }

        
        {
            customPadding = 17 * SIGMALink.scaleFactor;
            footerHeight = 70 * SIGMALink.scaleFactor;
            unitWidth = 50 * SIGMALink.scaleFactor;
        }

        internal var _group:feathers.controls.LayoutGroup;

        internal var _imgDistance:frontend.components.TextureImage;

        internal var _imgStatistic:frontend.components.TextureImage;

        internal var _imgTime:frontend.components.TextureImage;

        internal var _labelDistance:feathers.controls.Label;

        internal var _labelDistanceUnit:feathers.controls.Label;

        internal var _labelStatistic:feathers.controls.Label;

        internal var _labelTime:feathers.controls.Label;

        internal var _labelTimeUnit:feathers.controls.Label;

        internal var distGroup:feathers.controls.LayoutGroup;

        internal var statisticGroup:feathers.controls.LayoutGroup;

        internal var timeGroup:feathers.controls.LayoutGroup;

        internal static var customPadding:Number;

        internal static var footerHeight:Number;

        internal static var unitWidth:Number;
    }
}


