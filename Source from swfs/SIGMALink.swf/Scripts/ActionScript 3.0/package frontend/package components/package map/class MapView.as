//class MapView
package frontend.components.map 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import configCache.*;
    import core.general.*;
    import core.marker.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.popup.*;
    import handler.*;
    import sk.yoz.ycanvas.map.display.*;
    import sk.yoz.ycanvas.map.layers.*;
    import sk.yoz.ycanvas.map.managers.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.textures.*;
    import utils.*;
    
    public class MapView extends feathers.controls.LayoutGroup
    {
        public function MapView()
        {
            super();
            layout = new feathers.layout.AnchorLayout();
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }

        public function focusTrack():void
        {
            if (this.track) 
            {
                this.focusElement(this.track);
            }
            return;
        }

        public function showStartMarker(arg1:Number, arg2:Number):void
        {
            if (!this.startMarker) 
            {
                this.startMarker = this.createMarker(frontend.Textures.mapstarticon, arg1, arg2);
            }
            if (this.startMarker && !mapMain.markerLayer.contains(this.startMarker)) 
            {
                mapMain.markerLayer.add(this.startMarker);
            }
            return;
        }

        public function get mapLockActivated():Boolean
        {
            return this._mapLockActivated;
        }

        public function set mapLockActivated(arg1:Boolean):void
        {
            this._mapLockActivated = arg1;
            this.validateMapTouch();
            return;
        }

        public function showEndMarker(arg1:Number, arg2:Number):void
        {
            if (!this.endMarker) 
            {
                this.endMarker = this.createMarker(frontend.Textures.mapstopicon, arg1, arg2);
            }
            if (this.endMarker && !mapMain.markerLayer.contains(this.endMarker)) 
            {
                mapMain.markerLayer.add(this.endMarker);
            }
            return;
        }

        public function setPointNavigationMarker(arg1:Number, arg2:Number):void
        {
            if (!this.pointNavigationMarker) 
            {
                this.pointNavigationMarker = this.createMarker(frontend.Textures.mapstopicon, arg1, arg2);
            }
            if (this.pointNavigationMarker) 
            {
                if (mapMain.markerLayer.contains(this.pointNavigationMarker)) 
                {
                    this.updateMarkerPos(this.pointNavigationMarker as starling.display.Image, arg1, arg2);
                }
                else 
                {
                    mapMain.markerLayer.add(this.pointNavigationMarker);
                }
            }
            return;
        }

        public function showActivityMarkers(arg1:__AS3__.vec.Vector.<core.marker.Marker>):void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc2:*=arg1.length;
            var loc4:*="";
            this._markerDic = new flash.utils.Dictionary();
            this._calloutDic = new flash.utils.Dictionary();
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = arg1[loc1];
                var loc8:*=loc3.type;
                switch (loc8) 
                {
                    case core.general.MarkerType.LAP:
                    {
                        loc5 = frontend.Textures.maplapbubble;
                        loc4 = (loc3.number + 1).toString();
                        break;
                    }
                    case core.general.MarkerType.AUTO_LAP:
                    {
                        loc5 = frontend.Textures.autoLapBubble;
                        loc4 = (loc3.number + 1).toString();
                        break;
                    }
                }
                loc6 = this.createMarker(loc5, loc3.latitude, loc3.longitude, loc4);
                if (loc6) 
                {
                    mapMain.markerLayer.add(loc6);
                    this._markerDic[loc6] = loc3;
                    loc7 = this.createCallout(loc3);
                    if (loc7) 
                    {
                        mapMain.markerLayer.add(loc7);
                        this._calloutDic[loc6] = loc7;
                    }
                }
                ++loc1;
            }
            return;
        }

        public function setMapCenterToPointNavigation():void
        {
            if (!this.pointNavigationMarker) 
            {
                return;
            }
            mapMain.transformationManager.showBoundsTween(this.pointNavigationMarker.bounds.left, this.pointNavigationMarker.bounds.right, this.pointNavigationMarker.bounds.top, this.pointNavigationMarker.bounds.bottom + this.pointNavigationMarker.height);
            return;
        }

        internal function createMarker(arg1:String, arg2:Number, arg3:Number, arg4:String=""):starling.display.DisplayObject
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (arg2 == 0 && arg3 == 0) 
            {
                return null;
            }
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTexture(arg1);
            if (loc1) 
            {
                loc3 = new starling.display.Image(loc1);
                if (arg4 == "") 
                {
                    loc2 = loc3;
                }
                else 
                {
                    loc4 = new feathers.controls.Label();
                    loc4.text = arg4;
                    loc4.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
                    loc5 = new feathers.controls.LayoutGroup();
                    loc5.touchGroup = true;
                    loc5.addChild(loc3);
                    loc5.addChild(loc4);
                    loc4.validate();
                    loc4.x = (loc1.width - loc4.width) / 2;
                    loc4.y = 8 * SIGMALink.scaleFactor;
                    loc2 = loc5;
                }
            }
            loc2.x = frontend.components.map.GeoUtils.lon2x(arg3);
            loc2.y = frontend.components.map.GeoUtils.lat2y(arg2);
            loc2.pivotX = loc1.width / 2;
            loc2.pivotY = loc1.height;
            return loc2;
        }

        internal function updateMarkerPos(arg1:starling.display.DisplayObject, arg2:Number, arg3:Number):void
        {
            arg1.x = frontend.components.map.GeoUtils.lon2x(arg3);
            arg1.y = frontend.components.map.GeoUtils.lat2y(arg2);
            if (arg1 is starling.display.Image) 
            {
                arg1.pivotX = (arg1 as starling.display.Image).texture.width / 2;
                arg1.pivotY = (arg1 as starling.display.Image).texture.height;
            }
            return;
        }

        internal function createCallout(arg1:core.marker.Marker):starling.display.DisplayObject
        {
            var loc5:*=null;
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.markerPopUpBackground);
            var loc2:*=new flash.geom.Rectangle(loc1.width - BORDER_RADIUS * 2, BORDER_RADIUS, BORDER_RADIUS, loc1.height - BORDER_RADIUS - ARROW_HEIGHT);
            var loc3:*=SIGMALink.appWidth - 2 * OUTER_PADDING;
            var loc4:*=new starling.display.Image(loc1);
            loc4.scale9Grid = loc2;
            var loc6:*=new feathers.controls.LayoutGroup();
            loc6.layout = new feathers.layout.HorizontalLayout();
            (loc6.layout as feathers.layout.HorizontalLayout).gap = 3 * BORDER_RADIUS;
            (loc6.layout as feathers.layout.HorizontalLayout).verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            var loc7:*=new feathers.controls.Label();
            loc7.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_LAP") + " " + (arg1.number + 1);
            loc7.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
            loc6.addChild(loc7);
            var loc8:*=new feathers.controls.LayoutGroup();
            loc8.layout = new feathers.layout.HorizontalLayout();
            (loc8.layout as feathers.layout.HorizontalLayout).gap = 3 * BORDER_RADIUS;
            (loc8.layout as feathers.layout.HorizontalLayout).verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            var loc9:*=new feathers.controls.Label();
            loc9.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DISTANCE");
            loc9.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_ITALIC;
            loc8.addChild(loc9);
            var loc10:*=new feathers.controls.Label();
            loc10.text = arg1.distanceOutputString;
            loc10.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            loc8.addChild(loc10);
            var loc11:*=new feathers.controls.Label();
            loc11.text = backend.utils.DataUtils.unitStringDistance;
            loc11.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            loc8.addChild(loc11);
            loc8.validate();
            var loc12:*=new feathers.controls.LayoutGroup();
            loc12.layout = new feathers.layout.HorizontalLayout();
            (loc12.layout as feathers.layout.HorizontalLayout).gap = 3 * BORDER_RADIUS;
            (loc12.layout as feathers.layout.HorizontalLayout).paddingBottom = 3 * BORDER_RADIUS;
            (loc12.layout as feathers.layout.HorizontalLayout).verticalAlign = feathers.layout.HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
            var loc13:*=new feathers.controls.Label();
            loc13.text = utils.LanguageManager.getString("ACTIVIY_TAB_LAPS_DETAILS_LAPTIME");
            loc13.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL_ITALIC;
            loc12.addChild(loc13);
            var loc14:*=new feathers.controls.Label();
            loc14.text = arg1.timeOutputString;
            loc14.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            loc12.addChild(loc14);
            var loc15:*=new feathers.controls.Label();
            loc15.text = backend.utils.DataUtils.unitStringTimeHours;
            loc15.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
            loc12.addChild(loc15);
            loc12.validate();
            var loc16:*=new feathers.layout.VerticalLayout();
            loc16.padding = 3 * BORDER_RADIUS;
            loc16.gap = 3 * BORDER_RADIUS;
            var loc17:*=new starling.display.Quad(1, 1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            var loc18:*=new starling.display.Quad(1, 1 * SIGMALink.scaleFactor, core.general.Colors.LIGHTGREY);
            var loc19:*=new feathers.controls.LayoutGroup();
            loc19.layout = loc16;
            loc19.backgroundSkin = loc4;
            loc19.touchGroup = true;
            loc19.addChild(loc6);
            loc19.addChild(loc17);
            loc19.addChild(loc8);
            loc19.addChild(loc18);
            loc19.addChild(loc12);
            loc19.validate();
            var loc20:*=loc19.width - loc16.padding * 2 - (loc8.layout as feathers.layout.HorizontalLayout).gap * 2 - loc10.width - loc11.width;
            var loc21:*=loc19.width - loc16.padding * 2 - (loc12.layout as feathers.layout.HorizontalLayout).gap * 2 - loc14.width - loc15.width;
            var loc22:*=Math.max(loc20, loc21);
            var loc23:*=loc10.width;
            var loc24:*=loc14.width;
            var loc25:*=Math.max(loc23, loc24);
            var loc26:*=loc11.width;
            var loc27:*=loc15.width;
            var loc28:*=Math.max(loc26, loc27);
            loc9.width = loc22;
            loc10.width = loc25;
            loc13.width = loc22;
            loc14.width = loc25;
            var loc29:*;
            loc18.width = loc29 = loc22 + loc25 + loc28 + (loc8.layout as feathers.layout.HorizontalLayout).gap * 2;
            loc17.width = loc29;
            loc5 = loc19;
            loc5.x = frontend.components.map.GeoUtils.lon2x(arg1.longitude);
            loc5.y = frontend.components.map.GeoUtils.lat2y(arg1.latitude);
            loc5.pivotX = loc1.width / 2;
            loc5.pivotY = loc19.height;
            loc5.visible = false;
            return loc5;
        }

        internal function markerCallout(arg1:starling.display.DisplayObject):void
        {
            var loc3:*=null;
            if (!this._calloutDic) 
            {
                return;
            }
            if (!(this._currentCallout == null) && this._calloutDic[this._currentCallout]) 
            {
                this._calloutDic[this._currentCallout].visible = false;
            }
            var loc1:*=this._calloutDic[arg1] as starling.display.DisplayObject;
            var loc2:*=this._markerDic[arg1] as core.marker.Marker;
            if (loc1) 
            {
                mapMain.markerLayer.swapChildrenAt(mapMain.markerLayer.getChildIndex(loc1), (mapMain.markerLayer.numChildren - 1));
                loc1.visible = true;
                this.focusElement(loc1);
                this._currentCallout = arg1;
            }
            else if (this.markerCalloutTouchCallback != null) 
            {
                loc3 = this._markerDic[this._currentCallout];
                this.markerCalloutTouchCallback(loc3);
            }
            return;
        }

        public function showControls():void
        {
            if (this.showLockButton) 
            {
                this.iconLockButton = new frontend.components.button.IconButton();
                this.iconLockButton.image = frontend.Textures.lockbutton;
                this.iconLockButton.touchHandler = this.onLockButtonTouch;
                this.iconLockButton.layoutData = new feathers.layout.AnchorLayoutData(NaN, PADDING, PADDING);
                addChild(this.iconLockButton);
            }
            if (this.showFocusButton) 
            {
                this.focusButton = new frontend.components.button.IconButton();
                this.focusButton.image = frontend.Textures.focusTrackButton;
                this.focusButton.touchHandler = this.onFocusButtonTouch;
                this.focusButton.layoutData = new feathers.layout.AnchorLayoutData(PADDING, PADDING);
                addChild(this.focusButton);
            }
            if (this.showLayerButton) 
            {
                this.layerButton = new frontend.components.button.IconButton();
                this.layerButton.image = frontend.Textures.mapLayerButton;
                this.layerButton.touchHandler = this.onLayerButtonTouch;
                this.layerButton.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, PADDING, PADDING);
                addChild(this.layerButton);
            }
            if (this.showSearchButton) 
            {
                this.searchButton = new frontend.components.button.IconButton();
                this.searchButton.image = frontend.Textures.locationSearchIcon;
                this.searchButton.touchHandler = this.onSearchButtonTouch;
                this.searchButton.layoutData = new feathers.layout.AnchorLayoutData(PADDING, NaN, NaN, PADDING);
                addChild(this.searchButton);
            }
            if (this._validateMapTouchFlag) 
            {
                this.validateMapTouch();
            }
            return;
        }

        internal function removeTrack():void
        {
            if (this.track) 
            {
                if (mapMain.strokeLayer.contains(this.track)) 
                {
                    mapMain.strokeLayer.remove(this.track);
                }
                this.track.dispose();
                this.track = null;
            }
            return;
        }

        internal function removeMarkers():void
        {
            var loc1:*=undefined;
            if (this.startMarker && mapMain.markerLayer.contains(this.startMarker)) 
            {
                mapMain.markerLayer.remove(this.startMarker);
            }
            if (this.endMarker && mapMain.markerLayer.contains(this.endMarker)) 
            {
                mapMain.markerLayer.remove(this.endMarker);
            }
            if (this.pointNavigationMarker && mapMain.markerLayer.contains(this.pointNavigationMarker)) 
            {
                mapMain.markerLayer.remove(this.pointNavigationMarker);
            }
            var loc2:*=0;
            var loc3:*=this._markerDic;
            for (loc1 in loc3) 
            {
                mapMain.markerLayer.remove(loc1);
                delete this._markerDic[loc1];
            }
            loc2 = 0;
            loc3 = this._calloutDic;
            for (loc1 in loc3) 
            {
                mapMain.markerLayer.remove(this._calloutDic[loc1]);
                delete this._calloutDic[loc1];
            }
            this.startMarker = null;
            this.endMarker = null;
            return;
        }

        internal function removeMap():void
        {
            if (!mapMain) 
            {
                return;
            }
            this.mapLockActivated = false;
            removeChild(mapMain.map.display);
            mapMain.dispose();
            mapMain = null;
            return;
        }

        internal function removeControls():void
        {
            if (contains(this.iconLockButton)) 
            {
                removeChild(this.iconLockButton);
            }
            if (contains(this.focusButton)) 
            {
                removeChild(this.focusButton);
            }
            if (contains(this.layerButton)) 
            {
                removeChild(this.layerButton);
            }
            if (contains(this.zoomOutButton)) 
            {
                removeChild(this.zoomOutButton);
            }
            if (contains(this.zoomInButton)) 
            {
                removeChild(this.zoomInButton);
            }
            return;
        }

        internal function validateMapTouch():void
        {
            if (!mapMain) 
            {
                this._validateMapTouchFlag = true;
                return;
            }
            this._validateMapTouchFlag = false;
            if (this._mapLockActivated || this.leftMenuOpen) 
            {
                mapMain.removeTouchEvents();
                if (this.iconLockButton) 
                {
                    this.iconLockButton.image = frontend.Textures.lockbutton;
                }
            }
            else 
            {
                mapMain.addTouchEvents();
                if (this.iconLockButton) 
                {
                    this.iconLockButton.image = frontend.Textures.unlockbutton;
                }
            }
            dispatchEvent(new starling.events.Event(MAP_LOCK_CHANGED));
            return;
        }

        internal function onZoomInButtonTriggered():void
        {
            mapMain.transformationManager.scaleByTween(sk.yoz.ycanvas.map.layers.LayerFactory.CUSTOM_SCALE_STEPS);
            return;
        }

        internal function onZoomOutButtonTriggered():void
        {
            mapMain.transformationManager.scaleByTween(1 / sk.yoz.ycanvas.map.layers.LayerFactory.CUSTOM_SCALE_STEPS);
            return;
        }

        internal function onLockButtonTouch(arg1:starling.events.TouchEvent):void
        {
            this.mapLockActivated = !this.mapLockActivated;
            return;
        }

        internal function onFocusButtonTouch(arg1:starling.events.TouchEvent):void
        {
            if (this.mapFocusCallback == null) 
            {
                this.focusElement(this.track);
            }
            else 
            {
                this.mapFocusCallback();
            }
            return;
        }

        internal function onLayerButtonTouch(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=new frontend.components.menuList.editors.SpinnerEditor();
            loc1.dataProvider = new feathers.data.ListCollection(frontend.components.map.MapLayerOptions.getLayerVector());
            loc1.owner = new frontend.components.menuList.MenuListItem();
            loc1.rawValue = configCache.ConfigCache.getInstance().getValue(frontend.components.map.MapLayerOptions.CONFIG_ID, frontend.components.map.MapLayerOptions.DEFAULT);
            loc1.title = utils.LanguageManager.getString("LAYER_SELECT_POPUP_TITLE");
            loc1.saveCompleteCallback = this.onLayerSelectionChanged;
            frontend.components.popup.PopUpBase.showModalPopUp(loc1, true, false);
            return;
        }

        internal function onSearchButtonTouch(arg1:starling.events.TouchEvent):void
        {
            if (this.mapSearchCallback != null) 
            {
                this.mapSearchCallback();
            }
            return;
        }

        public function focusElement(arg1:starling.display.DisplayObject):void
        {
            if (!arg1) 
            {
                return;
            }
            var loc1:*=3000 * SIGMALink.scaleFactor;
            mapMain.transformationManager.showBoundsTween(arg1.bounds.left - loc1, arg1.bounds.right + loc1, arg1.bounds.top - loc1, arg1.bounds.bottom + loc1);
            return;
        }

        internal function mapTouchHandler(arg1:flash.events.MouseEvent):void
        {
            if (this._calloutDic && this._calloutDic[this._currentCallout]) 
            {
                this._calloutDic[this._currentCallout].visible = false;
            }
            return;
        }

        public override function dispose():void
        {
            removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            starling.core.Starling.current.nativeStage.removeEventListener(flash.events.MouseEvent.CLICK, this.mapTouchHandler);
            super.dispose();
            return;
        }

        internal function onAddedToStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.EVENT_LEFT_MENU_TOGGLE_CHANGED, this.onLeftMenuToggleChanged);
            starling.core.Starling.current.nativeStage.addEventListener(flash.events.MouseEvent.CLICK, this.mapTouchHandler, false, 100);
            sk.yoz.ycanvas.map.managers.AbstractTransformationManager.yStartCorrection = this.yStartCorrection;
            this.mapLockActivated = this.showLockButton ? true : false;
            return;
        }

        internal function onRemovedFromStage(arg1:starling.events.Event):void
        {
            sk.yoz.ycanvas.map.managers.AbstractTransformationManager.yStartCorrection = 0;
            this.removeTrack();
            this.removeMarkers();
            this.removeMap();
            this.removeControls();
            starling.core.Starling.current.nativeStage.removeEventListener(flash.events.MouseEvent.CLICK, this.mapTouchHandler);
            handler.ViewHandler.getInstance().removeEventListener(handler.ViewHandler.EVENT_LEFT_MENU_TOGGLE_CHANGED, this.onLeftMenuToggleChanged);
            return;
        }

        internal function onLeftMenuToggleChanged(arg1:starling.events.Event):void
        {
            this.leftMenuOpen = arg1.data as Boolean;
            this.validateStarlingClickEvent();
            return;
        }

        internal function validateStarlingClickEvent():void
        {
            if (this.leftMenuOpen) 
            {
                touchable = false;
                hideFocus();
                handler.ViewHandler.getInstance().openMainMenuOnSwipe(false);
            }
            else 
            {
                touchable = true;
                showFocus();
                handler.ViewHandler.getInstance().openMainMenuOnSwipe(true);
            }
            return;
        }

        public function showMap(arg1:Number, arg2:Number):void
        {
            if (mapMain) 
            {
                mapMain.dispose();
            }
            mapMain = new frontend.components.map.MapHelperMain(arg1, arg2);
            mapMain.map.display.width = width;
            mapMain.map.display.height = height;
            mapMain.markerTouchFunction = this.markerCallout;
            addChild(mapMain.map.display);
            mapMain.addMarkerTouchEvent();
            return;
        }

        public function getCenterLatitude():Number
        {
            return frontend.components.map.GeoUtils.y2lat(mapMain.map.center.y);
        }

        public function getCenterLongitude():Number
        {
            return frontend.components.map.GeoUtils.x2lon(mapMain.map.center.x);
        }

        internal function onLayerSelectionChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            frontend.components.map.MapHelperMain.LAYER_OPTION = arg2.rawValue.toString();
            frontend.components.map.MapHelperMain.LAYER_CACHE_SUBDIR = arg2.selectedDataProviderItem.layer;
            mapMain.updateConfig();
            return;
        }

        public function setMapCenterToLocation(arg1:Number, arg2:Number):void
        {
            var loc1:*=frontend.components.map.GeoUtils.lon2x(arg2);
            var loc2:*=frontend.components.map.GeoUtils.lat2y(arg1);
            mapMain.transformationManager.showBoundsTween(loc1, loc1, loc2, loc2);
            return;
        }

        public function showActivityTrack(arg1:__AS3__.vec.Vector.<core.activities.ActivityEntry>):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            if (!this.track) 
            {
                loc2 = arg1.length;
                loc3 = new Vector.<Number>();
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    if (!(arg1[loc1].longitude == 0) && !(arg1[loc1].latitude == 0)) 
                    {
                        loc3 = this.addTrackPoint(loc3, arg1[loc1].longitude, arg1[loc1].latitude);
                    }
                    ++loc1;
                }
                if (loc3.length == 0) 
                {
                    return;
                }
                this.createTrack(loc3);
            }
            if (!mapMain.strokeLayer.contains(this.track)) 
            {
                mapMain.strokeLayer.add(this.track);
            }
            this.focusElement(this.track);
            return;
        }

        public function showRouteTrack(arg1:__AS3__.vec.Vector.<core.route.RoutePoint>):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=null;
            if (!this.track) 
            {
                loc2 = arg1.length;
                loc3 = new Vector.<Number>();
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    if (!(arg1[loc1].longitude == 0) && !(arg1[loc1].latitude == 0)) 
                    {
                        loc3 = this.addTrackPoint(loc3, arg1[loc1].longitude, arg1[loc1].latitude);
                    }
                    ++loc1;
                }
                if (loc3.length == 0) 
                {
                    return;
                }
                this.createTrack(loc3);
            }
            if (!mapMain.strokeLayer.contains(this.track)) 
            {
                mapMain.strokeLayer.add(this.track);
            }
            this.focusElement(this.track);
            return;
        }

        internal function createTrack(arg1:__AS3__.vec.Vector.<Number>):void
        {
            this.track = new sk.yoz.ycanvas.map.display.MapStroke(arg1, 5 * SIGMALink.scaleFactor, core.general.Colors.DARK_BLUE, 0.6);
            this.track.simplifyTolerance = 1;
            return;
        }

        internal function addTrackPoint(arg1:__AS3__.vec.Vector.<Number>, arg2:Number, arg3:Number):__AS3__.vec.Vector.<Number>
        {
            arg1.push(frontend.components.map.GeoUtils.lon2x(arg2));
            arg1.push(frontend.components.map.GeoUtils.lat2y(arg3));
            return arg1;
        }

        public static const MAP_LOCK_CHANGED:String="mapLockChanged";

        internal static const ARROW_HEIGHT:Number=30 * SIGMALink.scaleFactor;

        internal static const BORDER_RADIUS:Number=5 * SIGMALink.scaleFactor;

        internal static const OUTER_PADDING:Number=50 * SIGMALink.scaleFactor;

        internal static const PADDING:Number=10 * SIGMALink.scaleFactor;

        public var mapFocusCallback:Function;

        internal var _mapLockActivated:Boolean=true;

        public var mapSearchCallback:Function;

        public var markerCalloutTouchCallback:Function;

        public var showFocusButton:Boolean=true;

        public var showLockButton:Boolean=true;

        public var showSearchButton:Boolean=false;

        public var yStartCorrection:Number=0;

        internal var _calloutDic:flash.utils.Dictionary;

        internal var _currentCallout:starling.display.DisplayObject;

        internal var _markerDic:flash.utils.Dictionary;

        internal var _validateMapTouchFlag:Boolean=false;

        internal var endMarker:starling.display.DisplayObject;

        internal var focusButton:frontend.components.button.IconButton;

        internal var iconLockButton:frontend.components.button.IconButton;

        internal var layerButton:frontend.components.button.IconButton;

        internal var leftMenuOpen:Boolean=false;

        internal var pointNavigationMarker:starling.display.DisplayObject;

        internal var searchButton:frontend.components.button.IconButton;

        internal var startMarker:starling.display.DisplayObject;

        internal var track:sk.yoz.ycanvas.map.display.MapStroke;

        internal var zoomInButton:feathers.controls.Button;

        internal var zoomOutButton:feathers.controls.Button;

        public var showLayerButton:Boolean=true;

        internal static var mapMain:frontend.components.map.MapHelperMain;
    }
}


