//class PossibleDevicesList
package frontend.screen.mydevices.components 
{
    import backend.utils.dataprovider.*;
    import core.general.*;
    import core.units.*;
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
    import frontend.components.list.*;
    import frontend.screen.mydevices.list.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.dataprovider.*;
    
    use namespace mx_internal;
    
    public class PossibleDevicesList extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function PossibleDevicesList()
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
            bindings = this._PossibleDevicesList_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_components_PossibleDevicesListWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return PossibleDevicesList[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._PossibleDevicesList_CustomList1_i()];
            this.addEventListener("addedToStage", this.___PossibleDevicesList_LayoutGroup1_addedToStage);
            this.addEventListener("initialize", this.___PossibleDevicesList_LayoutGroup1_initialize);
            this.addEventListener("removedFromStage", this.___PossibleDevicesList_LayoutGroup1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public override function set height(arg1:Number):void
        {
            super.height = arg1;
            this.possibleDeviceList.height = arg1;
            return;
        }

        internal function onRemovedFromStage(arg1:starling.events.Event):void
        {
            if (this._noResult && contains(this._noResult)) 
            {
                removeChild(this._noResult);
            }
            return;
        }

        internal function itemRenderer():feathers.controls.renderers.IListItemRenderer
        {
            return new frontend.screen.mydevices.list.PossibleDevicesRenderer();
        }

        internal function initializeHandler(arg1:starling.events.Event):void
        {
            this.listStateHandler = new frontend.components.list.ListStateHandler(this.possibleDeviceList);
            return;
        }

        protected function onAddetToStage(arg1:starling.events.Event):void
        {
            var loc2:*=null;
            var loc3:*=null;
            this._dataProvider = new feathers.data.ListCollection();
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < backend.utils.dataprovider.UnitsDataProvider.DATA_PROVIDER_ALL_DEVICES.length) 
            {
                loc2 = backend.utils.dataprovider.UnitsDataProvider.DATA_PROVIDER_ALL_DEVICES.getItemAt(loc1) as utils.dataprovider.UnitItemRendererData;
                this._dataProvider.push(new frontend.screen.mydevices.list.PossibleDevicesListItem(loc2.data as core.general.UnitType));
                ++loc1;
            }
            if (backend.utils.dataprovider.UnitsDataProvider.DATA_PROVIDER_ALL_DEVICES.length == 0) 
            {
                loc3 = utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_NO_COMMUNICATION_TITLE") + "\n\n";
                loc3 = loc3 + (utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_NO_COMMUNICATION_DESCRIPTION") + "\n\n\n");
                loc3 = loc3 + (utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_NO_USB") + "\n");
                loc3 = loc3 + (utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_NO_BLE") + "\n");
                loc3 = loc3 + utils.LanguageManager.getString("DEVICE_SELECTOR.INFOTEXT.DEVICE_NO_NFC");
                this._noResult = new feathers.controls.Label();
                this._noResult.padding = 17 * SIGMALink.scaleFactor;
                this._noResult.text = utils.LanguageManager.getString("LISTLOADER_DEFAULT_NORESULT_TEXT");
                this._noResult.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
                this._noResult.width = SIGMALink.appWidth;
                this._noResult.text = loc3;
                this._noResult.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_DASHBOARD_OPTION_TITLE;
                this._noResult.wordWrap = true;
                addChild(this._noResult);
            }
            return;
        }

        internal function triggeredHandler(arg1:starling.events.Event):void
        {
            if (this.listStateHandler.editState) 
            {
                return;
            }
            var loc1:*=(arg1.data as frontend.screen.mydevices.list.PossibleDevicesListItem).unitType;
            var loc2:*=core.units.UnitFactory.createUnitFromType(loc1);
            if (this.callBack != null) 
            {
                this.callBack(loc2);
            }
            return;
        }

        internal function _PossibleDevicesList_CustomList1_i():frontend.components.list.CustomList
        {
            var loc1:*=new frontend.components.list.CustomList();
            loc1.allowMultipleSelection = false;
            loc1.clipContent = true;
            loc1.addEventListener("triggered", this.__possibleDeviceList_triggered);
            loc1.id = "possibleDeviceList";
            this.possibleDeviceList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "possibleDeviceList", this.possibleDeviceList);
            return loc1;
        }

        public function __possibleDeviceList_triggered(arg1:starling.events.Event):void
        {
            this.triggeredHandler(arg1);
            return;
        }

        public function ___PossibleDevicesList_LayoutGroup1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddetToStage(arg1);
            return;
        }

        public function ___PossibleDevicesList_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.initializeHandler(arg1);
            return;
        }

        public function ___PossibleDevicesList_LayoutGroup1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _PossibleDevicesList_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "this.height")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            result[2] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "possibleDeviceList.backgroundSkin")
            result[3] = new feathers.binding.Binding(this, function ():feathers.data.ListCollection
            {
                return _dataProvider;
            }, null, "possibleDeviceList.dataProvider")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "possibleDeviceList.height")
            result[5] = new feathers.binding.Binding(this, function ():Function
            {
                return itemRenderer;
            }, null, "possibleDeviceList.itemRendererFactory")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "possibleDeviceList.width")
            return result;
        }

        public function get possibleDeviceList():frontend.components.list.CustomList
        {
            return this._1077679205possibleDeviceList;
        }

        public function set possibleDeviceList(arg1:frontend.components.list.CustomList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1077679205possibleDeviceList;
            if (loc1 !== arg1) 
            {
                this._1077679205possibleDeviceList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "possibleDeviceList", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _dataProvider():feathers.data.ListCollection
        {
            return this._1763739238_dataProvider;
        }

        internal function set _dataProvider(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1763739238_dataProvider;
            if (loc1 !== arg1) 
            {
                this._1763739238_dataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_dataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get listStateHandler():frontend.components.list.ListStateHandler
        {
            return this._873259721listStateHandler;
        }

        internal function set listStateHandler(arg1:frontend.components.list.ListStateHandler):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._873259721listStateHandler;
            if (loc1 !== arg1) 
            {
                this._873259721listStateHandler = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "listStateHandler", loc1, arg1, this);
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
            PossibleDevicesList._watcherSetupUtil = arg1;
            return;
        }

        internal var _1077679205possibleDeviceList:frontend.components.list.CustomList;

        public var callBack:Function;

        internal var _1763739238_dataProvider:feathers.data.ListCollection;

        internal var _noResult:feathers.controls.Label;

        internal var _873259721listStateHandler:frontend.components.list.ListStateHandler;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


