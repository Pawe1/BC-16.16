//class DeviceSportprofileFavSetView
package frontend.screen.mydevices.sportprofiles 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.general.*;
    import core.settings.interfaces.*;
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
    import frontend.*;
    import frontend.components.*;
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import frontend.screen.mydevices.sportprofiles.favsets.*;
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
    
    use namespace mx_internal;
    
    public class DeviceSportprofileFavSetView extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function DeviceSportprofileFavSetView()
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
            bindings = this._DeviceSportprofileFavSetView_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_sportprofiles_DeviceSportprofileFavSetViewWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return DeviceSportprofileFavSetView[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = true;
            this.saveAsOldScreen = false;
            this.savePropertiesForBackNavigation = false;
            this.mxmlContent = [this._DeviceSportprofileFavSetView_LayoutGroup1_i(), this._DeviceSportprofileFavSetView_Footer1_i()];
            this.addEventListener("initialize", this.___DeviceSportprofileFavSetView_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get activeCheckbox():frontend.components.menuList.MenuListItem
        {
            return this._665806615activeCheckbox;
        }

        public function set activeCheckbox(arg1:frontend.components.menuList.MenuListItem):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._665806615activeCheckbox;
            if (loc1 !== arg1) 
            {
                this._665806615activeCheckbox = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "activeCheckbox", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get favSetEditorScroller():frontend.components.scrollContainer.CustomHScrollContainer
        {
            return this._972775406favSetEditorScroller;
        }

        public function set favSetEditorScroller(arg1:frontend.components.scrollContainer.CustomHScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._972775406favSetEditorScroller;
            if (loc1 !== arg1) 
            {
                this._972775406favSetEditorScroller = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "favSetEditorScroller", loc1, arg1, this);
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

        public function get pageIndicator():frontend.components.CustomPageIndicator
        {
            return this._643699648pageIndicator;
        }

        public function set pageIndicator(arg1:frontend.components.CustomPageIndicator):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._643699648pageIndicator;
            if (loc1 !== arg1) 
            {
                this._643699648pageIndicator = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "pageIndicator", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _DeviceSportprofileFavSetView_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._DeviceSportprofileFavSetView_VerticalLayout1_i();
            loc1.mxmlContent = [this._DeviceSportprofileFavSetView_MenuListItem1_i(), this._DeviceSportprofileFavSetView_CustomHScrollContainer1_i(), this._DeviceSportprofileFavSetView_CustomPageIndicator1_i()];
            loc1.id = "_DeviceSportprofileFavSetView_LayoutGroup1";
            this._DeviceSportprofileFavSetView_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSportprofileFavSetView_LayoutGroup1", this._DeviceSportprofileFavSetView_LayoutGroup1);
            return loc1;
        }

        public function get active():Boolean
        {
            return this._active;
        }

        internal function set _1422950650active(arg1:Boolean):void
        {
            this._active = this.favsetNr > 1 ? arg1 : true;
            return;
        }

        public function set active(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.active;
            if (loc1 !== arg1) 
            {
                this._1422950650active = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "active", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get changeFunction():Function
        {
            return this._1095383976changeFunction;
        }

        public function get favsetNr():uint
        {
            return this._favsetNr;
        }

        internal function set _1054106507favsetNr(arg1:uint):void
        {
            if (this._favsetNr == arg1) 
            {
                return;
            }
            this._favsetNr = arg1;
            this._pageLabel = utils.LanguageManager.getString("DEVICEVIEW.DEVICE_SPORT_PROFILES_AKTIV").replace("###NR###", arg1.toString());
            if (this.favSetEditorScroller && this.favSetEditorScroller.numChildren >= arg1) 
            {
                this.active = (this.favSetEditorScroller.getChildAt((arg1 - 1)) as frontend.screen.mydevices.sportprofiles.favsets.FavSetEditor).favFunctionList.active;
            }
            return;
        }

        public function set favsetNr(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.favsetNr;
            if (loc1 !== arg1) 
            {
                this._1054106507favsetNr = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "favsetNr", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _favSetMaxCount():uint
        {
            return this._857027729_favSetMaxCount;
        }

        internal function set _favSetMaxCount(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._857027729_favSetMaxCount;
            if (loc1 !== arg1) 
            {
                this._857027729_favSetMaxCount = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_favSetMaxCount", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _pageLabel():String
        {
            return this._623155162_pageLabel;
        }

        internal function set _pageLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._623155162_pageLabel;
            if (loc1 !== arg1) 
            {
                this._623155162_pageLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_pageLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get verticalSeperatorLineVisible():Boolean
        {
            return this._56421971verticalSeperatorLineVisible;
        }

        internal function set verticalSeperatorLineVisible(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._56421971verticalSeperatorLineVisible;
            if (loc1 !== arg1) 
            {
                this._56421971verticalSeperatorLineVisible = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "verticalSeperatorLineVisible", loc1, arg1, this);
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
            DeviceSportprofileFavSetView._watcherSetupUtil = arg1;
            return;
        }

        internal function getFavFunctionList():core.sportprofiles.FavFunctionList
        {
            if (this.favSetEditorScroller && this.favSetEditorScroller.numChildren >= this.favsetNr) 
            {
                return (this.favSetEditorScroller.getChildAt((this.favsetNr - 1)) as frontend.screen.mydevices.sportprofiles.favsets.FavSetEditor).favFunctionList;
            }
            return null;
        }

        protected override function validateProperties():void
        {
            super.validateProperties();
            title = this.sportprofile.profileName;
            core.sportprofiles.SportprofileFavFunctions.currentSportprofile = this.sportprofile;
            return;
        }

        internal function onFavChanged(arg1:core.sportprofiles.FavFunctionList):void
        {
            this.sportprofile.changeFavFunctionList(this.favsetNr, arg1);
            this.sportprofile.modificationDate = new Date().time;
            handler.AppDeviceHandler.getInstance().saveSportprofile(new backend.utils.dbUtils.DBUtilObject(this.sportprofile, this.onInsertDataComplete, this.onInsertDataComplete, null));
            return;
        }

        protected function onInsertDataComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            return;
        }

        internal function onChangeTemplateClick(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET_CHANGE_TEMPLATE, {"sportprofile":this.sportprofile, "favsetNr":this.favsetNr, "defaultActive":this.active}, handler.ViewHandler.slideToLeftTransition(), true);
            return;
        }

        protected function onInit(arg1:starling.events.Event=null):void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=null;
            if (this.sportprofile is core.settings.interfaces.IFavSets) 
            {
                this._favSetMaxCount = (this.sportprofile as core.settings.interfaces.IFavSets).favSetMaxCount;
                loc1 = 1;
                this._favSetEditorsDataProvider = new Vector.<frontend.screen.mydevices.sportprofiles.favsets.FavSetEditor>();
                while (loc1 <= this._favSetMaxCount) 
                {
                    loc3 = new core.sportprofiles.FavFunctionList();
                    loc3 = (this.sportprofile as core.settings.interfaces.IFavSets).getFavSetObject(loc1);
                    loc2 = new frontend.screen.mydevices.sportprofiles.favsets.FavSetEditor();
                    loc2.layoutData = new feathers.layout.HorizontalLayoutData(NaN, 100);
                    loc2.id = "favSetEditor" + loc1;
                    loc2.autoInitialize = false;
                    loc2.favsetBoxTouchFunction = this.onFavsetBoxTouched;
                    loc2.enabled = loc3.active;
                    loc2.favFunctionList = loc3;
                    loc2.initEditor();
                    this._favSetEditorsDataProvider.push(loc2);
                    ++loc1;
                }
                this.favSetEditorsLoaded = true;
            }
            return;
        }

        internal function onFavsetBoxTouched(arg1:frontend.screen.mydevices.sportprofiles.favsets.FavsetBox):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET_CHANGE_CATEGORY, {"sportprofile":this.sportprofile, "favsetBox":arg1, "favsetNr":this.favsetNr}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected function onActiveCheckboxChanged(arg1:frontend.components.menuList.MenuListItem, arg2:frontend.components.menuList.editors.base.EditorReturnObject):void
        {
            this.active = arg2.rawValue as Boolean;
            var loc1:*=this.getFavFunctionList();
            loc1.active = this.active;
            this.onFavChanged(loc1);
            return;
        }

        internal function onUploadButtonClick(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILES_TRANSFER, {"unit":this.sportprofile.unit, "sportprofile":this.sportprofile, "transferModeDownload":false}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        protected function favSetEditorScroller_addedToStageHandler(arg1:starling.events.Event):void
        {
            if (!this.favSetEditorsLoaded) 
            {
                flash.utils.setTimeout(this.favSetEditorScroller_addedToStageHandler, 100, arg1);
                return;
            }
            this.favSetEditorScroller.removeChildren();
            this._scrollPosition = (this.favsetNr - 1);
            var loc1:*=0;
            while (loc1 < this._favSetEditorsDataProvider.length) 
            {
                this._favSetEditorsDataProvider[loc1].width = this.favSetEditorScroller.pageWidth;
                this.favSetEditorScroller.addChild(this._favSetEditorsDataProvider[loc1]);
                this._favSetEditorsDataProvider[loc1].validate();
                if (loc1 == this._scrollPosition) 
                {
                    this.active = (this._favSetEditorsDataProvider[loc1] as frontend.screen.mydevices.sportprofiles.favsets.FavSetEditor).favFunctionList.active;
                }
                ++loc1;
            }
            this.scrollTo(this._scrollPosition);
            return;
        }

        protected function onScrollComplete(arg1:starling.events.Event):void
        {
            this.favsetNr = this.favSetEditorScroller.horizontalPageIndex + 1;
            return;
        }

        protected function onScroll(arg1:starling.events.Event):void
        {
            if (this.pageIndicator.selectedIndex != this.favSetEditorScroller.horizontalPageIndex) 
            {
                if (this.favSetEditorScroller.horizontalPageIndex <= this._scrollIndex && this.favSetEditorScroller.horizontalScrollPosition > this._scrollPosition) 
                {
                    return;
                }
                this.pageIndicator.selectedIndex = this.favSetEditorScroller.horizontalPageIndex;
            }
            this._scrollPosition = this.favSetEditorScroller.horizontalScrollPosition;
            return;
        }

        protected function onPageIndicatorChanged(arg1:starling.events.Event):void
        {
            this._scrollIndex = this.pageIndicator.selectedIndex;
            this.favsetNr = this.pageIndicator.selectedIndex + 1;
            if (!this.favSetEditorScroller.isScrolling) 
            {
                this.scrollTo(this.pageIndicator.selectedIndex);
            }
            return;
        }

        internal function scrollTo(arg1:uint):void
        {
            if (this.favSetEditorScroller == null) 
            {
                return;
            }
            this.favSetEditorScroller.scrollToPageIndex(arg1, 0, 0);
            return;
        }

        public function set changeFunction(arg1:Function):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1095383976changeFunction;
            if (loc1 !== arg1) 
            {
                this._1095383976changeFunction = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "changeFunction", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _DeviceSportprofileFavSetView_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 2;
            loc1.paddingBottom = 25;
            this._DeviceSportprofileFavSetView_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSportprofileFavSetView_VerticalLayout1", this._DeviceSportprofileFavSetView_VerticalLayout1);
            return loc1;
        }

        internal function _DeviceSportprofileFavSetView_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.saveCompleteCallback = this.onActiveCheckboxChanged;
            loc1.useLocalesForText = false;
            loc1.id = "activeCheckbox";
            this.activeCheckbox = loc1;
            feathers.binding.BindingManager.executeBindings(this, "activeCheckbox", this.activeCheckbox);
            return loc1;
        }

        internal function _DeviceSportprofileFavSetView_CustomHScrollContainer1_i():frontend.components.scrollContainer.CustomHScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomHScrollContainer();
            loc1.autoHideBackground = true;
            loc1.clipContent = true;
            loc1.hasElasticEdges = true;
            loc1.snapToPages = true;
            loc1.addEventListener("addedToStage", this.__favSetEditorScroller_addedToStage);
            loc1.addEventListener("scroll", this.__favSetEditorScroller_scroll);
            loc1.addEventListener("scrollComplete", this.__favSetEditorScroller_scrollComplete);
            loc1.id = "favSetEditorScroller";
            this.favSetEditorScroller = loc1;
            feathers.binding.BindingManager.executeBindings(this, "favSetEditorScroller", this.favSetEditorScroller);
            return loc1;
        }

        public function __favSetEditorScroller_addedToStage(arg1:starling.events.Event):void
        {
            this.favSetEditorScroller_addedToStageHandler(arg1);
            return;
        }

        public function __favSetEditorScroller_scroll(arg1:starling.events.Event):void
        {
            this.onScroll(arg1);
            return;
        }

        public function __favSetEditorScroller_scrollComplete(arg1:starling.events.Event):void
        {
            this.onScrollComplete(arg1);
            return;
        }

        internal function _DeviceSportprofileFavSetView_CustomPageIndicator1_i():frontend.components.CustomPageIndicator
        {
            var loc1:*=new frontend.components.CustomPageIndicator();
            loc1.gap = 25;
            loc1.addEventListener("change", this.__pageIndicator_change);
            loc1.id = "pageIndicator";
            this.pageIndicator = loc1;
            feathers.binding.BindingManager.executeBindings(this, "pageIndicator", this.pageIndicator);
            return loc1;
        }

        public function __pageIndicator_change(arg1:starling.events.Event):void
        {
            this.onPageIndicatorChanged(arg1);
            return;
        }

        internal function _DeviceSportprofileFavSetView_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._DeviceSportprofileFavSetView_IconButton1_i(), this._DeviceSportprofileFavSetView_IconButton2_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _DeviceSportprofileFavSetView_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DeviceSportprofileFavSetView_IconButton1";
            this._DeviceSportprofileFavSetView_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSportprofileFavSetView_IconButton1", this._DeviceSportprofileFavSetView_IconButton1);
            return loc1;
        }

        internal function _DeviceSportprofileFavSetView_IconButton2_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "_DeviceSportprofileFavSetView_IconButton2";
            this._DeviceSportprofileFavSetView_IconButton2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_DeviceSportprofileFavSetView_IconButton2", this._DeviceSportprofileFavSetView_IconButton2);
            return loc1;
        }

        public function ___DeviceSportprofileFavSetView_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _DeviceSportprofileFavSetView_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "_DeviceSportprofileFavSetView_LayoutGroup1.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_DeviceSportprofileFavSetView_LayoutGroup1.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_DeviceSportprofileFavSetView_LayoutGroup1.width")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.HorizontalAlign.CENTER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceSportprofileFavSetView_VerticalLayout1.horizontalAlign")
            result[4] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceSportprofileFavSetView_VerticalLayout1.verticalAlign")
            result[5] = new feathers.binding.Binding(this, null, null, "activeCheckbox.checked", "active");
            result[6] = new feathers.binding.Binding(this, function ():Boolean
            {
                return favsetNr > 1;
            }, null, "activeCheckbox.editable")
            result[7] = new feathers.binding.Binding(this, function ():Boolean
            {
                return favsetNr > 1;
            }, null, "activeCheckbox.isEnabled")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_pageLabel;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "activeCheckbox.text")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "activeCheckbox.type")
            result[10] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.controls.List.SCROLL_POLICY_ON;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "favSetEditorScroller.horizontalScrollPolicy")
            result[11] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.HorizontalLayout();
            }, null, "favSetEditorScroller.layout")
            result[12] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 100);
            }, null, "favSetEditorScroller.layoutData")
            result[13] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "favSetEditorScroller.pageWidth")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.controls.List.SCROLL_BAR_DISPLAY_MODE_NONE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "favSetEditorScroller.scrollBarDisplayMode")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.controls.List.SCROLL_POLICY_OFF;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "favSetEditorScroller.verticalScrollPolicy")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.Direction.HORIZONTAL;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "pageIndicator.direction")
            result[17] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.HorizontalAlign.CENTER;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "pageIndicator.horizontalAlign")
            result[18] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.controls.PageIndicatorInteractionMode.PRECISE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "pageIndicator.interactionMode")
            result[19] = new feathers.binding.Binding(this, function ():int
            {
                return _favSetMaxCount;
            }, null, "pageIndicator.pageCount")
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "pageIndicator.verticalAlign")
            result[21] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.sportprofileTemplate;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceSportprofileFavSetView_IconButton1.image")
            result[22] = new feathers.binding.Binding(this, function ():Function
            {
                return onChangeTemplateClick;
            }, null, "_DeviceSportprofileFavSetView_IconButton1.touchHandler")
            result[23] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.uploadicon;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_DeviceSportprofileFavSetView_IconButton2.image")
            result[24] = new feathers.binding.Binding(this, function ():Function
            {
                return onUploadButtonClick;
            }, null, "_DeviceSportprofileFavSetView_IconButton2.touchHandler")
            return result;
        }

        public var _DeviceSportprofileFavSetView_IconButton1:frontend.components.button.IconButton;

        public var _DeviceSportprofileFavSetView_IconButton2:frontend.components.button.IconButton;

        public var _DeviceSportprofileFavSetView_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _DeviceSportprofileFavSetView_VerticalLayout1:feathers.layout.VerticalLayout;

        internal var _665806615activeCheckbox:frontend.components.menuList.MenuListItem;

        internal var _972775406favSetEditorScroller:frontend.components.scrollContainer.CustomHScrollContainer;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _643699648pageIndicator:frontend.components.CustomPageIndicator;

        internal var _1095383976changeFunction:Function;

        internal var _favsetNr:uint;

        public var sportprofile:core.sportprofiles.Sportprofile;

        internal var _favSetEditorsDataProvider:__AS3__.vec.Vector.<frontend.screen.mydevices.sportprofiles.favsets.FavSetEditor>;

        internal var _857027729_favSetMaxCount:uint=0;

        internal var _623155162_pageLabel:String="";

        internal var _scrollIndex:uint=0;

        internal var _scrollPosition:Number=0;

        internal var favSetEditorsLoaded:Boolean=false;

        internal var _56421971verticalSeperatorLineVisible:Boolean;

        mx_internal var _watchers:Array;

        internal var _active:Boolean=true;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


