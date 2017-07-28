//class GPSiesTrackRenderer
package frontend.screen.tracks.tabs.gpsies 
{
    import backend.utils.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.components.menuList.*;
    import starling.display.*;
    import utils.*;
    
    public class GPSiesTrackRenderer extends feathers.controls.renderers.DefaultListItemRenderer
    {
        public function GPSiesTrackRenderer()
        {
            super();
            height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            horizontalAlign = feathers.controls.renderers.DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
            verticalAlign = feathers.controls.renderers.DefaultListItemRenderer.VERTICAL_ALIGN_TOP;
            styleProvider = null;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            defaultSelectedSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            hasLabelTextRenderer = false;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._distanceToTrackPostfix = utils.LanguageManager.getString("GPSIES_DISTANCE_TO_TRACK_POSTFIX");
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = frontend.components.menuList.MenuList.ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._name = new feathers.controls.Label();
            this._name.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this._name.layoutData = new feathers.layout.AnchorLayoutData(PADDING, NaN, NaN, customPadding);
            this._group.addChild(this._name);
            this._hLayout = new feathers.layout.HorizontalLayout();
            this._hLayout.gap = 8 * SIGMALink.scaleFactor;
            this._hLayout.horizontalAlign = feathers.layout.VerticalLayout.HORIZONTAL_ALIGN_LEFT;
            this._hLayout.verticalAlign = feathers.layout.VerticalLayout.VERTICAL_ALIGN_MIDDLE;
            this._leftValuesGroup = new feathers.controls.LayoutGroup();
            this._leftValuesGroup.layout = this._hLayout;
            this._leftValuesGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, PADDING, customPadding);
            this._group.addChild(this._leftValuesGroup);
            this._hLayout = new feathers.layout.HorizontalLayout();
            this._hLayout.gap = 8 * SIGMALink.scaleFactor;
            this._hLayout.horizontalAlign = feathers.layout.VerticalLayout.HORIZONTAL_ALIGN_RIGHT;
            this._hLayout.verticalAlign = feathers.layout.VerticalLayout.VERTICAL_ALIGN_MIDDLE;
            this._rightValuesGroup = new feathers.controls.LayoutGroup();
            this._rightValuesGroup.layout = this._hLayout;
            this._rightValuesGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING, PADDING, NaN);
            this._group.addChild(this._rightValuesGroup);
            this._imageDistance = new frontend.components.TextureImage();
            this._imageDistance.textureName = frontend.Textures.streckesmall;
            this._imageDistance.touchable = false;
            this._leftValuesGroup.addChild(this._imageDistance);
            this._labelDistance = new feathers.controls.Label();
            this._labelDistance.width = VALUE_WIDTH;
            this._labelDistance.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._leftValuesGroup.addChild(this._labelDistance);
            this._labelDistanceUnit = new feathers.controls.Label();
            this._labelDistanceUnit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._leftValuesGroup.addChild(this._labelDistanceUnit);
            this._labelAltitude = new feathers.controls.Label();
            this._labelAltitude.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            this._rightValuesGroup.addChild(this._labelAltitude);
            this._bottomLine = new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(this._bottomLine);
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            var loc1:*=this.track();
            if (!loc1) 
            {
                return;
            }
            this._name.text = loc1.trackName;
            this._name.invalidate(INVALIDATION_FLAG_SIZE);
            this._name.validate();
            this._labelDistance.text = loc1.distanceFormatted;
            this._labelDistance.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistance.validate();
            this._labelDistanceUnit.text = backend.utils.DataUtils.unitStringDistance;
            this._labelDistanceUnit.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelDistanceUnit.validate();
            this._labelAltitude.text = loc1.distanceToTrackFormatted + " " + backend.utils.DataUtils.unitStringDistance + " " + this._distanceToTrackPostfix;
            this._labelAltitude.invalidate(INVALIDATION_FLAG_SIZE);
            this._labelAltitude.validate();
            this._bottomLine.y = height - this._bottomLine.height;
            this._maxLabelWidth = this._group.width - customPadding - customPadding;
            this._name.width = this._maxLabelWidth;
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

        internal function track():frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult
        {
            if (data is frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult) 
            {
                return data as frontend.screen.tracks.tabs.gpsies.GPSiesSearchResult;
            }
            return null;
        }

        
        {
            OPTION_GROUP_WIDTH = 65 * SIGMALink.scaleFactor;
            PADDING = 20 * SIGMALink.scaleFactor;
            VALUE_WIDTH = 100 * SIGMALink.scaleFactor;
            customPadding = 17 * SIGMALink.scaleFactor;
        }

        internal var _bottomLine:starling.display.Quad;

        internal var _distanceToTrackPostfix:String;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _hLayout:feathers.layout.HorizontalLayout;

        internal var _imageDistance:frontend.components.TextureImage;

        internal var _labelAltitude:feathers.controls.Label;

        internal var _labelAltitudeUnit:feathers.controls.Label;

        internal var _labelDistance:feathers.controls.Label;

        internal var _labelDistanceUnit:feathers.controls.Label;

        internal var _leftValuesGroup:feathers.controls.LayoutGroup;

        internal var _maxLabelWidth:Number=0;

        internal var _name:feathers.controls.Label;

        internal var _rightValuesGroup:feathers.controls.LayoutGroup;

        internal static var OPTION_GROUP_WIDTH:Number;

        internal static var PADDING:Number;

        internal static var VALUE_WIDTH:Number;

        internal static var customPadding:Number;
    }
}


