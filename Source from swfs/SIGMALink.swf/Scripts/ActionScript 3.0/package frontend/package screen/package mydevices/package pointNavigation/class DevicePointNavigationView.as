//class DevicePointNavigationView
package frontend.screen.mydevices.pointNavigation 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.gps.*;
    import core.units.*;
    import debug.*;
    import feathers.binding.*;
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
    import frontend.components.*;
    import frontend.components.button.*;
    import frontend.components.map.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.custom.*;
    import frontend.components.popup.*;
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import service.openstreetmap.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class DevicePointNavigationView extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function DevicePointNavigationView()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._nameEditor = new frontend.components.menuList.MenuListItem();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._DevicePointNavigationView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_pointNavigation_DevicePointNavigationViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DevicePointNavigationView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._DevicePointNavigationView_MenuList1_i(), this._DevicePointNavigationView_MapView1_i(), this._DevicePointNavigationView_TextureImage1_i(), this._DevicePointNavigationView_TextureImage2_i(), this._DevicePointNavigationView_Footer1_i()];
            this.addEventListener("addedToStage", this.___DevicePointNavigationView_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___DevicePointNavigationView_CustomScreen1_initialize);
            this.addEventListener("removedFromStage", this.___DevicePointNavigationView_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function ___DevicePointNavigationView_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage(arg1);
            return;
        }

        public function ___DevicePointNavigationView_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        public function ___DevicePointNavigationView_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _DevicePointNavigationView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return EDITOR_HEIGHT;
            }, null, "editors.height")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "editors.width")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight - EDITOR_HEIGHT;
            }, null, "mapView.height")
            result[3] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(EDITOR_HEIGHT);
            }, null, "mapView.layoutData")
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "mapView.width")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.headerHeight + EDITOR_HEIGHT;
            }, null, "mapView.yStartCorrection")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.mapPointEditIcon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "fakeEditMarker.textureName")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.mapstopicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "fakeSavedMarker.textureName")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.uploadicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DevicePointNavigationView_IconButton1.image")
            result[9] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _pointSaved;
            }, null, "_DevicePointNavigationView_IconButton1.isEnabled")
            result[10] = new feathers.binding.Binding(this, function ():Function
            {
                return uploadToDevice;
            }, null, "_DevicePointNavigationView_IconButton1.touchHandler")
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.pointNaviEditIcon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DevicePointNavigationView_IconButton2.image")
            result[12] = new feathers.binding.Binding(this, function ():Function
            {
                return editLocation;
            }, null, "_DevicePointNavigationView_IconButton2.touchHandler")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.mapstopicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DevicePointNavigationView_IconButton3.image")
            result[14] = new feathers.binding.Binding(this, function ():Function
            {
                return saveNewLocation;
            }, null, "_DevicePointNavigationView_IconButton3.touchHandler")
            return result;
        }

        public function set fakeSavedMarker(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2022442764fakeSavedMarker;
            if (loc1 !== arg1) 
            {
                this._2022442764fakeSavedMarker = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "fakeSavedMarker", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get editors():frontend.components.menuList.MenuList
        {
            return this._1887957850editors;
        }

        public function set editors(arg1:frontend.components.menuList.MenuList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1887957850editors;
            if (loc1 !== arg1) 
            {
                this._1887957850editors = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "editors", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get fakeEditMarker():frontend.components.TextureImage
        {
            return this._849677337fakeEditMarker;
        }

        internal function onInit():void
        {
            this._saveNameObj = new frontend.components.menuList.MenuListDbObject();
            this._saveNameObj.keyField = "GUID";
            this._saveNameObj.updateModificationDate = true;
            this._saveNameObj.updateField = core.gps.PointNavigationMapper.col_text1;
            this._saveNameObj.table = core.gps.PointNavigationMapper.table_name;
            this._saveNameObj.completeCallback = this.onNameChanged;
            this._searchEditor = new frontend.components.menuList.editors.custom.SearchEditor();
            this._searchEditor.rawValue = "";
            this._searchEditor.maxChars = 100;
            this._searchEditor.title = utils.LanguageManager.getString("POINT_NAVIGATION_SEARCH_TITLE");
            this._searchEditor.addEventListener(frontend.components.menuList.editors.custom.SearchEditor.RESULT_SELECTED, this.onSearchResultSelected);
            this._searchEditor.addEventListener(frontend.components.menuList.editors.custom.SearchEditor.CLOSED, this.onSearchEditorClosed);
            this._gpsLocationEditor = new frontend.components.menuList.editors.custom.GPSLocationEditor();
            this._gpsLocationEditor.rawValue = "";
            this._gpsLocationEditor.title = utils.LanguageManager.getString("POINT_NAVIGATION_LOCATION_INPUT");
            this._gpsLocationEditor.addEventListener(frontend.components.menuList.editors.custom.GPSLocationEditor.CLOSED, this.onGPSLocationEditorClosed);
            this._reverseGeoSearch = new service.openstreetmap.MapSearchEngine();
            this._reverseGeoSearch.addEventListener(service.openstreetmap.MapSearchEvent.SEARCH_REVERSE_RESULT, this.onReverseGeoSearchResult);
            return;
        }

        public function set fakeEditMarker(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._849677337fakeEditMarker;
            if (loc1 !== arg1) 
            {
                this._849677337fakeEditMarker = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "fakeEditMarker", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get fakeSavedMarker():frontend.components.TextureImage
        {
            return this._2022442764fakeSavedMarker;
        }

        public function get footer():frontend.screen.component.Footer
        {
            return this._1268861541footer;
        }

        public function set footer(arg1:frontend.screen.component.Footer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1268861541footer;
            if (loc1 !== arg1) 
            {
                this._1268861541footer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "footer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get mapView():frontend.components.map.MapView
        {
            return this._836781601mapView;
        }

        public function set mapView(arg1:frontend.components.map.MapView):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._836781601mapView;
            if (loc1 !== arg1) 
            {
                this._836781601mapView = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "mapView", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _pointSaved():Boolean
        {
            return this._1952024458_pointSaved;
        }

        internal function set _pointSaved(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1952024458_pointSaved;
            if (loc1 !== arg1) 
            {
                this._1952024458_pointSaved = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_pointSaved", loc1, arg1, this);
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
            DevicePointNavigationView._watcherSetupUtil = arg1;
            return;
        }

        public override function dispose():void
        {
            this._reverseGeoSearch.removeEventListener(service.openstreetmap.MapSearchEvent.SEARCH_REVERSE_RESULT, this.onReverseGeoSearchResult);
            this._searchEditor.removeEventListener(frontend.components.menuList.editors.custom.SearchEditor.RESULT_SELECTED, this.onSearchResultSelected);
            this._searchEditor.removeEventListener(frontend.components.menuList.editors.custom.SearchEditor.CLOSED, this.onSearchEditorClosed);
            this._searchEditor.dispose();
            this._gpsLocationEditor.removeEventListener(frontend.components.menuList.editors.custom.GPSLocationEditor.CLOSED, this.onGPSLocationEditorClosed);
            this._gpsLocationEditor.dispose();
            this.mapView.dispose();
            super.dispose();
            return;
        }

        internal function onNameChanged(arg1:Object):void
        {
            this.pointNavigation.text1 = arg1 as String;
            if (this.pointNavigation.pointNavigationId != 0) 
            {
                this.pointNavigation.modificationDate = new Date().time;
                handler.AppDeviceHandler.getInstance().savePointNavigation(new backend.utils.dbUtils.DBUtilObject(this.pointNavigation, this.savePointComplete, this.savePointError, null, this.pointNavigation));
            }
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            this.mapView.touchable = true;
            this.mapView.mapLockActivated = false;
            this.mapView.showFocus();
            handler.ViewHandler.getInstance().openMainMenuOnSwipe(false);
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            flash.utils.clearTimeout(this._showMapTimeout);
            this.mapView.touchable = false;
            this.mapView.hideFocus();
            handler.ViewHandler.getInstance().openMainMenuOnSwipe(true);
            return;
        }

        protected override function validateProperties():void
        {
            title = this.pointNavigation.text1;
            this._nameEditor.defaultValue = this.pointNavigation.text1;
            this._nameEditor.editable = true;
            this._nameEditor.minItemHeight = EDITOR_HEIGHT;
            this._nameEditor.text = "POINT_NAVIGATION_NAME";
            this._nameEditor.title = "POINT_NAVIGATION_NAME";
            this._nameEditor.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
            this._nameEditor.useConfigCache = false;
            this._nameEditor.useLocalesForText = true;
            this._nameEditor.useLocalesForTitle = true;
            this.validateNameEditor();
            this.editors.removeChildren();
            this.editors.addChild(this._nameEditor);
            this.showMap();
            return;
        }

        internal function validateNameEditor():void
        {
            if (this.pointNavigation.pointNavigationId == 0) 
            {
                this._pointSaved = false;
            }
            else 
            {
                this._pointSaved = true;
                this._saveNameObj.keyValue = this.pointNavigation.GUID;
                this._nameEditor.saveToDbUseUpdate = true;
                this._nameEditor.saveToDbUseUpdateObject = this._saveNameObj;
            }
            return;
        }

        internal function showMap():void
        {
            if (handler.ViewHandler.getInstance().navigator.isTransitionActive) 
            {
                this._showMapTimeout = flash.utils.setTimeout(this.showMap, 100);
                return;
            }
            this.mapView.showMap(this.pointNavigation.latitude, this.pointNavigation.longitude);
            if (this.pointNavigation.pointNavigationId == 0) 
            {
                this._pointSaved = false;
            }
            else 
            {
                this._pointSaved = true;
                this.mapView.setPointNavigationMarker(this.pointNavigation.latitude, this.pointNavigation.longitude);
            }
            this.mapView.showControls();
            return;
        }

        internal function onFakeMarkerLoaded():void
        {
            var loc1:*=this.fakeEditMarker.height - this.fakeSavedMarker.height;
            this.fakeEditMarker.layoutData = new feathers.layout.AnchorLayoutData(SIGMALink.containerHeight / 2 - loc1, NaN, NaN, NaN, 0);
            this.fakeEditMarker.visible = true;
            return;
        }

        internal function onCenterMarkerTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            this.saveNewLocation();
            return;
        }

        internal function saveNewLocation(arg1:starling.events.TouchEvent=null):void
        {
            this.pointNavigation.text1 = this._nameEditor.value as String;
            this.pointNavigation.latitude = this.mapView.getCenterLatitude();
            this.pointNavigation.longitude = this.mapView.getCenterLongitude();
            this.pointNavigation.modificationDate = new Date().time;
            handler.AppDeviceHandler.getInstance().savePointNavigation(new backend.utils.dbUtils.DBUtilObject(this.pointNavigation, this.savePointComplete, this.savePointError, null, this.pointNavigation));
            this._reverseGeoSearch.searchReverse(this.pointNavigation.latitude, this.pointNavigation.longitude);
            return;
        }

        internal function onReverseGeoSearchResult(arg1:service.openstreetmap.MapSearchEvent):void
        {
            var loc2:*=null;
            var loc3:*=null;
            this.pointNavigation.modificationDate = new Date().time;
            var loc1:*=arg1.data as Vector.<service.openstreetmap.MapSearchResult>;
            if (loc1.length >= 1) 
            {
                loc2 = loc1[0];
                loc3 = [];
                if (loc2.city) 
                {
                    loc3.push(loc2.city);
                }
                else if (loc2.town) 
                {
                    loc3.push(loc2.town);
                }
                else if (loc2.village) 
                {
                    loc3.push(loc2.village);
                }
                if (loc2.road) 
                {
                    if (loc2.houseNumber) 
                    {
                        loc3.push(loc2.road + " " + loc2.houseNumber);
                    }
                    else 
                    {
                        loc3.push(loc2.road);
                    }
                }
                this.pointNavigation.text2 = loc3.join(", ");
                debug.Debug.debug(this.pointNavigation.text2);
                this.pointNavigation.modificationDate = new Date().time;
                handler.AppDeviceHandler.getInstance().savePointNavigation(new backend.utils.dbUtils.DBUtilObject(this.pointNavigation, this.savePointStreetComplete, this.savePointError, null, this.pointNavigation));
            }
            return;
        }

        internal function savePointComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("savePointComplete");
            this.validateNameEditor();
            this.mapView.setPointNavigationMarker(this.pointNavigation.latitude, this.pointNavigation.longitude);
            return;
        }

        internal function savePointStreetComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("savePointStreetComplete");
            return;
        }

        internal function savePointError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("savePointError");
            return;
        }

        internal function editLocation(arg1:starling.events.TouchEvent):void
        {
            debug.Debug.debug("editLocation");
            this.mapView.mapLockActivated = true;
            this._gpsLocationEditor.updatePoint(this.pointNavigation);
            this._gpsLocationEditor.owner = this._nameEditor;
            frontend.components.popup.PopUpBase.showModalPopUp(this._gpsLocationEditor, true, true);
            return;
        }

        internal function uploadToDevice(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_POINT_NAVIGATION_TRANSFER, {"unit":this.unit, "pointNavigation":this.pointNavigation, "transferModeDownload":false, "backScreenName":handler.ViewHandler.VIEW_DEVICE_POINT_NAVIGATION}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function onGPSLocationEditorClosed(arg1:starling.events.Event):void
        {
            this.mapView.mapLockActivated = false;
            if (this._gpsLocationEditor.point) 
            {
                this.mapView.setMapCenterToLocation(this._gpsLocationEditor.point.latitude, this._gpsLocationEditor.point.longitude);
            }
            return;
        }

        internal function onMapSearchTouch():void
        {
            debug.Debug.debug("onMapSearchTouch");
            this.mapView.mapLockActivated = true;
            this._searchEditor.owner = this._nameEditor;
            frontend.components.popup.PopUpBase.showModalPopUp(this._searchEditor, true, true);
            return;
        }

        internal function onSearchResultSelected(arg1:starling.events.Event):void
        {
            debug.Debug.debug("onSearchResultSelected");
            var loc1:*=(arg1.currentTarget as frontend.components.menuList.editors.custom.SearchEditor).selectedItem;
            if (loc1) 
            {
                this.mapView.setMapCenterToLocation(loc1.latitude, loc1.longitude);
            }
            return;
        }

        internal function onSearchEditorClosed(arg1:starling.events.Event):void
        {
            this.mapView.mapLockActivated = false;
            return;
        }

        internal function onMapFocusTouch():void
        {
            debug.Debug.debug("onMapFocusTouch");
            this.mapView.setMapCenterToPointNavigation();
            return;
        }

        internal function _DevicePointNavigationView_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.id = "editors";
            this.editors = loc1;
            feathers.binding.BindingManager.executeBindings(this, "editors", this.editors);
            return loc1;
        }

        internal function _DevicePointNavigationView_MapView1_i():frontend.components.map.MapView
        {
            var loc1:*=new frontend.components.map.MapView();
            loc1.mapFocusCallback = this.onMapFocusTouch;
            loc1.mapSearchCallback = this.onMapSearchTouch;
            loc1.showFocusButton = true;
            loc1.showLayerButton = true;
            loc1.showLockButton = false;
            loc1.showSearchButton = true;
            loc1.id = "mapView";
            this.mapView = loc1;
            feathers.binding.BindingManager.executeBindings(this, "mapView", this.mapView);
            return loc1;
        }

        internal function _DevicePointNavigationView_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.visible = false;
            loc1.addEventListener("touch", this.__fakeEditMarker_touch);
            loc1.id = "fakeEditMarker";
            this.fakeEditMarker = loc1;
            feathers.binding.BindingManager.executeBindings(this, "fakeEditMarker", this.fakeEditMarker);
            return loc1;
        }

        public function __fakeEditMarker_touch(arg1:starling.events.TouchEvent):void
        {
            this.onCenterMarkerTouch(arg1);
            return;
        }

        internal function _DevicePointNavigationView_TextureImage2_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.visible = false;
            loc1.addEventListener("creationComplete", this.__fakeSavedMarker_creationComplete);
            loc1.id = "fakeSavedMarker";
            this.fakeSavedMarker = loc1;
            feathers.binding.BindingManager.executeBindings(this, "fakeSavedMarker", this.fakeSavedMarker);
            return loc1;
        }

        public function __fakeSavedMarker_creationComplete(arg1:starling.events.Event):void
        {
            this.onFakeMarkerLoaded();
            return;
        }

        internal function _DevicePointNavigationView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.showBackButton = true;
            loc1.mxmlContent = [this._DevicePointNavigationView_IconButton1_i(), this._DevicePointNavigationView_IconButton2_i(), this._DevicePointNavigationView_IconButton3_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _DevicePointNavigationView_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DevicePointNavigationView_IconButton1";
            this._DevicePointNavigationView_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DevicePointNavigationView_IconButton1", this._DevicePointNavigationView_IconButton1);
            return loc1;
        }

        internal function _DevicePointNavigationView_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DevicePointNavigationView_IconButton2";
            this._DevicePointNavigationView_IconButton2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DevicePointNavigationView_IconButton2", this._DevicePointNavigationView_IconButton2);
            return loc1;
        }

        internal function _DevicePointNavigationView_IconButton3_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DevicePointNavigationView_IconButton3";
            this._DevicePointNavigationView_IconButton3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DevicePointNavigationView_IconButton3", this._DevicePointNavigationView_IconButton3);
            return loc1;
        }

        internal static const EDITOR_HEIGHT:Number=frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;

        public var _DevicePointNavigationView_IconButton1:frontend.components.button.IconButton;

        public var _DevicePointNavigationView_IconButton2:frontend.components.button.IconButton;

        public var _DevicePointNavigationView_IconButton3:frontend.components.button.IconButton;

        internal var _1887957850editors:frontend.components.menuList.MenuList;

        internal var _849677337fakeEditMarker:frontend.components.TextureImage;

        internal var _2022442764fakeSavedMarker:frontend.components.TextureImage;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _836781601mapView:frontend.components.map.MapView;

        public var unit:core.units.Unit;

        internal var _gpsLocationEditor:frontend.components.menuList.editors.custom.GPSLocationEditor;

        internal var _nameEditor:frontend.components.menuList.MenuListItem;

        internal var _1952024458_pointSaved:Boolean=false;

        internal var _reverseGeoSearch:service.openstreetmap.MapSearchEngine;

        internal var _saveNameObj:frontend.components.menuList.MenuListDbObject;

        internal var _searchEditor:frontend.components.menuList.editors.custom.SearchEditor;

        internal var _showMapTimeout:uint=0;

        public var pointNavigation:core.gps.PointNavigation;

        mx_internal var _bindings:Array;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


