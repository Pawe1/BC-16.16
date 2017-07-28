//class DeleteUserPopUp
package frontend.screen.appsettings.benutzer 
{
    import __AS3__.vec.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.core.*;
    import frontend.components.menuList.*;
    import frontend.components.popup.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class DeleteUserPopUp extends frontend.components.popup.DeletePopUp
    {
        public function DeleteUserPopUp()
        {
            super();
            title = utils.LanguageManager.getString("DELETE_POPUP.DELETE_USERS_TITLE");
            deleteBtnLabel = utils.LanguageManager.getString("DELETE_POPUP.DELETE_USERS_CONFIRM");
            return;
        }

        public function get users():__AS3__.vec.Vector.<core.user.User>
        {
            return this._users;
        }

        public function set users(arg1:__AS3__.vec.Vector.<core.user.User>):void
        {
            this._users = arg1;
            return;
        }

        internal function onUserSelected(arg1:starling.events.Event):void
        {
            this.selectedUserId = (arg1.currentTarget as frontend.components.menuList.MenuListItem).value as int;
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            height = SIGMALink.appHeight * 0.7;
            return;
        }

        protected override function addContent():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc5:*=null;
            var loc6:*=null;
            contentHolder = new feathers.controls.LayoutGroup();
            contentHolder.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            contentHolder.layout = new feathers.layout.AnchorLayout();
            contentHolder.layoutData = contentLayoutData;
            contentHolder.width = SIGMALink.appWidth;
            contentHolder.height = height - HEADER_HEIGHT - FOOTER_HEIGHT;
            addChild(contentHolder);
            loc1 = new feathers.data.ListCollection();
            var loc3:*=this.users.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc1.push({"label":this.users[loc2].name, "data":this.users[loc2].userId});
                ++loc2;
            }
            var loc4:*=new feathers.layout.VerticalLayout();
            loc4.padding = 0;
            loc4.gap = 0;
            loc5 = new feathers.controls.LayoutGroup();
            loc5.layout = loc4;
            loc5.width = SIGMALink.appWidth;
            loc6 = new feathers.controls.Label();
            loc6.text = this.numToDelete != 1 ? utils.LanguageManager.getString("DELETE_POPUP.DELETE_USERS_WARNING_MULTI") : utils.LanguageManager.getString("DELETE_POPUP.DELETE_USERS_WARNING_SINGLE");
            loc6.wordWrap = true;
            loc6.width = SIGMALink.appWidth - 2 * _layoutGap;
            loc6.padding = _layoutGap;
            loc6.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            loc5.addChild(loc6);
            var loc7:*=new frontend.components.core.Spacer();
            loc7.height = _layoutGap;
            loc5.addChild(loc7);
            var loc8:*=new feathers.controls.Label();
            loc8.text = utils.LanguageManager.getString("DELETE_POPUP.DELETE_USERS_TEXT");
            loc8.wordWrap = true;
            loc8.width = SIGMALink.appWidth - 2 * _layoutGap;
            loc8.padding = _layoutGap;
            loc8.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            loc5.addChild(loc8);
            var loc9:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            loc5.addChild(loc9);
            this.selectedUserId = this.users[0].userId;
            var loc10:*=new frontend.components.menuList.MenuListItem();
            loc10.dataProvider = loc1;
            loc10.defaultValue = this.users[0].userId;
            loc10.type = frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER;
            loc10.editable = true;
            loc10.minItemHeight = frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            loc10.text = "APPSETTINGS.BENUTZER";
            loc10.title = "APPSETTINGS.BENUTZER";
            loc10.addEventListener("completeEvent", this.onUserSelected);
            loc5.addChild(loc10);
            var loc11:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            loc5.addChild(loc11);
            contentHolder.addChild(loc5);
            return;
        }

        protected override function validatePopUpContent():void
        {
            return;
        }

        public var numToDelete:int;

        public var selectedUserId:int;

        internal var _users:__AS3__.vec.Vector.<core.user.User>;
    }
}


