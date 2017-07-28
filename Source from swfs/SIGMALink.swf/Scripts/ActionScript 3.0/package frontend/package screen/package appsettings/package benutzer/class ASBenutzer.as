//class ASBenutzer
package frontend.screen.appsettings.benutzer 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.general.*;
    import core.user.*;
    import database.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.events.*;
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
    import frontend.components.menuList.*;
    import frontend.components.popup.*;
    import frontend.components.scrollContainer.*;
    import frontend.screen.component.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ASBenutzer extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ASBenutzer()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._buttonAdd = new frontend.components.button.IconButton();
            this._buttonCancel = new frontend.components.button.IconButton();
            this._buttonDelete = new frontend.components.button.IconButton();
            this._buttonEdit = new frontend.components.button.IconButton();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ASBenutzer_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_appsettings_benutzer_ASBenutzerWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ASBenutzer[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._ASBenutzer_CustomVScrollContainer1_i(), this._ASBenutzer_Footer1_i()];
            this.addEventListener("initialize", this.___ASBenutzer_CustomScreen1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _ASBenutzer_CustomVScrollContainer1_i():frontend.components.scrollContainer.CustomVScrollContainer
        {
            var loc1:*=new frontend.components.scrollContainer.CustomVScrollContainer();
            loc1.mxmlContent = [this._ASBenutzer_MenuList1_i()];
            loc1.id = "scroller";
            this.scroller = loc1;
            feathers.binding.BindingManager.executeBindings(this, "scroller", this.scroller);
            return loc1;
        }

        internal function _ASBenutzer_MenuList1_i():frontend.components.menuList.MenuList
        {
            var loc1:*=new frontend.components.menuList.MenuList();
            loc1.id = "userList";
            this.userList = loc1;
            feathers.binding.BindingManager.executeBindings(this, "userList", this.userList);
            return loc1;
        }

        internal function _ASBenutzer_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___ASBenutzer_CustomScreen1_initialize(arg1:starling.events.Event):void
        {
            this.initializeHandler(arg1);
            return;
        }

        internal function _ASBenutzer_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.BENUTZER.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "scroller.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "scroller.width")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "userList.width")
            return result;
        }

        protected function cancelEditHandler(arg1:starling.events.TouchEvent):void
        {
            this.userList.selectMode = false;
            this.setFooterButtons();
            return;
        }

        public function get footer():frontend.screen.component.Footer
        {
            return this._1268861541footer;
        }

        public function get scroller():frontend.components.scrollContainer.CustomVScrollContainer
        {
            return this._402164678scroller;
        }

        public function set scroller(arg1:frontend.components.scrollContainer.CustomVScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._402164678scroller;
            if (loc1 !== arg1) 
            {
                this._402164678scroller = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "scroller", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get userList():frontend.components.menuList.MenuList
        {
            return this._266718455userList;
        }

        public function set userList(arg1:frontend.components.menuList.MenuList):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._266718455userList;
            if (loc1 !== arg1) 
            {
                this._266718455userList = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "userList", loc1, arg1, this);
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
            ASBenutzer._watcherSetupUtil = arg1;
            return;
        }

        protected function initializeHandler(arg1:starling.events.Event):void
        {
            this._buttonEdit = new frontend.components.button.IconButton();
            this._buttonEdit.image = frontend.Textures.editbutton;
            this._buttonEdit.touchHandler = this.editUserHandler;
            this._buttonDelete = new frontend.components.button.IconButton();
            this._buttonDelete.image = frontend.Textures.trashicon;
            this._buttonDelete.touchHandler = this.deleteUserHandler;
            this._buttonCancel = new frontend.components.button.IconButton();
            this._buttonCancel.image = frontend.Textures.closeicon;
            this._buttonCancel.touchHandler = this.cancelEditHandler;
            this._buttonAdd = new frontend.components.button.IconButton();
            this._buttonAdd.image = frontend.Textures.addiconwhite;
            this._buttonAdd.touchHandler = this.addUserHandler;
            this.setFooterButtons();
            return;
        }

        internal function setFooterButtons():void
        {
            this._buttonGroup = new Vector.<frontend.components.button.IconButton>();
            this._buttonEdit.isEnabled = this._userCount > 1;
            this._buttonDelete.isEnabled = this._userCount > 1;
            if (this.userList.selectMode) 
            {
                this._buttonGroup.push(this._buttonDelete);
                this._buttonGroup.push(this._buttonCancel);
            }
            else 
            {
                this._buttonGroup.push(this._buttonAdd);
                this._buttonGroup.push(this._buttonEdit);
            }
            this.footer.showBackButton = !this.userList.selectMode;
            this.footer.setButtonGroup(this._buttonGroup);
            return;
        }

        protected override function addContent():void
        {
            this.userList.removeChildren();
            var loc1:*=core.user.User.statementGetUsers();
            loc1 = loc1 + " ORDER BY name COLLATE NOCASE ASC";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadUsersComplete, this.loadUsersError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function loadUsersComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc2:*=0;
            var loc4:*=null;
            var loc1:*=arg1.getResult();
            var loc3:*=loc1.length;
            this._userCount = 0;
            this._buttonEdit.isEnabled = false;
            this._buttonDelete.isEnabled = false;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = new core.user.User();
                loc4.fromDB(loc1[loc2]);
                this.addUser(loc4);
                ++loc2;
            }
            this._buttonEdit.isEnabled = this._userCount > 1;
            return;
        }

        internal function addUser(arg1:core.user.User):frontend.components.menuList.MenuListItem
        {
            var loc1:*=this.createItem(arg1);
            loc1.saveToDbUseUpdate = true;
            loc1.saveToDbUseUpdateObject = this.createSQLUpdateObject(arg1);
            this.userList.addChild(loc1);
            var loc2:*;
            var loc3:*=((loc2 = this)._userCount + 1);
            loc2._userCount = loc3;
            return loc1;
        }

        internal function createItem(arg1:core.user.User=null):frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
            loc1.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc1.editable = true;
            loc1.displayText = false;
            loc1.defaultValue = arg1 ? arg1.name : "";
            loc1.useLocalesForText = false;
            loc1.title = "ASBENUTZER.LINETITLENAME";
            loc1.destinationObject = arg1;
            loc1.useLocalesForTitle = true;
            return loc1;
        }

        internal function createSQLUpdateObject(arg1:core.user.User):frontend.components.menuList.MenuListDbObject
        {
            var loc1:*=new frontend.components.menuList.MenuListDbObject();
            loc1.keyField = core.user.User.COL_USER_ID;
            loc1.keyValue = arg1.userId.toString();
            loc1.updateField = core.user.User.COL_NAME;
            loc1.table = core.user.User.TABLE_NAME;
            loc1.updateModificationDate = false;
            return loc1;
        }

        internal function loadUsersError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("loadUsersError");
            return;
        }

        protected function addUserHandler(arg1:starling.events.TouchEvent):void
        {
            debug.Debug.debug("addUserButtonClicked");
            var loc1:*=this.createItem();
            loc1.addEventListener("completeEvent", this.onAddUserComplete);
            loc1.onInit();
            loc1.showEditor();
            return;
        }

        internal function onAddUserComplete(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as frontend.components.menuList.MenuListItem;
            var loc2:*="INSERT OR REPLACE INTO User (name, gender, color) VALUES (:name, :gender, :color)";
            var loc3:*=new Object();
            loc3[":name"] = loc1.value as String;
            loc3[":gender"] = core.general.Gender.MALE;
            loc3[":color"] = core.general.Colors.RED;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc2, this.insertUsersComplete, this.insertUsersError, null, null, loc3);
            return;
        }

        internal function insertUsersComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this.addContent();
            return;
        }

        internal function insertUsersError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("ASBenutzer > insertUsersError");
            return;
        }

        protected function editUserHandler(arg1:starling.events.TouchEvent):void
        {
            this.userList.selectMode = true;
            this.setFooterButtons();
            return;
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

        protected function deleteUserHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            this._deleteUserList = new Vector.<core.user.User>();
            this._restUserList = new Vector.<core.user.User>();
            var loc2:*=this.userList.numChildren;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                loc3 = this.userList.getChildAt(loc1) as frontend.components.menuList.MenuListItem;
                loc4 = loc3.destinationObject as core.user.User;
                if (loc3 && loc3.isSelected) 
                {
                    this._deleteUserList.push(loc4);
                }
                else 
                {
                    this._restUserList.push(loc4);
                }
                ++loc1;
            }
            if (this._restUserList.length == 0) 
            {
                loc6 = new frontend.components.popup.InfoPopUp(false, true, null, this.onErrorPopUpClose);
                loc6.headline = utils.LanguageManager.getString("DELETE_POPUP.DELETE_USERS_TITLE");
                loc6.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_USERS_ERROR_MINIMUM_ONE_USER");
                frontend.components.popup.PopUpBase.showModalPopUp(loc6);
                return;
            }
            if (this._deleteUserList.length > 0) 
            {
                this._deletePopUp = new frontend.screen.appsettings.benutzer.DeleteUserPopUp();
                this._deletePopUp.users = this._restUserList;
                this._deletePopUp.numToDelete = this._deleteUserList.length;
                this._deletePopUp.cancelCallback = this.onPopUpClose;
                this._deletePopUp.deleteCallback = this.onPopUpDelete;
                frontend.components.popup.PopUpBase.showModalPopUp(this._deletePopUp);
            }
            return;
        }

        internal function onErrorPopUpClose(arg1:frontend.components.popup.InfoPopUp):void
        {
            frontend.components.popup.PopUpBase.removePopUps(arg1, true);
            return;
        }

        internal function onPopUpClose():void
        {
            frontend.components.popup.PopUpBase.removePopUps(this._deletePopUp, true);
            return;
        }

        internal function onPopUpDelete():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc2:*=this._deleteUserList.length;
            if (this._deleteUserList.length > 0) 
            {
                loc4 = this._deleteUserList.shift();
                loc5 = "UPDATE Activity set userId = \'" + this._deletePopUp.selectedUserId + "\' WHERE userId = \'" + loc4.userId + "\'";
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc5, this.onUpdateActivityComplete, this.onUpdateActivityError, Workers.worker_DatabaseWorker, loc4);
            }
            else 
            {
                this.userList.selectMode = false;
                this.setFooterButtons();
                frontend.components.popup.PopUpBase.removePopUps(this._deletePopUp, true);
                this.addContent();
            }
            return;
        }

        internal function onUpdateActivityComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc1:*=arg1.data.data as core.user.User;
            var loc2:*=(loc1.generateDBDelete()[0] as database.DCSQLStatement).text;
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc2, this.onDeleteUserComplete, this.onDeleteUserError);
            return;
        }

        internal function onUpdateActivityError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onUpdateActivityError");
            return;
        }

        internal function onDeleteUserComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            this.onPopUpDelete();
            return;
        }

        internal function onDeleteUserError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("onDeleteActivityError");
            return;
        }

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _402164678scroller:frontend.components.scrollContainer.CustomVScrollContainer;

        internal var _266718455userList:frontend.components.menuList.MenuList;

        internal var _buttonAdd:frontend.components.button.IconButton;

        internal var _buttonCancel:frontend.components.button.IconButton;

        internal var _buttonEdit:frontend.components.button.IconButton;

        internal var _buttonGroup:__AS3__.vec.Vector.<frontend.components.button.IconButton>;

        internal var _deletePopUp:frontend.screen.appsettings.benutzer.DeleteUserPopUp;

        internal var _deleteUserList:__AS3__.vec.Vector.<core.user.User>;

        internal var _restUserList:__AS3__.vec.Vector.<core.user.User>;

        internal var _userCount:uint=0;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal var _buttonDelete:frontend.components.button.IconButton;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


