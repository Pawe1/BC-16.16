//class ViewHandler
package handler 
{
    import backend.utils.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.motion.*;
    import flash.desktop.*;
    import flash.utils.*;
    import frontend.components.*;
    import frontend.components.popup.*;
    import frontend.components.screenNavigator.*;
    import frontend.screen.about.*;
    import frontend.screen.activities.*;
    import frontend.screen.activities.activitiesImport.*;
    import frontend.screen.activities.share.*;
    import frontend.screen.appsettings.*;
    import frontend.screen.appsettings.allgemein.*;
    import frontend.screen.appsettings.benutzer.*;
    import frontend.screen.appsettings.cloud.*;
    import frontend.screen.appsettings.karten.*;
    import frontend.screen.appsettings.konten.*;
    import frontend.screen.appsettings.konten.facebook.*;
    import frontend.screen.appsettings.konten.strava.*;
    import frontend.screen.appsettings.konten.trainingpeaks.*;
    import frontend.screen.appsettings.konten.twitter.*;
    import frontend.screen.appsettings.konten.twopeak.*;
    import frontend.screen.appsettings.mobilesnetz.*;
    import frontend.screen.cloud.*;
    import frontend.screen.component.*;
    import frontend.screen.dashboard.*;
    import frontend.screen.initialAppStart.*;
    import frontend.screen.menu.*;
    import frontend.screen.mydevices.*;
    import frontend.screen.mydevices.pointNavigation.*;
    import frontend.screen.mydevices.settings.*;
    import frontend.screen.mydevices.sleepScreen.*;
    import frontend.screen.mydevices.sportprofiles.*;
    import frontend.screen.mydevices.track.*;
    import frontend.screen.mydevices.training.*;
    import frontend.screen.mydevices.transfer.*;
    import frontend.screen.statistic.*;
    import frontend.screen.tests.*;
    import frontend.screen.topvalues.*;
    import frontend.screen.tracks.*;
    import frontend.screen.tracks.tabs.gpsies.*;
    import frontend.screen.tracks.tabs.track.*;
    import frontend.screen.videos.*;
    import helper.*;
    import starling.events.*;
    import statistic.*;
    import utils.*;
    
    public class ViewHandler extends starling.events.EventDispatcher
    {
        public function ViewHandler()
        {
            this.navi = new frontend.screen.menu.Navi();
            this.views = new flash.utils.Dictionary();
            this._history = new flash.utils.Dictionary();
            this._oldScreens = [];
            super();
            this.views[VIEW_INITIAL_APP_SETTINGS] = frontend.screen.initialAppStart.InitialAppStart;
            this.views[VIEW_DASHBOARD] = frontend.screen.dashboard.Dashboard;
            this.views[VIEW_ACTIVITIES_LIST] = frontend.screen.activities.ActivitiesList;
            this.views[VIEW_TOPVALUES] = frontend.screen.topvalues.TopValues;
            this.views[VIEW_STATISTIC] = frontend.screen.statistic.Statistics;
            this.views[VIEW_TRACKS] = frontend.screen.tracks.Tracks;
            this.views[VIEW_MYDEVICES] = frontend.screen.mydevices.MyDevices;
            this.views[VIEW_VIDEOS] = frontend.screen.videos.Videos;
            this.views[VIEW_APPSETTINGS] = frontend.screen.appsettings.AppSettings;
            this.views[VIEW_CLOUD] = frontend.screen.cloud.CloudView;
            this.views[VIEW_TESTS] = frontend.screen.tests.TestsView;
            this.views[VIEW_ABOUT] = frontend.screen.about.About;
            this.views[VIEW_ACTIVITY] = frontend.screen.activities.ActivityView;
            this.views[VIEW_ACTIVITY_EDIT] = frontend.screen.activities.ActivityEdit;
            this.views[VIEW_ACTIVITIES_TRANSFER] = frontend.screen.mydevices.transfer.ActivitiesTransfer;
            this.views[VIEW_ACTIVITIES_SELECTOR] = frontend.screen.activities.activitiesImport.ActivitiesSelector;
            this.views[VIEW_SHARE_ACTIVITY] = frontend.screen.activities.share.ActivityShare;
            this.views[VIEW_DEVICE_VIEW] = frontend.screen.mydevices.MyDeviceView;
            this.views[VIEW_DEVICE_GENERAL] = frontend.screen.mydevices.MyDeviceGeneral;
            this.views[VIEW_DEVICE_FIRMWARE_UPDATE] = frontend.screen.mydevices.MyDeviceFirmwareUpdate;
            this.views[VIEW_DEVICE_GHOSTRACE_TRANSFER] = frontend.screen.mydevices.transfer.GhostRaceTransfer;
            this.views[VIEW_DEVICE_SETTINGS] = frontend.screen.mydevices.MyDeviceSettings;
            this.views[VIEW_DEVICE_SETTINGS_TRANSFER] = frontend.screen.mydevices.transfer.SettingsTransfer;
            this.views[VIEW_DEVICE_SETTING] = frontend.screen.mydevices.settings.DeviceSettingView;
            this.views[VIEW_DEVICE_SETTING_DEVICE] = frontend.screen.mydevices.settings.DeviceSettingDevice;
            this.views[VIEW_DEVICE_SETTING_UNIT] = frontend.screen.mydevices.settings.DeviceSettingUnit;
            this.views[VIEW_DEVICE_SETTING_BYCICLES] = frontend.screen.mydevices.settings.DeviceSettingBycicles;
            this.views[VIEW_DEVICE_SETTING_ALTITUDE] = frontend.screen.mydevices.settings.DeviceSettingAltitude;
            this.views[VIEW_DEVICE_SETTING_USER] = frontend.screen.mydevices.settings.DeviceSettingUser;
            this.views[VIEW_DEVICE_SETTING_RC_MOVE_FAVORITES] = frontend.screen.mydevices.settings.DeviceSettingRCMoveFavorites;
            this.views[VIEW_DEVICE_SETTING_RC_MOVE_TRAINING_FREE] = frontend.screen.mydevices.settings.DeviceSettingRCMoveTrainingFree;
            this.views[VIEW_DEVICE_SETTING_RC_MOVE_TRAINING_INTERVAL] = frontend.screen.mydevices.settings.DeviceSettingRCMoveTrainingInterval;
            this.views[VIEW_DEVICE_SETTING_FAVORITES_A] = frontend.screen.mydevices.settings.DeviceSettingFavA;
            this.views[VIEW_DEVICE_SETTING_FAVORITES_B] = frontend.screen.mydevices.settings.DeviceSettingFavB;
            this.views[VIEW_DEVICE_SETTING_FUEL_CONSUMPTION] = frontend.screen.mydevices.settings.DeviceSettingFuelConsumption;
            this.views[VIEW_DEVICE_TRAINING_PROGRAM] = frontend.screen.mydevices.MyDeviceTrainings;
            this.views[VIEW_DEVICE_TRAINING_PROGRAM_DETAIL] = frontend.screen.mydevices.training.DeviceTrainingDetail;
            this.views[VIEW_DEVICE_TRAININGS_TRANSFER] = frontend.screen.mydevices.transfer.TrainingsTransfer;
            this.views[VIEW_DEVICE_TRAININGS_SELECTOR] = frontend.screen.mydevices.training.TrainingsSelector;
            this.views[VIEW_DEVICE_REPAIR] = frontend.screen.mydevices.MyDeviceRepair;
            this.views[VIEW_DEVICE_SPORT_PROFILES] = frontend.screen.mydevices.MyDeviceSportProfiles;
            this.views[VIEW_DEVICE_SPORT_PROFILE] = frontend.screen.mydevices.sportprofiles.DeviceSportprofileView;
            this.views[VIEW_DEVICE_SPORTPROFILES_SELECTOR] = frontend.screen.mydevices.sportprofiles.SportprofilesSelector;
            this.views[VIEW_DEVICE_SPORT_PROFILE_SETTINGS] = frontend.screen.mydevices.sportprofiles.DeviceSportprofileSettingsView;
            this.views[VIEW_DEVICE_SPORT_PROFILE_FAVSET] = frontend.screen.mydevices.sportprofiles.DeviceSportprofileFavSetView;
            this.views[VIEW_DEVICE_SPORT_PROFILE_FAVSET_CHANGE_FUNCTION] = frontend.screen.mydevices.sportprofiles.DeviceSportprofileChangeFunctionView;
            this.views[VIEW_DEVICE_SPORT_PROFILE_FAVSET_CHANGE_CATEGORY] = frontend.screen.mydevices.sportprofiles.DeviceSportprofileChangeCategoryView;
            this.views[VIEW_DEVICE_SPORT_PROFILE_FAVSET_CHANGE_TEMPLATE] = frontend.screen.mydevices.sportprofiles.DeviceSportprofileChangeTemplateView;
            this.views[VIEW_DEVICE_SPORT_PROFILES_TRANSFER] = frontend.screen.mydevices.transfer.SportprofilesTransfer;
            this.views[VIEW_DEVICE_SLEEP_SCREEN] = frontend.screen.mydevices.sleepScreen.DeviceSleepScreen;
            this.views[VIEW_DEVICE_SLEEP_SCREEN_TRANSFER] = frontend.screen.mydevices.transfer.SleepScreenTransfer;
            this.views[VIEW_STRAVA_SEGMENTS_TRANSFER] = frontend.screen.mydevices.transfer.StravaSegmentsTransfer;
            this.views[VIEW_DEVICE_POINT_NAVIGATION] = frontend.screen.mydevices.pointNavigation.DevicePointNavigationView;
            this.views[VIEW_DEVICE_POINT_NAVIGATIONS] = frontend.screen.mydevices.MyDevicePointNavigations;
            this.views[VIEW_POINT_NAVIGATION_TRANSFER] = frontend.screen.mydevices.transfer.PointNavigationTransfer;
            this.views[VIEW_AGPS_TRANSFER] = frontend.screen.mydevices.transfer.AGPSTransfer;
            this.views[VIEW_ADD_DEVICE_POSSIBLE_DEVICES] = frontend.screen.mydevices.AddDevicePossibleDevices;
            this.views[VIEW_ADD_DEVICE] = frontend.screen.mydevices.AddDevice;
            this.views[VIEW_ADD_DEVICE_SET_NAME] = frontend.screen.mydevices.AddDeviceSetName;
            this.views[VIEW_APPSETTINGS_ALLGEMEIN] = frontend.screen.appsettings.allgemein.ASAllgemein;
            this.views[VIEW_APPSETTINGS_BENUTZER] = frontend.screen.appsettings.benutzer.ASBenutzer;
            this.views[VIEW_APPSETTINGS_CLOUD] = frontend.screen.appsettings.cloud.ASCloud;
            this.views[VIEW_APPSETTINGS_KONTEN] = frontend.screen.appsettings.konten.ASKonten;
            this.views[VIEW_APPSETTINGS_MOBILESNETZ] = frontend.screen.appsettings.mobilesnetz.ASMobilesNetz;
            this.views[VIEW_APPSETTINGS_KARTEN] = frontend.screen.appsettings.karten.ASKarten;
            this.views[VIEW_APPSETTINGS_KONTENT_STRAVA] = frontend.screen.appsettings.konten.strava.ASStrava;
            this.views[VIEW_APPSETTINGS_KONTENT_TRAININGPEAKS] = frontend.screen.appsettings.konten.trainingpeaks.ASTrainingPeaks;
            this.views[VIEW_APPSETTINGS_KONTENT_TWOPEAK] = frontend.screen.appsettings.konten.twopeak.ASTwoPeak;
            this.views[VIEW_APPSETTINGS_KONTENT_FACEBOOK] = frontend.screen.appsettings.konten.facebook.ASFacebook;
            this.views[VIEW_APPSETTINGS_KONTENT_TWITTER] = frontend.screen.appsettings.konten.twitter.ASTwitter;
            this.views[VIEW_TRACKS_TRACKDETAIL] = frontend.screen.tracks.tabs.track.TrackDetail;
            this.views[VIEW_TRACKS_GPSIES_SEARCH] = frontend.screen.tracks.tabs.gpsies.GPSiesSearch;
            this.views[VIEW_TRACKS_TRANSFER] = frontend.screen.mydevices.transfer.TracksTransfer;
            this.views[VIEW_DEVICE_TRACKS_SELECTOR] = frontend.screen.mydevices.track.TrackSelector;
            return;
        }

        
        {
            INITIAL_VIEW = VIEW_DASHBOARD;
        }

        public function get currentTitle():String
        {
            return this._currentTitle;
        }

        internal function set _1458436191currentTitle(arg1:String):void
        {
            this._currentTitle = arg1;
            return;
        }

        public function goBack():void
        {
            flash.utils.clearTimeout(this._goBackTimeoutId);
            if (this.navigator.isTransitionActive) 
            {
                debug.Debug.debug("[goBack stopped] > transition is active, goBack in 100 ms");
                this._goBackTimeoutId = flash.utils.setTimeout(this.goBack, 100);
                return;
            }
            if (handler.ViewHandler.getInstance().popUpMode && this._showExitWarningPopUp == null) 
            {
                debug.Debug.debug("[goBack stopped] > close pop up");
                frontend.components.popup.PopUpBase.closePopUp();
                return;
            }
            if (this.drawer.open) 
            {
                debug.Debug.debug("[goBack stopped] > toggle left menu");
                this.drawer.toggleLeftDrawer();
                return;
            }
            if (this.navigator.activeScreen == null) 
            {
                debug.Debug.debug("[goBack stopped] > there is no active screen");
                return;
            }
            if (!(this.navigator.activeScreen as frontend.screen.component.CustomScreen).hasBackwardNavigation) 
            {
                return;
            }
            if (this._oldScreens.length == 0) 
            {
                if (helper.Capabilities_helper.isAndroid() && this.navigator.activeScreenID == handler.ViewHandler.VIEW_DASHBOARD) 
                {
                    if (this._showExitWarningPopUp != null) 
                    {
                        flash.desktop.NativeApplication.nativeApplication.exit();
                    }
                    else 
                    {
                        this._showExitWarningPopUp = new frontend.components.popup.InfoPopUp(false, true, null, this.cancelExit);
                        this._showExitWarningPopUp.headline = utils.LanguageManager.getString("INFO_POPUP.APP_CLOSE_WARNING_HEADLINE");
                        this._showExitWarningPopUp.text = utils.LanguageManager.getString("INFO_POPUP.APP_CLOSE_WARNING_TEXT");
                        this._showExitWarningPopUp.popupIgnoresBackButton = false;
                        this._showExitWarningPopUp.closeCallback = this.closeExit;
                        frontend.components.popup.PopUpBase.showModalPopUp(this._showExitWarningPopUp, true, true, true, true);
                    }
                }
                return;
            }
            var loc1:*=this._oldScreens.pop();
            if (loc1 is String) 
            {
                this.showScreen(loc1 as String, null, handler.ViewHandler.slideToRightTransition(), true);
            }
            else if (loc1 is Function) 
            {
                loc1();
            }
            return;
        }

        public function set handleAndroidBackButton(arg1:Boolean):void
        {
            if (this.drawer) 
            {
                this.drawer.handleAndroidBackButton = arg1;
            }
            return;
        }

        internal function closeExit(arg1:frontend.components.popup.InfoPopUp):void
        {
            this._showExitWarningPopUp = null;
            return;
        }

        internal function cancelExit(arg1:frontend.components.popup.InfoPopUp):void
        {
            if (this._showExitWarningPopUp != null) 
            {
                frontend.components.popup.PopUpBase.removePopUps(this._showExitWarningPopUp);
            }
            this.closeExit(arg1);
            return;
        }

        internal function createScreen(arg1:String):frontend.screen.component.CustomScreen
        {
            var loc1:*=Class(this.views[arg1]);
            var loc2:*=new loc1() as frontend.screen.component.CustomScreen;
            loc2.screenID = arg1;
            return loc2;
        }

        public function get navigator():frontend.screen.component.CustomScreenNavigator
        {
            return this._navigator;
        }

        public function set navigator(arg1:frontend.screen.component.CustomScreenNavigator):void
        {
            this._navigator = arg1;
            return;
        }

        internal function disposeScreen(arg1:String):void
        {
            var p_screenId:String;
            var item:feathers.controls.ScreenNavigatorItem;

            var loc1:*;
            item = null;
            p_screenId = arg1;
            if (!this.navigator.hasScreen(p_screenId)) 
            {
                return;
            }
            if (this.navigator.isTransitionActive) 
            {
                flash.utils.setTimeout(this.disposeScreen, 100, p_screenId);
                return;
            }
            try 
            {
                if (this.navigator.activeScreenID == p_screenId) 
                {
                    return;
                }
                if (this.navigator.hasScreen(p_screenId)) 
                {
                    item = this.navigator.removeScreen(p_screenId);
                    if (item.screen is frontend.screen.component.CustomScreen) 
                    {
                        (item.screen as frontend.screen.component.CustomScreen).dispose();
                    }
                }
            }
            catch (e:Error)
            {
                debug.Debug.error("error disposeScreen: " + e.message);
            }
            return;
        }

        public function get popUpMode():Boolean
        {
            return this._popUpMode;
        }

        internal function set _1532504945popUpMode(arg1:Boolean):void
        {
            if (this._popUpMode != arg1) 
            {
                this._popUpMode = arg1;
                dispatchEventWith(POPUP_MODE_CHANGED);
            }
            return;
        }

        public function set currentTitle(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.currentTitle;
            if (loc1 !== arg1) 
            {
                this._1458436191currentTitle = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "currentTitle", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function showScreen(arg1:String, arg2:Object=null, arg3:Function=null, arg4:Boolean=false):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (this.navigator.isTransitionActive) 
            {
                debug.Debug.warning("######### ----- blockiert ----- Navigator führt bereits eine Aktion aus!");
                return;
            }
            if (!this.views[arg1]) 
            {
                return;
            }
            if (!(this.navigator.activeScreen == null) && this.navigator.activeScreen is frontend.screen.component.CustomScreen) 
            {
                debug.Debug.debug("oldScreen: " + this.navigator.activeScreenID + "\t\tClass: " + flash.utils.getQualifiedClassName(this.views[this.navigator.activeScreenID]));
                loc1 = this.navigator.activeScreenID;
                loc2 = this.navigator.activeScreen as frontend.screen.component.CustomScreen;
                if (!arg4 && (this.navigator.activeScreen as frontend.screen.component.CustomScreen).saveAsOldScreen && !(arg1 == loc1)) 
                {
                    this._oldScreens.push(loc1);
                }
            }
            debug.Debug.debug("newScreen: " + arg1 + "\t\tClass: " + flash.utils.getQualifiedClassName(this.views[arg1]));
            if (arg1 == loc1) 
            {
                debug.Debug.error("oldScreen & newScreen identisch... abbruch...");
                return;
            }
            var loc5:*="";
            if (this.navigator.hasScreen(arg1)) 
            {
                loc3 = this.navigator.getScreen(arg1) as frontend.components.screenNavigator.CustomScreenNavigatorItem;
            }
            else 
            {
                loc4 = this.createScreen(arg1);
                loc3 = new frontend.components.screenNavigator.CustomScreenNavigatorItem(loc4);
                this.navigator.addScreen(arg1, loc3);
            }
            if (arg4 && this._history[arg1]) 
            {
                arg2 = this._history[arg1];
            }
            loc3.properties = arg2;
            (loc3.screen as frontend.screen.component.CustomScreen).invalidate(feathers.core.FeathersControl.INVALIDATION_FLAG_DATA);
            loc4 = this.navigator.showScreen(arg1, arg3) as frontend.screen.component.CustomScreen;
            if (loc4) 
            {
                if (loc4.savePropertiesForBackNavigation) 
                {
                    this._history[arg1] = loc3.properties;
                }
                this.currentTitle = loc4.title;
            }
            if (loc2 && !loc2.allowCaching) 
            {
                this.disposeScreen(loc1);
            }
            return;
        }

        public function set popUpMode(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.popUpMode;
            if (loc1 !== arg1) 
            {
                this._1532504945popUpMode = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "popUpMode", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function slideToRightTransition(arg1:Number=0.35, arg2:Object="easeOut", arg3:Object=null):Function
        {
            return feathers.motion.Slide.createSlideRightTransition(arg1, arg2, arg3);
        }

        public static function slideToLeftTransition(arg1:Number=0.35, arg2:Object="easeOut", arg3:Object=null):Function
        {
            return feathers.motion.Slide.createSlideLeftTransition(arg1, arg2, arg3);
        }

        public static function getInstance():handler.ViewHandler
        {
            if (!_instance) 
            {
                _instance = new ViewHandler();
            }
            return _instance;
        }

        public function isActive(arg1:frontend.screen.component.CustomScreen):Boolean
        {
            return this.navigator.activeScreen == arg1;
        }

        public function hasScreen(arg1:String):Boolean
        {
            return this.views.hasOwnProperty(arg1);
        }

        public function updateScreens():void
        {
            this.navi.update();
            backend.utils.DataUtils.init();
            statistic.Statistic.init();
            var loc1:*=this.navigator.activeScreenID;
            if (loc1) 
            {
                this.navigator.removeAllScreens();
                this.showScreen(loc1);
            }
            return;
        }

        public function init():void
        {
            if (handler.AppDBHandler.getInstance().initialAppStart) 
            {
                INITIAL_VIEW = handler.ViewHandler.VIEW_INITIAL_APP_SETTINGS;
                this.drawer.icon.visible = false;
                this.openMainMenuOnSwipe(false);
            }
            else 
            {
                INITIAL_VIEW = handler.ViewHandler.VIEW_DASHBOARD;
                this.initComplete();
            }
            this.preInit(INITIAL_VIEW);
            return;
        }

        public function initComplete():void
        {
            this.drawer.icon.visible = true;
            this.openMainMenuOnSwipe(true);
            return;
        }

        public function openMainMenuOnSwipe(arg1:Boolean):void
        {
            this.drawer.openGesture = arg1 ? feathers.controls.Drawers.OPEN_GESTURE_DRAG_CONTENT_EDGE : feathers.controls.Drawers.OPEN_GESTURE_NONE;
            return;
        }

        public function preInit(arg1:String):void
        {
            var loc1:*=new frontend.components.screenNavigator.CustomScreenNavigatorItem(this.createScreen(arg1));
            this.navigator.addScreen(arg1, loc1);
            this.navigator.showScreen(arg1);
            this.currentTitle = (loc1.screen as frontend.screen.component.CustomScreen).title;
            return;
        }

        public function clearHistory():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this._history;
            for (loc1 in loc3) 
            {
                delete this._history[loc1];
            }
            this._oldScreens = [VIEW_DASHBOARD];
            return;
        }

        public function addBackFunction(arg1:Function):void
        {
            this._oldScreens.push(arg1);
            return;
        }

        public function removeBackFunction(arg1:Function):void
        {
            var loc1:*=this._oldScreens.indexOf(arg1);
            if (loc1 != -1) 
            {
                this._oldScreens.splice(loc1, 1);
            }
            return;
        }

        public static const VIEW_TESTS:String="tests";

        public static const VIEW_TOPVALUES:String="topvalues";

        public static const VIEW_TRACKS:String="tracks";

        public static const VIEW_TRACKS_GPSIES_SEARCH:String="tracks_gpsies_search";

        public static const VIEW_TRACKS_TRACKDETAIL:String="tracks_trackdetail";

        public static const VIEW_TRACKS_TRANSFER:String="device_tracks_transfer";

        public static const VIEW_VIDEOS:String="videos";

        public static const VIEW_SHARE_ACTIVITY:String="shareActivity";

        public static const ANIMATION_DURATION:Number=0.35;

        public static const EVENT_LEFT_MENU_TOGGLE_CHANGED:String="leftMenuToggleChanged";

        public static const EVENT_SPEED_FORMAT_CHANGED:String="speedFormatChanged";

        public static const EVENT_TOGGLE_LEFT_MENU:String="toggleLeftMenu";

        public static const POPUP_MODE_CHANGED:String="popUpModeChanged";

        public static const VIEW_ABOUT:String="about";

        public static const VIEW_ACTIVITIES_LIST:String="activitiesList";

        public static const VIEW_ACTIVITIES_SELECTOR:String="activitiesSelector";

        public static const VIEW_ACTIVITIES_TRANSFER:String="activitiesTransfer";

        public static const VIEW_ACTIVITY:String="activity";

        public static const VIEW_ACTIVITY_EDIT:String="activityEdit";

        public static const VIEW_ADD_DEVICE:String="add_device";

        public static const VIEW_ADD_DEVICE_POSSIBLE_DEVICES:String="add_device_possible_devices";

        public static const VIEW_ADD_DEVICE_SET_NAME:String="add_device_set_name";

        public static const VIEW_AGPS_TRANSFER:String="device_agps_transfer";

        public static const VIEW_APPSETTINGS:String="appsettings";

        public static const VIEW_APPSETTINGS_ALLGEMEIN:String="appsettings_allgemein";

        public static const VIEW_APPSETTINGS_BENUTZER:String="appsettings_benutzer";

        public static const VIEW_APPSETTINGS_CLOUD:String="appsettings_cloud";

        public static const VIEW_APPSETTINGS_KARTEN:String="appsettings_karten";

        public static const VIEW_APPSETTINGS_KONTEN:String="appsettings_konten";

        public static const VIEW_APPSETTINGS_KONTENT_FACEBOOK:String="appsettings_konten_facebook";

        public static const VIEW_APPSETTINGS_KONTENT_STRAVA:String="appsettings_konten_strava";

        public static const VIEW_APPSETTINGS_KONTENT_TRAININGPEAKS:String="appsettings_konten_trainingpeaks";

        public static const VIEW_APPSETTINGS_KONTENT_TWITTER:String="appsettings_konten_twitter";

        public static const VIEW_APPSETTINGS_KONTENT_TWOPEAK:String="appsettings_konten_twopeak";

        public static const VIEW_APPSETTINGS_MOBILESNETZ:String="appsettings_mobilesnetz";

        public static const VIEW_CLOUD:String="cloud";

        public static const VIEW_DASHBOARD:String="dashboard";

        public static const VIEW_DEVICE_FIRMWARE_UPDATE:String="device_firmware_update";

        public static const VIEW_DEVICE_GENERAL:String="device_general";

        public static const VIEW_DEVICE_GHOSTRACE_TRANSFER:String="device_ghostrace_transfer";

        public static const VIEW_DEVICE_POINT_NAVIGATION:String="device_point_navigation";

        public static const VIEW_DEVICE_POINT_NAVIGATIONS:String="device_point_navigations";

        public static const VIEW_DEVICE_REPAIR:String="device_repair";

        public static const VIEW_DEVICE_SETTING:String="device_setting";

        public static const VIEW_DEVICE_SETTINGS:String="device_settings";

        public static const VIEW_DEVICE_SETTINGS_TRANSFER:String="device_settings_transfer";

        public static const VIEW_DEVICE_SETTING_ALTITUDE:String="device_setting_altitude";

        public static const VIEW_DEVICE_SETTING_BYCICLES:String="device_setting_bycicles";

        public static const VIEW_DEVICE_SETTING_DEVICE:String="device_setting_device";

        public static const VIEW_DEVICE_SETTING_FAVORITES_A:String="device_setting_favorites_a";

        public static const VIEW_DEVICE_SETTING_FAVORITES_B:String="device_setting_favorites_b";

        public static const VIEW_DEVICE_SETTING_FUEL_CONSUMPTION:String="device_setting_fuel_consumption";

        public static const VIEW_DEVICE_SETTING_RC_MOVE_FAVORITES:String="device_setting_rc_move_favorites";

        public static const VIEW_DEVICE_SETTING_RC_MOVE_TRAINING_FREE:String="device_setting_rc_move_training_free";

        public static const VIEW_DEVICE_SETTING_RC_MOVE_TRAINING_INTERVAL:String="device_setting_rc_move_training_interval";

        public static const VIEW_DEVICE_SETTING_UNIT:String="device_setting_unit";

        public static const VIEW_DEVICE_SETTING_USER:String="device_setting_user";

        public static const VIEW_DEVICE_SLEEP_SCREEN:String="device_sleep_screen";

        public static const VIEW_DEVICE_SLEEP_SCREEN_TRANSFER:String="device_sleep_screen_transfer";

        public static const VIEW_DEVICE_SPORTPROFILES_SELECTOR:String="device_sportprofiles_selector";

        public static const VIEW_DEVICE_SPORT_PROFILE:String="device_sport_profile";

        public static const VIEW_DEVICE_SPORT_PROFILES:String="device_sport_profiles";

        public static const VIEW_DEVICE_SPORT_PROFILE_FAVSET:String="device_sport_profile_favset";

        public static const VIEW_DEVICE_SPORT_PROFILE_FAVSET_CHANGE_CATEGORY:String="device_sport_profile_favset_change_category";

        public static const VIEW_DEVICE_SPORT_PROFILE_FAVSET_CHANGE_FUNCTION:String="device_sport_profile_favset_change_function";

        public static const VIEW_DEVICE_SPORT_PROFILE_FAVSET_CHANGE_TEMPLATE:String="device_sport_profile_favset_change_template";

        public static const VIEW_DEVICE_SPORT_PROFILE_SETTINGS:String="device_sport_profile_settings";

        public static const VIEW_DEVICE_TRACKS_SELECTOR:String="device_tracks_selector";

        public static const VIEW_DEVICE_TRAININGS_SELECTOR:String="device_trainings_selector";

        public static const VIEW_DEVICE_TRAININGS_TRANSFER:String="device_training_transfer";

        public static const VIEW_DEVICE_TRAINING_PROGRAM:String="device_training_program";

        public static const VIEW_DEVICE_TRAINING_PROGRAM_DETAIL:String="device_training_program_detail";

        public static const VIEW_DEVICE_VIEW:String="device_view";

        public static const VIEW_INITIAL_APP_SETTINGS:String="initialAppSettings";

        public static const VIEW_MYDEVICES:String="mydevices";

        public static const VIEW_POINT_NAVIGATION_TRANSFER:String="device_point_navigation_transfer";

        public static const VIEW_DEVICE_SPORT_PROFILES_TRANSFER:String="device_sport_profile_transfer";

        public static const VIEW_STATISTIC:String="statistic";

        public static const VIEW_STRAVA_SEGMENTS_TRANSFER:String="device_strava_segments_transfer";

        internal var _currentTitle:String="";

        public var drawer:frontend.components.MainApplicationDrawer;

        public var mainLayoutGroup:feathers.controls.LayoutGroup;

        public var navi:frontend.screen.menu.Navi;

        internal var _navigator:frontend.screen.component.CustomScreenNavigator;

        internal var _popUpMode:Boolean=false;

        public var views:flash.utils.Dictionary;

        internal var _history:flash.utils.Dictionary;

        internal static var INITIAL_VIEW:String="dashboard";

        internal static var _instance:handler.ViewHandler;

        internal var _showExitWarningPopUp:frontend.components.popup.InfoPopUp;

        internal var _oldScreens:Array;

        internal var _menuOpened:Boolean=false;

        internal var _goBackTimeoutId:uint=0;
    }
}


