//class ActivityPhasesTabView
package frontend.screen.activities.tabs.phases 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import core.activities.*;
    import core.general.*;
    import core.marker.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
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
    import frontend.components.list.*;
    import frontend.components.tab.*;
    import frontend.components.tabbarbase.*;
    import frontend.screen.activities.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.sort.*;
    
    use namespace mx_internal;
    
    public class ActivityPhasesTabView extends frontend.components.tabbarbase.TabLayoutGroup implements feathers.binding.IBindingClient
    {
        public function ActivityPhasesTabView()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._1399580807listDataProvider = new feathers.data.HierarchicalCollection();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ActivityPhasesTabView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_tabs_phases_ActivityPhasesTabViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.activities.tabs.phases.ActivityPhasesTabView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.layout = this._ActivityPhasesTabView_AnchorLayout1_c();
            this.mxmlContent = [this._ActivityPhasesTabView_CustomGroupedList1_i(), this._ActivityPhasesTabView_LayoutGroup1_i()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set phaselist(arg1:frontend.components.list.CustomGroupedList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._425294695phaselist;
            if (loc1 !== arg1) 
            {
                this._425294695phaselist = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "phaselist", loc1, arg1, this);
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

        internal function get listDataProvider():feathers.data.HierarchicalCollection
        {
            return this._1399580807listDataProvider;
        }

        internal function set listDataProvider(arg1:feathers.data.HierarchicalCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1399580807listDataProvider;
            if (loc1 !== arg1) 
            {
                this._1399580807listDataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "listDataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
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

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.activities.tabs.phases.ActivityPhasesTabView._watcherSetupUtil = arg1;
            return;
        }

        internal function itemRenderer():feathers.controls.renderers.IGroupedListItemRenderer
        {
            return new frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer();
        }

        internal function footerRendererFactory():feathers.controls.renderers.IGroupedListHeaderOrFooterRenderer
        {
            return new frontend.screen.activities.tabs.phases.ActivityPhaseFooterRenderer();
        }

        public override function showContent():void
        {
            var loc2:*=0;
            var loc4:*=null;
            this.listDataProvider = new feathers.data.HierarchicalCollection();
            var loc1:*=(this.data as core.activities.Activity).markerList;
            loc1.sort(this.sortOnTimeAbsolute);
            var loc3:*=loc1.length;
            var loc5:*=new frontend.screen.activities.tabs.phases.ActivityPhaseListGroup();
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = loc1[loc2];
                if (!(loc4.type == core.general.MarkerType.LAP) && !(loc4.type == core.general.MarkerType.PAUSE) && !(loc4.type == core.general.MarkerType.AUTO_LAP)) 
                {
                    loc5 = new frontend.screen.activities.tabs.phases.ActivityPhaseListGroup();
                    this.listDataProvider.addItemAt(loc5, (this.listDataProvider.data as Array).length);
                    loc5.addItem(loc4);
                }
                ++loc2;
            }
            if (this.phaselist.dataProvider == null) 
            {
                this.phaselist.dataProvider = this.listDataProvider;
            }
            return;
        }

        internal function sortOnTimeAbsolute(arg1:core.marker.Marker, arg2:core.marker.Marker):Number
        {
            return utils.sort.SortUtil.sortOnNumber(arg1, arg2, core.marker.MarkerMapper.col_timeAbsolute, false);
        }

        public override function hideContent():void
        {
            this.listDataProvider = new feathers.data.HierarchicalCollection();
            return;
        }

        internal function _ActivityPhasesTabView_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityPhasesTabView_CustomGroupedList1_i():frontend.components.list.CustomGroupedList
        {
            var loc1:*=new frontend.components.list.CustomGroupedList();
            loc1.headerRendererFactory = null;
            loc1.stickyHeader = false;
            loc1.id = "phaselist";
            this.phaselist = loc1;
            feathers.binding.BindingManager.executeBindings(this, "phaselist", this.phaselist);
            return loc1;
        }

        internal function _ActivityPhasesTabView_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityPhasesTabView_AnchorLayout2_c();
            loc1.mxmlContent = [this._ActivityPhasesTabView_Label1_i(), this._ActivityPhasesTabView_Label2_i(), this._ActivityPhasesTabView_Label3_i()];
            loc1.id = "tableHeader";
            this.tableHeader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "tableHeader", this.tableHeader);
            return loc1;
        }

        internal function _ActivityPhasesTabView_AnchorLayout2_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityPhasesTabView_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = false;
            loc1.id = "_ActivityPhasesTabView_Label1";
            this._ActivityPhasesTabView_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityPhasesTabView_Label1", this._ActivityPhasesTabView_Label1);
            return loc1;
        }

        internal function _ActivityPhasesTabView_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = false;
            loc1.id = "_ActivityPhasesTabView_Label2";
            this._ActivityPhasesTabView_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityPhasesTabView_Label2", this._ActivityPhasesTabView_Label2);
            return loc1;
        }

        internal function _ActivityPhasesTabView_Label3_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = false;
            loc1.id = "_ActivityPhasesTabView_Label3";
            this._ActivityPhasesTabView_Label3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityPhasesTabView_Label3", this._ActivityPhasesTabView_Label3);
            return loc1;
        }

        internal function _ActivityPhasesTabView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.phasenicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.icon")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITIES.TABS.PHASES.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.label")
            result[2] = new feathers.binding.Binding(this, function ():Function
            {
                return footerRendererFactory;
            }, null, "phaselist.footerRendererFactory")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - frontend.components.tab.TabContainer.TAB_HEIGHT - frontend.screen.activities.ActivityView.SPORT_ROW_HEIGHT - PADDING_TOP - LIST_HEADER_HEIGHT;
            }, null, "phaselist.height")
            result[4] = new feathers.binding.Binding(this, function ():Function
            {
                return itemRenderer;
            }, null, "phaselist.itemRendererFactory")
            result[5] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(PADDING_TOP + LIST_HEADER_HEIGHT);
            }, null, "phaselist.layoutData")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "phaselist.width")
            result[7] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.DARKFONT);
            }, null, "tableHeader.backgroundSkin")
            result[8] = new feathers.binding.Binding(this, function ():Number
            {
                return LIST_HEADER_HEIGHT;
            }, null, "tableHeader.height")
            result[9] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(PADDING_TOP);
            }, null, "tableHeader.layoutData")
            result[10] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "tableHeader.width")
            result[11] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_PADDING, NaN, 0);
            }, null, "_ActivityPhasesTabView_Label1.layoutData")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label1.styleName")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITY_PHASE_DURATION") + " [" + backend.utils.DataUtils.unitStringTimeHours + "]";
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label1.text")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_WIDTH;
            }, null, "_ActivityPhasesTabView_Label1.width")
            result[15] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_PADDING + frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_WIDTH + frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_PADDING, NaN, NaN, NaN, 0);
            }, null, "_ActivityPhasesTabView_Label2.layoutData")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label2.styleName")
            result[17] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITY_PHASE_IN_ZONE") + " [" + backend.utils.DataUtils.unitStringTimeHours + "]";
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label2.text")
            result[18] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_WIDTH;
            }, null, "_ActivityPhasesTabView_Label2.width")
            result[19] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_PADDING, NaN, NaN, NaN, 0);
            }, null, "_ActivityPhasesTabView_Label3.layoutData")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label3.styleName")
            result[21] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITY_PHASE_HEARTRATE") + " [" + backend.utils.DataUtils.unitStringHeartrate + "]";
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityPhasesTabView_Label3.text")
            result[22] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.screen.activities.tabs.phases.ActivityPhaseItemRenderer.COL_WIDTH;
            }, null, "_ActivityPhasesTabView_Label3.width")
            return result;
        }

        public function get phaselist():frontend.components.list.CustomGroupedList
        {
            return this._425294695phaselist;
        }

        internal static const LIST_HEADER_HEIGHT:Number=53 * SIGMALink.scaleFactor;

        internal static const PADDING_TOP:Number=0 * SIGMALink.scaleFactor;

        public var _ActivityPhasesTabView_Label1:feathers.controls.Label;

        public var _ActivityPhasesTabView_Label2:feathers.controls.Label;

        public var _ActivityPhasesTabView_Label3:feathers.controls.Label;

        internal var _425294695phaselist:frontend.components.list.CustomGroupedList;

        internal var _65701893tableHeader:feathers.controls.LayoutGroup;

        internal var _data:Object;

        internal var _1399580807listDataProvider:feathers.data.HierarchicalCollection;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


