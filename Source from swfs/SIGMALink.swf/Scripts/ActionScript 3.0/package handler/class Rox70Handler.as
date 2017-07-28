//class Rox70Handler
package handler 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.activities.*;
    import core.route.*;
    import core.sportprofiles.*;
    import core.strava.*;
    import core.units.*;
    import core.units.interfaces.*;
    import decoder.*;
    import flash.events.*;
    import flash.utils.*;
    import handler.event.*;
    import init.*;
    import mx.events.*;
    import service.*;
    import service.usb.event.*;
    import utils.sort.*;
    
    public class Rox70Handler extends handler.UnitHandler
    {
        public function Rox70Handler()
        {
            _lastDataSend = [];
            _lastWPDataToSend = [];
            super();
            service.DeviceCommunicationHandler.getInstance().addEventListener("loggingErrorEvent", onToManyDataReceived);
            return;
        }

        internal function onLoadedSetStravaSegment(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            if (!decoder.Rox70Decoder.isValidCheckSum(arg1.data)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 529, "ROX70Decoder > onLoaded (send totals complete): wrong crc"));
            }
            if (arg1.data[3] != 5) 
            {
                if (arg1.data[3] == 0) 
                {
                    _currentSegmentSession = 0;
                    flash.utils.setTimeout(sendToDC, 500, "sendStravaSegmentToUnit");
                }
            }
            else 
            {
                ++_currentSegmentSession;
                flash.utils.setTimeout(sendSegmentData, 500);
            }
            return false;
        }

        public override function get unit():core.units.Unit
        {
            return _myUnit;
        }

        public override function set unit(arg1:core.units.Unit):void
        {
            _myUnit = arg1 as core.units.UnitROX70;
            currentFW = parseInt(_myUnit.softwareRevision.split("-")[3]);
            return;
        }

        internal function onLoadedDeleteStravaSegments(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            dispatchEvent(new flash.events.Event("deleteStravaSegmentsOnUnitComplete"));
            return false;
        }

        internal function onLoadedSetTrack(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            flash.utils.clearTimeout(_setNextTrackTimeoutId);
            if (!decoder.Rox70Decoder.isValidCheckSum(arg1.data)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 529, "ROX70Decoder > onLoaded (send totals complete): wrong crc"));
            }
            var loc2:*=_currentTrackToSend.routePointsReduced.length * 12;
            var loc1:*=loc2 - _currentTrackToSend.routePointsToSend.length;
            dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 100 * loc1 / loc2, 1, 1, "", false, false));
            if (arg1.data[3] != 5) 
            {
                if (arg1.data[3] == 0) 
                {
                    if (_currentTrackToSend.routePoisToSend.length > 0) 
                    {
                        _currentTrackSession = 0;
                        _currentTrackToSend.downloadId = (arg1.data[4] & 255 | (arg1.data[5] & 255) << 8).toString();
                        flash.utils.setTimeout(sendWaypoints, 500);
                    }
                    else 
                    {
                        flash.utils.setTimeout(sendToDC, 500, "sendTracksToUnit");
                    }
                }
            }
            else 
            {
                ++_currentTrackSession;
                flash.utils.setTimeout(sendTrackData, 500);
            }
            return false;
        }

        internal function get _currenLogToLoad():core.activities.Activity
        {
            return this._currenLogToLoad;
        }

        internal function set _currenLogToLoad(arg1:core.activities.Activity):void
        {
            var loc1:*=this._currenLogToLoad;
            if (loc1 !== arg1) 
            {
                this._currenLogToLoad = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_currenLogToLoad", loc1, arg1));
                }
            }
            return;
        }

        internal function onLoadedSetWaypoint(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            if (!decoder.Rox70Decoder.isValidCheckSum(arg1.data)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 529, "ROX70Decoder > onLoaded (send totals complete): wrong crc"));
            }
            if (arg1.data[3] != 5) 
            {
                if (arg1.data[3] != 0) 
                {
                    if (arg1.data[3] == 4) 
                    {
                        sendTrackData();
                    }
                }
                else 
                {
                    sendTrackData();
                }
            }
            else 
            {
                ++_currentTrackSession;
                sendWaypoints();
            }
            return false;
        }

        internal function onLoadedDeleteLogs(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            dispatchEvent(new flash.events.Event("logDeleteCompleteEvent"));
            if (unit is core.units.interfaces.ILogList) 
            {
                (unit as core.units.interfaces.ILogList).loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
            }
            return true;
        }

        internal function onLoadedDeleteTrack(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            if (arg1.data[3] != 0) 
            {
                if (arg1.data[3] != 4) 
                {
                };
                _currentTrackSession = 0;
                dispatchEvent(new flash.events.Event("deleteTracksOnUnitComplete"));
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            }
            else 
            {
                ++_currentTrackSession;
                dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", _currentTrackSession / (_myUnit as core.units.interfaces.IDataToDecode).tracksToDecode.length * 100, 1, 1, "", false, false));
                flash.utils.setTimeout(sendToDC, 500, "deleteTracksOnUnit");
            }
            return false;
        }

        internal function onLoadedGetProfile(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            ++_actualSportProfileToLoad;
            decoder.Rox70Decoder.getInstance().unit = _myUnit;
            (_myUnit as core.units.interfaces.ISportProfiles).loadedSportProfiles.push(decoder.Rox70Decoder.getInstance().decodeSportProfile(arg1.data));
            if (arg1.command != "2 0 2 41 3 40") 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue("loadSportProfilesFromDevice", "loadCommand", this);
            }
            else 
            {
                dispatchEventLater(new flash.events.Event("sportProfilesLoadedFromUnitComplete"));
                _actualSportProfileToLoad = 0;
            }
            return true;
        }

        internal function onLoadedSetProfile(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            if (!decoder.Rox70Decoder.isValidCheckSum(arg1.data)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 535, "ROX70Decoder > onLoaded (send sport profile complete): wrong crc"));
            }
            dispatchEventLater(new flash.events.Event("sportProfileSendComplete"));
            return true;
        }

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc1:*=null;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
            var loc2:*=false;
            var loc3:*=arg1.command;
            while ("2 0 1 36 37" === loc3) 
            {
                loc2 = onLoadedGetLogStatus(arg1);
            }
        }

        internal function onLogLoaded():void
        {
            decoder.Rox70Decoder.getInstance().decodeLog(_currenLogToLoad);
            _currenLogToLoad.recordValuesLoaded = [];
            _currenLogToLoad.lapValuesLoaded = [];
            _currenLogToLoad.autoLapValuesLoaded = [];
            _currenLogToLoad.loggingPauseValuesLoaded = [];
            resetLogDataLoading();
            return;
        }

        internal function decodePlanedTrackFileHeaderArray(arg1:Array):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc6:*=null;
            var loc3:*;
            var loc5:*=(loc3 = arg1.slice(3, (arg1.length - 1))).length / 280;
            var loc4:*=0;
            loc4 = 0;
            while (loc4 < loc5) 
            {
                loc1 = loc3.splice(0, 280);
                loc2 = decoder.Rox70Decoder.getInstance().decodeTrackHeader(loc1) as core.route.Route;
                handler.RouteHandlerCommon.getInstance().addFormattedValues(loc2);
                if (loc6 = handler.RouteHandlerCommon.routesDicGUID[loc2.GUID]) 
                {
                    if (loc6.downloadId != loc2.downloadId) 
                    {
                        loc6.downloadId = loc2.downloadId;
                    }
                }
                _myUnit.loadedTracks.addItem(loc2);
                ++loc4;
            }
            return;
        }

        internal function dispatchEventLater(arg1:flash.events.Event):void
        {
            return;
        }

        internal function get _currentTrackToLoad():core.route.Route
        {
            return this._currentTrackToLoad;
        }

        internal function set _currentTrackToLoad(arg1:core.route.Route):void
        {
            var loc1:*=this._currentTrackToLoad;
            if (loc1 !== arg1) 
            {
                this._currentTrackToLoad = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_currentTrackToLoad", loc1, arg1));
                }
            }
            return;
        }

        public override function loadFromDC(arg1:String):void
        {
            var loc1:*=null;
            var loc2:*=undefined;
            var loc3:*=undefined;
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "loadCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            if (arg1 != "loadFreeLoggingTimeInformation") 
            {
                if (arg1 != "loadUnitSettings") 
                {
                    if (arg1 != "loadTotalValues") 
                    {
                        if (arg1 != "loadUnitlogDataHeader") 
                        {
                            if (arg1 == "loadUnitlogData" || arg1 == "reloadUnitlogData") 
                            {
                                currentCommand = "50";
                                if (_currenLogToLoad == null && arg1 == "loadUnitlogData") 
                                {
                                    ++_currentLogHeaderIndex;
                                    if (_myUnit is core.units.interfaces.IDataToDecode) 
                                    {
                                        loc2 = (_myUnit as core.units.interfaces.IDataToDecode).activitiesToDecode;
                                    }
                                    else 
                                    {
                                        loc2 = (_myUnit as core.units.interfaces.ILogList).loadedLogs;
                                    }
                                    if (_currentLogHeaderIndex < loc2.length) 
                                    {
                                        _currenLogToLoad = loc2[_currentLogHeaderIndex];
                                        _totalRecordValuesToLoad = _currenLogToLoad.recordValuesToLoad;
                                        _totalLapValuesToLoad = _currenLogToLoad.lapValuesToLoad;
                                    }
                                }
                                loadLogData(arg1 == "reloadUnitlogData");
                                return;
                            }
                            if (arg1 != "loadUnitPlanedTrackFileHeader") 
                            {
                                if (arg1 == "loadUnitPlanedTrackFile" || arg1 == "reloadUnitPlanedTrackFile") 
                                {
                                    currentCommand = "66";
                                    if (_currentTrackToLoad == null && arg1 == "loadUnitPlanedTrackFile") 
                                    {
                                        ++_currentLoadPlanedTrackHeaderIndex;
                                        if (_myUnit is core.units.interfaces.IDataToDecode) 
                                        {
                                            loc3 = (_myUnit as core.units.interfaces.IDataToDecode).tracksToDecode;
                                        }
                                        else 
                                        {
                                            loc3 = new __AS3__.vec.Vector.<core.route.Route>((_myUnit as core.units.interfaces.ITrackList).loadedTracks.toArray());
                                        }
                                        if (_currentLoadPlanedTrackHeaderIndex < loc3.length) 
                                        {
                                            _currentTrackToLoad = loc3[_currentLoadPlanedTrackHeaderIndex];
                                            _totalTrackValuesToLoad = _currentTrackToLoad.routePointsToLoad;
                                        }
                                    }
                                    loadTrackData(arg1 == "reloadUnitPlanedTrackFile");
                                    return;
                                }
                                if (arg1 != "loadSportProfilesFromDevice") 
                                {
                                };
                            }
                            else if (_numberOfPlanedTracksCommandQueue == null || _numberOfPlanedTracksCommandQueue.length == 0) 
                            {
                                currentCommand = "2 0 1 64 65";
                                currentBytesToReceive = 6;
                            }
                            else 
                            {
                                loc1 = _numberOfPlanedTracksCommandQueue.shift();
                                currentCommand = "65";
                                currentBytesToReceive = 280 + 4;
                                flash.utils.clearTimeout(_getNextTrackHeaderTimeoutId);
                                _getNextTrackHeaderTimeoutId = flash.utils.setTimeout(onGetNextTrackHeaderTimeout, _getNextTrackHeaderTimeoutInterval);
                                service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc1.cmd), this);
                                service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
                                return;
                            }
                        }
                        else if (_numberOfTracksCommandQueue == null || _numberOfTracksCommandQueue.length == 0) 
                        {
                            currentCommand = "2 0 1 48 49";
                            currentBytesToReceive = 6;
                        }
                        else 
                        {
                            loc1 = _numberOfTracksCommandQueue.shift();
                            currentCommand = "49";
                            currentBytesToReceive = 208;
                            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc1.cmd), this);
                            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
                            return;
                        }
                    }
                    else 
                    {
                        currentCommand = "2 0 1 34 35";
                        currentBytesToReceive = 28;
                    }
                }
                else 
                {
                    currentCommand = "2 0 1 32 33";
                    currentBytesToReceive = 56;
                }
            }
            else 
            {
                currentCommand = "2 0 1 36 37";
                currentBytesToReceive = 28;
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        internal function loadLogData(arg1:Boolean=false):void
        {
            var loc16:*=null;
            var loc10:*=0;
            var loc1:*=0;
            var loc15:*=null;
            if (_currenLogToLoad == null) 
            {
                service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
                resetLogDataLoading();
                _currentLogHeaderIndex = -1;
                dispatchEvent(new flash.events.Event("logsLoadedFromUnitComplete"));
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
                return;
            }
            var loc8:*=0;
            var loc3:*=8;
            var loc17:*=loc8.toString() + " " + loc3.toString();
            var loc6:*=0;
            var loc18:*="";
            var loc11:*=0;
            var loc4:*=0;
            var loc7:*=0;
            var loc2:*=0;
            var loc9:*=0;
            var loc19:*="";
            var loc14:*=0;
            var loc5:*=0;
            var loc13:*="";
            var loc12:*=0;
            if (_sessionStart) 
            {
                _sessionStart = false;
                loc18 = (loc6 = 1).toString();
                loc4 = (loc11 = _currenLogToLoad.startIndex) >> 24 & 255;
                loc7 = loc11 >> 16 & 255;
                loc2 = loc11 >> 8 & 255;
                loc19 = (loc9 = loc11 & 255).toString() + " " + loc2.toString() + " " + loc7.toString() + " " + loc4.toString();
                loc14 = (_currenLogToLoad.recordValuesToLoad & 65280) >> 8;
                loc13 = (loc5 = _currenLogToLoad.recordValuesToLoad & 255).toString() + " " + loc14.toString();
                loc15 = [loc6, loc4, loc7, loc2, loc9, loc14, loc5];
                loc12 = decoder.Rox70Decoder.calculateCheckSum(loc15, 50, loc3, loc8);
                loc16 = "2 " + loc17 + " " + "50" + " " + loc18 + " " + loc19 + " " + loc13 + " " + loc12;
                evenPackage = false;
                loc10 = Math.min(_totalRecordValuesToLoad, 42);
                currentBytesToReceive = 9 + 48 * loc10 + 1;
            }
            else if (!_recordValuesLoadComplete) 
            {
                loc18 = (loc6 = 2).toString();
                loc4 = (loc11 = _currenLogToLoad.startIndex) >> 24 & 255;
                loc7 = loc11 >> 16 & 255;
                loc2 = loc11 >> 8 & 255;
                loc19 = (loc9 = loc11 & 255).toString() + " " + loc2.toString() + " " + loc7.toString() + " " + loc4.toString();
                loc14 = (_currenLogToLoad.recordValuesToLoad & 65280) >> 8;
                loc13 = (loc5 = _currenLogToLoad.recordValuesToLoad & 255).toString() + " " + loc14.toString();
                loc15 = [loc6, loc4, loc7, loc2, loc9, loc14, loc5];
                loc12 = decoder.Rox70Decoder.calculateCheckSum(loc15, 50, loc3, loc8);
                loc16 = "2 " + loc17 + " " + "50" + " " + loc18 + " " + loc19 + " " + loc13 + " " + loc12;
                loc1 = _totalRecordValuesToLoad - _currenLogToLoad.recordValuesLoaded.length / 48;
                if (evenPackage) 
                {
                    evenPackage = false;
                    loc10 = Math.min(loc1, 42);
                }
                else 
                {
                    evenPackage = true;
                    loc10 = Math.min(loc1, 43);
                }
                currentBytesToReceive = 9 + 48 * loc10 + 1;
            }
            flash.utils.clearTimeout(_getNextLogDataTimeoutId);
            _getNextLogDataTimeoutId = flash.utils.setTimeout(onGetNextTimeout, _getNextLogDataTimeoutInterval);
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc16), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        protected function loadLogLaps(arg1:Boolean=true, arg2:Boolean=true):void
        {
            var loc9:*=0;
            var loc6:*=0;
            var loc3:*=8;
            var loc2:*=loc6 + " " + loc3;
            var loc7:*=arg2 ? 1 : 2;
            var loc1:*=0;
            var loc14:*=0;
            if (arg1) 
            {
                loc1 = _currenLogToLoad.lapValuesIndex;
                loc9 = (loc14 = _currenLogToLoad.lapValuesToLoad) - _currenLogToLoad.lapValuesLoaded.length / 56;
                _currentCommandMode = "manualLaps";
            }
            else 
            {
                loc1 = _currenLogToLoad.autoLapValuesIndex;
                loc9 = (loc14 = _currenLogToLoad.autoLapValuesToLoad) - _currenLogToLoad.autoLapValuesLoaded.length / 56;
                _currentCommandMode = "autoLaps";
                loc7 = loc7 | 128;
            }
            var loc19:*=0;
            if (loc9 > 17) 
            {
                loc19 = 17 * 56;
            }
            else 
            {
                loc19 = loc9 * 56;
            }
            var loc18:*=(loc1 & 4278190080) >> 24;
            var loc17:*=(loc1 & 16711680) >> 16;
            var loc15:*=(loc1 & 65280) >> 8;
            var loc12:*;
            var loc5:*=(loc12 = loc1 & 255) + " " + loc15 + " " + loc17 + " " + loc18;
            var loc4:*=(loc14 & 65280) >> 8;
            var loc8:*;
            var loc10:*=(loc8 = loc14 & 255) + " " + loc4;
            var loc13:*=[loc18, loc17, loc15, loc12, loc4, loc8];
            var loc11:*=decoder.Rox70Decoder.calculateCheckSum(loc13, 53, loc3, loc6, loc7);
            currentCommand = "53";
            currentBytesToReceive = 10 + loc19;
            var loc16:*="2 " + loc2 + " " + "53" + " " + loc7 + " " + loc5 + " " + loc10 + " " + loc11;
            flash.utils.clearTimeout(_getNextLogLapsDataTimeoutId);
            _getNextLogLapsDataTimeoutId = flash.utils.setTimeout(onGetNextLapTimeout, _getNextLogLapsDataTimeoutInterval);
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc16), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        internal function onToManyDataReceived(arg1:com.logging.ErrorLoggingEvent):void
        {
            return;
        }

        protected function loadTrackData(arg1:Boolean=false):void
        {
            var loc10:*=null;
            var loc6:*=0;
            var loc1:*=0;
            if (_currentTrackToLoad == null) 
            {
                service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
                resetTrackDataLoading();
                _currentLoadPlanedTrackHeaderIndex = -1;
                dispatchEvent(new flash.events.Event("planedTrackFilesLoaded"));
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
                return;
            }
            var loc5:*=0;
            var loc3:*=4;
            var loc2:*=loc5.toString() + " " + loc3.toString();
            var loc11:*=(parseInt(_currentTrackToLoad.downloadId) & 65280) >> 8;
            var loc4:*;
            var loc8:*=(loc4 = parseInt(_currentTrackToLoad.downloadId) & 255).toString() + " " + loc11.toString();
            var loc12:*=arg1 ? 3 : _currentTrackSession != 0 ? 2 : 1;
            var loc9:*=[loc11, loc4];
            var loc7:*=decoder.Rox70Decoder.calculateCheckSum(loc9, 66, loc3, loc5, loc12);
            loc10 = "2 " + loc2 + " " + "66" + " " + loc12 + " " + loc8 + " " + loc7;
            loc1 = _totalTrackValuesToLoad - _currentTrackToLoad.routePointsLoaded.length / 12;
            loc6 = Math.min(loc1, 168);
            currentBytesToReceive = 6 + 280 + 12 * loc6;
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc10), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        protected function loadWaypoints(arg1:Boolean=false):void
        {
            var loc5:*=0;
            var loc2:*=4;
            var loc1:*=loc5.toString() + " " + loc2.toString();
            var loc3:*=parseInt(_currentTrackToLoad.downloadId) & 255;
            var loc7:*=(parseInt(_currentTrackToLoad.downloadId) & 65280) >> 8;
            var loc6:*=loc3.toString() + " " + loc7.toString();
            var loc9:*=_currentTrackSession != 0 ? 2 : 1;
            var loc4:*=decoder.Rox70Decoder.calculateCheckSum([loc9, loc3, loc7], 81, loc2, loc5);
            currentCommand = "81";
            currentBytesToReceive = 10 + Math.min(_currentTrackToLoad.routePoisToLoad, 30) * 72;
            var loc8:*="2 " + loc1 + " " + "81" + " " + loc9 + " " + loc6 + " " + loc4;
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc8), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        protected function sendSegmentData():void
        {
            var loc15:*=null;
            var loc9:*=0;
            var loc1:*=0;
            var loc16:*=null;
            var loc12:*=0;
            var loc5:*=0;
            var loc4:*=0;
            var loc3:*=null;
            var loc13:*=0;
            var loc14:*=null;
            var loc11:*=0;
            var loc8:*=null;
            if (_stravaSegmentToSend.latlngToSend == null || _stravaSegmentToSend.latlngToSend.length == 0) 
            {
                _currentSegmentSession = 0;
                _stravaSegmentToSend = null;
                service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
                dispatchEvent(new flash.events.Event("sendStravaSegmentToUnitComplete"));
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
                service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("startScanDockingStationEvent"));
                return;
            }
            loc16 = "72";
            currentBytesToReceive = 5;
            loc1 = _stravaSegmentToSend.latlngToSend.length;
            if (_stravaSegmentToSend.latlngToSend.length > 0) 
            {
                loc9 = Math.min(_stravaSegmentToSend.latlngToSend.length, 110 * 20);
                loc14 = _stravaSegmentToSend.latlngToSend.splice(0, loc9);
                loc5 = ((loc12 = 3 + 100 + loc9) & 65280) >> 8;
                loc4 = loc12 & 255;
                loc3 = loc5.toString() + " " + loc4.toString();
                loc11 = _stravaSegmentToSend.latlngToSend.length != 0 ? 0 : 1;
            }
            else 
            {
                dispatchEvent(new flash.events.Event("sendStravaSegmentToUnitComplete"));
                return;
            }
            _lastDataSend = loc14;
            var loc17:*;
            var loc6:*=((loc17 = loc11 != 1 ? _currentSegmentSession : _currentSegmentSession | 32768) & 65280) >> 8;
            var loc7:*=loc17 & 255;
            if (_currentSegmentSession == 0 && loc11 == 1) 
            {
                loc8 = loc7 + " " + loc6;
            }
            else 
            {
                loc8 = loc7 + " " + loc6;
            }
            var loc2:*=_stravaSegmentToSend.segmentHeader;
            var loc10:*;
            (loc10 = loc2.concat(loc14)).push(loc6);
            loc10.push(loc7);
            loc13 = decoder.Rox70Decoder.calculateCheckSum(loc10, 72, loc4, loc5);
            loc15 = "2 " + loc3 + " " + loc16 + " " + loc8 + " " + loc2.join(" ") + " " + loc14.join(" ") + " " + loc13;
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc15), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        protected function sendTrackData(arg1:Boolean=false):void
        {
            var loc14:*=null;
            var loc9:*=0;
            var loc1:*=0;
            var loc16:*=null;
            var loc12:*=0;
            var loc5:*=0;
            var loc4:*=0;
            var loc3:*=null;
            var loc13:*=0;
            var loc15:*=null;
            var loc11:*=0;
            if (_currentTrackToSend == null) 
            {
                service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
                resetTrackDataSending();
                _currentSendPlanedTrackHeaderIndex = -1;
                _currentTrackSession = 0;
                _currentTrackSessionWP = 0;
                dispatchEvent(new flash.events.Event("sendTrackToUnitComplete"));
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
                service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("startScanDockingStationEvent"));
                return;
            }
            loc16 = "67";
            currentBytesToReceive = 7;
            loc1 = _currentTrackToSend.routePointsToSend.length;
            if (_currentTrackToSend.routePointsToSend.length > 0) 
            {
                loc9 = Math.min(_currentTrackToSend.routePointsToSend.length, 168 * 12);
                loc15 = _currentTrackToSend.routePointsToSend.splice(0, loc9);
                loc5 = ((loc12 = 3 + 280 + loc9) & 65280) >> 8;
                loc4 = loc12 & 255;
                loc3 = loc5.toString() + " " + loc4.toString();
                loc11 = _currentTrackToSend.routePointsToSend.length != 0 ? 0 : 1;
            }
            else 
            {
                flash.utils.clearTimeout(_setNextTrackTimeoutId);
                resetTrackDataSending();
                flash.utils.setTimeout(sendToDC, 500, "sendTracksToUnit");
                return;
            }
            _lastDataSend = loc15;
            var loc17:*;
            var loc6:*=((loc17 = loc11 != 1 ? _currentTrackSession : _currentTrackSession | 32768) & 65280) >> 8;
            var loc7:*;
            var loc8:*=(loc7 = loc17 & 255) + " " + loc6;
            var loc2:*=_currentTrackToSend.routeHeader;
            var loc10:*;
            (loc10 = loc2.concat(loc15)).push(loc6);
            loc10.push(loc7);
            loc13 = decoder.Rox70Decoder.calculateCheckSum(loc10, 67, loc4, loc5);
            loc14 = "2 " + loc3 + " " + loc16 + " " + loc8 + " " + loc2.join(" ") + " " + loc15.join(" ") + " " + loc13;
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc14), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        internal function sendWaypoints(arg1:Boolean=false):void
        {
            var loc16:*=null;
            var loc15:*=null;
            if (!_currentTrackToSend || _currentTrackToSend.routePoisToSend.length == 0) 
            {
                flash.utils.clearTimeout(_setNextTrackTimeoutId);
                resetTrackDataSending();
                _currentTrackSession = 0;
                flash.utils.setTimeout(sendToDC, 500, "sendTracksToUnit");
                return;
            }
            var loc5:*=[];
            var loc1:*=0;
            while (_currentTrackToSend.routePoisToSend.length > 0 && loc1 < 30) 
            {
                ++loc1;
                ++_currentTrackSessionWP;
                (loc16 = _currentTrackToSend.routePoisToSend.shift()).wayTTPId_curId = _currentTrackSessionWP;
                loc15 = decoder.Rox70Decoder.getInstance().encodeWayPoint(loc16, _currentTrackToSend);
                loc5 = loc5.concat(loc15);
            }
            _lastWPDataToSend = loc5;
            var loc12:*;
            var loc6:*=((loc12 = 7 + loc5.length) & 65280) >> 8;
            var loc3:*=loc12 & 255;
            var loc2:*=loc6.toString() + " " + loc3.toString();
            var loc11:*;
            var loc19:*;
            var loc20:*=(loc19 = (loc11 = _currentTrackToSend.routePoisToSend.length != 0 ? 0 : 1) != 1 ? _currentTrackSession : _currentTrackSession | 32768) & 255;
            var loc7:*=(loc19 & 65280) >> 8;
            var loc14:*=loc20 + " " + loc7;
            var loc4:*=parseInt(_currentTrackToSend.downloadId) & 255;
            var loc17:*=(parseInt(_currentTrackToSend.downloadId) & 65280) >> 8;
            var loc9:*=loc4 + " " + loc17;
            var loc10:*=_currentTrackToSend.pois.length & 255;
            var loc8:*=(_currentTrackToSend.pois.length & 65280) >> 8;
            var loc21:*=loc10 + " " + loc8;
            var loc13:*=decoder.Rox70Decoder.calculateCheckSum(loc5, 82, loc3, loc6);
            loc13 = loc13 ^ loc20;
            loc13 = loc13 ^ loc7;
            loc13 = loc13 ^ loc4;
            loc13 = loc13 ^ loc17;
            loc13 = loc13 ^ loc10;
            loc13 = loc13 ^ loc8;
            var loc18:*="2 " + loc2 + " " + "82" + " " + loc14 + " " + loc9 + " " + loc21 + " " + loc5.join(" ") + " " + loc13;
            currentCommand = "82";
            currentBytesToReceive = 5;
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc18), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        internal function sortByRoutePointId(arg1:Object, arg2:Object):int
        {
            if (arg1.routePointId < arg2.routePointId) 
            {
                return -1;
            }
            if (arg1.routePointId > arg2.routePointId) 
            {
                return 1;
            }
            return 0;
        }

        internal function sortByRoutePointReferenceId(arg1:Object, arg2:Object):int
        {
            if (arg1.routePointReferenceId < arg2.routePointReferenceId) 
            {
                return -1;
            }
            if (arg1.routePointReferenceId > arg2.routePointReferenceId) 
            {
                return 1;
            }
            return 0;
        }

        internal function isErrorCode():Boolean
        {
            var loc1:*=false;
            var loc2:*=service.DeviceCommunicationHandler.getInstance().getLastReceivedData();
        }

        internal function setWaypointPointReference(arg1:core.route.Route):void
        {
            var loc5:*=null;
            var loc1:*=null;
            var loc4:*=0;
            var loc2:*=0;
            if (arg1.routePoisToSend.length == 0) 
            {
                return;
            }
            arg1.routePoisToSend.sort(sortByRoutePointReferenceId);
            var loc6:*=0;
            var loc3:*=arg1.routePoisToSend.length;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                loc1 = arg1.routePoisToSend[loc4] as core.route.RoutePoi;
                if (loc1.referencePoint != null) 
                {
                    loc2 = arg1.routePointsReduced.indexOf(loc1.referencePoint);
                    if (loc2 != -1) 
                    {
                        arg1.routePointsReduced[loc2].waypointIndex = loc4 + 1;
                    }
                    else 
                    {
                        loc1.referencePoint.waypointIndex = loc4 + 1;
                        arg1.routePointsReduced.push(loc1.referencePoint);
                    }
                    ++loc6;
                }
                ++loc4;
            }
            arg1.routePointsReduced.sort(sortByRoutePointId);
            return;
        }

        protected function generateNativeProzessBuffer(arg1:String):flash.utils.ByteArray
        {
            var loc2:*=0;
            var loc3:*=new flash.utils.ByteArray();
            var loc4:*;
            var loc1:*=(loc4 = arg1.split(" ")).length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                loc3.writeByte(loc4[loc2]);
                ++loc2;
            }
            return loc3;
        }

        internal function sortOnDownloadId(arg1:core.route.Route, arg2:core.route.Route):Number
        {
            return utils.sort.SortUtil.sortOnString(arg1, arg2, "downloadId", true);
        }

        public override function sendToDC(arg1:String):void
        {
            var loc1:*=null;
            var loc6:*=0;
            var loc2:*=0;
            var loc4:*=0;
            var loc3:*=0;
            var loc5:*=0;
            var loc7:*=null;
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "sendCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            var loc8:*=arg1;
            while ("writeUnitSettings" === loc8) 
            {
                sendToDCWriteUnitSettingsToDevice();
            }
        }

        internal function deleteAllTracks():void
        {
            var loc1:*="2 0 1 96 97";
            currentBytesToReceive = 5;
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc1), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        internal function sendToDCDeleteTracksOnUnit():void
        {
            var loc1:*=null;
            var loc6:*=0;
            var loc2:*=0;
            var loc10:*=null;
            var loc4:*=0;
            var loc7:*=null;
            currentCommand = "68";
            currentBytesToReceive = 5;
            var loc5:*=(unit as core.units.interfaces.IDataToDecode).tracksToDecode.sort(sortOnDownloadId);
            var loc9:*=0;
            var loc3:*=3;
            var loc8:*=loc9.toString() + " " + loc3.toString();
            if (_currentTrackSession < loc5.length) 
            {
                loc1 = loc5[_currentTrackSession];
                loc6 = (loc1.downloadId & 65280) >> 8;
                loc2 = loc1.downloadId & 255;
                loc10 = loc2 + " " + loc6;
                loc4 = decoder.Rox70Decoder.calculateCheckSum([loc6, loc2], 68, loc3, loc9);
                loc7 = "2 " + loc8 + " " + "68" + " " + loc10 + " " + loc4;
                service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc7), this);
                service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            }
            else 
            {
                _currentTrackSession = 0;
                dispatchEvent(new flash.events.Event("deleteTracksOnUnitComplete"));
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            }
            return;
        }

        internal function sendToDCDeleteUnitLogDataFromDevice():void
        {
            currentCommand = "2 0 1 52 53";
            currentBytesToReceive = 4;
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        internal function sendToDCSendStravaSegmentToUnit():void
        {
            service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("stopScanDockingStationEvent"));
            currentCommand = "72";
            if (_stravaSegmentToSend == null) 
            {
                _currentSegmentSession = 0;
                if (_myUnit is core.units.interfaces.IStravaSegmentsSupported) 
                {
                    _resendFirstPackage = true;
                    _stravaSegmentToSend = (_myUnit as core.units.interfaces.IStravaSegmentsSupported).currentStravaSegment;
                    _stravaSegmentToSend.decodeMap();
                    _stravaSegmentToSend.latlng_reduced = core.route.Route.reducePoints(_stravaSegmentToSend.latlng, 2000, 4, 0, 2);
                    if (!(_stravaSegmentToSend.latlng_reduced.length > 2000)) 
                    {
                    };
                    _stravaSegmentToSend.segmentHeader = decoder.Rox70Decoder.getInstance().encodeStraveSegmentHeader(_stravaSegmentToSend);
                    _stravaSegmentToSend.latlngToSend = decoder.Rox70Decoder.getInstance().encodeStravaSegment(_stravaSegmentToSend);
                }
            }
            sendSegmentData();
            return;
        }

        internal function sendToDCDeleteStravaSegmentsOnUnit():void
        {
            currentCommand = "2 0 3 73 255 255 74";
            currentBytesToReceive = 5;
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        internal function sendToDCSendTracksToUnit(arg1:String):void
        {
            var loc1:*=null;
            var loc6:*=0;
            var loc2:*=0;
            var loc4:*=0;
            var loc3:*=0;
            var loc5:*=0;
            var loc7:*=null;
            service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("stopScanDockingStationEvent"));
            currentCommand = "67";
            if (_currentTrackToSend == null) 
            {
                _currentTrackSession = 0;
                if (arg1 == "sendTracksToUnit") 
                {
                    ++_currentSendPlanedTrackHeaderIndex;
                    _resendFirstPackage = true;
                    if (_currentSendPlanedTrackHeaderIndex < (_myUnit as core.units.interfaces.IDataToDecode).tracksToDecode.length) 
                    {
                        _currentTrackToSend = (_myUnit as core.units.interfaces.IDataToDecode).tracksToDecode[_currentSendPlanedTrackHeaderIndex];
                        _currentTrackToSend.routePointsReduced = core.route.Route.reducePoints(_currentTrackToSend.routePoints, 2000, 4, 0, 2);
                        _currentTrackToSend.routePoisToSend = _currentTrackToSend.pois.concat();
                        setWaypointPointReference(_currentTrackToSend);
                        if (_currentTrackToSend.routePointsReduced.length > 2000) 
                        {
                            _currentTrackToSend = null;
                            sendToDC(arg1);
                            return;
                        }
                        _currentTrackToSend.routeHeader = decoder.Rox70Decoder.getInstance().encodeTrackHeader(_currentTrackToSend);
                        _currentTrackToSend.routePointsToSend = decoder.Rox70Decoder.getInstance().encodeTrack(_currentTrackToSend);
                        _totalTrackValuesToSend = _currentTrackToSend.routePointsToSend.length;
                    }
                }
            }
            sendTrackData(arg1 == "resendTracksToUnit");
            return;
        }

        internal function sendToDCWriteTotalValuesToDevice():void
        {
            var loc1:*=null;
            var loc6:*=0;
            var loc2:*=0;
            var loc4:*=0;
            var loc3:*=0;
            var loc5:*=0;
            var loc7:*=null;
            decoder.Rox70Decoder.getInstance().unit = _myUnit;
            decoder.Rox70Decoder.getInstance().settings = _myUnit.currentSettings;
            decoder.Rox70Decoder.getInstance().totals = (_myUnit as core.units.interfaces.ITotalsList).currentTotals;
            loc1 = decoder.Rox70Decoder.getInstance().encodeTotals();
            loc6 = 0;
            loc2 = loc1.length + 1;
            loc4 = loc2 & 255;
            loc3 = (loc2 & 65280) >> 8;
            loc5 = decoder.Rox70Decoder.calculateCheckSum(loc1, 35, loc4, loc3);
            loc7 = (loc7 = (loc7 = "2 ") + (loc3.toString() + " " + loc4.toString() + " ")) + "35 ";
            loc6 = 0;
            while (loc6 < (loc2 - 1)) 
            {
                loc7 = (loc7 = loc7 + loc1[loc6].toString()) + " ";
                ++loc6;
            }
            loc7 = loc7 + loc5.toString();
            currentCommand = "35";
            currentBytesToReceive = 5;
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc7), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        internal function sendToDCWriteSportProfilesToDevice():void
        {
            var loc1:*=null;
            var loc6:*=0;
            var loc2:*=0;
            var loc4:*=0;
            var loc3:*=0;
            var loc5:*=0;
            var loc8:*=null;
            decoder.Rox70Decoder.getInstance().unit = _myUnit;
            var loc7:*=_myUnit.loadedSportProfiles[_myUnit.currentSportProfileIndex] as core.sportprofiles.SportProfileROX70;
            var loc9:*=_myUnit.currentSportProfileIndex + 1;
            loc1 = decoder.Rox70Decoder.getInstance().encodeSportProfile(loc7);
            loc6 = 0;
            loc2 = loc1.length + 2;
            loc4 = loc2 & 255;
            loc3 = loc2 >> 8 & 255;
            loc5 = decoder.Rox70Decoder.calculateCheckSum(loc1, 42, loc4, loc3, loc9) & 255;
            loc8 = (loc8 = (loc8 = (loc8 = "2 ") + (loc3.toString() + " " + loc4.toString() + " ")) + "42 ") + (loc9 + " ");
            loc6 = 0;
            while (loc6 < loc2 - 2) 
            {
                loc8 = (loc8 = loc8 + loc1[loc6].toString()) + " ";
                ++loc6;
            }
            loc8 = loc8 + loc5.toString();
            currentCommand = "42";
            currentBytesToReceive = 5;
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc8), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        internal function sendToDCWriteUnitSettingsToDevice():void
        {
            var loc1:*=null;
            var loc6:*=0;
            var loc2:*=0;
            var loc4:*=0;
            var loc3:*=0;
            var loc5:*=0;
            var loc7:*=null;
            decoder.Rox70Decoder.getInstance().unit = _myUnit;
            decoder.Rox70Decoder.getInstance().settings = _myUnit.currentSettings;
            decoder.Rox70Decoder.getInstance().totals = (_myUnit as core.units.interfaces.ITotalsList).currentTotals;
            loc1 = decoder.Rox70Decoder.getInstance().encodeSettings();
            loc6 = 0;
            loc2 = loc1.length + 1;
            loc4 = loc2 & 255;
            loc3 = (loc2 & 65280) >> 8;
            loc5 = decoder.Rox70Decoder.calculateCheckSum(loc1, 33, loc4, loc3) & 255;
            loc7 = (loc7 = (loc7 = "2 ") + (loc3.toString() + " " + loc4.toString() + " ")) + "33 ";
            loc6 = 0;
            while (loc6 < (loc2 - 1)) 
            {
                loc7 = (loc7 = loc7 + loc1[loc6].toString()) + " ";
                ++loc6;
            }
            loc7 = loc7 + loc5.toString();
            currentCommand = "33";
            currentBytesToReceive = 5;
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc7), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        internal function resetTrackDataSending():void
        {
            _sessionStart = true;
            _currentTrackSession = 0;
            _currentTrackToSend = null;
            _sendTrackDataComplete = false;
            _lastDataSend = [];
            return;
        }

        internal function resetTrackDataLoading():void
        {
            _sessionStart = true;
            _currentTrackToLoad = null;
            _loadTrackDataComplete = false;
            return;
        }

        internal function resetLogDataLoading():void
        {
            _sessionStart = true;
            _currenLogToLoad = null;
            _loadLogDataComplete = false;
            _recordValuesLoadComplete = false;
            _lapValuesLoadComplete = false;
            _currentCommandMode = "manualLaps";
            _loggingPauseValuesLoadComplete = false;
            return;
        }

        internal function isTrackDownloadFinish(arg1:Array):Boolean
        {
            if (arg1.length > 0) 
            {
                if (arg1[0] == 157) 
                {
                    return true;
                }
            }
            return false;
        }

        internal function isDownloadFinish(arg1:Array):Boolean
        {
            if (arg1.length == 4) 
            {
                if (arg1[0] == 138 && arg1[1] == 0 && arg1[2] == 0 && arg1[3] == 0) 
                {
                    return true;
                }
            }
            return false;
        }

        internal function onSetNextWaypointTimeout():void
        {
            if (isErrorCode()) 
            {
                service.DeviceCommunicationHandler.getInstance().resetLastReceveidData();
                sendWaypoints(true);
            }
            return;
        }

        internal function onSetNextTrackTimeout():void
        {
            service.DeviceCommunicationHandler.getInstance().resetLastReceveidData();
            sendToDC("resendTracksToUnit");
            return;
        }

        internal function onGetNextTrackTimeout():void
        {
            service.DeviceCommunicationHandler.getInstance().resetLastReceveidData();
            if (!service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
            };
            ++onGetNextTrackTimeoutCounter;
            if (onGetNextTrackTimeoutCounter >= 5) 
            {
                service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
                onGetNextTrackTimeoutCounter = 0;
                resetTrackDataLoading();
                _currentLoadPlanedTrackHeaderIndex = -1;
                dispatchEvent(new flash.events.Event("planedTrackLoadingError"));
                return;
            }
            loadFromDC("reloadUnitPlanedTrackFile");
            return;
        }

        internal function onGetNextTrackHeaderTimeout():void
        {
            if (isErrorCode()) 
            {
                service.DeviceCommunicationHandler.getInstance().resetLastReceveidData();
            }
            if (_numberOfPlanedTracksCommandQueue.length > 0) 
            {
                loadFromDC("loadUnitPlanedTrackFileHeader");
            }
            else 
            {
                _numberOfPlanedTracksCommandQueue = null;
                dispatchEvent(new flash.events.Event("planedtrackFileHeaderChanged"));
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
            }
            return;
        }

        internal function onGetNextLapTimeout():void
        {
            var loc1:*=service.DeviceCommunicationHandler.getInstance().getLastReceivedData();
            if (loc1[0] == 161) 
            {
                service.DeviceCommunicationHandler.getInstance().resetLastReceveidData();
                loadLogLaps(_currentCommandMode == "manualLaps", false);
                return;
            }
            return;
        }

        internal function onGetNextTimeout():void
        {
            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingInfoEvent", 521, "ROX100Decoder: reget last session -  log (" + _currenLogToLoad.startDate.toString() + ")"));
            service.DeviceCommunicationHandler.getInstance().resetLastReceveidData();
            loadFromDC("reloadUnitlogData");
            return;
        }

        public override function destructor():void
        {
            super.destructor();
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            flash.utils.clearTimeout(_getNextLogDataTimeoutId);
            flash.utils.clearTimeout(_getNextTrackTimeoutId);
            flash.utils.clearTimeout(_setNextTrackTimeoutId);
            resetLogDataLoading();
            resetTrackDataLoading();
            resetTrackDataSending();
            _currentLogHeaderIndex = -1;
            _currentLoadPlanedTrackHeaderIndex = -1;
            _currentSendPlanedTrackHeaderIndex = -1;
            _totalRecordValuesToLoad = 0;
            _totalLapValuesToLoad = 0;
            _totalLoggingPauseValuesToLoad = 0;
            _totalTrackValuesToLoad = 0;
            _totalTrackValuesToSend = 0;
            return;
        }

        internal function onLoadedGetLogStatus(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            if (decoder.Rox70Decoder.isValidCheckSum(arg1.data)) 
            {
                decoder.Rox70Decoder.getInstance().unit = _myUnit;
                _myUnit = decoder.Rox70Decoder.getInstance().decodeLogStatus(arg1.data) as core.units.UnitROX70;
            }
            else 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 516, "ROX100Decoder > decodeLogStatus: wrong crc"));
            }
            dispatchEvent(new flash.events.Event("logStatusLoadedFromUnitComplete"));
            return true;
        }

        internal function onLoadedGetNumberOfLogs(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            var loc1:*=null;
            var loc4:*=0;
            var loc2:*=0;
            var loc3:*=null;
        }

        internal function onLoadedGetLogHeader(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            if (decoder.Rox70Decoder.isValidCheckSum(arg1.data)) 
            {
                decoder.Rox70Decoder.getInstance().unit = _myUnit;
                _myUnit.loadedLogs.push(decoder.Rox70Decoder.getInstance().decodeLogHeader(arg1.data));
            }
            else 
            {
                _myUnit.loadedLogs = new __AS3__.vec.Vector.<core.activities.Activity>();
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 532, "ROX70Decoder > decodeTrackFileHeader: wrong crc"));
            }
            if (_numberOfTracksCommandQueue.length > 0) 
            {
                loadFromDC("loadUnitlogDataHeader");
                return false;
            }
            _numberOfTracksCommandQueue = null;
            dispatchEvent(new flash.events.Event("pageHeaderChange"));
            return true;
        }

        internal function onLoadedGetLogCommand(arg1:service.usb.event.DeviceDataCompleteEvent, arg2:Array):Boolean
        {
            flash.utils.clearTimeout(_getNextLogDataTimeoutId);
            if (decoder.Rox70Decoder.isValidCheckSum(arg1.data)) 
            {
                arg2 = arg1.data;
                arg2.splice(0, 9);
                arg2.pop();
                if (!_recordValuesLoadComplete) 
                {
                    _currenLogToLoad.recordValuesLoaded = _currenLogToLoad.recordValuesLoaded.concat(arg2);
                    dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", _currenLogToLoad.recordValuesLoaded.length / 48 / _currenLogToLoad.entryCount * 100, _currentLogHeaderIndex + 1, (_myUnit as core.units.interfaces.IDataToDecode).activitiesToDecode.length, "", false, false));
                    if (_currenLogToLoad.recordValuesLoaded.length / 48 == _currenLogToLoad.entryCount) 
                    {
                        _recordValuesLoadComplete = true;
                        if (_currenLogToLoad.lapValuesLoaded.length / 56 < _currenLogToLoad.lapValuesToLoad) 
                        {
                            loadLogLaps(true, true);
                        }
                        else if (_currenLogToLoad.autoLapValuesLoaded.length / 56 < _currenLogToLoad.autoLapValuesToLoad) 
                        {
                            loadLogLaps(false, true);
                        }
                        else 
                        {
                            onLogLoaded();
                        }
                        return false;
                    }
                }
            }
            else 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 531, "ROX70Decoder > decodeTrackFile: wrong crc"));
            }
            flash.utils.setTimeout(loadFromDC, 0, "loadUnitlogData");
            return true;
        }

        internal function onLoadedGetLogLaps(arg1:service.usb.event.DeviceDataCompleteEvent, arg2:Array):Boolean
        {
            var loc2:*=0;
            flash.utils.clearTimeout(_getNextLogLapsDataTimeoutId);
            var loc1:*=false;
            if (decoder.Rox70Decoder.isValidCheckSum(arg1.data)) 
            {
                loc1 = (loc2 = (loc2 = arg1.data[3] & 255) | (arg1.data[4] & 255) << 8) >> 15 == 1;
                arg2 = arg1.data;
                arg2.splice(0, 9);
                arg2.pop();
            }
            if (_currentCommandMode != "manualLaps") 
            {
                if (_currentCommandMode == "autoLaps") 
                {
                    _currenLogToLoad.autoLapValuesLoaded = _currenLogToLoad.autoLapValuesLoaded.concat(arg2);
                    if (loc1) 
                    {
                        onLogLoaded();
                    }
                    else 
                    {
                        loadLogLaps(false, false);
                    }
                }
            }
            else 
            {
                _currenLogToLoad.lapValuesLoaded = _currenLogToLoad.lapValuesLoaded.concat(arg2);
                if (loc1) 
                {
                    if (_currenLogToLoad.autoLapValuesToLoad > 0) 
                    {
                        loadLogLaps(false, true);
                    }
                    else 
                    {
                        onLogLoaded();
                    }
                }
                else 
                {
                    loadLogLaps(true, false);
                }
            }
            return true;
        }

        internal function onLoadedGetSettings(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            decoder.Rox70Decoder.getInstance().unit = _myUnit;
            _myUnit.currentSettings = decoder.Rox70Decoder.getInstance().decodeSettings(arg1.data);
            dispatchEventLater(new flash.events.Event("settingsLoadedFromUnitComplete"));
            return true;
        }

        internal function onLoadedSetSettings(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            if (!decoder.Rox70Decoder.isValidCheckSum(arg1.data)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 528, "ROX70Decoder > onLoaded (send settings complete): wrong crc"));
            }
            dispatchEventLater(new flash.events.Event("settingsSendComplete"));
            return true;
        }

        internal function onLoadedGetTotals(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            decoder.Rox70Decoder.getInstance().unit = _myUnit;
            (_myUnit as core.units.interfaces.ITotalsList).currentTotals = decoder.Rox70Decoder.getInstance().decodeTotals(arg1.data);
            dispatchEventLater(new flash.events.Event("totalsLoadComplete"));
            return true;
        }

        internal function onLoadedSetTotals(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            if (!decoder.Rox70Decoder.isValidCheckSum(arg1.data)) 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 529, "ROX70Decoder > onLoaded (send totals complete): wrong crc"));
            }
            dispatchEventLater(new flash.events.Event("sendTotalValuesComplete"));
            return true;
        }

        internal function onLoadedGetNumberOfTracks(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            var loc5:*=0;
            var loc6:*=0;
            var loc3:*=0;
            var loc8:*=0;
            var loc7:*=null;
            var loc2:*=0;
            var loc1:*=0;
            var loc4:*=0;
            var loc9:*=null;
            if (decoder.Rox70Decoder.isValidCheckSum(arg1.data)) 
            {
                _numberOfPlanedTracks = arg1.data[3];
                _numberOfPlanedTracksCommandQueue = [];
                _myUnit.loadedTracks = init.BackendInitializer.getInstance().createVectorList();
                loc2 = 3;
                loc1 = loc2 & 255;
                loc9 = (loc4 = (loc2 & 65280) >> 8) + " " + loc1;
                decoder.Rox70Decoder.getInstance().unit = _myUnit;
                _myUnit.loadedTracks = init.BackendInitializer.getInstance().createVectorList();
                loc5 = 0;
                while (loc5 < _numberOfPlanedTracks) 
                {
                    loc6 = (loc5 & 65280) >> 8;
                    loc3 = loc5 & 255;
                    loc8 = decoder.Rox70Decoder.calculateCheckSum([loc6, loc3], 65, loc1, loc4);
                    loc7 = "2 " + loc9 + " " + "65" + " " + loc3 + " " + loc6 + " " + loc8;
                    _numberOfPlanedTracksCommandQueue.push({"cmd":loc7});
                    ++loc5;
                }
                _totalNumberOfPlanedTracks = _numberOfPlanedTracks;
                _numberOfPlanedTracks = 0;
                if (_numberOfPlanedTracksCommandQueue.length > 0) 
                {
                    loadFromDC("loadUnitPlanedTrackFileHeader");
                    return false;
                }
                _numberOfPlanedTracksCommandQueue = null;
                dispatchEvent(new flash.events.Event("planedtrackFileHeaderChanged"));
            }
            else 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 525, "ROX70Decoder > decodeNumberOfTracks: wrong crc"));
            }
            return true;
        }

        internal function onLoadedGetTrackHeader(arg1:service.usb.event.DeviceDataCompleteEvent):Boolean
        {
            flash.utils.clearTimeout(_getNextTrackHeaderTimeoutId);
            if (decoder.Rox70Decoder.isValidCheckSum(arg1.data)) 
            {
                decodePlanedTrackFileHeaderArray(arg1.data);
                dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", 100, _myUnit.loadedTracks.length, _totalNumberOfPlanedTracks));
            }
            else 
            {
                dispatchEvent(new com.logging.ErrorLoggingEvent("loggingErrorEvent", 526, "ROX70Decoder > decodePlanedTrackFile: wrong crc"));
            }
            if (_numberOfPlanedTracksCommandQueue.length > 0) 
            {
                loadFromDC("loadUnitPlanedTrackFileHeader");
                return false;
            }
            _numberOfPlanedTracksCommandQueue = null;
            dispatchEvent(new flash.events.Event("planedtrackFileHeaderChanged"));
            return true;
        }

        internal function onLoadedGetTrack(arg1:service.usb.event.DeviceDataCompleteEvent, arg2:Array):Boolean
        {
            var loc2:*=0;
            onGetNextTrackTimeoutCounter = 0;
            flash.utils.clearTimeout(_getNextTrackTimeoutId);
            var loc3:*=false;
            if (decoder.Rox70Decoder.isValidCheckSum(arg1.data)) 
            {
                loc3 = (loc2 = (loc2 = arg1.data[3] & 255) | (arg1.data[4] & 255) << 8) >> 15 == 1;
                arg2 = arg1.data;
                arg2.splice(0, 5 + 280);
                arg2.pop();
                _currentTrackToLoad.routePointsLoaded = _currentTrackToLoad.routePointsLoaded.concat(arg2);
            }
            var loc4:*=_currentTrackToLoad.routePointsToLoad;
            var loc5:*=_currentTrackToLoad.routePointsLoaded.length / 12;
            var loc1:*=0;
            if (_myUnit is core.units.interfaces.IDataToDecode) 
            {
                loc1 = (_myUnit as core.units.interfaces.IDataToDecode).tracksToDecode.length;
            }
            else 
            {
                loc1 = (_myUnit as core.units.interfaces.ITrackList).loadedTracks.length;
            }
            dispatchEvent(new handler.event.ProgressStatusEvent("progressbarEvent", loc5 / loc4 * 100, _currentLoadPlanedTrackHeaderIndex + 1, loc1, "", false, false));
            if (loc3) 
            {
                decoder.Rox70Decoder.getInstance().decodeTrack(_currentTrackToLoad);
                _currentTrackSession = 0;
                if (_currentTrackToLoad.routePoisToLoad > 0) 
                {
                    loadWaypoints();
                }
                else 
                {
                    resetTrackDataLoading();
                    loadFromDC("loadUnitPlanedTrackFile");
                }
                return false;
            }
            ++_currentTrackSession;
            loadTrackData();
            return false;
        }

        internal function onLoadedGetWaypoints(arg1:service.usb.event.DeviceDataCompleteEvent, arg2:Array):Boolean
        {
            var loc2:*=0;
            var loc1:*=false;
            if (decoder.Rox70Decoder.isValidCheckSum(arg1.data)) 
            {
                loc1 = (loc2 = (loc2 = arg1.data[3] & 255) | (arg1.data[4] & 255) << 8) >> 15 == 1;
                arg2 = arg1.data;
                arg2.splice(0, 9);
                arg2.pop();
                _currentTrackToLoad.waypointsLoaded = _currentTrackToLoad.waypointsLoaded.concat(arg2);
                _currentTrackToLoad.routePoisToLoad = _currentTrackToLoad.routePoisToLoad - 30;
            }
            else 
            {
                loadWaypoints(true);
                return false;
            }
            if (loc1) 
            {
                decoder.Rox70Decoder.getInstance().decodeWaypoints(_currentTrackToLoad);
                _currentTrackToLoad.routePointsLoaded = [];
                resetTrackDataLoading();
                loadTrackData();
                return false;
            }
            ++_currentTrackSession;
            loadWaypoints();
            return false;
        }

        public static const SET_PROFILE_BYTES_TO_RECEIVE:uint=5;

        public static const SET_PROFILE_COMMAND:String="42";

        public static const SET_SETTINGS_BYTES_TO_RECEIVE:uint=5;

        public static const SET_SETTINGS_COMMAND:String="33";

        public static const SET_STRAVA_SEGMENT_BYTES_TO_RECEIVE:uint=5;

        public static const SET_STRAVA_SEGMENT_COMMAND:String="72";

        public static const SET_TOTALS_COMMAND:String="35";

        public static const SET_TOTALS_COMMAND_BYTES_TO_RECEIVE:uint=5;

        public static const SET_TRACK_BYTES_TO_RECEIVE:uint=7;

        public static const SET_TRACK_COMMAND:String="67";

        public static const SET_WAYPOINT_BYTES_TO_RECEIVE:uint=5;

        public static const SET_WAYPOINT_COMMAND:String="82";

        public static const STRAVA_SEGMENT_HEADER_SIZE:int=100;

        public static const STRAVA_SEGMENT_POINTS_PER_SESSION:int=110;

        public static const STRAVA_SEGMENT_POINTS_SIZE:int=20;

        public static const TRACK_HEADER_SIZE:int=280;

        public static const TRACK_POINTS_PER_SESSION:int=168;

        public static const TRACK_POINTS_SIZE:int=12;

        public static const WAY_POINTS_PER_SESSION:int=30;

        public static const WAY_POINTS_PER_TRACK:int=1000;

        public static const REGET_TRACK_COMMAND:String="159";

        public static const DELETE_LOGS_BYTES_TO_RECEIVE:int=4;

        public static const DELETE_LOGS_COMMAND:String="2 0 1 52 53";

        public static const DELETE_STRAVA_SEGMENTS_BYTES_TO_RECEIVE:int=5;

        public static const DELETE_STRAVA_SEGMENTS_COMMAND:String="2 0 3 73 255 255 74";

        public static const DELETE_TRACK_BYTES_TO_RECEIVE:int=5;

        public static const DELETE_TRACK_COMMAND:String="68";

        public static const GET_LOG_COMMAND:String="50";

        public static const GET_LOG_HEADER_COMMAND:String="49";

        public static const GET_LOG_LAPS_AUTO:String="autoLaps";

        public static const GET_LOG_LAPS_COMMAND:String="53";

        public static const GET_LOG_LAPS_MANUAL:String="manualLaps";

        public static const GET_LOG_STATUS_BYTES_TO_RECEIVE:uint=28;

        public static const GET_LOG_STATUS_COMMAND:String="2 0 1 36 37";

        public static const GET_NEXT_LOG_COMMAND:String="2 0 8 50 2";

        public static const GET_NUMBER_OF_LOGS_BYTES_TO_RECEIVE:uint=6;

        public static const GET_NUMBER_OF_LOGS_COMMAND:String="2 0 1 48 49";

        public static const GET_NUMBER_OF_TRACKS_BYTES_TO_RECEIVE:uint=6;

        public static const GET_NUMBER_OF_TRACKS_COMMAND:String="2 0 1 64 65";

        public static const GET_PROFILE_1_COMMAND:String="2 0 2 41 1 42";

        public static const GET_PROFILE_2_COMMAND:String="2 0 2 41 2 41";

        public static const GET_PROFILE_3_COMMAND:String="2 0 2 41 3 40";

        public static const GET_PROFILE_BYTES_TO_RECEIVE:uint=88;

        public static const GET_SETTINGS_BYTES_TO_RECEIVE:uint=56;

        public static const GET_SETTINGS_COMMAND:String="2 0 1 32 33";

        public static const GET_TOTALS_COMMAND:String="2 0 1 34 35";

        public static const GET_TOTALS_COMMAND_BYTES_TO_RECEIVE:uint=28;

        public static const GET_TRACK_COMMAND:String="66";

        public static const GET_TRACK_HEADER_COMMAND:String="65";

        public static const GET_WAYPOINTS_COMMAND:String="81";

        public static const LOG_HEADER_SIZE:int=208;

        public static const MAX_LAPS_PER_SESSION:int=17;

        public static const MAX_PLANED_TRACKS_ALLOWED:int=50;

        public static const MAX_PLANED_TRACK_POINTS_ALLOWED:int=42000;

        public static const MAX_POIS_PER_SESSION:int=30;

        public static const MAX_TRACK_HEADER_PER_SESSION:int=65535;

        public static const PAUSE_VALUES_PER_SESSION:int=42;

        public static const RECORD_VALUES_PER_SESSION_EVEN:int=42;

        public static const RECORD_VALUES_PER_SESSION_ODD:int=43;

        public static const REGET_LOG_COMMAND:String="2 0 8 50 3";

        public static const RESET_TRACK_COMMAND:String="168";

        public static const SET_NEXT_TRACK_COMMAND:String="168";

        public var DISPATCH_EVENT_TIMEOUT:int=1000;

        internal var _actualSportProfileToLoad:uint=0;

        internal var _currenLogToLoad:core.activities.Activity;

        internal var _currentCommandMode:String;

        internal var _currentLoadPlanedTrackHeaderIndex:int=-1;

        internal var _currentLogHeaderIndex:int=-1;

        internal var _currentPlanedTrackDataToSend:Array;

        internal var _currentSegmentSession:int=0;

        internal var _currentSendPlanedTrackHeaderIndex:int=-1;

        internal var _currentTrackSession:int=0;

        internal var _currentTrackSessionWP:int=0;

        internal var _currentTrackToLoad:core.route.Route;

        internal var _currentTrackToSend:core.route.Route;

        internal var _getNextLogDataTimeoutId:int=0;

        internal var _getNextLogDataTimeoutInterval:int=2000;

        internal var _getNextLogLapsDataTimeoutInterval:int=2000;

        internal var _getNextTrackHeaderTimeoutId:int=0;

        internal var _getNextTrackHeaderTimeoutInterval:int=5000;

        internal var _getNextTrackTimeoutId:int=0;

        internal var _getNextTrackTimeoutInterval:int=1000;

        internal var _totalLoggingPauseValuesToLoad:int=0;

        internal var _totalLapValuesToLoad:int=0;

        internal var _stravaSegmentToSend:core.strava.StravaSegment;

        internal var _setNextTrackTimeoutInterval:int=4000;

        internal var _setNextTrackTimeoutId:int=0;

        internal var _getNextLogLapsDataTimeoutId:int=0;

        internal var _sessionStart:Boolean=true;

        internal var _sendTrackDataComplete:Boolean=false;

        internal var _resendFirstPackage:Boolean=false;

        internal var _recordValuesLoadComplete:Boolean=false;

        internal var _numberOfTracksCommandQueue:Array;

        internal var _numberOfTracks:int=0;

        internal var _numberOfPlanedTracksCommandQueue:Array;

        internal var _numberOfPlanedTracks:int=0;

        internal var _myUnit:core.units.UnitROX70;

        internal var _loggingPauseValuesLoadComplete:Boolean=false;

        internal var _loadTrackDataComplete:Boolean=false;

        internal var _loadLogDataComplete:Boolean=false;

        internal var _lastWPDataToSend:Array;

        internal var _lastDataSend:Array;

        internal var _lapValuesLoadComplete:Boolean=false;

        internal var onGetNextTrackTimeoutCounter:uint=0;

        internal var evenPackage:Boolean=false;

        internal var currentFW:uint=0;

        internal var _totalTrackValuesToSend:int=0;

        internal var _totalTrackValuesToLoad:int=0;

        internal var _totalRecordValuesToLoad:int=0;

        internal var _totalNumberOfPlanedTracks:int=0;
    }
}


