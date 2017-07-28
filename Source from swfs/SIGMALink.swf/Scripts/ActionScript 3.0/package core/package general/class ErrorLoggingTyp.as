//class ErrorLoggingTyp
package core.general 
{
    public class ErrorLoggingTyp extends Object
    {
        public function ErrorLoggingTyp()
        {
            super();
            return;
        }

        public static const DESC_ABSTRACTDECODER_ABSTRACT_FUNC:String="AbstractDecoder > decodeUnitInformation: Abstract function, please override!";

        public static const DESC_ACTIVATIONHANDLER_NO_ACTIVATION_KEY:String="ActivationHandler > isActivationNumberValid: Activation key is not available";

        public static const DESC_ACTIVATIONHANDLER_NO_UNIQUE_KEY:String="ActivationHandler > generateTransmitKey: Unique key is not available";

        public static const DESC_ACTIVATIONHANDLER_UNKNOWN_REGISTER_RESULT:String="ActivationHandler > dataReceived: unknown status of register result";

        public static const DESC_ACTIVATIONHANDLER_USE_GET_INSTANCE:String="ActivationHandler > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_CONFIG_ERROR_INSERT_CONFIG:String="Config > insertConfigError: config not saved";

        public static const DESC_CONFIG_SELECT_CONFIG_ERROR:String="Config > selectConfigError: config data not selected";

        public static const DESC_CONFIG_USE_GET_INSTANCE:String="Config > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_CONFIG_WITHOUT_DATA:String="Config > selectConfigComplete: required config data not found";

        public static const DESC_CSV_INVALID_FIELD:String="CSVSpreadSheetFactory > addRow: Field is not a String";

        public static const DESC_DATABASEHANDLER_COMMIT_ERROR:String="DatabaseHandler > commitStatementsError: statement not committed";

        public static const DESC_DATABASEHANDLER_CONNECTION_ERROR:String="DatabaseHandler > openConnectionError: database not connected";

        public static const DESC_DATABASEHANDLER_DATABASE_IO_ERROR:String="DatabaseHandler:";

        public static const DESC_DATABASEHANDLER_DATABASE_SECURITY_ERROR:String="DatabaseHandler:";

        public static const DESC_DATABASEHANDLER_USE_GET_INSTANCE:String="DatabaseHandler > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_DECODE_BMP_ERROR:String="SaveFileWorker > decodeBMPBytes: ";

        public static const DESC_ENCODE_SQLRESULT_DATA_ERROR:String="SaveFileWorker > encodeSQLResultData: ";

        public static const DESC_ERROR_AGPS_DATA_URL_STREAM_ERROR:String="FirmwareUpdateHandler > The download of the A-GPS update file failed.";

        public static const DESC_ERROR_BC2316_WRONG_CRC:String="BC 23.16 > Log: incorrect checksum";

        public static const DESC_ERROR_BLE_SERVICE_READ_FAILED:String="BLEHandler > onLoaded: usb service, read failed!";

        public static const DESC_ERROR_BLE_UNIT_INFO_DYN_CHECKSUM:String="BLEHandler > decodeUnitInformation: incorrect dynamic checksum";

        public static const DESC_ERROR_BLE_UNIT_INFO_STATIC_CHECKSUM:String="BLEHandler > decodeUnitInformation: incorrect checksum1";

        public static const DESC_ERROR_BLE_WRONG_CRC_UNIT_INFO:String="BLEDSHandler > decodeUnitInformation: wrong crc";

        public static const DESC_ERROR_CURRENT_DATABASE_CORRUPT:String="DatabaseBackup > ";

        public static const DESC_ERROR_DATABASE_CANNOT_DELETE:String="StartApplicationHandler > updateDatabaseAgain: ";

        public static const DESC_ERROR_DATABASE_NOT_EXIST:String="DataCenter2 > backup file exist but current data base file doesn\'t exist";

        public static const DESC_ERROR_DATABASE_UPDATE:String="DatabaseUpdate > update error";

        public static const DESC_ERROR_DB_RECOVERY_NOT_POSSIBLE:String="DatabaseRecovery > invalid database";

        public static const DESC_ERROR_DECODE_RC_LOG:String="RC2011Decoder > decodeLog: log not decoded";

        public static const DESC_ERROR_DELETE_MARKER:String="UnitHandler > deleteMarkerError: ";

        public static const DESC_ERROR_DELETE_TRACK_ON_UNIT_TIME_OUT:String="Delete Track timeout ";

        public static const DESC_ERROR_DELETE_TRAINING:String="TrainingHandler > deleteTraining: ";

        public static const DESC_ERROR_DELETE_TRAININGPHASE:String="TrainingHandler > deleteTrainingPhase: ";

        public static const DESC_ERROR_FILE_IMPORT:String="FileImportHandler > fileOpenError: ";

        public static const DESC_ERROR_FILE_MULTI_SELECT:String="FileImportHandler > multipleFileSelectError: ";

        public static const DESC_ERROR_FIRMWARE_UPDATE_DEVICE_INVALID_RESPONSE:String="invalid response";

        public static const DESC_ERROR_FIRMWARE_UPDATE_DEVICE_NO_RESPONSE:String="FirmwareUpdateHandler > Device not responding.";

        public static const DESC_ERROR_FIRMWARE_UPDATE_URL_STREAM_ERROR:String="FirmwareUpdateHandler > The download of the firmware update file failed.";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_EEPROM:String="GPS10Decoder > load EEPROM: wrong crc";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_LOG:String="GPS10Decoder > decodeLog: wrong crc";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_LOGHEADER:String="GPS10Decoder > decodeLogHeader: wrong crc";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_PAGE_HEADER_COUNT:String="GPS10Decoder > decodePageHeaderCount: wrong crc";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_PAUSE:String="GPS10Decoder > decodePause: wrong crc";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_SETTINGS:String="GPS10Decoder > decodeSettings: wrong crc";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_TOTALS:String="GPS10Decoder > decodeTotals: wrong crc";

        public static const DESC_ERROR_GPS10DECODER_WRONG_CRC_UNIT_INFO:String="GPS10DSHandler > decodeUnitInformation: wrong crc";

        public static const DESC_ERROR_GPS10HANDLER_WRONG_UNIT:String="GPS10Handler > load data from unit: wrong unit";

        public static const DESC_ERROR_INSERT_ACTIVATION:String="ActivationHandler > updateActivationError: new activation data not saved";

        public static const DESC_ERROR_INSERT_ROUTE:String="UnitHandler > createNewRouteError: ";

        public static const DESC_ERROR_INSERT_SPORT:String="SportHandler > saveSport: ";

        public static const DESC_ERROR_INSERT_TRAINING:String="TrainingHandler > saveTraining: ";

        public static const DESC_ERROR_LOAD_DATA_FROM_UNIT_TIME_OUT:String="Load data timeout ";

        public static const DESC_ERROR_LOAD_SETTINGS_TIME_OUT:String="Load Settings timeout ";

        public static const DESC_ERROR_LOAD_TOTALS_TIME_OUT:String="Load Totals timeout ";

        public static const DESC_ERROR_LOAD_TRAININGS_TIME_OUT:String="Load Trainings timeout ";

        public static const DESC_ERROR_OLD_DATABASE_CORRUPT:String="DatabaseBackup > ";

        public static const DESC_ERROR_RC2011DECODER_BATTERY_INFORMATION_CHECKSUM1:String="RC2011Decoder > decodeBatteryInformation: incorrect checksum1";

        public static const DESC_ERROR_RC2011DECODER_BATTERY_INFORMATION_CHECKSUM3:String="RC2011Decoder > decodeBatteryInformation: incorrect checksum3";

        public static const DESC_ERROR_RC2011DECODER_LOG_CHECKSUM6:String="RC2011Decoder > decodeLog: incorrect checksum6";

        public static const DESC_ERROR_RC2011DECODER_LOG_FAST_LAP_CHECKSUM6:String="RC2011Decoder > decodeLogFastLap: incorrect checksum6";

        public static const DESC_ERROR_RC2011DECODER_LOG_MARKER_CHECKSUM6:String="RC2011Decoder > decodeLogMarker: incorrect checksum6";

        public static const DESC_ERROR_RC2011DECODER_LOG_PAUSE_CHECKSUM6:String="RC2011Decoder > decodeLogPause: incorrect checksum6";

        public static const DESC_ERROR_RC2011DECODER_PAGEHEADER_ADDRLIST_CHECKSUM1:String="RC2011Decoder > decodeListOfAdressOfPageHeader: incorrect checksum1";

        public static const DESC_ERROR_RC2011DECODER_PAGEHEADER_ADDRLIST_CHECKSUM4:String="RC2011Decoder > decodeListOfAdressOfPageHeader: incorrect checksum4";

        public static const DESC_ERROR_RC2011DECODER_PAGEHEADER_INFO_CHECKSUM6:String="RC2011Decoder > decodePageHeaderInformation: incorrect checksum6";

        public static const DESC_ERROR_RC2011DECODER_SETTINGS_CHECKSUM1:String="RC2011Decoder > decodeSettings: incorrect checksum1";

        public static const DESC_ERROR_RC2011DECODER_SETTINGS_CHECKSUM3:String="RC2011Decoder > decodeSettings: incorrect checksum3";

        public static const DESC_ERROR_RC2011DECODER_SN_INFO_CHECKSUM2:String="RC2011Decoder > decodeSerialNumberInformation: incorrect checksum2";

        public static const DESC_ERROR_RC2011DECODER_SN_INFO_CHECKSUM5:String="RC2011Decoder > decodeSerialNumberInformation: incorrect checksum5";

        public static const DESC_ERROR_RC2011DECODER_TOTAL_VALUES_CHECKSUM1:String="RC2011Decoder > decodeTotalValues: incorrect checksum1";

        public static const DESC_ERROR_RC2011DECODER_TOTAL_VALUES_CHECKSUM3:String="RC2011Decoder > decodeTotalValues: incorrect checksum3";

        public static const DESC_ERROR_RC2011DECODER_UNIT_INFO_CHECKSUM1:String="RC2011Decoder > decodeUnitInformation: incorrect checksum1";

        public static const DESC_ERROR_RC2011DECODER_UNIT_INFO_CHECKSUM2:String="RC2011Decoder > decodeUnitInformation: incorrect checksum2";

        public static const DESC_ERROR_ROX100DECODER_SINGLETON_VIOLATION:String="Rox100Decoder > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_LOG_STATUS:String="ROX100Decoder > decodeLogStatus: wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_NUMBER_OF_TRACKS:String="ROX100Decoder > decodeNumberOfTracks: wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_PLANED_TRACK_HEADER:String="ROX100Decoder > decodePlanedTrackFile: wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_SETTINGS:String="ROX100Decoder > decodeSettings: wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_SET_SETTINGS:String="ROX100Decoder > onLoaded (send settings complete): wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_SET_TOTALS:String="ROX100Decoder > onLoaded (send totals complete): wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_TOTALS:String="ROX100Decoder > decodeTotals: wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_TRACK_DATA:String="ROX100Decoder > decodeTrackFile: wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_TRACK_HEADER:String="ROX100Decoder > decodeTrackFileHeader: wrong crc";

        public static const DESC_ERROR_ROX100DECODER_WRONG_CRC_UNIT_INFO:String="ROX100DSHandler > decodeUnitInformation: wrong crc";

        public static const DESC_ERROR_ROX110DECODER_WRONG_CRC_SET_PROGRAM:String="ROX110Decoder > onLoaded (send program complete): wrong crc";

        public static const DESC_ERROR_ROX2010DECODER_UNIT_INFORMATION_CHECKSUM1:String="ROX2010Decoder > decodeUnitInformation: incorrect checksum1";

        public static const DESC_ERROR_ROX2010DECODER_UNIT_INFORMATION_CHECKSUM2:String="ROX2010Decoder > decodeUnitInformation: incorrect checksum2";

        public static const DESC_ERROR_ROX2012DECODER_BATTERY_INFORMATION_CHECKSUM:String="RC2012Decoder > decodeBatteryInformation: incorrect checksum";

        public static const DESC_ERROR_ROX2012DECODER_LOG_CYCLING_CHECKSUM:String="ROX2012Decoder > decodeLogCycling: incorrect checksum";

        public static const DESC_ERROR_ROX2012DECODER_LOG_CYCLING_LAP_CHECKSUM:String="ROX2012Decoder > decodeLogCyclingLap: incorrect checksum";

        public static const DESC_ERROR_ROX2012DECODER_LOG_HIKING_CHECKSUM:String="ROX2012Decoder > decodeLogRunning: incorrect checksum";

        public static const DESC_ERROR_ROX2012DECODER_LOG_PAUSE_CHECKSUM:String="ROX2012Decoder > decodeLogPause: incorrect checksum";

        public static const DESC_ERROR_ROX2012DECODER_PAGEHEADER_INFO_CHECKSUM6:String="ROX2012Decoder > decodePageHeaderInformation: incorrect checksum6";

        public static const DESC_ERROR_ROX2012DECODER_SETTINGS_CHECKSUM:String="ROX2012Decoder > decodeSettings: incorrect checksum";

        public static const DESC_ERROR_ROX2012DECODER_TOTALS_CHECKSUM:String="ROX2012Decoder > decodeTotals: incorrect checksum";

        public static const DESC_ERROR_ROX2012_SERIAL_NUMBER_DECODING_CHECKSUM:String="Topline2012Decoder > decode serialnumber: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_LOG_STATUS:String="ROX70Decoder > decodeLogStatus: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_NUMBER_OF_TRACKS:String="ROX70Decoder > decodeNumberOfTracks: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_PLANED_TRACK_HEADER:String="ROX70Decoder > decodePlanedTrackFile: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_SETTINGS:String="ROX70Decoder > decodeSettings: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_SET_PROFILE:String="ROX70Decoder > onLoaded (send sport profile complete): wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_SET_SETTINGS:String="ROX70Decoder > onLoaded (send settings complete): wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_SET_TOTALS:String="ROX70Decoder > onLoaded (send totals complete): wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_SPORT_PROFILE:String="ROX70Decoder > decodeSportProfile: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_TOTALS:String="ROX70Decoder > decodeTotals: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_TRACK_DATA:String="ROX70Decoder > decodeTrackFile: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_TRACK_HEADER:String="ROX70Decoder > decodeTrackFileHeader: wrong crc";

        public static const DESC_ERROR_ROX70DECODER_WRONG_CRC_UNIT_INFO:String="ROX70DSHandler > decodeUnitInformation: wrong crc";

        public static const DESC_ERROR_ROXDECODER_UNIT_INFORMATION_CHECKSUM1:String="ROXDecoder > decodeUnitInformation: incorrect checksum1";

        public static const DESC_ERROR_ROXDECODER_UNIT_INFORMATION_ROX2011_DETECTED:String="ROXDecoder > decodeUnitInformation: ROX 8.1 / 9.1 on DS 2008 is not supported";

        public static const DESC_ERROR_SAVE_MARKER:String="UnitHandler > saveMarkerError: ";

        public static const DESC_ERROR_SELECT_ACTIVATION:String="ActivationHandler > selectActivationError: activations not selected";

        public static const DESC_ERROR_SELECT_SPORT:String="SportHandler > loadSportsFromDB: ";

        public static const DESC_ERROR_SELECT_STATISTIC_YEARS:String="StatisticHandler > selectYearsWithData";

        public static const DESC_ERROR_SELECT_TRAINING:String="TrainingHandler > loadTrainingsFromDB: ";

        public static const DESC_ERROR_SELECT_TRAININGPHASES:String="TrainingHandler > loadTrainingPhasesFromDB: ";

        public static const DESC_ERROR_SEND_CHECK_RESPONSE_LESS_DATA:String="Gps10Handler > Send-Response Check failed... > Less Data";

        public static const DESC_ERROR_SEND_CHECK_RESPONSE_NO_DATA:String="Gps10Handler > Send-Response Check failed... > No Data";

        public static const DESC_ERROR_SEND_CHECK_RESPONSE_OUT_OF_RANGE:String="Gps10Handler > Send-Response Check failed... > Out of Range";

        public static const DESC_ERROR_SEND_CHECK_RESPONSE_UNKNOWN_ERROR:String="Gps10Handler > Send-Response Check failed... > Unknown Error";

        public static const DESC_ERROR_SEND_TOTALS_TIME_OUT:String="Send Totlas timeout ";

        public static const DESC_ERROR_SEND_TRACK_TO_UNIT_TIME_OUT:String="Send Track timeout ";

        public static const DESC_ERROR_SEND_TRAININGS_TIME_OUT:String="Send Trainings timeout ";

        public static const DESC_ERROR_SETTING_DATA_TOPLINE2009_NOT_VALIDE:String="ToplineDecoder > decodeSettings: data is not valid";

        public static const DESC_ERROR_SETTING_DATA_TOPLINE2012_NOT_VALIDE:String="Topline2012Decoder > decodeSettings: data is not valid";

        public static const DESC_ERROR_TRIP_DATA_TOPLINE2009_NOT_VALIDE:String="ToplineDecoder > decodeMemory: data is not valid";

        public static const DESC_ERROR_UNIT_IN_SLEEP_MODE:String="ToplineDecoder > decodeUnitInformation: Unit in sleep mode";

        public static const DESC_ERROR_UNIT_NOT_IN_SILENCE_MODE:String="RC2011Decoder > decodeUnitInformation: Unit not in silence mode";

        public static const DESC_ERROR_UNKNOWN_OS_CAPABILITIES:String="USB > Initialisation of USBService failed";

        public static const DESC_ERROR_USB:String="USB > receivedDataUncomplete: ";

        public static const DESC_ERROR_USB_SERVICE_FILE_NOT_FOUND:String="USB > Executable USBService file not found";

        public static const DESC_ERROR_USB_SERVICE_READ_FAILED:String="RC2011Handler > onLoaded: usb service, read failed!";

        public static const DESC_ERROR_USB_SERVICE_SCAN_USB_PORT:String="USB > scanUSBPortsError: ";

        public static const DESC_ERROR_USB_SERVICE_STANDARD_ERROR_DATA_HANDLER:String="USB > standardErrorDataHandler: ";

        public static const DESC_ERROR_USB_SERVICE_TOO_MANY_DATA_RECEIVED:String="USB > standardOutputDataHandler: ";

        public static const DESC_ERROR_USB_SERVICE_UNIT_HANDLER_IS_NULL:String="USB > standardOutputDataHandler: current unit handler is null, ";

        public static const DESC_ERROR_WRITE_DATA_ON_UNIT:String="RC2011Handler > onSent: write data error, checksum incorrect";

        public static const DESC_EXPORTDATA_ERROR_WRITE_EXPORT_FILE_01:String="ExportData > saveFileSelected: file couldn\'t write";

        public static const DESC_EXPORTDATA_ERROR_WRITE_EXPORT_FILE_02:String="ExportData > onFileIOError: file couldn\'t write";

        public static const DESC_FILTERHANDLER_ERROR_WRITE_FILTER_FILE:String="FilterHandler > saveFilterIOError: file couldn\'t write";

        public static const DESC_FILTERHANDLER_SFF_NOT_READ:String="FilterHandler > loadFilterListIOError: .sff file couldn\'t read";

        public static const DESC_HANDLECOMMANDMESSAGE_ERROR:String="SaveFileWorker > handleCommandMessage: ";

        public static const DESC_HANDLER_FACTORY_DOCKING_STATION_IN_NOT_SUPPORTED:String="Not the same Unit";

        public static const DESC_HANDLER_FACTORY_NOT_THE_SAME_UNIT:String="Not the same Unit";

        public static const DESC_HANDLER_FACTORY_UNIT_IS_NOT_SUPPORTED:String="Unit is not supported";

        public static const DESC_INFO_ACTIVATION:String="ActivationHandler: ";

        public static const DESC_INFO_CHECK_CONNECTION_TIME_OUT:String="Unit Handler > checkConnectionTimeout ";

        public static const DESC_INFO_CONFIG_UPDATE:String="Config > save: ";

        public static const DESC_INFO_ERROR_USB_SERVICE_READ_FAILED:String="RC2011Handler > read data error... repeat command";

        public static const DESC_INFO_ERROR_WRITE_DATA_ON_UNIT:String="RC2011Handler > write data error... repeat command";

        public static const DESC_INFO_REGET_LOG_DATA_COMMAND:String="ROX100Decoder: reget last session - ";

        public static const DESC_INFO_ROX_ON_WRONG_MENU:String="ROX on wrong menu";

        public static const DESC_LOGROX_NO_ENTRIES_TO_GENERATE_CSV:String="LogROX9 > generateCSV: no log entries found";

        public static const DESC_LOGVIEW_NO_ENTRIES_FOUND:String="LogView > logEntriesLoadComplete: no entries found";

        public static const DESC_LOG_ABSTRACT_FUNC_GENERATE_CSV:String="Log > generateCSV: Abstract function, please override!";

        public static const DESC_LOG_ABSTRACT_FUNC_GENERATE_PWX:String="Log > generatePWX: Abstract function, please override!";

        public static const DESC_LOG_ABSTRACT_FUNC_GENERATE_XLSX:String="Log > generateXLSX: Abstract function, please override!";

        public static const DESC_LOG_PARTICIPANT_INVALID_DECLARATION:String="Log > set participant: p_participant must be an array of Person";

        public static const DESC_LOG_ROX_UNKNOWN_SMF_VERSION:String="LogROX9 > fromSLF: unknown .slf version";

        public static const DESC_MEMORY_ABSTRACT_FUNC_GENERATE_CSV:String="Memory > generateCSV: Abstract function, please override!";

        public static const DESC_MEMORY_ABSTRACT_FUNC_GENERATE_PWX:String="Memory > generatePWX: Abstract function, please override!";

        public static const DESC_MEMORY_ABSTRACT_FUNC_GENERATE_XLSX:String="Memory > generateXLSX: Abstract function, please override!";

        public static const DESC_MEMORY_BIKE_ABSTRACT_FUNC_GENERATE_CSV:String="MemoryBikeComputer > generateCSV: Abstract function, please override!";

        public static const DESC_MEMORY_BIKE_ABSTRACT_FUNC_GENERATE_PWX:String="MemoryBikeComputer > generatePWX: Abstract function, please override!";

        public static const DESC_MEMORY_BIKE_ABSTRACT_FUNC_GENERATE_XLSX:String="MemoryBikeComputer > generateXLSX: Abstract function, please override!";

        public static const DESC_MEMORY_PARTICIPANT_INVALID_DECLARATION:String="Memory > set participant: p_participant must be an array of Person";

        public static const DESC_MEMORY_ROX_UNKNOWN_SMF_VERSION:String="MemoryROX > fromSMF: unknown .smf version";

        public static const DESC_MEMORY_RUNNING_ABSTRACT_FUNC_GENERATE_CSV:String="MemoryRunningComputer > generateCSV: Abstract function, please override!";

        public static const DESC_MEMORY_RUNNING_ABSTRACT_FUNC_GENERATE_PWX:String="MemoryRunningComputer > generatePWX: Abstract function, please override!";

        public static const DESC_MEMORY_RUNNING_ABSTRACT_FUNC_GENERATE_XLSX:String="MemoryRunningComputer > generateXLSX: Abstract function, please override!";

        public static const DESC_OLDUNITHANDLER_UNIT_NOT_SUPPORTED:String="OldUnitHandler > getNewSerialNumber: Unit is not supported - unknown serialnumber";

        public static const DESC_PERSON_ILLEGAL_TYPE_OF_GENDER:String="Person > set gender: Illegal type of gender";

        public static const DESC_RC2011DECODER_USE_GET_INSTANCE:String="RC2011Decoder > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_ROXDECODER_USE_GET_INSTANCE:String="ROXDecoder > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_SPORTPROFILE_NOT_SAVED:String="Sportprofiles > Error while saving sportprofile";

        public static const DESC_TOPLINE2012DECODER_USE_GET_INSTANCE:String="Topline2012Decoder > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_TOPLINEDECODER_USE_GET_INSTANCE:String="ToplineDecoder > Constructor: This is a Singleton. Use the getInstace() methode!";

        public static const DESC_UNITCOLLECTIONMANAGER_ERROR_DELETE_UNIT:String="UnitCollectionManager > insertUnitInDBError: unit not deleted";

        public static const DESC_UNITCOLLECTIONMANAGER_ERROR_INSERT_UNIT:String="UnitCollectionManager > insertUnitInDBError: unit not saved";

        public static const DESC_UNITCOLLECTIONMANAGER_ERROR_SELECT_UNIT:String="UnitCollectionManager > loadUnitFromDBError: units not selected";

        public static const DESC_UNITHANDLER_ERROR_DELETE_LOG:String="UnitHandler > deleteLogFromDBError: log not deleted";

        public static const DESC_UNITHANDLER_ERROR_DELETE_LOG_PERSON:String="UnitHandler > deletePersonError: log person not deleted";

        public static const DESC_UNITHANDLER_ERROR_DELETE_MEMORY:String="UnitHandler > deleteMemoryFromDBError: memory not deleted";

        public static const DESC_UNITHANDLER_ERROR_DELETE_PERSON_FROM_ALL:String="UnitHandler > deletePersonFromAllTablesError: Can not delete person from all tables";

        public static const DESC_UNITHANDLER_ERROR_DELETE_SETTINGS:String="UnitHandler > deleteSettingsFromDBError: settings not deleted";

        public static const DESC_UNITHANDLER_ERROR_DELETE_TOTALS:String="UnitHandler > deleteTotalsFromDBError: totals not deleted";

        public static const DESC_UNITHANDLER_ERROR_GET_LOG_DATA:String="UnitHandler > getLogData: required log data not found";

        public static const DESC_UNITHANDLER_ERROR_GET_MEMORY_DATA:String="UnitHandler > getMemoryData: required memory data not found";

        public static const DESC_UNITHANDLER_ERROR_INSERT_ENTRY:String="UnitHandler > insertEntryError: log entries not saved";

        public static const DESC_UNITHANDLER_ERROR_INSERT_LOG:String="UnitHandler > insertLogError: log not saved";

        public static const DESC_UNITHANDLER_ERROR_INSERT_MEMORY:String="UnitHandler > insertMemoryError: memory not saved";

        public static const DESC_UNITHANDLER_ERROR_INSERT_MEMORY_PERSON:String="UnitHandler > insertPersonToMemoryError: memory person not saved";

        public static const DESC_UNITHANDLER_ERROR_INSERT_PERSON:String="UnitHandler > insertPersonError: person not saved";

        public static const DESC_UNITHANDLER_ERROR_INSERT_SETTINGS:String="UnitHandler > insertSettingsError: settings not saved";

        public static const DESC_UNITHANDLER_ERROR_SELECT_ALL_PERSONS:String="UnitHandler > selectAllPersonsError: Can not select all persons";

        public static const DESC_UNITHANDLER_ERROR_SELECT_CURRENT_SETTINGS:String="UnitHandler > selectCurrentSettingsError: current settings not selected";

        public static const DESC_UNITHANDLER_ERROR_SELECT_LOG_COMPLETE:String="UnitHandler > selectLogError: log not selected";

        public static const DESC_UNITHANDLER_ERROR_SELECT_LOG_ENTRIES:String="UnitHandler > loadLogEntriesError: log entries not selected";

        public static const DESC_UNITHANDLER_ERROR_SELECT_LOG_PERSON:String="UnitHandler > selectLogPersonError: log person not selected";

        public static const DESC_UNITHANDLER_ERROR_SELECT_MEMORY:String="UnitHandler > selectMemoryError: memory not selected";

        public static const DESC_UNITHANDLER_ERROR_SELECT_MEMORY_PERSON:String="UnitHandler > selectMemoryPersonError: memory person not selected";

        public static const DESC_UNITHANDLER_ERROR_SELECT_SETTINGS_DATA:String="UnitHandler > getSettingsData: required settings data not found";

        public static const DESC_UNITHANDLER_FILE_NOT_EXIST:String="UnitHandler > createEmptySettings: file does not exist";

        public static const DESC_UNIT_ABSTRACT_FUNC_FROM_DB:String="Unit > fromDB: Abstract function, please override!";

        public static const DESC_UNIT_ABSTRACT_FUNC_FROM_SUF:String="Unit > fromSUF: Abstract function, please override!";

        public static const DESC_WARNING_CANNOT_CREATE_SETTING_DATA:String="CurrentUnitHandler > onLoaded: Can not create setting data";

        public static const DESC_WARNING_CANNOT_CREATE_UNIT:String="CurrentUnitHandler > onLoaded: Can not create unit";

        public static const DESC_WARNING_DECODING_CHECKSUM6_CORRUPT:String="ROXDecoder > Decoding > Wrong checksum6";

        public static const DESC_WARNING_DECODING_CHECKSUM7_CORRUPT:String="ROXDecoder > Decoding > Wrong checksum7";

        public static const DESC_WARNING_MULTIPLE_WRONG_HR_VALUES:String="RC2011Decoder > smoothHR: wrong heartrate values";

        public static const DESC_WARNING_MULTIPLE_WRONG_SPEE_VALUES:String="RC2011Decoder > smoothSpeed: wrong speed values";

        public static const DESC_WARNING_NOT_SUPPORTED_MODEL:String="Gps10Decoder > decodeUnitInformation: Model not supported";

        public static const DESC_WARNING_NOT_SUPPORTET_2012_MODEL:String="Topline2012Decoder > decodeUnitInformation: Model not supported";

        public static const DESC_WARNING_NOT_SUPPORTET_MODEL:String="ToplineDecoder > decodeUnitInformation: Model not supported";

        public static const DESC_WARNING_UNIT_DO_NOT_MATCH:String="Topline2016Handler > onLoaded: Unit do not match";

        public static const DESC_WARNING_UNSUPPORTED_OR_NO_COMMUNICATION_MODE:String="Topline2016Handler > unsupported or no communication mode";

        public static const DESC_WARNING_USB_SERVICE_TOO_MANY_DS_FOUND:String="USB > Too many docking stations found...";

        public static const DESC_WARNING_WRONG_ALTITUDE_VALUE:String="ROXDecoder > Decoding > Wrong altitude value";

        public static const DESC_WARNING_WRONG_CADENCE_VALUE:String="ROX2010Decoder > Decoding > Wrong cadence value";

        public static const DESC_WARNING_WRONG_HEARTRATE_VALUE:String="ROXDecoder > Decoding > Wrong heartrate value";

        public static const DESC_WARNING_WRONG_SPEED_VALUE:String="ROXDecoder > Decoding > Wrong speed value";

        public static const DESC_WRITE_FILE_ERROR:String="SaveFileWorker > writeToFile: ";

        public static const DESC_XLSX_INVALID_FIELD:String="XLSXSpreadSheetFactory > addRow: Field is not a String";

        public static const ERROR_ABSTRACTDECODER_ABSTRACT_FUNC:int=10063;

        public static const ERROR_ACTIVATIONHANDLER_NO_ACTIVATION_KEY:int=100001;

        public static const ERROR_ACTIVATIONHANDLER_SINGLETON_VIOLATION:int=10070;

        public static const ERROR_ACTIVATIONHANDLER_UNIQUE_KEY_IS_NULL:int=100000;

        public static const ERROR_ACTIVATIONHANDLER_UNKOWN_REGISTER_RESULT:int=100002;

        public static const ERROR_AGPS_DATA_URL_STREAM_ERROR:int=1058;

        public static const ERROR_BC2316_WRONG_CRC:int=537;

        public static const ERROR_BLE_SERVICE_READ_FAILED:int=118;

        public static const ERROR_BLE_UNIT_INFO_DYN_CHECKSUM:int=10133;

        public static const ERROR_BLE_UNIT_INFO_STATIC_CHECKSUM:int=10134;

        public static const ERROR_BLE_WRONG_CRC_UNIT_INFO:int=523;

        public static const ERROR_COMMIT_STATEMENTS:int=1000001;

        public static const ERROR_CONFIG_SINGLETON_VIOLATION:int=10071;

        public static const ERROR_CSV_INVALID_FIELD:int=10003;

        public static const ERROR_CURRENT_DATABASE_CORRUPT:int=1000035;

        public static const ERROR_DATABASEHANDLER_SINGLETON_VIOLATION:int=10072;

        public static const ERROR_DATABASE_CANNOT_DELETE:int=1000044;

        public static const ERROR_DATABASE_CONNECTION:int=1000000;

        public static const ERROR_DATABASE_IO:int=1000030;

        public static const ERROR_DATABASE_NOT_EXIST:int=1000036;

        public static const ERROR_DATABASE_SECURITY_ERROR:int=1000031;

        public static const ERROR_DATABASE_UPDATE:int=1000059;

        public static const ERROR_DB_RECOVERY_NOT_POSSIBLE:int=1000047;

        public static const ERROR_DECODE_BMP_ERROR:int=1000051;

        public static const ERROR_DECODE_RC_LOG:int=10121;

        public static const ERROR_DELETE_LOG:int=1000023;

        public static const ERROR_DELETE_LOG_PERSON:int=1000024;

        public static const ERROR_DELETE_MARKER:int=1000040;

        public static const ERROR_DELETE_MEMORY:int=1000019;

        public static const ERROR_DELETE_PERSON_FROM_ALL:int=10098;

        public static const ERROR_DELETE_SETTINGS:int=1000012;

        public static const ERROR_DELETE_TOTLAS:int=1000045;

        public static const ERROR_DELETE_TRACK_ON_UNIT_TIME_OUT:int=129;

        public static const ERROR_DELETE_TRAINING:int=1000057;

        public static const ERROR_DELETE_TRAININGPHASE:int=1000057;

        public static const ERROR_DELETE_UNIT:int=1000028;

        public static const ERROR_DOCKING_STATION_IN_NOT_SUPPORTED:int=10093;

        public static const ERROR_EMPTY_CONFIG:int=1000003;

        public static const ERROR_EMPTY_SETTINGS_FILE_NOT_EXIST:int=1035;

        public static const ERROR_ENCODE_SQLRESULT_DATA_ERROR:int=1000052;

        public static const ERROR_FILE_IMPORT:int=1059;

        public static const ERROR_FILE_MULTI_SELECT:int=1060;

        public static const ERROR_FIRMWARE_UPDATE_DEVICE_INVALID_RESPONSE:int=1061;

        public static const ERROR_FIRMWARE_UPDATE_DEVICE_NO_RESPONSE:int=1058;

        public static const ERROR_FIRMWARE_UPDATE_URL_STREAM_ERROR:int=1057;

        public static const ERROR_GET_LOG_DATA:int=1000013;

        public static const ERROR_GET_MEMORY_DATA:int=1000016;

        public static const ERROR_GPS10DECODER_LOG_INFO_CHECKSUM:int=10156;

        public static const ERROR_GPS10DECODER_PAGEHEADER_INFO_CHECKSUM:int=10155;

        public static const ERROR_GPS10DECODER_WRONG_CRC_EEPROM:int=549;

        public static const ERROR_GPS10DECODER_WRONG_CRC_PAGE_HEADER_COUNT:int=550;

        public static const ERROR_GPS10DECODER_WRONG_CRC_SETTINGS:int=547;

        public static const ERROR_GPS10DECODER_WRONG_CRC_TOTALS:int=548;

        public static const ERROR_GPS10DECODER_WRONG_CRC_UNIT_INFO:int=533;

        public static const ERROR_GPS10HANDLER_WRONG_UNIT:int=548;

        public static const ERROR_HANDLECOMMANDMESSAGE_ERROR:int=1000053;

        public static const ERROR_INSERT_ACTIVATION:int=1000033;

        public static const ERROR_INSERT_CONFIG:int=1000025;

        public static const ERROR_INSERT_ENTRY:int=1000005;

        public static const ERROR_INSERT_LOG:int=1000004;

        public static const ERROR_INSERT_MEMORY:int=1000020;

        public static const ERROR_INSERT_MEMORY_PERSON:int=1000021;

        public static const ERROR_INSERT_PERSON:int=1000006;

        public static const ERROR_INSERT_ROUTE:int=1000046;

        public static const ERROR_INSERT_SETTINGS:int=1000011;

        public static const ERROR_INSERT_SPORT:int=1000048;

        public static const ERROR_INSERT_TRAINING:int=1000054;

        public static const ERROR_INSERT_UNIT:int=1000027;

        public static const ERROR_INVALID_DATABASE:int=3;

        public static const ERROR_LOAD_DATA_FROM_UNIT_TIME_OUT:int=130;

        public static const ERROR_LOAD_SETTINGS_TIME_OUT:int=125;

        public static const ERROR_LOAD_TOTALS_TIME_OUT:int=126;

        public static const ERROR_LOAD_TRACK_FROM_DEVICE:int=10135;

        public static const ERROR_LOAD_TRAININGS_TIME_OUT:int=131;

        public static const ERROR_LOGGING_INFO:int=1;

        public static const ERROR_LOG_ABSTRACT_FUNC_GENERATE_CSV:int=10054;

        public static const ERROR_LOG_ABSTRACT_FUNC_GENERATE_PWX:int=10056;

        public static const ERROR_LOG_ABSTRACT_FUNC_GENERATE_XLSX:int=10055;

        public static const ERROR_LOG_PARTICIPANT_INVALID_DECLARATION:int=10005;

        public static const ERROR_LOG_TO_VIEW_UNCOMPLETE:int=1051;

        public static const ERROR_MEMORY_ABSTRACT_FUNC_GENERATE_CSV:int=10057;

        public static const ERROR_MEMORY_ABSTRACT_FUNC_GENERATE_PWX:int=10059;

        public static const ERROR_MEMORY_ABSTRACT_FUNC_GENERATE_XLSX:int=10058;

        public static const ERROR_MEMORY_BIKE_ABSTRACT_FUNC_GENERATE_CSV:int=10064;

        public static const ERROR_MEMORY_BIKE_ABSTRACT_FUNC_GENERATE_PWX:int=10066;

        public static const ERROR_MEMORY_BIKE_ABSTRACT_FUNC_GENERATE_XLSX:int=10065;

        public static const ERROR_MEMORY_PARTICIPANT_INVALID_DECLARATION:int=10006;

        public static const ERROR_MEMORY_RUNNING_ABSTRACT_FUNC_GENERATE_CSV:int=10094;

        public static const ERROR_MEMORY_RUNNING_ABSTRACT_FUNC_GENERATE_PWX:int=10096;

        public static const ERROR_MEMORY_RUNNING_ABSTRACT_FUNC_GENERATE_XLSX:int=10095;

        public static const ERROR_NFC_SERVICE_STANDARD_ERROR_DATA_HANDLER:int=216;

        public static const ERROR_NOT_THE_SAME_UNIT:int=10092;

        public static const ERROR_NO_LOG_ENTRIES_TO_GENERATE_CSV:int=10067;

        public static const ERROR_OLD_DATABASE_CORRUPT:int=1000034;

        public static const ERROR_OLD_DC_VERSION:int=2;

        public static const ERROR_PERSON_ILLEGAL_TYPE_OF_GENDER:int=10007;

        public static const ERROR_RC2011DECODER_BATTERY_INFORMATION_CHECKSUM1:int=10109;

        public static const ERROR_RC2011DECODER_BATTERY_INFORMATION_CHECKSUM3:int=10108;

        public static const ERROR_RC2011DECODER_LOG_CHECKSUM6:int=10113;

        public static const ERROR_RC2011DECODER_LOG_FAST_LAP_CHECKSUM6:int=10116;

        public static const ERROR_RC2011DECODER_LOG_MARKER_CHECKSUM6:int=10114;

        public static const ERROR_RC2011DECODER_LOG_PAUSE_CHECKSUM6:int=10115;

        public static const ERROR_RC2011DECODER_PAGEHEADER_ADDRLIST_CHECKSUM1:int=10112;

        public static const ERROR_RC2011DECODER_PAGEHEADER_ADDRLIST_CHECKSUM4:int=10111;

        public static const ERROR_RC2011DECODER_PAGEHEADER_INFO_CHECKSUM6:int=10110;

        public static const ERROR_RC2011DECODER_SETTINGS_CHECKSUM1:int=10105;

        public static const ERROR_RC2011DECODER_SETTINGS_CHECKSUM3:int=10104;

        public static const ERROR_RC2011DECODER_SINGLETON_VIOLATION:int=10099;

        public static const ERROR_RC2011DECODER_SN_INFO_CHECKSUM2:int=10102;

        public static const ERROR_RC2011DECODER_SN_INFO_CHECKSUM5:int=10103;

        public static const ERROR_RC2011DECODER_TOTAL_VALUES_CHECKSUM1:int=10107;

        public static const ERROR_RC2011DECODER_TOTAL_VALUES_CHECKSUM3:int=10106;

        public static const ERROR_RC2011DECODER_UNIT_INFO_CHECKSUM1:int=10101;

        public static const ERROR_RC2011DECODER_UNIT_INFO_CHECKSUM2:int=10100;

        public static const ERROR_ROX100DECODER_SINGLETON_VIOLATION:int=10124;

        public static const ERROR_ROX100DECODER_WRONG_CRC_LOG_STATUS:int=516;

        public static const ERROR_ROX100DECODER_WRONG_CRC_NUMBER_OF_TRACKS:int=518;

        public static const ERROR_ROX100DECODER_WRONG_CRC_PLANED_TRACK_HEADER:int=520;

        public static const ERROR_ROX100DECODER_WRONG_CRC_SETTINGS:int=512;

        public static const ERROR_ROX100DECODER_WRONG_CRC_SET_SETTINGS:int=513;

        public static const ERROR_ROX100DECODER_WRONG_CRC_SET_TOTALS:int=515;

        public static const ERROR_ROX100DECODER_WRONG_CRC_TOTALS:int=514;

        public static const ERROR_ROX100DECODER_WRONG_CRC_TRACK_DATA:int=519;

        public static const ERROR_ROX100DECODER_WRONG_CRC_TRACK_HEADER:int=517;

        public static const ERROR_ROX100DECODER_WRONG_CRC_UNIT_INFO:int=511;

        public static const ERROR_ROX110DECODER_WRONG_CRC_SET_PROGRAM:int=536;

        public static const ERROR_ROX2010DECODER_UNIT_INFORMATION_CHECKSUM1:int=10118;

        public static const ERROR_ROX2010DECODER_UNIT_INFORMATION_CHECKSUM2:int=10119;

        public static const ERROR_ROX2012DECODER_BATTERY_INFORMATION_CHECKSUM:int=10126;

        public static const ERROR_ROX2012DECODER_LOG_CYCLING_CHECKSUM:int=10130;

        public static const ERROR_ROX2012DECODER_LOG_CYCLING_LAP_CHECKSUM:int=10131;

        public static const ERROR_ROX2012DECODER_LOG_HIKING_CHECKSUM:int=10132;

        public static const ERROR_ROX2012DECODER_LOG_PAUSE_CHECKSUM:int=10129;

        public static const ERROR_ROX2012DECODER_PAGEHEADER_INFO_CHECKSUM6:int=10125;

        public static const ERROR_ROX2012DECODER_SETTINGS_CHECKSUM:int=10127;

        public static const ERROR_ROX2012DECODER_TOTALS_CHECKSUM:int=10128;

        public static const ERROR_ROX2012_SERIAL_NUMBER_DECODING_CHECKSUM:int=522;

        public static const ERROR_ROX70DECODER_WRONG_CRC_LOG_STATUS:int=524;

        public static const ERROR_ROX70DECODER_WRONG_CRC_NUMBER_OF_TRACKS:int=525;

        public static const ERROR_ROX70DECODER_WRONG_CRC_PLANED_TRACK_HEADER:int=526;

        public static const ERROR_ROX70DECODER_WRONG_CRC_SETTINGS:int=527;

        public static const ERROR_ROX70DECODER_WRONG_CRC_SET_PROFILE:int=535;

        public static const ERROR_ROX70DECODER_WRONG_CRC_SET_SETTINGS:int=528;

        public static const ERROR_ROX70DECODER_WRONG_CRC_SET_TOTALS:int=529;

        public static const ERROR_ROX70DECODER_WRONG_CRC_SPORT_PROFILE:int=534;

        public static const ERROR_ROX70DECODER_WRONG_CRC_TOTALS:int=530;

        public static const ERROR_ROX70DECODER_WRONG_CRC_TRACK_DATA:int=531;

        public static const ERROR_ROX70DECODER_WRONG_CRC_TRACK_HEADER:int=532;

        public static const ERROR_ROX70DECODER_WRONG_CRC_UNIT_INFO:int=533;

        public static const ERROR_ROXDECODER_SINGLETON_VIOLATION:int=10074;

        public static const ERROR_ROXDECODER_UNIT_INFORMATION_CHECKSUM1:int=10120;

        public static const ERROR_ROXDECODER_UNIT_INFORMATION_ROX2011_DETECTED:int=10122;

        public static const ERROR_SAVE_MARKER:int=1000041;

        public static const ERROR_SAVE_SPORTPROFILES_DATA:int=1000094;

        public static const ERROR_SELECT_ACTIVATION:int=1000032;

        public static const ERROR_SELECT_ALL_PERSONS:int=10097;

        public static const ERROR_SELECT_CONFIG:int=1000002;

        public static const ERROR_SELECT_CURRENT_SETTINGS:int=1000007;

        public static const ERROR_SELECT_LOG:int=1000014;

        public static const ERROR_SELECT_LOG_ENTRIES:int=1000022;

        public static const ERROR_SELECT_LOG_PERSON:int=1000017;

        public static const ERROR_SELECT_MEMORY:int=1000015;

        public static const ERROR_SELECT_MEMORY_PERSON:int=1000018;

        public static const ERROR_SELECT_SETTINGS_DATA:int=1000009;

        public static const ERROR_SELECT_SPORT:int=1000049;

        public static const ERROR_SELECT_SPORTPROFILES_DATA:int=1000010;

        public static const ERROR_SELECT_STATISTIC_YEARS:int=1000058;

        public static const ERROR_SELECT_TRAINING:int=1000055;

        public static const ERROR_SELECT_TRAININGPHASES:int=1000056;

        public static const ERROR_SELECT_UNIT:int=1000026;

        public static const ERROR_SEND_CHECK_RESPONSE_LESS_DATA:int=900002;

        public static const ERROR_SEND_CHECK_RESPONSE_NO_DATA:int=900001;

        public static const ERROR_SEND_CHECK_RESPONSE_OUT_OF_RANGE:int=900003;

        public static const ERROR_SEND_CHECK_RESPONSE_UNKNOWN_ERROR:int=900004;

        public static const ERROR_SEND_TOTALS_TIME_OUT:int=127;

        public static const ERROR_SEND_TRACK_TO_UNIT_TIME_OUT:int=128;

        public static const ERROR_SEND_TRAININGS_TIME_OUT:int=132;

        public static const ERROR_SETTING_DATA_TOPLINE2009_NOT_VALIDE:int=101;

        public static const ERROR_SETTING_DATA_TOPLINE2012_NOT_VALIDE:int=124;

        public static const ERROR_TOPLINE2012DECODER_SINGLETON_VIOLATION:int=10123;

        public static const ERROR_TOPLINEDECODER_SINGLETON_VIOLATION:int=10075;

        public static const ERROR_TRIP_DATA_TOPLINE2009_NOT_VALIDE:int=107;

        public static const ERROR_UNCAUGHT_EXCEPTION:int=-1;

        public static const ERROR_UNIT_ABSTRACT_FUNC_FROM_DB:int=10061;

        public static const ERROR_UNIT_ABSTRACT_FUNC_FROM_SUF:int=10060;

        public static const ERROR_UNIT_IN_SLEEP_MODE:int=100;

        public static const ERROR_UNIT_IS_NOT_SUPPORTED:int=10091;

        public static const ERROR_UNIT_NOT_IN_SILENCE_MODE:int=109;

        public static const ERROR_UNIT_NOT_SUPPORTED:int=10078;

        public static const ERROR_UNKNOWN_OS_CAPABILITIES:int=111;

        public static const ERROR_UNKNOWN_SLF_VERSION:int=10090;

        public static const ERROR_UNKNOWN_SMF_VERSION:int=10069;

        public static const ERROR_USB:int=110;

        public static const ERROR_USB_SERVICE_FILE_NOT_FOUND:int=112;

        public static const ERROR_USB_SERVICE_READ_FAILED:int=118;

        public static const ERROR_USB_SERVICE_SCAN_USB_PORT:int=114;

        public static const ERROR_USB_SERVICE_STANDARD_ERROR_DATA_HANDLER:int=116;

        public static const ERROR_USB_SERVICE_TOO_MANY_DATA_RECEIVED:int=115;

        public static const ERROR_USB_SERVICE_UNIT_HANDLER_IS_NULL:int=117;

        public static const ERROR_WRITE_DATA_ON_UNIT:int=108;

        public static const ERROR_WRITE_FILE_ERROR:int=1000050;

        public static const ERROR_XLSX_INVALID_FIELD:int=10004;

        public static const INFO_ACTIVATION:int=1000038;

        public static const INFO_CHECK_CONNECTION_TIME_OUT:int=120;

        public static const INFO_CONFIG_UPDATE:int=1000037;

        public static const INFO_ERROR_USB_SERVICE_READ_FAILED:int=122;

        public static const INFO_ERROR_WRITE_DATA_ON_UNIT:int=121;

        public static const INFO_REGET_LOG_DATA_COMMAND:int=521;

        public static const INFO_ROX_ON_WRONG_MENU:int=123;

        public static const IO_ERROR_EXPORT_DATA_WRITE_FILE_01:int=1043;

        public static const IO_ERROR_EXPORT_DATA_WRITE_FILE_02:int=1044;

        public static const IO_ERROR_READ_FILTER_FILE:int=1021;

        public static const IO_ERROR_WRITE_FILTER_FILE:int=1022;

        public static const WARNING_CANNOT_CREATE_SETTING_DATA:int=10002;

        public static const WARNING_CANNOT_CREATE_UNIT:int=10001;

        public static const WARNING_DECODING_CHECKSUM6_CORRUPT:int=505;

        public static const WARNING_DECODING_CHECKSUM7_CORRUPT:int=506;

        public static const WARNING_MULTIPLE_WRONG_HR_VALUES:int=509;

        public static const WARNING_MULTIPLE_WRONG_SPEE_VALUES:int=508;

        public static const WARNING_NOT_SUPPORTET_MODEL:int=51133;

        public static const WARNING_NOT_SUPPORTET_TOPLINE2009_MODEL:int=501;

        public static const WARNING_NOT_SUPPORTET_TOPLINE2012_MODEL:int=510;

        public static const WARNING_UNIT_DO_NOT_MATCH:int=10010;

        public static const WARNING_UNSUPPORTED_OR_NO_COMMUNICATION_MODE:int=10011;

        public static const WARNING_USB_SERVICE_TOO_MANY_DS_FOUND:int=113;

        public static const WARNING_WRONG_ALTITUDE_VALUE:int=502;

        public static const WARNING_WRONG_CADENCE_VALUE:int=507;

        public static const WARNING_WRONG_HEARTRATE_VALUE:int=504;

        public static const WARNING_WRONG_SPEED_VALUE:int=503;
    }
}


