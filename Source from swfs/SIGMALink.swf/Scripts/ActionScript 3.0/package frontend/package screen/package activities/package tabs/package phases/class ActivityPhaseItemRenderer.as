//class ActivityPhaseItemRenderer
package frontend.screen.activities.tabs.phases 
{
    import backend.utils.*;
    import core.general.*;
    import core.marker.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import starling.display.*;
    import utils.*;
    
    public class ActivityPhaseItemRenderer extends feathers.controls.renderers.DefaultGroupedListItemRenderer
    {
        public function ActivityPhaseItemRenderer()
        {
            this._group = new feathers.controls.LayoutGroup();
            super();
            hasLabelTextRenderer = false;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(SIGMALink.appWidth, ROW_HEIGHT, core.general.Colors.WHITE);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._group.width = SIGMALink.appWidth;
            this._group.height = ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._title = new feathers.controls.Label();
            this._title.layoutData = new feathers.layout.AnchorLayoutData(COL_PADDING, NaN, NaN, COL_PADDING);
            this._group.addChild(this._title);
            this._labelDuration = new feathers.controls.Label();
            this._labelDuration.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._labelDuration.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH * 2 + COL_PADDING, NaN, NaN, NaN, 0);
            this._group.addChild(this._labelDuration);
            this._inZone = new feathers.controls.Label();
            this._inZone.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._inZone.layoutData = new feathers.layout.AnchorLayoutData(NaN, COL_WIDTH + COL_PADDING, NaN, NaN, NaN, 0);
            this._group.addChild(this._inZone);
            var loc1:*=ROW_HEIGHT / 3;
            this._avgPrefix = utils.LanguageManager.getString("AVG");
            this._avgHRPrefix = new feathers.controls.Label();
            this._avgHRPrefix.text = this._avgPrefix;
            this._avgHRPrefix.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._group.addChild(this._avgHRPrefix);
            this._avgHRPrefix.validate();
            var loc2:*=(loc1 - this._avgHRPrefix.height) / 2;
            this._avgHRPrefix.layoutData = new feathers.layout.AnchorLayoutData(loc2, COL_HR_WIDTH);
            this._minPrefix = utils.LanguageManager.getString("MIN");
            this._minHRPrefix = new feathers.controls.Label();
            this._minHRPrefix.text = this._minPrefix;
            this._minHRPrefix.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._minHRPrefix.layoutData = new feathers.layout.AnchorLayoutData(loc1 + loc2, COL_HR_WIDTH);
            this._group.addChild(this._minHRPrefix);
            this._maxPrefix = utils.LanguageManager.getString("MAX");
            this._maxHRPrefix = new feathers.controls.Label();
            this._maxHRPrefix.text = this._maxPrefix;
            this._maxHRPrefix.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._maxHRPrefix.layoutData = new feathers.layout.AnchorLayoutData(loc1 * 2 + loc2, COL_HR_WIDTH);
            this._group.addChild(this._maxHRPrefix);
            this._avgHR = new feathers.controls.Label();
            this._avgHR.text = "0";
            this._avgHR.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._group.addChild(this._avgHR);
            this._avgHR.validate();
            loc2 = (loc1 - this._avgHR.height) / 2;
            this._avgHR.layoutData = new feathers.layout.AnchorLayoutData(loc2, COL_PADDING);
            this._minHR = new feathers.controls.Label();
            this._minHR.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._minHR.layoutData = new feathers.layout.AnchorLayoutData(loc1 + loc2, COL_PADDING);
            this._group.addChild(this._minHR);
            this._maxHR = new feathers.controls.Label();
            this._maxHR.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._maxHR.layoutData = new feathers.layout.AnchorLayoutData(loc1 * 2 + loc2, COL_PADDING);
            this._group.addChild(this._maxHR);
            var loc3:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc3);
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
                this._group.backgroundSkin = new starling.display.Quad(1, 1, !(loc1.type == core.general.MarkerType.INTERVAL_PHASE) && !(loc1.type == core.general.MarkerType.SIMPLE_PHASE) ? core.general.Colors.WHITE : core.general.Colors.brightenColor(core.general.Colors.LIGHTGREY, 75));
                this._title.text = loc1.type == core.general.MarkerType.INTERVAL_PHASE ? utils.LanguageManager.getString("ACTIVITY_INTERVAL_PHASE_SUMMERY") : loc1.title;
                this._labelDuration.text = backend.utils.DataUtils.timeFormatterHHMMSST.format(loc1.time);
                this._inZone.text = backend.utils.DataUtils.timeFormatterHHMMSST.format(loc1.timeInTargetZone);
                if (loc1.averageHeartrateDefined) 
                {
                    this._avgHRPrefix.text = this._avgPrefix;
                    this._avgHR.text = backend.utils.DataUtils.heartrateFormatter.format(loc1.averageHeartrate);
                }
                else 
                {
                    this._avgHRPrefix.text = "";
                    this._avgHR.text = "";
                }
                if (loc1.minimumHeartrateDefined) 
                {
                    this._minHRPrefix.text = this._minPrefix;
                    this._minHR.text = backend.utils.DataUtils.heartrateFormatter.format(loc1.minimumHeartrate);
                }
                else 
                {
                    this._minHRPrefix.text = "";
                    this._minHR.text = "";
                }
                if (loc1.maximumHeartrateDefined) 
                {
                    this._maxHRPrefix.text = this._maxPrefix;
                    this._maxHR.text = backend.utils.DataUtils.heartrateFormatter.format(loc1.maximumHeartrate);
                }
                else 
                {
                    this._maxHRPrefix.text = "";
                    this._maxHR.text = "";
                }
            }
            return;
        }

        public static const COL_PADDING:Number=20 * SIGMALink.scaleFactor;

        public static const COL_WIDTH:Number=(SIGMALink.appWidth - 4 * COL_PADDING) / 3;

        internal static const COL_HR_WIDTH:Number=85 * SIGMALink.scaleFactor;

        internal static const ROW_HEIGHT:Number=150 * SIGMALink.scaleFactor;

        internal var _avgHR:feathers.controls.Label;

        internal var _avgHRPrefix:feathers.controls.Label;

        internal var _avgPrefix:String;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _inZone:feathers.controls.Label;

        internal var _labelDuration:feathers.controls.Label;

        internal var _maxHR:feathers.controls.Label;

        internal var _maxHRPrefix:feathers.controls.Label;

        internal var _maxPrefix:String;

        internal var _minHR:feathers.controls.Label;

        internal var _minHRPrefix:feathers.controls.Label;

        internal var _minPrefix:String;

        internal var _title:feathers.controls.Label;
    }
}


