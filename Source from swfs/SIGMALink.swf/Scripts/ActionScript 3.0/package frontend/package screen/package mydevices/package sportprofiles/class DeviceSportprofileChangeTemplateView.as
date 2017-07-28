//class DeviceSportprofileChangeTemplateView
package frontend.screen.mydevices.sportprofiles 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.general.*;
    import core.sportprofiles.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import frontend.screen.component.*;
    import frontend.screen.mydevices.sportprofiles.favsets.layouts.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class DeviceSportprofileChangeTemplateView extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSportprofileChangeTemplateView()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._favSetTemplatesDataProvider = new Vector.<frontend.screen.mydevices.sportprofiles.FavsetLayoutBase>();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._DeviceSportprofileChangeTemplateView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_DeviceSportprofileChangeTemplateViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSportprofileChangeTemplateView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.savePropertiesForBackNavigation = false;
            this.mxmlContent = [this._DeviceSportprofileChangeTemplateView_ScrollContainer1_i(), this._DeviceSportprofileChangeTemplateView_Footer1_i()];
            this.addEventListener("addedToStage", this.___DeviceSportprofileChangeTemplateView_CustomScreen1_addedToStage);
            this.addEventListener("initialize", this.___DeviceSportprofileChangeTemplateView_CustomScreen1_initialize);
            this.addEventListener("removedFromStage", this.___DeviceSportprofileChangeTemplateView_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _DeviceSportprofileChangeTemplateView_TiledRowsLayout1_i():feathers.layout.TiledRowsLayout
        {
            var loc1:*=new feathers.layout.TiledRowsLayout();
            loc1.distributeHeights = true;
            loc1.distributeWidths = true;
            loc1.useSquareTiles = false;
            this._DeviceSportprofileChangeTemplateView_TiledRowsLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSportprofileChangeTemplateView_TiledRowsLayout1", this._DeviceSportprofileChangeTemplateView_TiledRowsLayout1);
            return loc1;
        }

        public function __templateContainer_addedToStage(arg1:starling.events.Event):void
        {
            this.templateContainer_addedToStageHandler(arg1);
            return;
        }

        public function ___DeviceSportprofileChangeTemplateView_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddetToStage(arg1);
            return;
        }

        public function ___DeviceSportprofileChangeTemplateView_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___DeviceSportprofileChangeTemplateView_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        public function get colsMaxCount():uint
        {
            return this._colsMaxCount;
        }

        public function set colsMaxCount(arg1:uint):void
        {
            this._colsMaxCount = arg1;
            this.refresehTemplatePreviewSize();
            return;
        }

        internal function _DeviceSportprofileChangeTemplateView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "templateContainer.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "templateContainer.height")
            result[2] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.controls.List.SCROLL_POLICY_OFF;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "templateContainer.horizontalScrollPolicy")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "templateContainer.pageWidth")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.controls.List.SCROLL_BAR_DISPLAY_MODE_NONE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "templateContainer.scrollBarDisplayMode")
            result[5] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.controls.List.SCROLL_POLICY_ON;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "templateContainer.verticalScrollPolicy")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "templateContainer.width")
            result[7] = new feathers.binding.Binding(this, null, null, "_DeviceSportprofileChangeTemplateView_TiledRowsLayout1.gap", "gap");
            result[8] = new feathers.binding.Binding(this, null, null, "_DeviceSportprofileChangeTemplateView_TiledRowsLayout1.padding", "gap");
            result[9] = new feathers.binding.Binding(this, function ():int
            {
                return _cols;
            }, null, "_DeviceSportprofileChangeTemplateView_TiledRowsLayout1.requestedColumnCount")
            return result;
        }

        public function get colsMinWidth():uint
        {
            return this._colsMinWidth;
        }

        public function set colsMinWidth(arg1:uint):void
        {
            this._colsMinWidth = arg1;
            this.refresehTemplatePreviewSize();
            return;
        }

        public function set gap(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.gap;
            if (loc1 !== arg1) 
            {
                this._102102gap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "gap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
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

        public function get gap():Number
        {
            return this._gap;
        }

        internal function set _102102gap(arg1:Number):void
        {
            this._gap = arg1;
            this.refresehTemplatePreviewSize();
            return;
        }

        public function get templateContainer():feathers.controls.ScrollContainer
        {
            return this._1612581159templateContainer;
        }

        public function set templateContainer(arg1:feathers.controls.ScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1612581159templateContainer;
            if (loc1 !== arg1) 
            {
                this._1612581159templateContainer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "templateContainer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function set templatePreviewWidth(arg1:Number):void
        {
            this._templatePreviewWidth = arg1;
            this._templatePreviewHeight = this._templatePreviewWidth / 3 * 4;
            return;
        }

        internal function get _cols():uint
        {
            return this._90793938_cols;
        }

        internal function set _cols(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._90793938_cols;
            if (loc1 !== arg1) 
            {
                this._90793938_cols = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_cols", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function templateContainer_addedToStageHandler(arg1:starling.events.Event):void
        {
            if (!this._favSetTemplatesLoaded) 
            {
                flash.utils.setTimeout(this.templateContainer_addedToStageHandler, 100, arg1);
                return;
            }
            this.templateContainer.removeChildren();
            var loc1:*=0;
            while (loc1 < this._favSetTemplatesDataProvider.length) 
            {
                this.templateContainer.addChild(this._favSetTemplatesDataProvider[loc1]);
                this._favSetTemplatesDataProvider[loc1].validate();
                ++loc1;
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            DeviceSportprofileChangeTemplateView._watcherSetupUtil = arg1;
            return;
        }

        internal function refresehTemplatePreviewSize():void
        {
            var loc1:*=this._cols;
            var loc2:*=(SIGMALink.appWidth - this.gap * (loc1 + 1)) / loc1;
            if (!this.autoCalculateCols) 
            {
                this.templatePreviewWidth = loc2;
                return;
            }
            while (loc2 > this.colsMinWidth && loc1 < this.colsMaxCount) 
            {
                ++loc1;
                loc2 = (SIGMALink.appWidth - this.gap * (loc1 + 1)) / loc1;
            }
            this._cols = loc1;
            this.templatePreviewWidth = loc2;
            if (this.templateContainer != null) 
            {
                this.templateContainer.validate();
            }
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            var loc2:*=null;
            this.refresehTemplatePreviewSize();
            var loc1:*=0;
            while (loc1 < frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayoutsConfig.templates.length) 
            {
                loc2 = new frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayoutsConfig.templates[loc1]();
                loc2.id = "template_" + loc2.templateId;
                loc2.editable = false;
                loc2.showLabel = false;
                loc2.height = this._templatePreviewHeight;
                loc2.width = this._templatePreviewWidth;
                loc2.gap = 4;
                loc2.padding = 4;
                loc2.touchable = true;
                loc2.touchFunction = this.onTemplateSelected;
                loc2.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.GREY);
                loc2.selected = this.sportprofile.getFavSetObject(this.favsetNr).templateId == loc2.templateId;
                this._favSetTemplatesDataProvider.push(loc2);
                ++loc1;
            }
            this._favSetTemplatesLoaded = true;
            return;
        }

        internal function onTemplateSelected(arg1:frontend.screen.mydevices.sportprofiles.FavsetLayoutBase):void
        {
            var loc1:*=new core.sportprofiles.FavFunctionList();
            loc1.fromJson(arg1.favFunctionList.toJson());
            loc1.active = this.defaultActive;
            this.sportprofile.changeFavFunctionList(this.favsetNr, loc1);
            arg1.editable = false;
            this.sportprofile.modificationDate = new Date().time;
            handler.AppDeviceHandler.getInstance().saveSportprofile(new backend.utils.dbUtils.DBUtilObject(this.sportprofile, this.onInsertDataComplete, this.onInsertDataComplete, null));
            return;
        }

        protected function onInsertDataComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this.goBack();
            return;
        }

        internal function goBack():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET, {"sportprofile":this.sportprofile, "favsetNr":this.favsetNr}, handler.ViewHandler.slideToRightTransition(), true);
            return;
        }

        internal function _DeviceSportprofileChangeTemplateView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        protected override function validateProperties():void
        {
            super.validateProperties();
            core.sportprofiles.SportprofileFavFunctions.currentSportprofile = this.sportprofile;
            var loc1:*=0;
            while (loc1 < this._favSetTemplatesDataProvider.length) 
            {
                this._favSetTemplatesDataProvider[loc1].selected = this.sportprofile.getFavSetObject(this.favsetNr).templateId == this._favSetTemplatesDataProvider[loc1].templateId;
                ++loc1;
            }
            return;
        }

        protected function onAddetToStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().addBackFunction(this.goBack);
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            handler.ViewHandler.getInstance().removeBackFunction(this.goBack);
            return;
        }

        internal function _DeviceSportprofileChangeTemplateView_ScrollContainer1_i():feathers.controls.ScrollContainer
        {
            var loc1:*=new feathers.controls.ScrollContainer();
            loc1.autoHideBackground = true;
            loc1.clipContent = true;
            loc1.hasElasticEdges = false;
            loc1.layout = this._DeviceSportprofileChangeTemplateView_TiledRowsLayout1_i();
            loc1.addEventListener("addedToStage", this.__templateContainer_addedToStage);
            loc1.id = "templateContainer";
            this.templateContainer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "templateContainer", this.templateContainer);
            return loc1;
        }

        internal static const DEFAULT_COLS_MAX_COUNT:uint=4;

        internal static const DEFAULT_COLS_MIN_WIDTH:uint=120;

        internal static const DEFAULT_GAP:Number=20;

        public var _DeviceSportprofileChangeTemplateView_TiledRowsLayout1:feathers.layout.TiledRowsLayout;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _1612581159templateContainer:feathers.controls.ScrollContainer;

        public var autoCalculateCols:Boolean=true;

        internal var _colsMaxCount:uint=4;

        internal var _colsMinWidth:uint=120;

        public var defaultActive:Boolean=false;

        public var favsetNr:uint;

        internal var _gap:Number=20;

        public var sportprofile:core.sportprofiles.Sportprofile;

        internal var _templatePreviewWidth:Number=0;

        internal var _90793938_cols:uint=2;

        internal var _favSetTemplatesDataProvider:__AS3__.vec.Vector.<frontend.screen.mydevices.sportprofiles.FavsetLayoutBase>;

        internal var _templatePreviewHeight:Number=0;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _watchers:Array;

        mx_internal var _bindings:Array;

        internal var _favSetTemplatesLoaded:Boolean=false;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


