//class ASKontenSetting
package frontend.screen.appsettings.konten 
{
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.general.*;
    import core.sport.*;
    import core.user.*;
    import debug.*;
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
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.popup.oauth.*;
    import frontend.screen.appsettings.konten.list.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ASKontenSetting extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function ASKontenSetting()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._313456815_listLayoutData = new feathers.layout.VerticalLayoutData(100, 100);
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ASKontenSetting_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_konten_ASKontenSettingWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.screen.appsettings.konten.ASKontenSetting[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._ASKontenSetting_LayoutGroup2_i(), this._ASKontenSetting_CustomGroupedList1_i()];
            this.addEventListener("addedToStage", this.___ASKontenSetting_LayoutGroup1_addedToStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function set toggleLabel(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._663631872toggleLabel;
            if (loc1 !== arg1) 
            {
                this._663631872toggleLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "toggleLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set oauthInstance(arg1:frontend.components.popup.oauth.CustomOAuth):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.oauthInstance;
            if (loc1 !== arg1) 
            {
                this._1940553804oauthInstance = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "oauthInstance", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _autoSharingEnabledProperty():String
        {
            return this._1524315112_autoSharingEnabledProperty;
        }

        internal function set _autoSharingEnabledProperty(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1524315112_autoSharingEnabledProperty;
            if (loc1 !== arg1) 
            {
                this._1524315112_autoSharingEnabledProperty = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_autoSharingEnabledProperty", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _listLayoutData():feathers.layout.VerticalLayoutData
        {
            return this._313456815_listLayoutData;
        }

        public function get oauthInstance():frontend.components.popup.oauth.CustomOAuth
        {
            return this._oauthInstance;
        }

        internal function set _1940553804oauthInstance(arg1:frontend.components.popup.oauth.CustomOAuth):void
        {
            this._oauthInstance = arg1;
            this._autoSharingEnabledProperty = this._oauthInstance.className + handler.SharingHandler.AUTO_SHARE_KEY + handler.SharingHandler.ENABLED_KEY;
            return;
        }

        internal function set _listLayoutData(arg1:feathers.layout.VerticalLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._313456815_listLayoutData;
            if (loc1 !== arg1) 
            {
                this._313456815_listLayoutData = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_listLayoutData", loc1, arg1, this);
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

        public static function validateHeaderGroupSelection(arg1:frontend.components.list.CustomGroupedList):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc8:*=0;
            loc6 = arg1.dataProvider;
            var loc7:*=loc6.getLength();
            loc1 = 0;
            while (loc1 < loc7) 
            {
                loc4 = loc6.getItemAt(loc1) as frontend.screen.appsettings.konten.list.AutoShareListGroup;
                loc3 = loc4.children.length;
                loc8 = 0;
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc5 = loc4.children[loc2] as frontend.screen.appsettings.konten.list.AutoShareListItem;
                    if (loc5.selected) 
                    {
                        ++loc8;
                    }
                    ++loc2;
                }
                loc4.header.selected = loc8 > loc4.children.length / 2;
                loc6.updateItemAt(loc1);
                ++loc1;
            }
            return;
        }

        public static function validateChildSelection(arg1:frontend.components.list.CustomGroupedList):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc8:*=0;
            loc6 = arg1.dataProvider;
            var loc7:*=loc6.getLength();
            loc1 = 0;
            while (loc1 < loc7) 
            {
                loc4 = loc6.getItemAt(loc1) as frontend.screen.appsettings.konten.list.AutoShareListGroup;
                loc3 = loc4.children.length;
                loc8 = 0;
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    loc5 = loc4.children[loc2] as frontend.screen.appsettings.konten.list.AutoShareListItem;
                    loc5.selected = loc4.header.selected;
                    ++loc2;
                }
                loc6.updateItemAt(loc1);
                ++loc1;
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            frontend.screen.appsettings.konten.ASKontenSetting._watcherSetupUtil = arg1;
            return;
        }

        internal function onAddedToStage():void
        {
            var loc1:*="select distinct sportId from Activity where isDeleted = false";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.onSportIdsComplete, this.onSportIdsError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function onSportIdsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onSportIdsError");
            return;
        }

        internal function onSportIdsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this._sportIds = arg1.getResult();
            var loc1:*="select * from User";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.onUserIdsComplete, this.onUserIdsError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function onUserIdsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onUserIdsError");
            return;
        }

        internal function onUserIdsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this._users = arg1.getResult();
            this.updateList();
            return;
        }

        internal function updateList():void
        {
            var loc1:*=0;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            this.listDataProvider = new feathers.data.HierarchicalCollection();
            var loc2:*=this._sportIds.length;
            var loc3:*=new frontend.screen.appsettings.konten.list.AutoShareListGroup();
            var loc4:*=new frontend.screen.appsettings.konten.list.AutoShareListGroupHeader();
            loc4.name = utils.LanguageManager.getString("APPSETTINGS.KONTEN.SPORT");
            loc3.header = loc4;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc7 = handler.SportHandler.getInstance().resolveSportById(this._sportIds[loc1].sportId);
                loc8 = new frontend.screen.appsettings.konten.list.AutoShareListItem();
                loc8.sportId = loc7.sportId;
                loc8.key = this.oauthInstance.className + handler.SharingHandler.AUTO_SHARE_KEY + loc7.keyName;
                loc8.label = loc7.name;
                loc8.selected = configCache.ConfigCache.getInstance().getValue(loc8.key, true);
                loc3.addItem(loc8);
                ++loc1;
            }
            this.listDataProvider.addItemAt(loc3, (this.listDataProvider.data as Array).length);
            var loc5:*=new frontend.screen.appsettings.konten.list.AutoShareListGroup();
            var loc6:*=new frontend.screen.appsettings.konten.list.AutoShareListGroupHeader();
            loc6.name = utils.LanguageManager.getString("APPSETTINGS.KONTEN.USER");
            loc5.header = loc6;
            loc2 = this._users.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc9 = new core.user.User();
                loc9.fromDB(this._users[loc1]);
                loc10 = new frontend.screen.appsettings.konten.list.AutoShareListItem();
                loc10.userId = loc9.userId;
                loc10.key = this.oauthInstance.className + handler.SharingHandler.AUTO_SHARE_KEY + "user" + loc9.userId;
                loc10.label = loc9.name;
                loc10.selected = configCache.ConfigCache.getInstance().getValue(loc10.key, true);
                loc5.addItem(loc10);
                ++loc1;
            }
            this.listDataProvider.addItemAt(loc5, (this.listDataProvider.data as Array).length);
            this.list.dataProvider = this.listDataProvider;
            validateHeaderGroupSelection(this.list);
            return;
        }

        internal function onToggleButtonComplete():void
        {
            this.toggleLabel.width = SIGMALink.appWidth - this.autoShareOption.width - PADDING;
            this.toggleList(this.autoShareOption.checked);
            return;
        }

        internal function onAutoShareOptionChange(arg1:Boolean):void
        {
            configCache.ConfigCache.getInstance().setValue(this._autoSharingEnabledProperty, arg1);
            this.toggleList(arg1);
            return;
        }

        internal function toggleList(arg1:Boolean):void
        {
            if (this.list == null) 
            {
                return;
            }
            var loc1:*=new starling.animation.Tween(this._listLayoutData, this.ANIMATION_DURATION, starling.animation.Transitions.EASE_IN);
            loc1.animate("percentHeight", arg1 ? 100 : 0);
            var loc2:*=new starling.animation.Tween(this.list, this.ANIMATION_DURATION, starling.animation.Transitions.EASE_OUT_IN_ELASTIC);
            loc2.fadeTo(arg1 ? 1 : 0);
            starling.core.Starling.juggler.add(loc1);
            starling.core.Starling.juggler.add(loc2);
            return;
        }

        internal function _ASKontenSetting_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ASKontenSetting_AnchorLayout1_c();
            loc1.mxmlContent = [this._ASKontenSetting_Label1_i(), this._ASKontenSetting_OnOffToggleButton1_i()];
            loc1.id = "_ASKontenSetting_LayoutGroup2";
            this._ASKontenSetting_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ASKontenSetting_LayoutGroup2", this._ASKontenSetting_LayoutGroup2);
            return loc1;
        }

        internal function _ASKontenSetting_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ASKontenSetting_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "toggleLabel";
            this.toggleLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "toggleLabel", this.toggleLabel);
            return loc1;
        }

        internal function _ASKontenSetting_OnOffToggleButton1_i():frontend.components.menuList.editors.base.OnOffToggleButton
        {
            var loc1:*=new frontend.components.menuList.editors.base.OnOffToggleButton();
            loc1.addEventListener("creationComplete", this.__autoShareOption_creationComplete);
            loc1.id = "autoShareOption";
            this.autoShareOption = loc1;
            feathers.binding.BindingManager.executeBindings(this, "autoShareOption", this.autoShareOption);
            return loc1;
        }

        public function __autoShareOption_creationComplete(arg1:starling.events.Event):void
        {
            this.onToggleButtonComplete();
            return;
        }

        internal function _ASKontenSetting_CustomGroupedList1_i():frontend.components.list.CustomGroupedList
        {
            var loc1:*=new frontend.components.list.CustomGroupedList();
            loc1.clipContent = true;
            loc1.stickyHeader = true;
            loc1.id = "list";
            this.list = loc1;
            feathers.binding.BindingManager.executeBindings(this, "list", this.list);
            return loc1;
        }

        public function ___ASKontenSetting_LayoutGroup1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddedToStage();
            return;
        }

        internal function _ASKontenSetting_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.VerticalLayout();
            }, null, "this.layout")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.VerticalLayoutData(100, 100);
            }, null, "this.layoutData")
            result[2] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "_ASKontenSetting_LayoutGroup2.backgroundSkin")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_ASKontenSetting_LayoutGroup2.height")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(0);
            }, null, "_ASKontenSetting_LayoutGroup2.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ASKontenSetting_LayoutGroup2.width")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, PADDING, NaN, 0);
            }, null, "toggleLabel.layoutData")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "toggleLabel.styleName")
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.AUTO_SHARE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "toggleLabel.text")
            result[9] = new feathers.binding.Binding(this, function ():Boolean
            {
                return configCache.ConfigCache.getInstance().getValue(_autoSharingEnabledProperty, false);
            }, null, "autoShareOption.checked")
            result[10] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, 0, NaN, NaN, NaN, 0);
            }, null, "autoShareOption.layoutData")
            result[11] = new feathers.binding.Binding(this, function ():Function
            {
                return onAutoShareOptionChange;
            }, null, "autoShareOption.toggleChangedFunction")
            result[12] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.appsettings.konten.list.AutoShareHeaderRenderer;
            }, null, "list.headerRendererType")
            result[13] = new feathers.binding.Binding(this, function ():Boolean
            {
                return autoShareOption.checked;
            }, null, "list.isEnabled")
            result[14] = new feathers.binding.Binding(this, function ():Class
            {
                return frontend.screen.appsettings.konten.list.AutoShareListItemRenderer;
            }, null, "list.itemRendererType")
            result[15] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return _listLayoutData;
            }, null, "list.layoutData")
            result[16] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "list.width")
            return result;
        }

        public function get autoShareOption():frontend.components.menuList.editors.base.OnOffToggleButton
        {
            return this._270194693autoShareOption;
        }

        public function set autoShareOption(arg1:frontend.components.menuList.editors.base.OnOffToggleButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._270194693autoShareOption;
            if (loc1 !== arg1) 
            {
                this._270194693autoShareOption = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "autoShareOption", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get list():frontend.components.list.CustomGroupedList
        {
            return this._3322014list;
        }

        public function set list(arg1:frontend.components.list.CustomGroupedList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3322014list;
            if (loc1 !== arg1) 
            {
                this._3322014list = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "list", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get toggleLabel():feathers.controls.Label
        {
            return this._663631872toggleLabel;
        }

        internal const ANIMATION_DURATION:Number=0.3;

        internal static const PADDING:Number=20 * SIGMALink.scaleFactor;

        public var _ASKontenSetting_LayoutGroup2:feathers.controls.LayoutGroup;

        internal var _270194693autoShareOption:frontend.components.menuList.editors.base.OnOffToggleButton;

        internal var _3322014list:frontend.components.list.CustomGroupedList;

        internal var _663631872toggleLabel:feathers.controls.Label;

        internal var _oauthInstance:frontend.components.popup.oauth.CustomOAuth;

        internal var _1524315112_autoSharingEnabledProperty:String="";

        internal var _313456815_listLayoutData:feathers.layout.VerticalLayoutData;

        internal var _sportIds:Array;

        internal var _users:Array;

        internal var _1399580807listDataProvider:feathers.data.HierarchicalCollection;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


