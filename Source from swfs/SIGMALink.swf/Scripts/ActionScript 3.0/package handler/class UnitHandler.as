//class UnitHandler
package handler 
{
    import com.logging.*;
    import core.settings.*;
    import core.settings.interfaces.*;
    import core.units.*;
    import database.*;
    import debug.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;
    import flash.xml.*;
    import utils.events.*;
    
    public class UnitHandler extends handler.DeviceHandler
    {
        public function UnitHandler()
        {
            super();
            return;
        }

        public function get unit():core.units.Unit
        {
            return null;
        }

        public function set unit(arg1:core.units.Unit):void
        {
            return;
        }

        protected function generateNativeProzessBufferDs(arg1:uint, arg2:Array=null):flash.utils.ByteArray
        {
            var loc1:*=0;
            debug.Debug.debug("Command: " + arg1);
            var loc2:*;
            (loc2 = new flash.utils.ByteArray()).writeByte(arg1);
            if (arg2 != null) 
            {
                debug.Debug.debug("Data: " + arg2.join(" "));
                loc1 = 0;
                while (loc1 < arg2.length) 
                {
                    loc2.writeByte(arg2[loc1]);
                    ++loc1;
                }
            }
            loc2.position = 0;
            return loc2;
        }

        protected function generateNativeProzessBufferData(arg1:Array):flash.utils.ByteArray
        {
            var loc1:*=0;
            var loc2:*=new flash.utils.ByteArray();
            if (arg1 != null) 
            {
                debug.Debug.debug("Command: " + arg1.join(" "));
                loc1 = 0;
                while (loc1 < arg1.length) 
                {
                    loc2.writeByte(arg1[loc1]);
                    ++loc1;
                }
            }
            loc2.position = 0;
            return loc2;
        }

        public override function destructor():void
        {
            super.destructor();
            database.DatabaseHandlerCommon.getInstance().removeEventListener("databaseDisconnected", onLoadDataCommited);
            return;
        }

        public function createEmptySettings():void
        {
            var loc2:*=flash.filesystem.File.applicationDirectory.nativePath + "/defaults/settings/" + unit.type.toString() + "." + "ssf";
            var loc1:*=new flash.filesystem.File(loc2);
            if (!loc1.exists) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 1035, "UnitHandler > createEmptySettings: file does not exist"));
            }
            var loc3:*=new flash.filesystem.FileStream();
            loc3.addEventListener("complete", loadDefaultSettingsFromFileComplete);
            loc3.openAsync(loc1, "read");
            return;
        }

        internal function loadDefaultSettingsFromFileComplete(arg1:flash.events.Event):void
        {
            var loc5:*;
            (loc5 = arg1.currentTarget as flash.filesystem.FileStream).removeEventListener("complete", loadDefaultSettingsFromFileComplete);
            var loc2:*=loc5.readUTFBytes(loc5.bytesAvailable);
            loc5.close();
            var loc1:*=new flash.xml.XMLDocument();
            loc1.ignoreWhite = true;
            loc1.parseXML(loc2);
            var loc3:*=new XML(loc1.toString());
            var loc4:*;
            (loc4 = core.settings.SettingsFactory.createSettingsFromSSF(loc3)).unit = unit;
            loc4.unitType = unit.type;
            (loc4 as core.settings.interfaces.IDate).date = new Date();
            dispatchEvent(new utils.events.SettingsEvent("creationComplete", false, false, loc4));
            return;
        }

        internal function onLoadDataCommited(arg1:flash.events.Event):void
        {
            database.DatabaseHandlerCommon.getInstance().removeEventListener("databaseDisconnected", onLoadDataCommited);
            dispatchEvent(new flash.events.Event("memoriesLoadComplete"));
            return;
        }

        public static const WRITE_UNIT_SETTINGS_TO_DEVICE:String="writeUnitSettings";

        public static const WRITE_UNIT_SLEEP_SCREEN_TO_DEVICE:String="writeUnitSleepScreen";

        public static const BATTERY_INFORMATION_LOADED_FROM_UNIT_COMPLETE:String="batteryInformationLoadedFromUnitComplete";

        public static const DATA_LIST_ADDED_EVENT:String="dataListAddedEvent";

        public static const DATA_LOAD_FROM_DB_COMPLETE:String="memoriesLoadComplete";

        public static const DATA_LOAD_PROGRESS:String="memoriesLoadProgress";

        public static const DATA_SAVE_PROGRESS:String="dataSaveProgress";

        public static const DELETE_MARKER_COMPLETE:String="deleteMarkerComplete";

        public static const DELETE_PERSON_COMPLETE:String="deletePersonComplete";

        public static const DELETE_PERSON_FROM_ALL_COMPLETE:String="deletePersonFromAllComplete";

        public static const DELETE_STRAVA_SEGMENTS_ON_UNIT:String="deleteStravaSegmentsOnUnit";

        public static const DELETE_STRAVA_SEGMENTS_ON_UNIT_COMPLETE:String="deleteStravaSegmentsOnUnitComplete";

        public static const DELETE_TRACKS_ON_UNIT:String="deleteTracksOnUnit";

        public static const DELETE_TRACKS_ON_UNIT_COMPLETE:String="deleteTracksOnUnitComplete";

        public static const DELETE_UNIT_LOG_DATA_FROM_DEVICE:String="deleteUnitlogData";

        public static const DELETE_UNIT_MEMORY_DATA_FROM_DEVICE:String="deleteUnitMemoryData";

        public static const DELETE_WORKOUTS_ON_UNIT:String="deleteWorkoutsOnUnit";

        public static const DELETE_WORKOUTS_ON_UNIT_COMPLETE:String="deleteWorkoutsOnUnitComplete";

        public static const EMPTY_SETTINGS_CREATED:String="emptySettingsCreated";

        public static const ENTRY_CHANGE:String="entryChange";

        public static const EVENT_AGPS_FILE_LOADED:String="eventAgpsFileLoaded";

        public static const EVENT_DOWNLOAD_ERROR:String="downloadError";

        public static const EVENT_UNIT_SERIALNUMBER_DO_NOT_MATCH:String="eventUnitSerialNumberDoNotMatch";

        public static const EVENT_UNIT_TYPE_DO_NOT_MATCH:String="eventUnitTypeDoNotMatch";

        public static const LOAD_ALL_DATA:String="loadAllData";

        public static const LOAD_ALL_DATA_COMPLETE:String="loadAllDataComplete";

        public static const LOAD_BATTERY_INFORMATION_FROM_DEVICE:String="loadBatteryInformation";

        public static const LOAD_CURRENT_TRACK_ID:String="loadCurrentTrackId";

        public static const LOAD_FREE_LOGGING_TIME_INFORMATION_FROM_DEVICE:String="loadFreeLoggingTimeInformation";

        public static const LOAD_LOG_PROGRAM:String="loadLogProgram";

        public static const LOAD_LOG_PROGRAM_PHASE_CHANGE:String="loadLogProgramPhaseChange";

        public static const LOAD_PERSONS_COMPLETE:String="loadPersonsComplete";

        public static const LOAD_PROGRAMS:String="loadPrograms";

        public static const LOAD_SPORT_PROFILES_FROM_DEVICE:String="loadSportProfilesFromDevice";

        public static const LOAD_TOTAL_ADVANCED_VALUES_FROM_DEVICE:String="loadTotalAdvancedValues";

        public static const LOAD_TOTAL_VALUES_FROM_DEVICE:String="loadTotalValues";

        public static const LOAD_UNIT_ADVANCED_SETTINGS_FROM_DEVICE:String="loadUnitAdvancedSettings";

        public static const LOAD_UNIT_LOG_DATA_FROM_DEVICE:String="loadUnitlogData";

        public static const LOAD_UNIT_LOG_DATA_HEADER_FROM_DEVICE:String="loadUnitlogDataHeader";

        public static const LOAD_UNIT_LOG_DATA_HEADER_FROM_DEVICE_COMPLETE:String="loadUnitlogDataHeaderComplete";

        public static const LOAD_UNIT_PLANED_TRACK_FILE:String="loadUnitPlanedTrackFile";

        public static const LOAD_UNIT_PLANED_TRACK_FILE_HEADER:String="loadUnitPlanedTrackFileHeader";

        public static const LOAD_UNIT_SETTINGS_FROM_DEVICE:String="loadUnitSettings";

        public static const LOAD_UNIT_TRIP_DATA_FROM_DEVICE:String="loadUnitTripData";

        public static const LOGS_LOADED_FROM_DB_COMPLETE:String="logsLoadedFromDBComplete";

        public static const LOGS_LOADED_FROM_UNIT_COMPLETE:String="logsLoadedFromUnitComplete";

        public static const LOGS_SAVE_ERROR:String="logsSaveError";

        public static const LOG_DELETE_COMPLETE:String="logDeleteCompleteEvent";

        public static const LOG_MARKER_SAVED:String="logMarkerSavedCompleteEvent";

        public static const LOG_STATUS_LOADED_FROM_UNIT_COMPLETE:String="logStatusLoadedFromUnitComplete";

        public static const MEMORIES_LOADED_FROM_DB_COMPLETE:String="memoriesLoadedFromDBComplete";

        public static const MEMORIES_LOADED_FROM_UNIT_COMPLETE:String="memoriesLoadedFromUnitComplete";

        public static const MEMORIES_SAVE_ERROR:String="memoriesSaveError";

        public static const MEMORY_FULL:String="memoryFullError";

        public static const NEW_ENTRY_FOUND:String="newEntryFound";

        public static const PAGE_HEADER_CHANGE:String="pageHeaderChange";

        public static const PLANED_TRACKS_LOADED_COMPLETE:String="planedTrackFilesLoaded";

        public static const PLANED_TRACKS_LOADING_ERROR:String="planedTrackLoadingError";

        public static const PLANED_TRACKS_SEND_COMPLETE:String="planedTrackSendComplete";

        public static const PLANED_TRACK_FILE_HEADER_COMPLETE:String="planedtrackFileHeaderChanged";

        public static const POINT_NAVIGATION_SEND_TO_DEVICE_COMPLETE:String="pointNavigationSendComplete";

        public static const PROGRAM_LOADED_FROM_UNIT_COMPLETE:String="programLoadedFromUnitComplete";

        public static const PROGRAM_SEND_TO_DEVICE_COMPLETE:String="programSendComplete";

        public static const RELOAD_UNIT_LOG_DATA_FROM_DEVICE:String="reloadUnitlogData";

        public static const RELOAD_UNIT_PLANED_TRACK_FILE:String="reloadUnitPlanedTrackFile";

        public static const RESEND_TRACKS_TO_UNIT:String="resendTracksToUnit";

        public static const SAVE_MARKER_COMPLETE:String="saveMarkerComplete";

        public static const SEND_NOTIFICATION:String="sendNotification";

        public static const SEND_NOTIFICATION_TO_DEVICE_COMPLETE:String="sendNotificationComplete";

        public static const SEND_RESET_MEMORY_TO_DEVICE_COMPLETE:String="sendResetMomoryToDeviceComplete";

        public static const SEND_STRAVA_SEGMENT_TO_UNIT:String="sendStravaSegmentToUnit";

        public static const SEND_STRAVA_SEGMENT_TO_UNIT_COMPLETE:String="sendStravaSegmentToUnitComplete";

        public static const SEND_TRACKS_TO_UNIT:String="sendTracksToUnit";

        public static const SEND_TRACKS_TO_UNIT_COMPLETE:String="sendTrackToUnitComplete";

        public static const SETTINGS_ADDED_EVENT:String="SettingsAddedEvent";

        public static const SETTINGS_LOADED_FROM_UNIT_COMPLETE:String="settingsLoadedFromUnitComplete";

        public static const SETTINGS_SEND_TO_DEVICE_COMPLETE:String="settingsSendComplete";

        public static const SLEEP_SCREEN_SEND_TO_DEVICE_COMPLETE:String="sleepScreenSendComplete";

        public static const SPORT_PROFILES_LOADED_FROM_UNIT_COMPLETE:String="sportProfilesLoadedFromUnitComplete";

        public static const SPORT_PROFILE_SEND_TO_DEVICE_COMPLETE:String="sportProfileSendComplete";

        public static const START_LOAD_TOTALS:String="startLoadTotalsSettings";

        public static const TOTALS_ADDED_EVENT:String="totalsAddedEvent";

        public static const TOTALS_LOADED_FROM_UNIT_COMPLETE:String="totalsLoadComplete";

        public static const TOTALS_LOAD_COMPLETE:String="totalsLoadComplete";

        public static const TOTALS_SEND_TO_DEVICE_COMPLETE:String="sendTotalValuesComplete";

        public static const UNITOPTIONS_LOADED_FROM_DB_COMPLETE:String="unitOptionsLoadedFromDBComplete";

        public static const WRITE_ADVANCED_TOTAL_VALUES_TO_DEVICE:String="writeAdvancedTotalValues";

        public static const WRITE_GHOST_RACE_COMPLETE:String="sendGhostRaceComplete";

        public static const WRITE_GHOST_RACE_ERROR:String="sendGhostRaceError";

        public static const WRITE_GHOST_RACE_PROGRESS:String="sendGhostRaceProgress";

        public static const WRITE_GHOST_RACE_TO_DEVICE:String="writeGhostRace";

        public static const WRITE_POINT_NAVIGATION_TO_DEVICE:String="writePointNavigation";

        public static const WRITE_PROGRAM_DATA_TO_DEVICE:String="writeProgramDataFromDevice";

        public static const WRITE_SPORT_PROFILES_TO_DEVICE:String="writeSportProfilesToDevice";

        public static const WRITE_TOTAL_VALUES_TO_DEVICE:String="writeTotalValues";

        public static const WRITE_UNIT_ADVANCED_SETTINGS_TO_DEVICE:String="writeUnitAdvancedSettings";

        public static const WRITE_UNIT_AGPS_DATA:String="writeUnitGpsData";

        public static const WRITE_UNIT_AGPS_DATA_COMPLETE:String="writeUnitGpsDataComplete";

        public static const WRITE_UNIT_INFORMATION_COMPLETE:String="writeUnitInformationComplete";

        public static const WRITE_UNIT_INFORMATION_TO_DEVICE:String="writeUnitInformation";

        internal var _hasLog:Boolean=true;

        internal var _hasMemory:Boolean=true;
    }
}


