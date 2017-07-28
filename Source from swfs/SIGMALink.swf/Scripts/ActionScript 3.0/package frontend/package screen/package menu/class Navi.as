//class Navi
package frontend.screen.menu 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import flash.system.*;
    import frontend.*;
    import frontend.components.scrollContainer.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    import utils.*;
    
    public class Navi extends feathers.controls.LayoutGroup
    {
        public function Navi()
        {
            super();
            height = SIGMALink.appHeight;
            width = MENU_ITEM_WIDTH;
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.DARKGREY);
            layout = new feathers.layout.AnchorLayout();
            this._scroller = new frontend.components.scrollContainer.CustomVScrollContainer();
            this._scroller.width = width;
            this._scroller.height = height - 2 * MENU_ITEM_HEIGHT - 1 * SIGMALink.scaleFactor - SIGMALink.iOSHeaderCorrectur * SIGMALink.scaleFactor;
            this._scroller.layoutData = new feathers.layout.AnchorLayoutData(MENU_ITEM_HEIGHT + SIGMALink.iOSHeaderCorrectur * SIGMALink.scaleFactor);
            this._scroller.clipContent = true;
            this._scroller.backgroundSkin = backgroundSkin;
            addEventListener(feathers.events.FeathersEventType.INITIALIZE, this.update);
            return;
        }

        public function update(arg1:starling.events.Event=null):void
        {
            this._scroller.removeChildren();
            removeChildren();
            addChild(this._scroller);
            this.addNaviItem(NO_DESTINATION_USE_TOUCH_FUNCTION, "", frontend.Textures.sigmagermanylogowhite, false, true, false, SIGMALink.toggleNavi);
            this.addNaviItem(handler.ViewHandler.VIEW_DASHBOARD, "MAINMENU.DASHBOARD", frontend.Textures.dashboard);
            this.addNaviItem(handler.ViewHandler.VIEW_ACTIVITIES_LIST, "MAINMENU.ACTIVITIES_LIST", frontend.Textures.aktivitaeten);
            this.addNaviItem(handler.ViewHandler.VIEW_TOPVALUES, "MAINMENU.TOPVALUES", frontend.Textures.topvaluesiconwhite);
            this.addNaviItem(handler.ViewHandler.VIEW_STATISTIC, "MAINMENU.STATISTIC", frontend.Textures.statsiconwhite);
            this.addNaviItem(handler.ViewHandler.VIEW_TRACKS, "MAINMENU.TRACKS", frontend.Textures.trackwhite);
            this.addNaviItem(handler.ViewHandler.VIEW_MYDEVICES, "MAINMENU.MYDEVICES", frontend.Textures.deviceswhite);
            this.addNaviItem(handler.ViewHandler.VIEW_APPSETTINGS, "MAINMENU.APPSETTINGS", frontend.Textures.settingsiconwhite);
            this.addNaviItem(handler.ViewHandler.VIEW_VIDEOS, "MAINMENU.VIDEOS", frontend.Textures.videoiconwhite);
            this.addNaviItem(handler.ViewHandler.VIEW_CLOUD, "MAINMENU.CLOUD", frontend.Textures.cloudiconwhite);
            if (flash.system.Capabilities.isDebugger) 
            {
                this.addNaviItem(handler.ViewHandler.VIEW_TESTS, "MAINMENU.TESTS", frontend.Textures.infoIcon);
            }
            this.addNaviItem(handler.ViewHandler.VIEW_ABOUT, "MAINMENU.ABOUT", frontend.Textures.sigmaminiiconwhite, true, false, true);
            return;
        }

        internal function addNaviItem(arg1:String, arg2:String, arg3:String, arg4:Boolean=true, arg5:Boolean=false, arg6:Boolean=false, arg7:Function=null):void
        {
            var loc1:*=new frontend.screen.menu.NaviItem();
            loc1.height = MENU_ITEM_HEIGHT;
            if (arg1 == NO_DESTINATION_USE_TOUCH_FUNCTION) 
            {
                if (arg7 != null) 
                {
                    loc1.touchFunction = arg7;
                }
            }
            else 
            {
                loc1.destination = arg1;
            }
            if (arg2 != "") 
            {
                loc1.labeltext = utils.LanguageManager.getString(arg2);
            }
            loc1.texture = arg3;
            loc1.useBackgroundSkin = arg4;
            loc1.width = MENU_ITEM_WIDTH;
            if (arg5) 
            {
                loc1.layoutData = new feathers.layout.AnchorLayoutData(SIGMALink.iOSHeaderCorrectur * SIGMALink.scaleFactor);
                addChild(loc1);
            }
            else if (arg6) 
            {
                loc1.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, 0);
                addChild(loc1);
            }
            else 
            {
                this._scroller.addChild(loc1);
            }
            return;
        }

        internal static function calcItemTop(arg1:int):Number
        {
            return arg1 * (MENU_ITEM_HEIGHT + LIST_VGAP);
        }

        
        {
            NO_DESTINATION_USE_TOUCH_FUNCTION = "noDestinationUseTouchFunction";
        }

        public static const MENU_ITEM_HEIGHT:Number=85 * SIGMALink.scaleFactor;

        public static const MENU_ITEM_WIDTH:Number=0.8 * SIGMALink.appWidth;

        internal static const LIST_VGAP:Number=1 * SIGMALink.scaleFactor;

        internal var _scroller:frontend.components.scrollContainer.CustomVScrollContainer;

        public static var NO_DESTINATION_USE_TOUCH_FUNCTION:String="noDestinationUseTouchFunction";
    }
}


