//package locationEditorTabs
//  class TabDecimal
package frontend.screen.mydevices.pointNavigation.locationEditorTabs 
{
    import backend.utils.*;
    import core.general.*;
    import core.gps.*;
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.text.*;
    import frontend.components.menuList.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class TabDecimal extends frontend.components.tabbarbase.TabLayoutGroup
    {
        public function TabDecimal()
        {
            this.stageTextEditorFunc = function ():feathers.core.ITextEditor
            {
                var loc1:*=new feathers.controls.text.StageTextTextEditor();
                loc1.autoCorrect = false;
                loc1.multiline = false;
                loc1.minHeight = 30 * SIGMALink.scaleFactor;
                loc1.textAlign = "right";
                loc1.returnKeyLabel = flash.text.ReturnKeyLabel.NEXT;
                loc1.softKeyboardType = flash.text.SoftKeyboardType.NUMBER;
                return loc1;
            }
            super();
            return;
        }

        internal function onLonEnterPress(arg1:starling.events.Event):void
        {
            arg1.stopPropagation();
            this.lat.setFocus();
            return;
        }

        internal function onLatDEnterPress(arg1:starling.events.Event):void
        {
            arg1.stopPropagation();
            this.latM.setFocus();
            return;
        }

        internal function onLatMEnterPress(arg1:starling.events.Event):void
        {
            arg1.stopPropagation();
            this.latS.setFocus();
            return;
        }

        internal function onLatSEnterPress(arg1:starling.events.Event):void
        {
            arg1.stopPropagation();
            this.lonD.setFocus();
            return;
        }

        internal function onLonDEnterPress(arg1:starling.events.Event):void
        {
            arg1.stopPropagation();
            this.lonM.setFocus();
            return;
        }

        internal function onLonMEnterPress(arg1:starling.events.Event):void
        {
            arg1.stopPropagation();
            this.lonS.setFocus();
            return;
        }

        public function get point():core.gps.LatLon
        {
            return this._point;
        }

        public function set point(arg1:core.gps.LatLon):void
        {
            this._point = arg1;
            this._dms = this._point.getDegreesToDegreesMinutesSeconds();
            return;
        }

        internal function onLonSEnterPress(arg1:starling.events.Event):void
        {
            arg1.stopPropagation();
            this.latD.setFocus();
            return;
        }

        public function createLayout():void
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            this.createComponents();
            removeChildren();
            var loc1:*=new feathers.controls.Label();
            loc1.text = utils.LanguageManager.getString("POINT_NAVIGATION_LATITUDE_INPUT");
            loc1.width = this.containerWidth / 2;
            loc1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            var loc2:*=new feathers.controls.Label();
            loc2.text = utils.LanguageManager.getString("POINT_NAVIGATION_LONGITUDE_INPUT");
            loc2.width = this.containerWidth / 2;
            loc2.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            var loc3:*=new feathers.controls.LayoutGroup();
            loc3.width = this.containerWidth;
            loc3.layout = this.hl;
            loc3.addChild(loc1);
            var loc4:*=new feathers.controls.LayoutGroup();
            loc4.width = this.containerWidth;
            loc4.layout = this.hl;
            loc4.addChild(loc2);
            if (this.currentMode != MODE_DECIMAL) 
            {
                loc3.addChild(this.latD);
                loc6 = new feathers.controls.Label();
                loc6.text = "° ";
                loc6.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                loc3.addChild(loc6);
                loc3.addChild(this.latM);
                loc7 = new feathers.controls.Label();
                loc7.text = "\' ";
                loc7.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                loc3.addChild(loc7);
                loc3.addChild(this.latS);
                loc8 = new feathers.controls.Label();
                loc8.text = "\"";
                loc8.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                loc3.addChild(loc8);
                loc4.addChild(this.lonD);
                loc9 = new feathers.controls.Label();
                loc9.text = "° ";
                loc9.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                loc4.addChild(loc9);
                loc4.addChild(this.lonM);
                loc10 = new feathers.controls.Label();
                loc10.text = "\' ";
                loc10.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                loc4.addChild(loc10);
                loc4.addChild(this.lonS);
                loc11 = new feathers.controls.Label();
                loc11.text = "\"";
                loc11.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                loc4.addChild(loc11);
            }
            else 
            {
                loc3.addChild(this.lat);
                loc4.addChild(this.lon);
            }
            var loc5:*=new feathers.controls.LayoutGroup();
            loc5.layout = this.vl;
            loc5.addChild(loc3);
            loc5.addChild(loc4);
            addChild(loc5);
            this.updateInputs();
            return;
        }

        public function updateInputs():void
        {
            this.updateAllLatTexts();
            this.updateAllLonTexts();
            return;
        }

        internal function updateLatText():void
        {
            this.lat.text = backend.utils.DataUtils.latLonFormatter.format(this.point.latitude);
            return;
        }

        internal function updateLonText():void
        {
            this.lon.text = backend.utils.DataUtils.latLonFormatter.format(this.point.longitude);
            return;
        }

        internal function updateLatDText():void
        {
            this.latD.text = backend.utils.DataUtils.latLonDegreesFormatter.format(this._dms.latDegrees);
            return;
        }

        internal function updateLatMText():void
        {
            this.latM.text = backend.utils.DataUtils.latLonMinutesFormatter.format(this._dms.latMinutes);
            return;
        }

        internal function updateLatSText():void
        {
            this.latS.text = backend.utils.DataUtils.latLonSecondsFormatter.format(this._dms.latSeconds);
            return;
        }

        internal function updateLonDText():void
        {
            this.lonD.text = backend.utils.DataUtils.latLonDegreesFormatter.format(this._dms.lonDegrees);
            return;
        }

        internal function updateLonMText():void
        {
            this.lonM.text = backend.utils.DataUtils.latLonMinutesFormatter.format(this._dms.lonMinutes);
            return;
        }

        internal function updateLonSText():void
        {
            this.lonS.text = backend.utils.DataUtils.latLonSecondsFormatter.format(this._dms.lonSeconds);
            return;
        }

        internal function updateAllLatTexts():void
        {
            this.updateLatText();
            this.updateLatDText();
            this.updateLatMText();
            this.updateLatSText();
            return;
        }

        internal function updateAllLonTexts():void
        {
            this.updateLonText();
            this.updateLonDText();
            this.updateLonMText();
            this.updateLonSText();
            return;
        }

        internal function validateTextInput(arg1:feathers.controls.TextInput, arg2:Number, arg3:Number):Number
        {
            var loc1:*=parseFloat(arg1.text);
            loc1 = Math.max(arg2, loc1);
            loc1 = Math.min(loc1, arg3);
            return loc1;
        }

        internal function onLatChanged(arg1:starling.events.Event=null):void
        {
            var loc1:*=new core.gps.LatLon();
            loc1.latitude = this.validateTextInput(this.lat, this.latMin, this.latMax);
            loc1.longitude = this.point.longitude;
            this.point = loc1;
            if (this.pointChangedCallback != null) 
            {
                this.pointChangedCallback();
            }
            this.updateAllLatTexts();
            return;
        }

        internal function onLatEnterPress(arg1:starling.events.Event):void
        {
            arg1.stopPropagation();
            this.lon.setFocus();
            return;
        }

        internal function onLonChanged(arg1:starling.events.Event):void
        {
            var loc1:*=new core.gps.LatLon();
            loc1.latitude = this.point.latitude;
            loc1.longitude = this.validateTextInput(this.lon, this.lonMin, this.lonMax);
            this.point = loc1;
            if (this.pointChangedCallback != null) 
            {
                this.pointChangedCallback();
            }
            this.updateAllLonTexts();
            return;
        }

        internal function onLatDChanged(arg1:starling.events.Event):void
        {
            this._dms.latDegrees = this.validateTextInput(this.latD, this.latMin, this.latMax);
            var loc1:*=new core.gps.LatLon();
            loc1.setDegreesFromDegreesMinutesSeconds(this._dms);
            this.point = loc1;
            if (this.pointChangedCallback != null) 
            {
                this.pointChangedCallback();
            }
            this.updateAllLatTexts();
            return;
        }

        internal function onLatMChanged(arg1:starling.events.Event):void
        {
            this._dms.latMinutes = this.validateTextInput(this.latM, 0, 60);
            var loc1:*=new core.gps.LatLon();
            loc1.setDegreesFromDegreesMinutesSeconds(this._dms);
            this.point = loc1;
            if (this.pointChangedCallback != null) 
            {
                this.pointChangedCallback();
            }
            this.updateAllLatTexts();
            return;
        }

        internal function onLatSChanged(arg1:starling.events.Event):void
        {
            this._dms.latSeconds = this.validateTextInput(this.latS, 0, 60);
            var loc1:*=new core.gps.LatLon();
            loc1.setDegreesFromDegreesMinutesSeconds(this._dms);
            this.point = loc1;
            if (this.pointChangedCallback != null) 
            {
                this.pointChangedCallback();
            }
            this.updateAllLatTexts();
            return;
        }

        internal function onLonDChanged(arg1:starling.events.Event):void
        {
            this._dms.lonDegrees = this.validateTextInput(this.lonD, this.lonMin, this.lonMax);
            var loc1:*=new core.gps.LatLon();
            loc1.setDegreesFromDegreesMinutesSeconds(this._dms);
            this.point = loc1;
            if (this.pointChangedCallback != null) 
            {
                this.pointChangedCallback();
            }
            this.updateAllLonTexts();
            return;
        }

        internal function onLonMChanged(arg1:starling.events.Event):void
        {
            this._dms.lonMinutes = this.validateTextInput(this.lonM, 0, 60);
            var loc1:*=new core.gps.LatLon();
            loc1.setDegreesFromDegreesMinutesSeconds(this._dms);
            this.point = loc1;
            if (this.pointChangedCallback != null) 
            {
                this.pointChangedCallback();
            }
            this.updateAllLonTexts();
            return;
        }

        internal function onLonSChanged(arg1:starling.events.Event):void
        {
            this._dms.lonSeconds = this.validateTextInput(this.lonS, 0, 60);
            var loc1:*=new core.gps.LatLon();
            loc1.setDegreesFromDegreesMinutesSeconds(this._dms);
            this.point = loc1;
            if (this.pointChangedCallback != null) 
            {
                this.pointChangedCallback();
            }
            this.updateAllLonTexts();
            return;
        }

        internal function createComponents():void
        {
            if (!this._createComponentsFlag) 
            {
                return;
            }
            height = frontend.components.tab.TabContainer.TAB_HEIGHT + 2 * frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            this.padding = 16 * SIGMALink.scaleFactor;
            this.containerWidth = SIGMALink.appWidth - 2 * this.padding;
            this.hl = new feathers.layout.HorizontalLayout();
            this.hl.paddingRight = this.padding;
            this.hl.paddingLeft = this.padding;
            this.hl.gap = 2 * SIGMALink.scaleFactor;
            this.hl.verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            this.vl = new feathers.layout.VerticalLayout();
            this.vl.paddingTop = this.padding;
            this.vl.paddingBottom = this.padding;
            this.vl.gap = this.padding;
            this.input1Width = this.containerWidth / 2 - this.hl.gap;
            this.input3Width = this.containerWidth / 2 / 3 - this.padding - this.hl.gap;
            this.lat = new feathers.controls.TextInput();
            this.lat.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.onLatChanged);
            this.lat.addEventListener(feathers.events.FeathersEventType.ENTER, this.onLatEnterPress);
            this.lat.styleName = "TEXTINPUT";
            this.lat.width = this.input1Width;
            this.lat.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this.lat.backgroundFocusedSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.lat.alignPivot("right", "center");
            this.lat.textEditorFactory = this.stageTextEditorFunc;
            this.lon = new feathers.controls.TextInput();
            this.lon.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.onLonChanged);
            this.lon.addEventListener(feathers.events.FeathersEventType.ENTER, this.onLonEnterPress);
            this.lon.styleName = "TEXTINPUT";
            this.lon.width = this.input1Width;
            this.lon.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this.lon.backgroundFocusedSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.lon.alignPivot("right", "center");
            this.lon.textEditorFactory = this.stageTextEditorFunc;
            this.latD = new feathers.controls.TextInput();
            this.latD.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.onLatDChanged);
            this.latD.addEventListener(feathers.events.FeathersEventType.ENTER, this.onLatDEnterPress);
            this.latD.styleName = "TEXTINPUT";
            this.latD.width = this.input3Width;
            this.latD.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this.latD.backgroundFocusedSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.latD.alignPivot("right", "center");
            this.latD.textEditorFactory = this.stageTextEditorFunc;
            this.latM = new feathers.controls.TextInput();
            this.latM.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.onLatMChanged);
            this.latM.addEventListener(feathers.events.FeathersEventType.ENTER, this.onLatMEnterPress);
            this.latM.styleName = "TEXTINPUT";
            this.latM.width = this.input3Width;
            this.latM.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this.latM.backgroundFocusedSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.latM.alignPivot("right", "center");
            this.latM.textEditorFactory = this.stageTextEditorFunc;
            this.latS = new feathers.controls.TextInput();
            this.latS.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.onLatSChanged);
            this.latS.addEventListener(feathers.events.FeathersEventType.ENTER, this.onLatSEnterPress);
            this.latS.styleName = "TEXTINPUT";
            this.latS.width = this.input3Width;
            this.latS.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this.latS.backgroundFocusedSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.latS.alignPivot("right", "center");
            this.latS.textEditorFactory = this.stageTextEditorFunc;
            this.lonD = new feathers.controls.TextInput();
            this.lonD.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.onLonDChanged);
            this.lonD.addEventListener(feathers.events.FeathersEventType.ENTER, this.onLonDEnterPress);
            this.lonD.styleName = "TEXTINPUT";
            this.lonD.width = this.input3Width;
            this.lonD.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this.lonD.backgroundFocusedSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.lonD.alignPivot("right", "center");
            this.lonD.textEditorFactory = this.stageTextEditorFunc;
            this.lonM = new feathers.controls.TextInput();
            this.lonM.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.onLonMChanged);
            this.lonM.addEventListener(feathers.events.FeathersEventType.ENTER, this.onLonMEnterPress);
            this.lonM.styleName = "TEXTINPUT";
            this.lonM.width = this.input3Width;
            this.lonM.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this.lonM.backgroundFocusedSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.lonM.alignPivot("right", "center");
            this.lonM.textEditorFactory = this.stageTextEditorFunc;
            this.lonS = new feathers.controls.TextInput();
            this.lonS.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.onLonSChanged);
            this.lonS.addEventListener(feathers.events.FeathersEventType.ENTER, this.onLonSEnterPress);
            this.lonS.styleName = "TEXTINPUT";
            this.lonS.width = this.input3Width;
            this.lonS.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this.lonS.backgroundFocusedSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.lonS.alignPivot("right", "center");
            this.lonS.textEditorFactory = this.stageTextEditorFunc;
            this._createComponentsFlag = false;
            return;
        }

        internal const latMax:Number=90;

        internal const latMin:Number=-90;

        internal const lonMax:Number=180;

        internal const lonMin:Number=-180;

        public static const MODE_DECIMAL:String="modeDecimal";

        public static const MODE_DEGREES_MINUTES_SECONDS:String="modeDegreesMinutesSeconds";

        public var converter:utils.converter.IConverter;

        public var currentMode:String="modeDecimal";

        public var formatter:utils.interfaces.ICustomFormatterBase;

        public var maximum:Number;

        public var minimum:Number;

        internal var _point:core.gps.LatLon;

        public var pointChangedCallback:Function;

        internal var _createComponentsFlag:Boolean=true;

        internal var _dms:core.gps.DdMS;

        internal var backConverter:utils.converter.IConverter;

        internal var containerWidth:Number;

        internal var hl:feathers.layout.HorizontalLayout;

        internal var input1Width:Number;

        internal var input3Width:Number;

        internal var lat:feathers.controls.TextInput;

        internal var latD:feathers.controls.TextInput;

        internal var latM:feathers.controls.TextInput;

        internal var latS:feathers.controls.TextInput;

        internal var lon:feathers.controls.TextInput;

        internal var lonM:feathers.controls.TextInput;

        internal var lonS:feathers.controls.TextInput;

        internal var padding:Number;

        internal var stageTextEditorFunc:Function;

        internal var vl:feathers.layout.VerticalLayout;

        internal var lonD:feathers.controls.TextInput;
    }
}


