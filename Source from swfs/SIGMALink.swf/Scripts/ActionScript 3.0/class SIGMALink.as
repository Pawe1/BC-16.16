//class SIGMALink
package 
{
    import database.*;
    import debug.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.themes.*;
    import flash.events.*;
    import flash.system.*;
    import frontend.components.*;
    import frontend.screen.databaseUpdate.*;
    import handler.*;
    import helper.*;
    import starling.events.*;
    
    public class SIGMALink extends feathers.core.Application
    {
        public function SIGMALink()
        {
            super();
            this.addEventListener("initialize", this.___SIGMALink_Application1_initialize);
            return;
        }

        public static function set containerHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=SIGMALink._83469576containerHeight;
            if (loc1 !== arg1) 
            {
                SIGMALink._83469576containerHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "containerHeight", loc1, arg1, SIGMALink);
                loc3 = SIGMALink.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get footerHeight():Number
        {
            return SIGMALink._976858462footerHeight;
        }

        internal function initApp():void
        {
            debug.Debug.info("initializing Application with scaleFactor: " + scaleFactor);
            new feathers.themes.SIGMATheme();
            return;
        }

        public function startApp():void
        {
            debug.Debug.info("Starting Application with: " + appWidth + "px * " + appHeight + "px");
            debug.Debug.info("+++ [initWorker] -> Worker.isSupported: " + flash.system.Worker.isSupported);
            debug.Debug.info("+++ [initWorker] -> Worker.current.isPrimordial: " + flash.system.Worker.current.isPrimordial);
            this.initAppDrawer();
            handler.AppDBHandler.getInstance().addEventListener(database.DBHandler.DATABASE_VALIDATED, this.onDatabaseValidated);
            handler.ApplicationHandler.getInstance().init();
            return;
        }

        internal function initAppDrawer():void
        {
            drawer = new frontend.components.MainApplicationDrawer();
            drawer.initMainApplicationDrawer();
            addChild(drawer);
            return;
        }

        internal function initUpdateView():void
        {
            this.updateView = new frontend.screen.databaseUpdate.DatabaseUpdateView();
            this.updateView.addEventListener(frontend.screen.databaseUpdate.DatabaseUpdateView.UPDATE_COMPLETE, this.onUpdateComplete);
            addChild(this.updateView);
            return;
        }

        internal function onDatabaseValidated(arg1:flash.events.Event):void
        {
            handler.AppDBHandler.getInstance().removeEventListener(database.DBHandler.DATABASE_VALIDATED, this.onDatabaseValidated);
            if (database.DBHandler.showUpdateView) 
            {
                this.initUpdateView();
            }
            return;
        }

        internal function onUpdateComplete(arg1:starling.events.Event):void
        {
            (arg1.currentTarget as frontend.screen.databaseUpdate.DatabaseUpdateView).removeEventListener(frontend.screen.databaseUpdate.DatabaseUpdateView.UPDATE_COMPLETE, this.onUpdateComplete);
            removeChild(this.updateView);
            this.updateView.dispose();
            this.updateView = null;
            return;
        }

        public function ___SIGMALink_Application1_initialize(arg1:starling.events.Event):void
        {
            this.initApp();
            return;
        }

        public static function set footerHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=SIGMALink._976858462footerHeight;
            if (loc1 !== arg1) 
            {
                SIGMALink._976858462footerHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "footerHeight", loc1, arg1, SIGMALink);
                loc3 = SIGMALink.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get headerHeight():Number
        {
            return SIGMALink._1676640788headerHeight;
        }

        public static function set headerHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=SIGMALink._1676640788headerHeight;
            if (loc1 !== arg1) 
            {
                SIGMALink._1676640788headerHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "headerHeight", loc1, arg1, SIGMALink);
                loc3 = SIGMALink.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get headerTop():Number
        {
            return SIGMALink._213303416headerTop;
        }

        public static function set headerTop(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=SIGMALink._213303416headerTop;
            if (loc1 !== arg1) 
            {
                SIGMALink._213303416headerTop = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "headerTop", loc1, arg1, SIGMALink);
                loc3 = SIGMALink.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get scaleFactor():Number
        {
            return SIGMALink._1210167495scaleFactor;
        }

        public static function set scaleFactor(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=SIGMALink._1210167495scaleFactor;
            if (loc1 !== arg1) 
            {
                SIGMALink._1210167495scaleFactor = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "scaleFactor", loc1, arg1, SIGMALink);
                loc3 = SIGMALink.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            _213303416headerTop = 0;
            _1210167495scaleFactor = 1;
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public static function toggleNavi():void
        {
            if (!drawer) 
            {
                return;
            }
            drawer.toggleNavi();
            return;
        }

        public static function get appHeight():Number
        {
            return SIGMALink._1170807464appHeight;
        }

        public static function set appHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=SIGMALink._1170807464appHeight;
            if (loc1 !== arg1) 
            {
                SIGMALink._1170807464appHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "appHeight", loc1, arg1, SIGMALink);
                loc3 = SIGMALink.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get appWidth():Number
        {
            return SIGMALink._1160114213appWidth;
        }

        public static function set appWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=SIGMALink._1160114213appWidth;
            if (loc1 !== arg1) 
            {
                SIGMALink._1160114213appWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "appWidth", loc1, arg1, SIGMALink);
                loc3 = SIGMALink.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get containerHeight():Number
        {
            return SIGMALink._83469576containerHeight;
        }

        public static const iOSHeaderCorrectur:Number=helper.Capabilities_helper.isIOS() ? 40 : 0;

        internal var initialLanguage:String;

        internal var updateView:frontend.screen.databaseUpdate.DatabaseUpdateView;

        internal static var _1170807464appHeight:Number;

        internal static var _1160114213appWidth:Number;

        internal static var _83469576containerHeight:Number;

        public static var drawer:frontend.components.MainApplicationDrawer;

        internal static var _976858462footerHeight:Number;

        internal static var _1676640788headerHeight:Number;

        internal static var _213303416headerTop:Number=0;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        internal static var _1210167495scaleFactor:Number=1;
    }
}


