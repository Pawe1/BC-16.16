//package laps
//  class ActivityLapDetailsView
package frontend.screen.activities.tabs.laps 
{
    import backend.utils.*;
    import configCache.*;
    import core.general.*;
    import core.marker.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.scrollContainer.*;
    import frontend.components.tab.*;
    import frontend.screen.activities.*;
    import frontend.screen.activities.component.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.format.*;
    
    use namespace mx_internal;
    
    public class ActivityLapDetailsView extends frontend.components.scrollContainer.CustomVScrollContainer implements feathers.binding.IBindingClient
    {
        public function ActivityLapDetailsView()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ActivityLapDetailsView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_laps_ActivityLapDetailsViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.laps.ActivityLapDetailsView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._ActivityLapDetailsView_LayoutGroup1_i()];
            this.addEventListener("addedToStage", this.___ActivityLapDetailsView_CustomVScrollContainer1_addedToStage);
            this.addEventListener("removedFromStage", this.___ActivityLapDetailsView_CustomVScrollContainer1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function ___ActivityLapDetailsView_CustomVScrollContainer1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage();
            return;
        }

        internal function _ActivityLapDetailsView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - frontend.components.tab.TabContainer.TAB_HEIGHT;
            }, null, "this.height")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[2] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_ActivityLapDetailsView_LayoutGroup2.backgroundSkin")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 100;
            }, null, "_ActivityLapDetailsView_LayoutGroup2.height")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ActivityLapDetailsView_LayoutGroup2.width")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth * 0.5;
            }, null, "_ActivityLapDetailsView_LayoutGroup3.width")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_VerticalLayout1.paddingLeft")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_VerticalLayout1.paddingTop")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_LAP") + " " + lapCurrent + "/" + lapAmount;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_Label1.text")
            result[9] = new feathers.binding.Binding(this, null, null, "_ActivityLapDetailsView_Label2.text", "lapTypeLabel");
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth * 0.5;
            }, null, "_ActivityLapDetailsView_LayoutGroup4.width")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_HorizontalLayout2.gap")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_HorizontalLayout2.paddingRight")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.lefticon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_IconButton1.image")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.lefticonDisabled;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_IconButton1.imageDisabled")
            result[15] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _prevButtonEnabled;
            }, null, "_ActivityLapDetailsView_IconButton1.isEnabled")
            result[16] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_IconButton1.paddingLeft")
            result[17] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_IconButton1.paddingRight")
            result[18] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.righticon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_IconButton2.image")
            result[19] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.righticonDisabled;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityLapDetailsView_IconButton2.imageDisabled")
            result[20] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _nextButtonEnabled;
            }, null, "_ActivityLapDetailsView_IconButton2.isEnabled")
            result[21] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_IconButton2.paddingLeft")
            result[22] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.scaleFactor * 20;
            }, null, "_ActivityLapDetailsView_IconButton2.paddingRight")
            return result;
        }

        public function get vContainer():feathers.controls.LayoutGroup
        {
            return this._120745813vContainer;
        }

        public function set vContainer(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._120745813vContainer;
            if (loc1 !== arg1) 
            {
                this._120745813vContainer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "vContainer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get lapCurrent():uint
        {
            return this._1439809374lapCurrent;
        }

        public function set lapCurrent(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1439809374lapCurrent;
            if (loc1 !== arg1) 
            {
                this._1439809374lapCurrent = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "lapCurrent", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get lapTypeLabel():String
        {
            return this._520982655lapTypeLabel;
        }

        internal function _ActivityLapDetailsView_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapDetailsView_VerticalLayout1_i();
            loc1.mxmlContent = [this._ActivityLapDetailsView_Label1_i(), this._ActivityLapDetailsView_Label2_i()];
            loc1.id = "_ActivityLapDetailsView_LayoutGroup3";
            this._ActivityLapDetailsView_LayoutGroup3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_LayoutGroup3", this._ActivityLapDetailsView_LayoutGroup3);
            return loc1;
        }

        public function set lapTypeLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._520982655lapTypeLabel;
            if (loc1 !== arg1) 
            {
                this._520982655lapTypeLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "lapTypeLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set markerList(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.markerList;
            if (loc1 !== arg1) 
            {
                this._1115163640markerList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "markerList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _nextButtonEnabled():Boolean
        {
            return this._731648253_nextButtonEnabled;
        }

        internal function get _prevButtonEnabled():Boolean
        {
            return this._1506460093_prevButtonEnabled;
        }

        internal function set _prevButtonEnabled(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1506460093_prevButtonEnabled;
            if (loc1 !== arg1) 
            {
                this._1506460093_prevButtonEnabled = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_prevButtonEnabled", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get markerList():feathers.data.ListCollection
        {
            return this._markerList;
        }

        internal function set _1115163640markerList(arg1:feathers.data.ListCollection):void
        {
            this._markerList = arg1;
            this.lapAmount = this._markerList.length;
            return;
        }

        internal function get lapAmount():uint
        {
            return this._2096497197lapAmount;
        }

        internal function set lapAmount(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2096497197lapAmount;
            if (loc1 !== arg1) 
            {
                this._2096497197lapAmount = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "lapAmount", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.activities.tabs.laps.ActivityLapDetailsView._watcherSetupUtil = arg1;
            return;
        }

        internal function onSwitchToPreviousLapTouch():void
        {
            if (this.lapCurrent > 1) 
            {
                var loc1:*;
                var loc2:*=((loc1 = this).lapCurrent - 1);
                loc1.lapCurrent = loc2;
                this.onAddedToStage();
            }
            return;
        }

        internal function onSwitchToNextLapTouch():void
        {
            if (this.lapCurrent < this.lapAmount) 
            {
                var loc1:*;
                var loc2:*=((loc1 = this).lapCurrent + 1);
                loc1.lapCurrent = loc2;
                this.onAddedToStage();
            }
            return;
        }

        internal function checkButtonStates():void
        {
            this._prevButtonEnabled = this.lapCurrent > 1;
            this._nextButtonEnabled = this.lapCurrent < this.lapAmount;
            return;
        }

        internal function onAddedToStage():void
        {
            this.checkButtonStates();
            this.addValues();
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED, this.onSpeedFormatChanged);
            return;
        }

        internal function onRemovedFromStage():void
        {
            handler.ViewHandler.getInstance().removeEventListener(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED, this.onSpeedFormatChanged);
            return;
        }

        internal function onSpeedFormatChanged(arg1:starling.events.Event):void
        {
            this.addValues();
            return;
        }

        internal function addValues(arg1:starling.events.Event=null):void
        {
            var loc2:*=null;
            var loc1:*=this.markerList.getItemAt((this.lapCurrent - 1)) as core.marker.Marker;
            if (!loc1) 
            {
                return;
            }
            var loc4:*=loc1.type;
            switch (loc4) 
            {
                case core.general.MarkerType.LAP:
                {
                    this.lapTypeLabel = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_MANUAL_LAP");
                    break;
                }
                case core.general.MarkerType.AUTO_LAP:
                {
                    this.lapTypeLabel = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_AUTO_LAP");
                    break;
                }
                default:
                {
                    this.lapTypeLabel = "";
                }
            }
            if (this.vContainer.numChildren > 0) 
            {
                this.vContainer.removeChildren(1);
            }
            var loc3:*=100 * SIGMALink.scaleFactor;
            loc2 = new frontend.screen.activities.component.ActivityValueComp();
            loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
            loc2.ROW_HEIGHT = ROW_HEIGHT;
            loc2.iconSource = frontend.Textures.laengstezeit;
            loc2.iconText = "ACTIVIY_TAB_LAPS_DETAILS_LAPTIME";
            loc2.setValue(loc1.time, null, backend.utils.DataUtils.timeFormatter);
            loc2.unit = backend.utils.DataUtils.unitStringTimeHours;
            this.vContainer.addChild(loc2);
            loc3 = loc3 + ROW_HEIGHT;
            loc3 = loc3 + this.addHLine(loc3);
            loc2 = new frontend.screen.activities.component.ActivityValueComp();
            loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
            loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
            loc2.iconText = "ACTIVIY_TAB_LAPS_DETAILS_FROM_START";
            loc2.setValue(loc1.timeAbsolute, null, backend.utils.DataUtils.timeFormatter);
            loc2.unit = backend.utils.DataUtils.unitStringTimeHours;
            this.vContainer.addChild(loc2);
            loc3 = loc3 + SUB_ROW_HEIGHT;
            loc3 = loc3 + this.addHLine(loc3, true);
            if (loc1.distanceDefined) 
            {
                loc2 = new frontend.screen.activities.component.ActivityValueComp();
                loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                loc2.ROW_HEIGHT = ROW_HEIGHT;
                loc2.iconSource = frontend.Textures.strecke;
                loc2.iconTextTranslated = backend.utils.DataUtils.distanceLabel;
                loc2.setValue(loc1.distance, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                loc2.unit = backend.utils.DataUtils.unitStringDistance;
                this.vContainer.addChild(loc2);
                loc3 = loc3 + ROW_HEIGHT;
                if (loc1.distanceAbsoluteDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_LAPS_DETAILS_FROM_START";
                    loc2.setValue(loc1.distanceAbsolute, backend.utils.DataUtils.distanceConverter, backend.utils.DataUtils.distanceFormatter);
                    loc2.unit = backend.utils.DataUtils.unitStringDistance;
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                loc3 = loc3 + this.addHLine(loc3, true);
            }
            if (loc1.averageSpeedDefined) 
            {
                loc2 = new frontend.screen.activities.component.ActivityValueComp();
                loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                loc2.ROW_HEIGHT = ROW_HEIGHT;
                loc2.speedBasedValue = loc1.averageSpeed;
                loc2.iconSource = frontend.Textures.IconSpeed;
                loc2.iconTextTranslated = backend.utils.DataUtils.speedLabel;
                loc2.valueIconSource = frontend.Textures.averageiconmini;
                loc2.clickCallback = this.swapSpeedFormat;
                this.updateSpeedBasedObjects(loc2);
                this.vContainer.addChild(loc2);
                loc3 = loc3 + ROW_HEIGHT;
                if (loc1.minimumSpeedDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_VALUES_MIN";
                    loc2.speedBasedValue = loc1.minimumSpeed;
                    loc2.clickCallback = this.swapSpeedFormat;
                    this.updateSpeedBasedObjects(loc2);
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                if (loc1.maximumSpeedDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_VALUES_MAX";
                    loc2.speedBasedValue = loc1.maximumSpeed;
                    loc2.clickCallback = this.swapSpeedFormat;
                    this.updateSpeedBasedObjects(loc2);
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                loc3 = loc3 + this.addHLine(loc3, true);
            }
            if (loc1.averageHeartrateDefined) 
            {
                loc2 = new frontend.screen.activities.component.ActivityValueComp();
                loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                loc2.ROW_HEIGHT = ROW_HEIGHT;
                loc2.iconSource = frontend.Textures.heartrateicon;
                loc2.iconTextTranslated = backend.utils.DataUtils.heartrateLabel;
                loc2.setValue(loc1.averageHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                loc2.unit = backend.utils.DataUtils.unitStringHeartrate;
                loc2.valueIconSource = frontend.Textures.averageiconmini;
                this.vContainer.addChild(loc2);
                loc3 = loc3 + ROW_HEIGHT;
                if (loc1.minimumHeartrateDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_VALUES_MIN";
                    loc2.setValue(loc1.minimumHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                    loc2.unit = backend.utils.DataUtils.unitStringHeartrate;
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                if (loc1.maximumHeartrateDefined) 
                {
                    loc3 = loc3 + this.addHLine(loc3);
                    loc2 = new frontend.screen.activities.component.ActivityValueComp();
                    loc2.layoutData = new feathers.layout.AnchorLayoutData(loc3);
                    loc2.ROW_HEIGHT = SUB_ROW_HEIGHT;
                    loc2.iconText = "ACTIVIY_TAB_VALUES_MAX";
                    loc2.setValue(loc1.maximumHeartrate, null, backend.utils.DataUtils.heartrateFormatter);
                    loc2.unit = backend.utils.DataUtils.unitStringHeartrate;
                    this.vContainer.addChild(loc2);
                    loc3 = loc3 + SUB_ROW_HEIGHT;
                }
                loc3 = loc3 + this.addHLine(loc3, true);
            }
            return;
        }

        internal function updateSpeedBasedObjects(arg1:frontend.screen.activities.component.ActivityValueComp):void
        {
            var loc3:*=NaN;
            var loc1:*=this.markerList.getItemAt((this.lapCurrent - 1)) as core.marker.Marker;
            var loc2:*=configCache.ConfigCache.getInstance().getSportSpeedFormatValue(loc1.logReference.sport);
            if (loc2 != utils.format.SpeedFormat.DISTANCE_PER_TIME) 
            {
                loc3 = utils.Calculations.calculateSpeedTime(arg1.speedBasedValue);
                if (loc3 != utils.Calculations.speedTimeMaximum()) 
                {
                    arg1.setValue(loc3 * 100, null, backend.utils.DataUtils.timeFormatter_MM_SS);
                }
                else 
                {
                    arg1.value = "--:--";
                }
                arg1.unit = backend.utils.DataUtils.unitStringSpeedTime;
            }
            else 
            {
                arg1.setValue(arg1.speedBasedValue, backend.utils.DataUtils.speedConverter, backend.utils.DataUtils.speedFormatter);
                arg1.unit = backend.utils.DataUtils.unitStringSpeed;
            }
            return;
        }

        internal function addHLine(arg1:Number, arg2:Boolean=false):Number
        {
            var loc1:*=arg2 ? 30 : 3;
            var loc2:*=new starling.display.Quad(SIGMALink.appWidth, loc1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            loc2.y = arg1;
            this.vContainer.addChild(loc2);
            return loc1;
        }

        internal function swapSpeedFormat():void
        {
            var loc1:*=this.markerList.getItemAt((this.lapCurrent - 1)) as core.marker.Marker;
            var loc2:*=configCache.ConfigCache.getInstance().getSportSpeedFormatValue(loc1.logReference.sport);
            loc2 = loc2 != utils.format.SpeedFormat.DISTANCE_PER_TIME ? utils.format.SpeedFormat.DISTANCE_PER_TIME : utils.format.SpeedFormat.TIME_PER_DISTANCE;
            configCache.ConfigCache.getInstance().setSportSpeedFormatValue(loc1.logReference.sport, loc2);
            handler.ViewHandler.getInstance().dispatchEventWith(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED);
            return;
        }

        internal function _ActivityLapDetailsView_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapDetailsView_AnchorLayout1_c();
            loc1.mxmlContent = [this._ActivityLapDetailsView_LayoutGroup2_i()];
            loc1.id = "vContainer";
            this.vContainer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "vContainer", this.vContainer);
            return loc1;
        }

        internal function _ActivityLapDetailsView_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityLapDetailsView_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapDetailsView_HorizontalLayout1_c();
            loc1.mxmlContent = [this._ActivityLapDetailsView_LayoutGroup3_i(), this._ActivityLapDetailsView_LayoutGroup4_i()];
            loc1.id = "_ActivityLapDetailsView_LayoutGroup2";
            this._ActivityLapDetailsView_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_LayoutGroup2", this._ActivityLapDetailsView_LayoutGroup2);
            return loc1;
        }

        internal function _ActivityLapDetailsView_HorizontalLayout1_c():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.verticalAlign = "middle";
            return loc1;
        }

        internal function set _nextButtonEnabled(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._731648253_nextButtonEnabled;
            if (loc1 !== arg1) 
            {
                this._731648253_nextButtonEnabled = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_nextButtonEnabled", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _ActivityLapDetailsView_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.horizontalAlign = "left";
            loc1.verticalAlign = "middle";
            this._ActivityLapDetailsView_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_VerticalLayout1", this._ActivityLapDetailsView_VerticalLayout1);
            return loc1;
        }

        internal function _ActivityLapDetailsView_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.styleName = "BIGLISTLABEL";
            loc1.id = "_ActivityLapDetailsView_Label1";
            this._ActivityLapDetailsView_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_Label1", this._ActivityLapDetailsView_Label1);
            return loc1;
        }

        internal function _ActivityLapDetailsView_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.styleName = "SMALLLISTLABEL";
            loc1.id = "_ActivityLapDetailsView_Label2";
            this._ActivityLapDetailsView_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_Label2", this._ActivityLapDetailsView_Label2);
            return loc1;
        }

        internal function _ActivityLapDetailsView_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapDetailsView_HorizontalLayout2_i();
            loc1.mxmlContent = [this._ActivityLapDetailsView_IconButton1_i(), this._ActivityLapDetailsView_IconButton2_i()];
            loc1.id = "_ActivityLapDetailsView_LayoutGroup4";
            this._ActivityLapDetailsView_LayoutGroup4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_LayoutGroup4", this._ActivityLapDetailsView_LayoutGroup4);
            return loc1;
        }

        internal function _ActivityLapDetailsView_HorizontalLayout2_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.horizontalAlign = "right";
            loc1.verticalAlign = "middle";
            this._ActivityLapDetailsView_HorizontalLayout2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_HorizontalLayout2", this._ActivityLapDetailsView_HorizontalLayout2);
            return loc1;
        }

        internal function _ActivityLapDetailsView_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.addEventListener("triggered", this.___ActivityLapDetailsView_IconButton1_triggered);
            loc1.id = "_ActivityLapDetailsView_IconButton1";
            this._ActivityLapDetailsView_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_IconButton1", this._ActivityLapDetailsView_IconButton1);
            return loc1;
        }

        public function ___ActivityLapDetailsView_IconButton1_triggered(arg1:starling.events.Event):void
        {
            this.onSwitchToPreviousLapTouch();
            return;
        }

        internal function _ActivityLapDetailsView_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.addEventListener("triggered", this.___ActivityLapDetailsView_IconButton2_triggered);
            loc1.id = "_ActivityLapDetailsView_IconButton2";
            this._ActivityLapDetailsView_IconButton2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityLapDetailsView_IconButton2", this._ActivityLapDetailsView_IconButton2);
            return loc1;
        }

        public function ___ActivityLapDetailsView_IconButton2_triggered(arg1:starling.events.Event):void
        {
            this.onSwitchToNextLapTouch();
            return;
        }

        public function ___ActivityLapDetailsView_CustomVScrollContainer1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage();
            return;
        }

        internal static const ROW_HEIGHT:Number=80 * SIGMALink.scaleFactor;

        internal static const SUB_ROW_HEIGHT:Number=55 * SIGMALink.scaleFactor;

        public var _ActivityLapDetailsView_HorizontalLayout2:feathers.layout.HorizontalLayout;

        public var _ActivityLapDetailsView_IconButton1:frontend.components.button.IconButton;

        public var _ActivityLapDetailsView_IconButton2:frontend.components.button.IconButton;

        public var _ActivityLapDetailsView_Label1:feathers.controls.Label;

        public var _ActivityLapDetailsView_Label2:feathers.controls.Label;

        public var _ActivityLapDetailsView_LayoutGroup2:feathers.controls.LayoutGroup;

        public var _ActivityLapDetailsView_LayoutGroup3:feathers.controls.LayoutGroup;

        public var _ActivityLapDetailsView_VerticalLayout1:feathers.layout.VerticalLayout;

        internal var _120745813vContainer:feathers.controls.LayoutGroup;

        internal var _1439809374lapCurrent:uint=0;

        internal var _520982655lapTypeLabel:String="";

        internal var _markerList:feathers.data.ListCollection;

        internal var _731648253_nextButtonEnabled:Boolean=true;

        internal var _1506460093_prevButtonEnabled:Boolean=true;

        internal var _2096497197lapAmount:uint;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        public var _ActivityLapDetailsView_LayoutGroup4:feathers.controls.LayoutGroup;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


//  class ActivityLapItemListRenderer
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


//  class ActivityLapsTabView
package frontend.screen.activities.tabs.laps 
{
    import backend.utils.*;
    import configCache.*;
    import core.activities.*;
    import core.general.*;
    import core.marker.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.*;
    import frontend.components.scrollContainer.*;
    import frontend.components.tab.*;
    import frontend.components.tabbar.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.format.*;
    
    use namespace mx_internal;
    
    public class ActivityLapsTabView extends frontend.components.tabbarbase.TabLayoutScroller implements feathers.binding.IBindingClient
    {
        public function ActivityLapsTabView()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ActivityLapsTabView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_laps_ActivityLapsTabViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.laps.ActivityLapsTabView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.ignoreVScrollPolicySetting = true;
            this.verticalScrollPolicy = "off";
            this.layout = this._ActivityLapsTabView_AnchorLayout1_c();
            this.mxmlContent = [this._ActivityLapsTabView_TextTabBar1_i(), this._ActivityLapsTabView_LayoutGroup1_i()];
            this.addEventListener("initialize", this.___ActivityLapsTabView_TabLayoutScroller1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get tabbar():frontend.components.tabbar.TextTabBar
        {
            return this._881387426tabbar;
        }

        public function set tabbar(arg1:frontend.components.tabbar.TextTabBar):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._881387426tabbar;
            if (loc1 !== arg1) 
            {
                this._881387426tabbar = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tabbar", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get tableHeader():feathers.controls.LayoutGroup
        {
            return this._65701893tableHeader;
        }

        public function set tableHeader(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._65701893tableHeader;
            if (loc1 !== arg1) 
            {
                this._65701893tableHeader = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tableHeader", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set data(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.data;
            if (loc1 !== arg1) 
            {
                this._3076010data = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "data", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get autolLapsMarkerList():feathers.data.ListCollection
        {
            return this._1866457677autolLapsMarkerList;
        }

        public function get data():Object
        {
            return this._data;
        }

        internal function set _3076010data(arg1:Object):void
        {
            this._data = arg1 as core.activities.Activity;
            return;
        }

        internal function set autolLapsMarkerList(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1866457677autolLapsMarkerList;
            if (loc1 !== arg1) 
            {
                this._1866457677autolLapsMarkerList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "autolLapsMarkerList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get manualLapsMarkerList():feathers.data.ListCollection
        {
            return this._1445284426manualLapsMarkerList;
        }

        internal function set manualLapsMarkerList(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1445284426manualLapsMarkerList;
            if (loc1 !== arg1) 
            {
                this._1445284426manualLapsMarkerList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "manualLapsMarkerList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get tabBarDataProvider():feathers.data.ListCollection
        {
            return this._273520409tabBarDataProvider;
        }

        internal function set tabBarDataProvider(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._273520409tabBarDataProvider;
            if (loc1 !== arg1) 
            {
                this._273520409tabBarDataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tabBarDataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.activities.tabs.laps.ActivityLapsTabView._watcherSetupUtil = arg1;
            return;
        }

        protected function init(arg1:starling.events.Event):void
        {
            this._currentSelectedTab = configCache.ConfigCache.getInstance().getValue(SELECTED_MARKER_TAB, AUTO_LAPS);
            var loc1:*=frontend.screen.activities.tabs.laps.ActivityLapItemListRenderer.COL_WIDTH;
            var loc2:*=frontend.screen.activities.tabs.laps.ActivityLapItemListRenderer.COL_PADDING;
            var loc3:*=new feathers.controls.Label();
            loc3.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DISTANCE") + " [" + backend.utils.DataUtils.unitStringDistance + "]";
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc3.wordWrap = false;
            this.tableHeader.addChild(loc3);
            loc3.validate();
            loc3.width = loc1;
            loc3.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, loc2, NaN, 0);
            var loc4:*=new feathers.controls.Label();
            loc4.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_TIME") + " [" + backend.utils.DataUtils.unitStringTimeHours + "]";
            loc4.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc4.wordWrap = false;
            this.tableHeader.addChild(loc4);
            loc4.validate();
            loc4.width = loc1;
            loc4.layoutData = new feathers.layout.AnchorLayoutData(NaN, loc2 + loc1 + loc2, NaN, NaN, NaN, 0);
            this.speedLabel = new feathers.controls.Label();
            this.speedLabel.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_SPEED");
            this.speedLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            this.speedLabel.wordWrap = false;
            this.tableHeader.addChild(this.speedLabel);
            this.speedLabel.width = loc1;
            this.speedLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, loc2, NaN, NaN, NaN, 0);
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.EVENT_SPEED_FORMAT_CHANGED, this.onSpeedFormatChanged);
            return;
        }

        internal function onSpeedFormatChanged(arg1:starling.events.Event):void
        {
            this.showContent();
            return;
        }

        public override function showContent():void
        {
            var loc1:*=0;
            var loc2:*=null;
            this.manualLapsMarkerList = new feathers.data.ListCollection();
            this.autolLapsMarkerList = new feathers.data.ListCollection();
            if (configCache.ConfigCache.getInstance().getSportSpeedFormatValue(this._data.sport) != utils.format.SpeedFormat.DISTANCE_PER_TIME) 
            {
                this.speedLabel.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_SPEED") + " [" + backend.utils.DataUtils.unitStringSpeedTime + "]";
            }
            else 
            {
                this.speedLabel.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_SPEED") + " [" + backend.utils.DataUtils.unitStringSpeed + "]";
            }
            this.speedLabel.validate();
            var loc3:*=this._data.markerList.length;
            loc1 = 0;
            while (loc1 < loc3) 
            {
                loc2 = this._data.markerList[loc1];
                if (core.general.MarkerType.LAP != loc2.type) 
                {
                    if (core.general.MarkerType.AUTO_LAP == loc2.type) 
                    {
                        this.autolLapsMarkerList.addItem(loc2);
                    }
                }
                else 
                {
                    this.manualLapsMarkerList.addItem(loc2);
                }
                ++loc1;
            }
            var loc4:*=new feathers.data.ListCollection();
            if (this.autolLapsMarkerList.length > 0) 
            {
                loc4.push({"data":AUTO_LAPS, "label":utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_AUTO")});
            }
            else 
            {
                this._currentSelectedTab = MANUAL_LAPS;
                configCache.ConfigCache.getInstance().setValue(SELECTED_MARKER_TAB, MANUAL_LAPS);
            }
            loc4.push({"data":MANUAL_LAPS, "label":utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_MANUAL")});
            this.tabbar.dataProvider = loc4;
            this.tabbar.addEventListener(starling.events.Event.CHANGE, this.onTabeSelectionChange);
            this.validateDataProvider();
            return;
        }

        public override function hideContent():void
        {
            this.laplist.dataProvider = new feathers.data.ListCollection();
            return;
        }

        internal function onTabeSelectionChange(arg1:starling.events.Event):void
        {
            this._currentSelectedTab = (arg1.currentTarget as feathers.controls.TabBar).selectedItem.data;
            configCache.ConfigCache.getInstance().setValue(SELECTED_MARKER_TAB, this._currentSelectedTab);
            this.validateDataProvider();
            return;
        }

        internal function validateDataProvider():void
        {
            if (!this.autolLapsMarkerList || !this.manualLapsMarkerList) 
            {
                flash.utils.setTimeout(this.validateDataProvider, 100);
                return;
            }
            var loc1:*=this._currentSelectedTab;
            switch (loc1) 
            {
                case AUTO_LAPS:
                {
                    this.laplist.dataProvider = this.autolLapsMarkerList;
                    this.tabbar.selectedIndex = 0;
                    break;
                }
                case MANUAL_LAPS:
                {
                    this.laplist.dataProvider = this.manualLapsMarkerList;
                    this.tabbar.selectedIndex = (this.tabbar.dataProvider.length - 1);
                    break;
                }
            }
            return;
        }

        internal function onListTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.laplist.dataProvider.getItemAt(0) is core.marker.Marker && this.laplist.selectedIndex > -1) 
            {
                this.lapDetailsGroup = new frontend.screen.activities.tabs.laps.ActivityLapDetailsView();
                this.lapDetailsGroup.layoutData = new feathers.layout.AnchorLayoutData();
                this.lapDetailsGroup.lapCurrent = this.laplist.selectedIndex + 1;
                this.lapDetailsGroup.markerList = this.laplist.dataProvider;
                addChild(this.lapDetailsGroup);
                this.laplist.selectedItem = null;
                handler.ViewHandler.getInstance().addBackFunction(this.closeLapDetails);
            }
            return;
        }

        public function closeLapDetails():void
        {
            removeChild(this.lapDetailsGroup);
            this.lapDetailsGroup = null;
            return;
        }

        internal function _ActivityLapsTabView_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityLapsTabView_TextTabBar1_i():frontend.components.tabbar.TextTabBar
        {
            var loc1:*=new frontend.components.tabbar.TextTabBar();
            loc1.id = "tabbar";
            this.tabbar = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tabbar", this.tabbar);
            return loc1;
        }

        internal function _ActivityLapsTabView_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapsTabView_VerticalLayout1_c();
            loc1.mxmlContent = [this._ActivityLapsTabView_LayoutGroup2_i(), this._ActivityLapsTabView_CustomVScrollContainer1_i()];
            loc1.id = "tabVGroup";
            this.tabVGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tabVGroup", this.tabVGroup);
            return loc1;
        }

        internal function _ActivityLapsTabView_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            return loc1;
        }

        internal function _ActivityLapsTabView_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityLapsTabView_AnchorLayout2_c();
            loc1.id = "tableHeader";
            this.tableHeader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tableHeader", this.tableHeader);
            return loc1;
        }

        internal function _ActivityLapsTabView_AnchorLayout2_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityLapsTabView_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.clipContent = true;
            loc1.mxmlContent = [this._ActivityLapsTabView_List1_i()];
            loc1.id = "scrollContainer";
            this.scrollContainer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "scrollContainer", this.scrollContainer);
            return loc1;
        }

        internal function _ActivityLapsTabView_List1_i():feathers.controls.List
        {
            var loc1:*=new feathers.controls.List();
            loc1.addEventListener("touch", this.__laplist_touch);
            loc1.id = "laplist";
            this.laplist = loc1;
            feathers.binding.BindingManager.executeBindings(this, "laplist", this.laplist);
            return loc1;
        }

        public function __laplist_touch(arg1:starling.events.TouchEvent):void
        {
            this.onListTouch(arg1);
            return;
        }

        public function ___ActivityLapsTabView_TabLayoutScroller1_initialize(arg1:starling.events.Event):void
        {
            this.init(arg1);
            return;
        }

        internal function _ActivityLapsTabView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.uhr;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.icon")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIES.TABS.LAPS.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.tabbar.TextTabBar.SELECTED_HEIGHT;
            }, null, "tabbar.height")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(PADDING_TOP);
            }, null, "tabbar.layoutData")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tabbar.width")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - frontend.components.tabbar.TextTabBar.SELECTED_HEIGHT;
            }, null, "tabVGroup.height")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(PADDING_TOP + frontend.components.tabbar.TextTabBar.SELECTED_HEIGHT);
            }, null, "tabVGroup.layoutData")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tabVGroup.width")
            result[8] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.DARKFONT);
            }, null, "tableHeader.backgroundSkin")
            result[9] = new feathers.binding.Binding(this, function ():Number
            {
                return LIST_HEADER_HEIGHT;
            }, null, "tableHeader.height")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tableHeader.width")
            result[11] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - LIST_HEADER_HEIGHT;
            }, null, "scrollContainer.height")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "scrollContainer.width")
            result[13] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - LIST_HEADER_HEIGHT - frontend.components.tabbar.TextTabBar.SELECTED_HEIGHT;
            }, null, "laplist.height")
            result[14] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.activities.tabs.laps.ActivityLapItemListRenderer;
            }, null, "laplist.itemRendererType")
            result[15] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "laplist.width")
            return result;
        }

        public function get laplist():feathers.controls.List
        {
            return this._50066247laplist;
        }

        public function set laplist(arg1:feathers.controls.List):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._50066247laplist;
            if (loc1 !== arg1) 
            {
                this._50066247laplist = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "laplist", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get scrollContainer():frontend.components.scrollContainer.CustomVScrollContainer
        {
            return this._2128618444scrollContainer;
        }

        public function set scrollContainer(arg1:frontend.components.scrollContainer.CustomVScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2128618444scrollContainer;
            if (loc1 !== arg1) 
            {
                this._2128618444scrollContainer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "scrollContainer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get tabVGroup():feathers.controls.LayoutGroup
        {
            return this._1649788830tabVGroup;
        }

        public function set tabVGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1649788830tabVGroup;
            if (loc1 !== arg1) 
            {
                this._1649788830tabVGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "tabVGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal static const AUTO_LAPS:String="autoLaps";

        internal static const LIST_HEADER_HEIGHT:Number=53 * SIGMALink.scaleFactor;

        internal static const MANUAL_LAPS:String="manualLaps";

        internal static const PADDING_TOP:Number=0;

        internal static const SELECTED_MARKER_TAB:String="selectedMarkerTab";

        internal static const UNIT_WIDTH:Number=50 * SIGMALink.scaleFactor;

        internal var _50066247laplist:feathers.controls.List;

        internal var _2128618444scrollContainer:frontend.components.scrollContainer.CustomVScrollContainer;

        internal var _1649788830tabVGroup:feathers.controls.LayoutGroup;

        internal var _881387426tabbar:frontend.components.tabbar.TextTabBar;

        internal var _65701893tableHeader:feathers.controls.LayoutGroup;

        internal var _data:core.activities.Activity;

        internal var _currentSelectedTab:String="autoLaps";

        internal var _1866457677autolLapsMarkerList:feathers.data.ListCollection;

        internal var lapDetailsGroup:frontend.screen.activities.tabs.laps.ActivityLapDetailsView;

        internal var _1445284426manualLapsMarkerList:feathers.data.ListCollection;

        internal var speedLabel:feathers.controls.Label;

        internal var _273520409tabBarDataProvider:feathers.data.ListCollection;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


