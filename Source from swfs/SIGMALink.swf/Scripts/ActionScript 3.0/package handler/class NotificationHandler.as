//class NotificationHandler
package handler 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.notification.*;
    import core.units.*;
    import core.units.interfaces.*;
    import de.pagecon.ane.notificationlistenerservice.*;
    import de.pagecon.ane.notificationlistenerservice.events.*;
    import debug.*;
    import flash.data.*;
    import flash.desktop.*;
    import flash.events.*;
    import flash.utils.*;
    import helper.*;
    import service.*;
    import starling.events.*;
    
    public class NotificationHandler extends flash.events.EventDispatcher
    {
        public function NotificationHandler(arg1:flash.events.IEventDispatcher=null)
        {
            var target:flash.events.IEventDispatcher=null;

            var loc1:*;
            target = arg1;
            super(target);
            try 
            {
                de.pagecon.ane.notificationlistenerservice.NotificationServiceController.instance.addEventListener(de.pagecon.ane.notificationlistenerservice.NotificationServiceController.EVENT_STATUS_CHANGED, this.onNotificationStatusChanged);
                de.pagecon.ane.notificationlistenerservice.NotificationServiceController.instance.addEventListener(de.pagecon.ane.notificationlistenerservice.NotificationServiceController.EVENT_APPLICATION_STATE_CHANGED, this.onApplicationStateChanged);
                this.loadUnitsForNotifications();
            }
            catch (e:Error)
            {
                debug.Debug.error("error: " + e.message);
            }
            return;
        }

        public function loadUnitsForNotifications():void
        {
            if (handler.DeviceCommunicationHandlerLink.deviceCommunicationMode) 
            {
                return;
            }
            this._notifications = new Vector.<core.notification.NotificationEvent>();
            this._units = new Vector.<core.units.Unit>();
            this._processStarted = false;
            this._currentUnitIndex = -1;
            this._unitsLoading = true;
            var loc1:*=core.units.UnitFactory.notificationsSupported();
            var loc2:*="\'" + loc1.join("\', \'") + "\'";
            var loc3:*="SELECT * FROM " + core.units.Unit.table_name + " WHERE " + core.units.Unit.col_type + " in (" + loc2 + ") AND " + core.units.Unit.col_isDeleted + " = false ";
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc3, this.loadUnitsForNotificationsComplete, this.loadUnitsForNotificationsError);
            return;
        }

        internal function loadUnitsForNotificationsComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc2:*=0;
            var loc4:*=null;
            debug.Debug.debug("loadDeviceListComplete");
            var loc1:*=arg1.getResult();
            var loc3:*=loc1.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc4 = core.units.UnitFactory.createUnitFromDB(loc1[loc2]);
                if (loc4 is core.units.interfaces.IBLEDeviceInfo && loc4 is core.units.interfaces.INotificationEvent) 
                {
                    this._units.push(loc4);
                }
                ++loc2;
            }
            this._checkSecuritySettingsTimeoutId = flash.utils.setTimeout(this.checkSecuritySettings, 1000);
            this._unitsLoading = false;
            return;
        }

        internal function loadUnitsForNotificationsError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.debug("loadDeviceListError");
            this._unitsLoading = false;
            return;
        }

        internal function checkSecuritySettings():void
        {
            var loc1:*=0;
            var loc2:*=0;
            if (this._units.length == 0) 
            {
                debug.Debug.debug("no notificationEvent-listener required...");
                de.pagecon.ane.notificationlistenerservice.NotificationServiceController.instance.removeEventListener(NOTIFICATION_EVENT, this.onNotification);
                return;
            }
            if (de.pagecon.ane.notificationlistenerservice.NotificationServiceController.instance.getNotificationsEnabled()) 
            {
                this.onNotificationStatusChanged(null);
            }
            else if (this.showNotificationSettingsForUnit) 
            {
                loc2 = this._units.length;
                loc1 = 0;
                while (loc1 < loc2) 
                {
                    if (this._units[loc1].GUID == this.showNotificationSettingsForUnit.GUID) 
                    {
                        de.pagecon.ane.notificationlistenerservice.NotificationServiceController.instance.openSecuritySettings();
                    }
                    ++loc1;
                }
            }
            this.showNotificationSettingsForUnit = null;
            return;
        }

        internal function onApplicationStateChanged(arg1:de.pagecon.ane.notificationlistenerservice.events.ApplicationStateChangedEvent):void
        {
            debug.Debug.debug("[STATE] " + arg1.toString());
            if (helper.Capabilities_helper.isAndroid() && !(arg1.activityName == ACTIVITY_NAME_LINKAPP_ANDROID)) 
            {
                return;
            }
            if (helper.Capabilities_helper.isIOS() && !(arg1.activityName == ACTIVITY_NAME_LINKAPP_IOS)) 
            {
                return;
            }
            var loc1:*=arg1.state;
            switch (loc1) 
            {
                case de.pagecon.ane.notificationlistenerservice.events.ApplicationStateChangedEvent.APPLICATION_STATE_SAVEINSTANCE:
                {
                    this._applicationStateResumAfterSaveInstance = false;
                    break;
                }
                case de.pagecon.ane.notificationlistenerservice.events.ApplicationStateChangedEvent.APPLICATION_STATE_RESUME:
                {
                    if (this._lastApplicationState == de.pagecon.ane.notificationlistenerservice.events.ApplicationStateChangedEvent.APPLICATION_STATE_SAVEINSTANCE) 
                    {
                        this._applicationStateResumAfterSaveInstance = true;
                    }
                    break;
                }
                case de.pagecon.ane.notificationlistenerservice.events.ApplicationStateChangedEvent.APPLICATION_STATE_DESTROY:
                {
                    if (!this._applicationStateResumAfterSaveInstance) 
                    {
                        flash.desktop.NativeApplication.nativeApplication.exit();
                    }
                    this._applicationStateResumAfterSaveInstance = false;
                    break;
                }
            }
            this._lastApplicationState = arg1.state;
            return;
        }

        internal function onNotificationStatusChanged(arg1:de.pagecon.ane.notificationlistenerservice.events.NotificationStatusChangedEvent=null):void
        {
            if (de.pagecon.ane.notificationlistenerservice.NotificationServiceController.instance.getNotificationsEnabled()) 
            {
                de.pagecon.ane.notificationlistenerservice.NotificationServiceController.instance.addEventListener(NOTIFICATION_EVENT, this.onNotification);
            }
            else 
            {
                de.pagecon.ane.notificationlistenerservice.NotificationServiceController.instance.removeEventListener(NOTIFICATION_EVENT, this.onNotification);
            }
            return;
        }

        internal function onNotification(arg1:de.pagecon.ane.notificationlistenerservice.events.NotificationServiceControllerEvent):void
        {
            if (!service.DeviceCommunicationHandler.getInstance().isBleSupported() || service.DeviceCommunicationHandler.getInstance().isBLEEnabled()) 
            {
                return;
            }
            if (handler.DeviceCommunicationHandlerLink.deviceCommunicationMode) 
            {
                return;
            }
            if (!arg1.tickerText || arg1.tickerText == "null") 
            {
                arg1.tickerText = "";
            }
            if (!arg1.text || arg1.text == "null") 
            {
                arg1.text = "";
            }
            if (!arg1.textBig || arg1.textBig == "null") 
            {
                arg1.textBig = "";
            }
            if (arg1.textBig == "" && !(arg1.tickerText == "")) 
            {
                arg1.textBig = arg1.tickerText;
            }
            if (this._unitsLoading) 
            {
                debug.Debug.debug("onNotification");
                flash.utils.setTimeout(this.onNotification, 1000, arg1);
                return;
            }
            if (this._units.length == 0) 
            {
                return;
            }
            var loc1:*="[id]" + arg1.id + "\n";
            loc1 = loc1 + ("[title] " + arg1.title + "\n");
            loc1 = loc1 + ("[text] " + arg1.text + "\n");
            loc1 = loc1 + ("[textBig] " + arg1.textBig + "\n");
            loc1 = loc1 + ("[tickerText] " + arg1.tickerText + "\n");
            loc1 = loc1 + ("[tag] " + arg1.tag + "\n");
            loc1 = loc1 + ("[packageName] " + arg1.packageName + "\n");
            loc1 = loc1 + ("[postTime] " + arg1.postTime + "\n");
            loc1 = loc1 + ("[group] " + arg1.group + "\n");
            loc1 = loc1 + ("[groupKey] " + arg1.groupKey + "\n");
            loc1 = loc1 + ("[sdk] " + arg1.sdk + "\n");
            loc1 = loc1 + ("[category] " + arg1.category + "\n");
            loc1 = loc1 + "--------------\n\n";
            debug.Debug.debug(loc1);
            var loc2:*=new core.notification.NotificationEvent();
            loc2.id = arg1.id;
            loc2.tickerText = arg1.tickerText;
            loc2.tag = arg1.tag;
            loc2.packageName = arg1.packageName;
            loc2.postTime = arg1.postTime;
            loc2.group = arg1.group;
            loc2.groupKey = arg1.groupKey;
            loc2.sdk = arg1.sdk;
            loc2.category = arg1.category;
            loc2.title = arg1.title;
            loc2.text = arg1.textBig;
            this._notifications.push(loc2);
            if (!this._processStarted) 
            {
                this._processStarted = true;
                this.processNotifications();
            }
            return;
        }

        public function processNotifications():void
        {
            if (this._notifications.length > 0) 
            {
                debug.Debug.debug("start processNotifications...");
                this._currentNotificationEvent = this._notifications.shift() as core.notification.NotificationEvent;
                this.sendNotificationToUnits();
            }
            else 
            {
                debug.Debug.debug("end processNotifications...");
                this._processStarted = false;
                this._currentUnitIndex = -1;
            }
            return;
        }

        internal function sendNotificationToUnits():void
        {
            var loc1:*;
            var loc2:*=((loc1 = this)._currentUnitIndex + 1);
            loc1._currentUnitIndex = loc2;
            flash.utils.clearTimeout(this._connectTimeoutId);
            flash.utils.clearTimeout(this._sendNextNotificationTimeoutId);
            if (this._currentUnitIndex < this._units.length) 
            {
                debug.Debug.debug("sendNotificationsToUnits");
                this._currentUnit = this._units[this._currentUnitIndex];
                (this._currentUnit as core.units.interfaces.INotificationEvent).notificationEvent = this._currentNotificationEvent;
                this.checkConnection();
            }
            else 
            {
                this._currentUnitIndex = -1;
                this.processNotifications();
            }
            return;
        }

        internal function checkConnection():void
        {
            debug.Debug.debug("checkConnection");
            handler.CommunicationHandling.getInstance().addEventListener(handler.CommunicationHandling.COMMUNICATION_ERROR, this.onCommunicationError);
            handler.CommunicationHandling.getInstance().addEventListener(handler.CommunicationHandling.COMMUNICATION_TIMEOUT, this.onCommunicationTimeout);
            handler.CommunicationHandling.getInstance().communicationFunction = this.transferFunction;
            handler.CommunicationHandling.getInstance().ignoreUSB = true;
            handler.CommunicationHandling.getInstance().currentDevice = this._currentUnit;
            handler.CommunicationHandling.getInstance().initCurrentDeviceCommunication();
            return;
        }

        protected function transferFunction():void
        {
            debug.Debug.debug("transferFunction");
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler = handler.HandlerFactory.getImplementation(handler.CommunicationHandling.getInstance().currentDevice) as handler.UnitHandler;
            if (handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler) 
            {
                handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.port = handler.DeviceCommunicationHandlerLink.getInstance().currentDSHandler.port;
            }
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.addEventListener(handler.UnitHandler.SEND_NOTIFICATION_TO_DEVICE_COMPLETE, this.onNotificationSendComplete);
            handler.DeviceCommunicationHandlerLink.getInstance().currentOnlineUnitHandler.sendToDC(handler.UnitHandler.SEND_NOTIFICATION);
            return;
        }

        internal function onCommunicationError(arg1:starling.events.Event):void
        {
            debug.Debug.debug("onCommunicationError");
            this._currentNotificationEvent.transferError = true;
            this.onNotificationSendComplete();
            return;
        }

        internal function onCommunicationTimeout(arg1:starling.events.Event):void
        {
            debug.Debug.debug("onCommunicationTimeout");
            this._currentNotificationEvent.transferError = true;
            this.onNotificationSendComplete();
            return;
        }

        internal function onNotificationSendComplete(arg1:flash.events.Event=null):void
        {
            handler.CommunicationHandling.getInstance().removeEventListener(handler.CommunicationHandling.COMMUNICATION_ERROR, this.onCommunicationError);
            handler.CommunicationHandling.getInstance().removeEventListener(handler.CommunicationHandling.COMMUNICATION_TIMEOUT, this.onCommunicationTimeout);
            handler.CommunicationHandling.getInstance().stopCommunication();
            if (arg1) 
            {
                debug.Debug.debug("onNotificationSendComplete > send to next unit");
                this._sendNextNotificationTimeoutId = flash.utils.setTimeout(this.sendNotificationToUnits, this._sendNextNotificationTimeoutInterval);
            }
            else if (this._currentNotificationEvent.repeatSendCounter > 0 && (this._currentNotificationEvent.transferError || this._currentNotificationEvent.repeatSendNotification)) 
            {
                var loc1:*;
                var loc2:*=((loc1 = this._currentNotificationEvent).repeatSendCounter - 1);
                loc1.repeatSendCounter = loc2;
                if (this._currentNotificationEvent.transferError) 
                {
                    this._currentNotificationEvent.transferError = false;
                }
                if (this._currentNotificationEvent.repeatSendNotification) 
                {
                    this._currentNotificationEvent.repeatSendNotification = false;
                }
                debug.Debug.debug("Notification erneut senden, wenn es Probleme beim Übertragen gab");
                flash.utils.setTimeout(this.checkConnection, 2000);
            }
            else 
            {
                this._sendNextNotificationTimeoutId = flash.utils.setTimeout(this.sendNotificationToUnits, this._sendNextNotificationTimeoutInterval);
            }
            return;
        }

        public static function getInstance():handler.NotificationHandler
        {
            if (!_instance) 
            {
                _instance = new NotificationHandler();
            }
            return _instance;
        }

        public static const ACTIVITY_NAME_LINKAPP_IOS:String="AppEntry";

        internal static const NOTIFICATION_EVENT:String="eventNotification";

        public static const ACTIVITY_NAME_LINKAPP_ANDROID:String="AppEntry";

        public var showNotificationSettingsForUnit:core.units.Unit=null;

        internal var _applicationStateResumAfterSaveInstance:Boolean=false;

        internal var _checkSecuritySettingsTimeoutId:uint=0;

        internal var _connectTimeoutId:uint=0;

        internal var _currentNotificationEvent:core.notification.NotificationEvent;

        internal var _currentUnit:core.units.Unit;

        internal var _currentUnitIndex:int=-1;

        internal var _lastApplicationState:String="unknown";

        internal var _notifications:__AS3__.vec.Vector.<core.notification.NotificationEvent>;

        internal var _processStarted:Boolean=false;

        internal var _sendNextNotificationTimeoutId:uint=0;

        internal var _sendNextNotificationTimeoutInterval:uint=3000;

        internal var _unitInitialisedTimeout:uint=0;

        internal var _units:__AS3__.vec.Vector.<core.units.Unit>;

        internal var _unitsLoading:Boolean=false;

        internal static var _instance:handler.NotificationHandler;
    }
}


