//class ApplicationHandler
package handler 
{
    import __AS3__.vec.*;
    import backend.oauth.*;
    import backend.utils.*;
    import backend.utils.dataprovider.*;
    import backend.utils.dbUtils.*;
    import com.logging.*;
    import core.general.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.data.*;
    import flash.data.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.permissions.*;
    import flash.system.*;
    import flash.utils.*;
    import frontend.formatter.*;
    import frontend.screen.activities.list.*;
    import frontend.screen.component.devices.*;
    import frontend.screen.tracks.tabs.list.*;
    import helper.*;
    import mx.events.*;
    import service.*;
    import service.cloud.*;
    import starling.core.*;
    import statistic.*;
    import utils.*;
    
    public class ApplicationHandler extends flash.events.EventDispatcher
    {
        public function ApplicationHandler(arg1:flash.events.IEventDispatcher=null)
        {
            var loc2:*=null;
            this.yearsWithData = new Vector.<Object>();
            super(arg1);
            var loc1:*=flash.desktop.NativeApplication.nativeApplication.applicationDescriptor;
            if (loc1) 
            {
                loc2 = loc1.namespace();
                versionLabel = loc1.loc2::description[0];
                versionNumber = loc1.loc2::versionNumber[0];
                versionNumberForFWRequest = versionNumber.replace(new RegExp("\\.", "g"), "");
            }
            com.logging.ErrorLogging.getInstance().addEventListener(com.logging.ErrorLoggingEvent.ERROR, this.onError);
            return;
        }

        public static function set versionLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc1:*=handler.ApplicationHandler._120604420versionLabel;
            if (loc1 !== arg1) 
            {
                handler.ApplicationHandler._120604420versionLabel = arg1;
                loc2 = handler.ApplicationHandler.staticEventDispatcher;
                if (!(loc2 == null) && loc2.hasEventListener("propertyChange")) 
                {
                    loc2.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(handler.ApplicationHandler, "versionLabel", loc1, arg1));
                }
            }
            return;
        }

        public static function get versionNumber():String
        {
            return handler.ApplicationHandler._632283713versionNumber;
        }

        public static function set versionNumber(arg1:String):void
        {
            var loc2:*=null;
            var loc1:*=handler.ApplicationHandler._632283713versionNumber;
            if (loc1 !== arg1) 
            {
                handler.ApplicationHandler._632283713versionNumber = arg1;
                loc2 = handler.ApplicationHandler.staticEventDispatcher;
                if (!(loc2 == null) && loc2.hasEventListener("propertyChange")) 
                {
                    loc2.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(handler.ApplicationHandler, "versionNumber", loc1, arg1));
                }
            }
            return;
        }

        public static function get staticEventDispatcher():flash.events.IEventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        public function init():void
        {
            useWorker = flash.system.Worker.isSupported ? useWorker : false;
            this.checkFilePermissions(this.onFilePermissionsChecked);
            return;
        }

        internal function onFilePermissionsChecked():void
        {
            handler.AppDBHandler.getInstance().validateDatabase();
            handler.ViewHandler.getInstance();
            frontend.formatter.LinkBackendInitializer.getInstance();
            backend.utils.DataUtils.init();
            handler.DeviceCommunicationHandlerLink.getInstance();
            backend.utils.dataprovider.UnitsDataProvider.init(service.DeviceCommunicationHandler.getInstance().isUsbSupported(), service.DeviceCommunicationHandler.getInstance().isBleSupported(), service.DeviceCommunicationHandler.getInstance().isNfcSupported());
            handler.SportHandler.init();
            statistic.Statistic.init();
            handler.SharingHandler.getInstance();
            handler.PromotionHandler.getInstance();
            handler.CommunicationHandling.getInstance();
            handler.NetworkCommunicationHandler.getInstance();
            if (helper.Capabilities_helper.isAndroid()) 
            {
                handler.NotificationHandler.getInstance();
            }
            handler.CloudHandler.getInstance();
            service.cloud.CommonCloudHandler.getInstance().addEventListener(service.cloud.CloudEvent.PROGRESS, this.handleCloudSyncProgressEvent);
            service.cloud.CommonCloudHandler.getInstance().addEventListener(service.cloud.CloudConfig.SYNC_END, this.stopHandleCloudSyncProgressEvent, false, 100);
            return;
        }

        
        {
            isSimulator = !(flash.system.Capabilities.os.indexOf("Windows") == -1) || !(flash.system.Capabilities.os.indexOf("Mac OS") == -1);
            softwareGUID = utils.GUID.create();
            useWorker = true;
            _120604420versionLabel = "";
            _632283713versionNumber = "";
            versionNumberForFWRequest = "";
            _staticBindingEventDispatcher = new flash.events.EventDispatcher();
        }

        public function checkFilePermissions(arg1:Function=null):void
        {
            var p_callback:Function=null;
            var f:flash.filesystem.File;

            var loc1:*;
            f = null;
            p_callback = arg1;
            this._checkFilePermissionsCallback = p_callback;
            if (flash.filesystem.File.permissionStatus == flash.permissions.PermissionStatus.GRANTED) 
            {
                this.onPermissionsChanged();
            }
            else 
            {
                flash.desktop.NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, this.onPermissionsChanged);
                try 
                {
                    f = new flash.filesystem.File(flash.filesystem.File.documentsDirectory.nativePath);
                    f.requestPermission();
                }
                catch (e:Error)
                {
                    onPermissionsChanged();
                }
            }
            return;
        }

        internal function onPermissionsChanged(arg1:flash.events.Event=null):void
        {
            if (arg1 != null) 
            {
                flash.desktop.NativeApplication.nativeApplication.removeEventListener(flash.events.Event.ACTIVATE, this.onPermissionsChanged);
            }
            if (flash.filesystem.File.permissionStatus != flash.permissions.PermissionStatus.GRANTED) 
            {
                com.logging.ErrorLogging.getInstance().dispatchEvent(new com.logging.ErrorLoggingEvent(com.logging.ErrorLoggingEvent.ERROR, 0, "file permissions are required!"));
            }
            if (this._checkFilePermissionsCallback != null) 
            {
                this._checkFilePermissionsCallback();
            }
            return;
        }

        public function checkOAuths():void
        {
            var loc1:*=null;
            if (handler.NetworkCommunicationHandler.online) 
            {
                loc1 = starling.core.Starling.current.nativeOverlay.stage;
                backend.oauth.SigmaOAuth.getInstance().checkLogin(loc1, false);
                backend.oauth.StravaOAuth.getInstance().checkLogin(loc1, false);
                backend.oauth.TwoPeakOAuth.getInstance().checkLogin(loc1, false);
                backend.oauth.TrainingPeaksOAuth.getInstance().checkLogin(loc1, false);
                backend.oauth.FacebookGoViralHandler.getInstance().checkLogin(loc1, false);
                backend.oauth.TwitterOAuth.getInstance().checkLogin(loc1, false);
            }
            return;
        }

        public function startDatabaseWorker():void
        {
            if (useWorker) 
            {
                backend.utils.dbUtils.DBUtil.getInstance().startWorker(Workers.worker_DatabaseWorker);
            }
            return;
        }

        internal function handleCloudSyncProgressEvent(arg1:flash.events.Event):void
        {
            flash.utils.clearTimeout(this._reloadTimeoutId);
            var loc1:*;
            var loc2:*=((loc1 = this)._cloudSyncProgressCounter + 1);
            loc1._cloudSyncProgressCounter = loc2;
            if (this._cloudSyncProgressCounter > 20) 
            {
                this._cloudSyncProgressCounter = 0;
                this._reloadTimeoutId = flash.utils.setTimeout(this.dispatchReloadEvents, 500);
            }
            return;
        }

        public function dispatchReloadEvents():void
        {
            debug.Debug.debug("dispatchReloadEvents");
            handler.ActivityHandler.getInstance().dispatchEvent(new frontend.screen.activities.list.ActivityListEvent(frontend.screen.activities.list.ActivityListEvent.RELOAD));
            handler.AppDeviceHandler.getInstance().dispatchEvent(new frontend.screen.component.devices.DeviceListEvent(frontend.screen.component.devices.DeviceListEvent.RELOAD));
            handler.RouteHandler.getInstance().dispatchEvent(new frontend.screen.tracks.tabs.list.MyTracksListEvent(frontend.screen.tracks.tabs.list.MyTracksListEvent.RELOAD));
            handler.ApplicationHandler.getInstance().validateYearsWithData();
            return;
        }

        internal function stopHandleCloudSyncProgressEvent(arg1:flash.events.Event):void
        {
            flash.utils.clearTimeout(this._reloadTimeoutId);
            this._cloudSyncProgressCounter = 0;
            this.dispatchReloadEvents();
            return;
        }

        public function validateYearsWithData():void
        {
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, handler.ActivityHandler.getInstance().generateYearsWithDataStatement(), this.onYearsSelected, this.onYearsSelectError);
            return;
        }

        internal function onYearsSelected(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc2:*=0;
            var loc6:*=null;
            var loc1:*=arg1.getResult();
            var loc3:*=loc1.length;
            handler.ApplicationHandler.getInstance().yearsWithData = new Vector.<Object>();
            var loc4:*=new Date().fullYear;
            var loc5:*=true;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                handler.ApplicationHandler.getInstance().yearsWithData.push({"label":loc1[loc2].year + "", "data":loc1[loc2].year});
                if (loc4 == loc1[loc2].year) 
                {
                    loc5 = false;
                }
                ++loc2;
            }
            if (loc5) 
            {
                loc6 = new Date();
                handler.ApplicationHandler.getInstance().yearsWithData.unshift({"label":loc6.fullYear + "", "data":loc6.fullYear});
            }
            dispatchEvent(new flash.events.Event(YEARS_WITH_DATA_CHANGED));
            return;
        }

        internal function onYearsSelectError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ApplicationHandler.getInstance().yearsWithData = new Vector.<Object>();
            debug.Debug.error("onYearsSelectError");
            return;
        }

        internal function onError(arg1:com.logging.ErrorLoggingEvent):void
        {
            if (arg1.errorType != core.general.ErrorLoggingTyp.ERROR_OLD_DC_VERSION) 
            {
                if (arg1.errorType != core.general.ErrorLoggingTyp.ERROR_INVALID_DATABASE) 
                {
                    if (flash.system.Capabilities.isDebugger) 
                    {
                        feathers.controls.Alert.show(arg1.message, "ERROR", new feathers.data.ListCollection([{"label":"OK"}]));
                    }
                }
                else 
                {
                    feathers.controls.Alert.show(arg1.message, "ERROR");
                }
            }
            else 
            {
                feathers.controls.Alert.show("wrong database version", "ERROR");
            }
            return;
        }

        public static function getInstance():handler.ApplicationHandler
        {
            if (!_instance) 
            {
                _instance = new ApplicationHandler();
            }
            return _instance;
        }

        public static function get versionLabel():String
        {
            return handler.ApplicationHandler._120604420versionLabel;
        }

        public static const SW_VERSION_FOR_FW_REQUEST:String="500";

        public static const YEARS_WITH_DATA_CHANGED:String="yearsWithDataChanged";

        public static const isBeta:Boolean=false;

        public var currentLicenceVersion:String="1.0";

        public var yearsWithData:__AS3__.vec.Vector.<Object>;

        internal var _cloudSyncProgressCounter:int=0;

        internal var _reloadTimeoutId:uint=0;

        internal var _checkFilePermissionsCallback:Function;

        internal static var _632283713versionNumber:String="";

        public static var versionNumberForFWRequest:String="";

        internal static var _instance:handler.ApplicationHandler;

        public static var isSimulator:Boolean;

        public static var softwareGUID:String;

        internal static var _staticBindingEventDispatcher:flash.events.EventDispatcher;

        public static var useWorker:Boolean=true;

        internal static var _120604420versionLabel:String="";
    }
}


