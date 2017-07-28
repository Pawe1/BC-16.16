//class ActivityLapItemListRenderer
package frontend.screen.activities.tabs.laps 
{
    import configCache.*;
    import core.general.*;
    import core.marker.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import starling.display.*;
    import utils.format.*;
    
    public class ActivityLapItemListRenderer extends feathers.controls.renderers.DefaultListItemRenderer
    {
        public function ActivityLapItemListRenderer()
        {
            this._group = new feathers.controls.LayoutGroup();
            this._labelAvgSpeed = new feathers.controls.Label();
            this._labelDistance = new feathers.controls.Label();
            this._labelTime = new feathers.controls.Label();
            super();
            hasLabelTextRenderer = false;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(SIGMALink.appWidth, ROW_HEIGHT, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(SIGMALink.appWidth, ROW_HEIGHT, core.general.Colors.LIGHTGREY);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group.width = SIGMALink.appWidth;
            this._group.height = ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            this._labelDistance.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelDistance.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, COL_PADDING, NaN, 0);
            this._labelDistance.width = COL_WIDTH;
            this._group.addChild(this._labelDistance);
            this._labelTime.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelTime.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_PADDING + COL_WIDTH + COL_PADDING, NaN, NaN, NaN, 0);
            this._labelTime.width = COL_WIDTH;
            this._group.addChild(this._labelTime);
            this._labelAvgSpeed.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelAvgSpeed.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_PADDING, NaN, NaN, NaN, 0);
            this._labelAvgSpeed.width = COL_WIDTH;
            this._group.addChild(this._labelAvgSpeed);
            addChild(this._group);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc1);
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
            if (data is core.marker.Marker) 
            {
                loc1 = data as core.marker.Marker;
                if (loc1.distanceDefined) 
                {
                    this._labelDistance.text = loc1.distanceOutputString;
                }
                this._labelTime.text = loc1.timeOutputString;
                if (loc1.averageSpeedDefined) 
                {
                    if (configCache.ConfigCache.getInstance().getSportSpeedFormatValue(loc1.logReference.sport) != utils.format.SpeedFormat.DISTANCE_PER_TIME) 
                    {
                        this._labelAvgSpeed.text = loc1.averageSpeedTimeOutputString;
                    }
                    else 
                    {
                        this._labelAvgSpeed.text = loc1.averageSpeedOutputString;
                    }
                }
            }
            else 
            {
                this._labelDistance.text = data + "";
                this._labelTime.text = "";
                this._labelAvgSpeed.text = "";
            }
            return;
        }

        public static const COL_PADDING:Number=20 * SIGMALink.scaleFactor;

        public static const COL_WIDTH:Number=(SIGMALink.appWidth - 4 * COL_PADDING) / 3;

        internal static const ROW_HEIGHT:Number=60 * SIGMALink.scaleFactor;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _labelAvgSpeed:feathers.controls.Label;

        internal var _labelDistance:feathers.controls.Label;

        internal var _labelTime:feathers.controls.Label;
    }
}


