//class Rox100Handler
package handler 
{
    import __AS3__.vec.*;
    import com.logging.*;
    import core.activities.*;
    import core.route.*;
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
    
    public class Rox100Handler extends handler.UnitHandler
    {
        public function Rox100Handler()
        {
            _lastDataSend = [];
            _lastWPDataToSend = [];
            super();
            service.DeviceCommunicationHandler.getInstance().addEventListener("loggingErrorEvent", onToManyDataReceived);
            return;
        }

        internal function onGetNextTimeout():void
        {
            dispatchEvent(new com.logging.ErrorLoggingEvent("loggingInfoEvent", 521, "ROX100Decoder: reget last session -  log (" + _currenLogToLoad.startDate.toString() + ")"));
            service.DeviceCommunicationHandler.getInstance().resetLastReceveidData();
            loadFromDC("reloadUnitlogData");
            return;
        }

        public override function get unit():core.units.Unit
        {
            return _myUnit;
        }

        public override function set unit(arg1:core.units.Unit):void
        {
            _myUnit = arg1 as core.units.UnitROX100;
            currentFW = parseInt(_myUnit.softwareRevision.split("-")[3]);
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

        internal function onSetNextTrackTimeout():void
        {
            service.DeviceCommunicationHandler.getInstance().resetLastReceveidData();
            sendToDC("resendTracksToUnit");
            return;
        }

        internal function onSetNextWaypointTimeout():void
        {
            service.DeviceCommunicationHandler.getInstance().resetLastReceveidData();
            sendWaypoints(true);
            return;
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

        internal function resetLogDataLoading():void
        {
            _sessionStart = true;
            _currenLogToLoad = null;
            _loadLogDataComplete = false;
            _recordValuesLoadComplete = false;
            _lapValuesLoadComplete = false;
            _loggingPauseValuesLoadComplete = false;
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

        internal function resetTrackDataLoading():void
        {
            _sessionStart = true;
            _currentTrackToLoad = null;
            _loadTrackDataComplete = false;
            return;
        }

        internal function get _currentTrackToSend():core.route.Route
        {
            return this._currentTrackToSend;
        }

        internal function set _currentTrackToSend(arg1:core.route.Route):void
        {
            var loc1:*=this._currentTrackToSend;
            if (loc1 !== arg1) 
            {
                this._currentTrackToSend = arg1;
                if (this.hasEventListener("propertyChange")) 
                {
                    this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_currentTrackToSend", loc1, arg1));
                }
            }
            return;
        }

        internal function resetTrackDataSending():void
        {
            _sessionStart = true;
            _currentTrackToSend = null;
            _sendTrackDataComplete = false;
            _lastDataSend = [];
            return;
        }

        public override function sendToDC(arg1:String):void
        {
            var loc2:*=null;
            var loc5:*=0;
            var loc12:*=0;
            var loc4:*=0;
            var loc13:*=0;
            var loc16:*=0;
            var loc7:*=null;
            var loc10:*=0;
            var loc3:*=0;
            var loc19:*=null;
            var loc15:*=0;
            var loc6:*=0;
            var loc20:*=null;
            var loc9:*=null;
            var loc17:*=null;
            var loc11:*=0;
            var loc1:*=0;
            var loc8:*=0;
            var loc14:*=0;
            var loc18:*=null;
            if (service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
                service.DeviceCommunicationHandler.getInstance().addToCommandQueue(arg1, "sendCommand", this);
                return;
            }
            service.DeviceCommunicationHandler.getInstance().addEventListener("usbComplete", onLoaded, false, 0, false);
            if (arg1 != "writeUnitSettings") 
            {
                if (arg1 != "writeTotalValues") 
                {
                    if (arg1 == "sendTracksToUnit" || arg1 == "resendTracksToUnit") 
                    {
                        service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("stopScanDockingStationEvent"));
                        currentCommand = "164";
                        if (_currentTrackToSend == null) 
                        {
                            if (arg1 == "sendTracksToUnit") 
                            {
                                ++_currentSendPlanedTrackHeaderIndex;
                                _resendFirstPackage = true;
                                if (_currentSendPlanedTrackHeaderIndex < (_myUnit as core.units.interfaces.IDataToDecode).tracksToDecode.length) 
                                {
                                    _currentTrackToSend = (_myUnit as core.units.interfaces.IDataToDecode).tracksToDecode[_currentSendPlanedTrackHeaderIndex];
                                    _currentTrackToSend.routePointsReduced = core.route.Route.reducePoints(_currentTrackToSend.routePoints, 2000, 4, 0, 2);
                                    setWaypointPointReference(_currentTrackToSend);
                                    if (_currentTrackToSend.routePointsReduced.length > 2000) 
                                    {
                                        _currentTrackToSend = null;
                                        sendToDC(arg1);
                                        return;
                                    }
                                    _currentTrackToSend.routeHeader = decoder.Rox100Decoder.getInstance().encodeTrackHeader(_currentTrackToSend);
                                    _currentTrackToSend.routePointsToSend = decoder.Rox100Decoder.getInstance().encodeTrack(_currentTrackToSend);
                                    _totalTrackValuesToSend = _currentTrackToSend.routePointsToSend.length;
                                }
                            }
                        }
                        if (_currentTrackToSend != null) 
                        {
                            if (arg1 == "sendTracksToUnit") 
                            {
                            };
                        }
                        sendTrackData(arg1 == "resendTracksToUnit");
                        return;
                    }
                    if (arg1 != "deleteUnitlogData") 
                    {
                        if (arg1 == "deleteTracksOnUnit") 
                        {
                            currentCommand = "165";
                            currentBytesToReceive = 4;
                            loc10 = 0;
                            loc3 = 3 + (unit as core.units.interfaces.IDataToDecode).tracksToDecode.length * 2;
                            loc19 = loc10.toString() + " " + loc3.toString();
                            loc15 = ((unit as core.units.interfaces.IDataToDecode).tracksToDecode.length & 65280) >> 8;
                            loc20 = (loc6 = (unit as core.units.interfaces.IDataToDecode).tracksToDecode.length & 255).toString() + " " + loc15.toString();
                            loc9 = [];
                            (loc17 = []).push(loc15);
                            loc17.push(loc6);
                            loc5 = 0;
                            while (loc5 < (unit as core.units.interfaces.IDataToDecode).tracksToDecode.length) 
                            {
                                loc1 = (loc11 = (unit as core.units.interfaces.IDataToDecode).tracksToDecode[loc5].downloadId) & 255;
                                loc8 = (loc11 & 65280) >> 8;
                                loc9.push(loc1);
                                loc9.push(loc8);
                                loc17.push(loc1);
                                loc17.push(loc8);
                                ++loc5;
                            }
                            loc14 = decoder.Rox100Decoder.calculateCheckSum(loc17, 165, loc3, loc10);
                            loc18 = "2 " + loc19 + " " + "165" + " " + loc20 + " " + loc9.join(" ") + " " + loc14;
                            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc18), this);
                            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
                        }
                    }
                    else 
                    {
                        currentCommand = "2 0 3 121 80 0 42";
                        currentBytesToReceive = 4;
                        service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
                        service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
                    }
                }
                else 
                {
                    decoder.Rox100Decoder.getInstance().unit = _myUnit;
                    decoder.Rox100Decoder.getInstance().settings = _myUnit.currentSettings;
                    decoder.Rox100Decoder.getInstance().totals = _myUnit.currentTotals;
                    loc2 = decoder.Rox100Decoder.getInstance().encodeTotals();
                    loc5 = 0;
                    loc4 = (loc12 = loc2.length + 1) & 255;
                    loc13 = (loc12 & 65280) >> 8;
                    loc16 = decoder.Rox100Decoder.calculateCheckSum(loc2, 162, loc4, loc13);
                    loc7 = (loc7 = (loc7 = "2 ") + (loc13.toString() + " " + loc4.toString() + " ")) + "162 ";
                    loc5 = 0;
                    while (loc5 < (loc12 - 1)) 
                    {
                        loc7 = (loc7 = loc7 + loc2[loc5].toString()) + " ";
                        ++loc5;
                    }
                    loc7 = loc7 + loc16.toString();
                    currentCommand = "162";
                    currentBytesToReceive = 4;
                    service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc7), this);
                    service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
                }
            }
            else 
            {
                decoder.Rox100Decoder.getInstance().unit = _myUnit;
                decoder.Rox100Decoder.getInstance().settings = _myUnit.currentSettings;
                decoder.Rox100Decoder.getInstance().totals = _myUnit.currentTotals;
                if (currentFW >= 1403271) 
                {
                    loc2 = decoder.Rox100Decoder.getInstance().encodeSettings1403271();
                }
                else 
                {
                    loc2 = decoder.Rox100Decoder.getInstance().encodeSettings();
                }
                loc5 = 0;
                loc4 = (loc12 = loc2.length + 1) & 255;
                loc13 = (loc12 & 65280) >> 8;
                loc16 = decoder.Rox100Decoder.calculateCheckSum(loc2, 126, loc4, loc13) & 255;
                loc7 = (loc7 = (loc7 = "2 ") + (loc13.toString() + " " + loc4.toString() + " ")) + "126 ";
                loc5 = 0;
                while (loc5 < (loc12 - 1)) 
                {
                    loc7 = (loc7 = loc7 + loc2[loc5].toString()) + " ";
                    ++loc5;
                }
                loc7 = loc7 + loc16.toString();
                currentCommand = "126";
                currentBytesToReceive = 4;
                service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc7), this);
                service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            }
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

        internal function setWaypointPointReference(arg1:core.route.Route):void
        {
            var loc5:*=null;
            var loc1:*=null;
            var loc4:*=0;
            var loc2:*=0;
            if (arg1.pois.length == 0) 
            {
                return;
            }
            arg1.pois.sort(sortByRoutePointReferenceId);
            var loc3:*=arg1.pois.length;
            loc4 = 0;
            while (loc4 < loc3) 
            {
                loc1 = arg1.pois[loc4] as core.route.RoutePoi;
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
                }
                ++loc4;
            }
            arg1.routePointsReduced.sort(sortByRoutePointId);
            return;
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

        public override function destructor():void
        {
            super.destructor();
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded);
            flash.utils.clearTimeout(_getNextLogDataTimeoutId);
            flash.utils.clearTimeout(_getNextTrackTimeoutId);
            flash.utils.clearTimeout(_setNextTrackTimeoutId);
            flash.utils.clearTimeout(_setNextWaypointTimeoutId);
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

        internal function onLoaded(arg1:service.usb.event.DeviceDataCompleteEvent):void
        {
            var loc4:*=null;
            var loc1:*=0;
            var loc3:*=0;
            var loc9:*=0;
            var loc6:*=false;
            var loc7:*=0;
            var loc8:*=0;
            var loc2:*=0;
            var loc10:*=0;
            var loc5:*=0;
            service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
        }

        internal function decodeTrackFileHeaderArray(arg1:Array):void
        {
            var loc1:*=null;
            var loc6:*=null;
            var loc3:*=arg1.slice(3, (arg1.length - 1));
            var loc2:*=132;
            if (currentFW >= 1403271) 
            {
                loc2 = 148;
            }
            var loc5:*=loc3.length / loc2;
            var loc4:*=0;
            loc4 = 0;
            while (loc4 < loc5) 
            {
                loc1 = loc3.splice(0, loc2);
                if (loc6 = decoder.Rox100Decoder.getInstance().decodeLogHeader(loc1, currentFW)) 
                {
                    loc6.recordValuesToLoad = loc6.entryCount;
                    loc6.lapValuesToLoad = loc6.lapCount;
                    loc6.loggingPauseValuesToLoad = loc6.pauseCount;
                }
                (_myUnit as core.units.UnitROX100).loadedLogs.push(loc6);
                ++loc4;
            }
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
                loc2 = decoder.Rox100Decoder.getInstance().decodeTrackHeader(loc1) as core.route.Route;
                handler.RouteHandlerCommon.getInstance().addFormattedValues(loc2);
                if (loc6 = handler.RouteHandlerCommon.routesDicGUID[loc2.GUID]) 
                {
                    if (loc6.downloadId != loc2.downloadId) 
                    {
                        loc6.downloadId = loc2.downloadId;
                    }
                }
                (_myUnit as core.units.UnitROX100).loadedTracks.addItem(loc2);
                ++loc4;
            }
            return;
        }

        internal function dispatchEventLater(arg1:flash.events.Event):void
        {
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
                                currentCommand = "128";
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
                                        _totalLoggingPauseValuesToLoad = _currenLogToLoad.loggingPauseValuesToLoad;
                                    }
                                }
                                loadLogData(arg1 == "reloadUnitlogData");
                                return;
                            }
                            if (arg1 != "loadCurrentTrackId") 
                            {
                                if (arg1 != "loadUnitPlanedTrackFileHeader") 
                                {
                                    if (arg1 == "loadUnitPlanedTrackFile" || arg1 == "reloadUnitPlanedTrackFile") 
                                    {
                                        currentCommand = "153";
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
                                }
                                else if (_numberOfPlanedTracksCommandQueue == null || _numberOfPlanedTracksCommandQueue.length == 0) 
                                {
                                    currentCommand = "2 0 1 156 157";
                                    currentBytesToReceive = 5;
                                }
                                else 
                                {
                                    loc1 = _numberOfPlanedTracksCommandQueue.shift();
                                    currentCommand = loc1.cmd;
                                    currentBytesToReceive = loc1.count * 280 + 4;
                                }
                            }
                            else 
                            {
                                currentCommand = "2 0 1 169 168";
                                currentBytesToReceive = 6;
                            }
                        }
                        else if (_numberOfTracksCommandQueue == null || _numberOfTracksCommandQueue.length == 0) 
                        {
                            currentCommand = "2 0 1 116 117";
                            currentBytesToReceive = 5;
                        }
                        else 
                        {
                            loc1 = _numberOfTracksCommandQueue.shift();
                            currentCommand = loc1.cmd;
                            if (currentFW >= 1403271) 
                            {
                                currentBytesToReceive = loc1.count * 148 + 4;
                            }
                            else 
                            {
                                currentBytesToReceive = loc1.count * 132 + 4;
                            }
                        }
                    }
                    else 
                    {
                        currentCommand = "2 0 1 136 137";
                        currentBytesToReceive = 124;
                    }
                }
                else 
                {
                    currentCommand = "2 0 1 134 135";
                    if (currentFW >= 1403271) 
                    {
                        currentBytesToReceive = 280;
                    }
                    else 
                    {
                        currentBytesToReceive = 240;
                    }
                }
            }
            else 
            {
                currentCommand = "2 0 1 132 133";
                currentBytesToReceive = 30;
            }
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(currentCommand), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        internal function loadLogData(arg1:Boolean=false):void
        {
            var loc12:*=null;
            var loc7:*=0;
            var loc1:*=0;
            var loc6:*=0;
            var loc3:*=0;
            var loc13:*=null;
            var loc10:*=0;
            var loc4:*=0;
            var loc14:*=null;
            var loc5:*=0;
            var loc2:*=0;
            var loc15:*=null;
            var loc11:*=null;
            var loc9:*=0;
            if (_currenLogToLoad == null) 
            {
                service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
                resetLogDataLoading();
                _currentLogHeaderIndex = -1;
                dispatchEvent(new flash.events.Event("logsLoadedFromUnitComplete"));
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
                return;
            }
            var loc8:*=132;
            if (currentFW >= 1403271) 
            {
                loc8 = 148;
            }
            if (_sessionStart) 
            {
                _sessionStart = false;
                loc6 = 0;
                loc3 = 5;
                loc13 = loc6.toString() + " " + loc3.toString();
                loc10 = 0;
                loc14 = (loc4 = 1).toString() + " " + loc10.toString();
                loc5 = (_currenLogToLoad.startIndex & 65280) >> 8;
                loc2 = _currenLogToLoad.startIndex & 255;
                loc15 = loc2.toString() + " " + loc5.toString();
                loc11 = [loc10, loc4, loc5, loc2];
                loc9 = decoder.Rox100Decoder.calculateCheckSum(loc11, 128, loc3, loc6);
                loc12 = "2 " + loc13 + " " + "128" + " " + loc14 + " " + loc15 + " " + loc9;
                loc7 = Math.min(_totalRecordValuesToLoad, 42);
                currentBytesToReceive = 3 + loc8 + 32 * loc7 + 1;
            }
            else 
            {
                currentCommand = "2 0 1 129 128";
                if (arg1) 
                {
                    loc12 = "2 0 1 130 131";
                    flash.utils.clearTimeout(_getNextLogDataTimeoutId);
                    _getNextLogDataTimeoutId = flash.utils.setTimeout(onGetNextTimeout, _getNextLogDataTimeoutInterval);
                    service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc12), this);
                    service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
                    return;
                }
                loc12 = "2 0 1 129 128";
                if (_recordValuesLoadComplete) 
                {
                    if (_lapValuesLoadComplete) 
                    {
                        if (_loggingPauseValuesLoadComplete) 
                        {
                            if (!_loadLogDataComplete) 
                            {
                                currentBytesToReceive = 4;
                            }
                        }
                        else 
                        {
                            loc1 = _totalLoggingPauseValuesToLoad - _currenLogToLoad.loggingPauseValuesLoaded.length / 48;
                            loc7 = Math.min(loc1, 42);
                            currentBytesToReceive = 3 + loc8 + 48 * loc7 + 1;
                        }
                    }
                    else 
                    {
                        loc1 = _totalLapValuesToLoad - _currenLogToLoad.lapValuesLoaded.length / 68;
                        loc7 = Math.min(loc1, 28);
                        currentBytesToReceive = 3 + loc8 + 68 * loc7 + 1;
                    }
                }
                else 
                {
                    loc1 = _totalRecordValuesToLoad - _currenLogToLoad.recordValuesLoaded.length / 32;
                    loc7 = Math.min(loc1, 42);
                    currentBytesToReceive = 3 + loc8 + 32 * loc7 + 1;
                }
            }
            flash.utils.clearTimeout(_getNextLogDataTimeoutId);
            _getNextLogDataTimeoutId = flash.utils.setTimeout(onGetNextTimeout, _getNextLogDataTimeoutInterval);
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc12), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        protected function loadTrackData(arg1:Boolean=false):void
        {
            var loc10:*=null;
            var loc6:*=0;
            var loc1:*=0;
            if (!service.DeviceCommunicationHandler.getInstance().nativeProcessIsBusy) 
            {
            };
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
            var loc3:*=3;
            var loc2:*=loc5.toString() + " " + loc3.toString();
            var loc11:*=(parseInt(_currentTrackToLoad.downloadId) & 65280) >> 8;
            var loc4:*;
            var loc8:*=(loc4 = parseInt(_currentTrackToLoad.downloadId) & 255).toString() + " " + loc11.toString();
            var loc9:*=[loc11, loc4];
            var loc12:*=arg1 ? "159" : "153";
            var loc7:*=decoder.Rox100Decoder.calculateCheckSum(loc9, loc12, loc3, loc5);
            loc10 = "2 " + loc2 + " " + loc12 + " " + loc8 + " " + loc7;
            loc1 = _totalTrackValuesToLoad - _currentTrackToLoad.routePointsLoaded.length / 12;
            loc6 = Math.min(loc1, 168);
            currentBytesToReceive = 3 + 280 + 12 * loc6 + 1;
            flash.utils.clearTimeout(_getNextTrackTimeoutId);
            _getNextTrackTimeoutId = flash.utils.setTimeout(onGetNextTrackTimeout, _getNextTrackTimeoutInterval);
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc10), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        protected function sendTrackData(arg1:Boolean=false):void
        {
            var loc10:*=null;
            var loc6:*=0;
            var loc1:*=0;
            var loc12:*=null;
            var loc8:*=0;
            var loc5:*=0;
            var loc4:*=0;
            var loc3:*=null;
            var loc9:*=0;
            var loc11:*=null;
            if (_currentTrackToSend == null) 
            {
                service.DeviceCommunicationHandler.getInstance().removeEventListener("usbComplete", onLoaded, false);
                resetTrackDataSending();
                _currentSendPlanedTrackHeaderIndex = -1;
                dispatchEvent(new flash.events.Event("sendTrackToUnitComplete"));
                service.DeviceCommunicationHandler.getInstance().processNextCommandFromQueue();
                service.DeviceCommunicationHandler.getInstance().dispatchEvent(new flash.events.Event("startScanDockingStationEvent"));
                return;
            }
            if (_sessionStart) 
            {
                loc12 = "164";
                _sessionStart = false;
            }
            else 
            {
                loc12 = arg1 ? "168" : "168";
            }
            currentBytesToReceive = 4;
            loc1 = _currentTrackToSend.routePointsToSend.length;
            if (arg1) 
            {
                loc6 = (loc11 = _lastDataSend).length;
                if (_resendFirstPackage) 
                {
                    loc12 = "164";
                }
                loc5 = ((loc8 = 1 + 280 + loc6) & 65280) >> 8;
                loc4 = loc8 & 255;
                loc3 = loc5.toString() + " " + loc4.toString();
            }
            else 
            {
                if (_currentTrackToSend.routePointsToSend.length > 0) 
                {
                    loc6 = Math.min(_currentTrackToSend.routePointsToSend.length, 168 * 12);
                    loc11 = _currentTrackToSend.routePointsToSend.splice(0, loc6);
                    loc5 = ((loc8 = 1 + 280 + loc6) & 65280) >> 8;
                    loc4 = loc8 & 255;
                    loc3 = loc5.toString() + " " + loc4.toString();
                }
                else 
                {
                    flash.utils.clearTimeout(_setNextTrackTimeoutId);
                    resetTrackDataSending();
                    flash.utils.setTimeout(sendToDC, 500, "sendTracksToUnit");
                    return;
                }
                _lastDataSend = loc11;
            }
            var loc2:*=_currentTrackToSend.routeHeader;
            var loc7:*=loc2.concat(loc11);
            loc9 = decoder.Rox100Decoder.calculateCheckSum(loc7, loc12, loc4, loc5);
            loc10 = "2 " + loc3 + " " + loc12 + " " + loc2.join(" ") + " " + loc11.join(" ") + " " + loc9;
            flash.utils.clearTimeout(_setNextTrackTimeoutId);
            _setNextTrackTimeoutId = flash.utils.setTimeout(onSetNextTrackTimeout, _setNextTrackTimeoutInterval);
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc10), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        internal function sendWaypoints(arg1:Boolean=false):void
        {
            var loc6:*=0;
            var loc5:*=0;
            var loc3:*=0;
            var loc2:*=null;
            var loc8:*=0;
            var loc12:*=null;
            var loc11:*=null;
            var loc10:*=null;
            var loc9:*=118;
            var loc7:*=_currentTrackToSend.pois.length;
            if (arg1 && _lastWPDataToSend.length > 0) 
            {
                loc7 = _lastWPDataToSend.length / 16;
            }
            loc5 = ((loc6 = 1 + loc7 * 16) & 65280) >> 8;
            loc3 = loc6 & 255;
            var loc4:*=[];
            var loc1:*=0;
            if (arg1) 
            {
                loc4 = _lastWPDataToSend;
            }
            else 
            {
                while (_currentTrackToSend.pois.length > 0 && loc1 < 10) 
                {
                    ++loc1;
                    (loc11 = _currentTrackToSend.pois.shift()).wayTTPId_curId = _currentTrackToSend.wayTTP_curId;
                    loc10 = decoder.Rox100Decoder.getInstance().encodeWayPoint(loc11);
                    loc4 = loc4.concat(loc10);
                }
                _lastWPDataToSend = loc4;
            }
            loc8 = decoder.Rox100Decoder.calculateCheckSum(loc4, loc9, loc3, loc5);
            loc12 = "2 " + loc5.toString() + " " + loc3.toString() + " " + loc9.toString() + " " + loc4.join(" ") + " " + loc8;
            currentCommand = "164";
            currentBytesToReceive = 4;
            if (arg1) 
            {
            };
            flash.utils.clearTimeout(_setNextWaypointTimeoutId);
            _setNextWaypointTimeoutId = flash.utils.setTimeout(onSetNextWaypointTimeout, _setNextWaypointTimeoutInterval);
            service.DeviceCommunicationHandler.getInstance().sendToDevice(generateNativeProzessBuffer(loc12), this);
            service.DeviceCommunicationHandler.getInstance().onStopWaitForData();
            return;
        }

        internal function onToManyDataReceived(arg1:com.logging.ErrorLoggingEvent):void
        {
            return;
        }

        public static const GET_SETTINGS_BYTES_TO_RECEIVE_1403271:uint=280;

        public static const GET_SETTINGS_COMMAND:String="2 0 1 134 135";

        public static const GET_TOTALS_COMMAND_BYTES_TO_RECEIVE:uint=124;

        public static const GET_TRACK_COMMAND:String="153";

        public static const GET_TRACK_HEADER_COMMAND:String="2 0 1 148 149";

        public static const GET_TRACK_ID_BYTES_TO_RECEIVE:uint=6;

        public static const GET_TRACK_ID_COMMAND:String="2 0 1 169 168";

        public static const LAP_VALUES_PER_SESSION:int=28;

        public static const LAP_VALUES_SIZE:int=68;

        public static const LOG_HEADER_SIZE:int=132;

        public static const LOG_HEADER_SIZE_1403271:int=148;

        public static const GET_TOTALS_COMMAND:String="2 0 1 136 137";

        public static const MAX_LOG_HEADER_PER_SESSION:int=16;

        public static const MAX_PLANED_TRACKS_ALLOWED:int=50;

        public static const MAX_PLANED_TRACK_POINTS_ALLOWED:int=42000;

        public static const MAX_TRACK_HEADER_PER_SESSION:int=5;

        public static const PAUSE_VALUES_PER_SESSION:int=42;

        public static const PAUSE_VALUES_SIZE:int=48;

        public static const RECORD_VALUES_PER_SESSION:int=42;

        public static const RECORD_VALUES_SIZE:int=32;

        public static const REGET_LOG_COMMAND:String="2 0 1 130 131";

        public static const REGET_TRACK_COMMAND:String="159";

        public static const RESET_TRACK_COMMAND:String="168";

        public static const SET_NEXT_TRACK_COMMAND:String="168";

        public static const SET_SETTINGS_BYTES_TO_RECEIVE:uint=4;

        public static const SET_SETTINGS_COMMAND:String="126";

        public static const SET_TOTALS_COMMAND_BYTES_TO_RECEIVE:uint=4;

        public static const SET_TRACK_BYTES_TO_RECEIVE:uint=4;

        public static const SET_TRACK_COMMAND:String="164";

        internal const _setNextTrackTimeoutTime:uint=500;

        public static const SET_WAYPOINT_BYTES_TO_RECEIVE:uint=4;

        public static const SET_WAYPOINT_COMMAND:String="118";

        public static const TRACK_HEADER_SIZE:int=280;

        public static const TRACK_POINTS_PER_SESSION:int=168;

        public static const TRACK_POINTS_SIZE:int=12;

        public static const GET_LOG_STATUS_COMMAND:String="2 0 1 132 133";

        public static const WAY_POINTS_PER_SESSION:int=50;

        public static const WAY_POINTS_PER_TRACK:int=10;

        public static const WAY_POINT_SIZE:int=16;

        public static const DELETE_LOGS_BYTES_TO_RECEIVE:int=4;

        public static const DELETE_LOGS_COMMAND:String="2 0 3 121 80 0 42";

        public static const DELETE_TRACK_BYTES_TO_RECEIVE:int=4;

        public static const DELETE_TRACK_COMMAND:String="165";

        public static const GET_LOG_COMMAND:String="128";

        public static const GET_LOG_HEADER_COMMAND:String="2 0 1 120 121";

        public static const GET_LOG_STATUS_BYTES_TO_RECEIVE:uint=30;

        public static const SET_TOTALS_COMMAND:String="162";

        public static const GET_NEXT_LOG_COMMAND:String="2 0 1 129 128";

        public static const GET_NEXT_LOG_HEADER_COMMAND:String="2 0 1 127 126";

        public static const GET_NEXT_TRACK_HEADER_COMMAND:String="2 0 1 158 159";

        public static const GET_NUMBER_OF_LOGS_BYTES_TO_RECEIVE:uint=5;

        public static const GET_NUMBER_OF_LOGS_COMMAND:String="2 0 1 116 117";

        public static const GET_NUMBER_OF_TRACKS_BYTES_TO_RECEIVE:uint=5;

        public static const GET_NUMBER_OF_TRACKS_COMMAND:String="2 0 1 156 157";

        public static const GET_SETTINGS_BYTES_TO_RECEIVE:uint=240;

        public var DISPATCH_EVENT_TIMEOUT:int=1000;

        internal var _currenLogToLoad:core.activities.Activity;

        internal var _currentLoadPlanedTrackHeaderIndex:int=-1;

        internal var _currentLogHeaderIndex:int=-1;

        internal var _currentPlanedTrackDataToSend:Array;

        internal var _currentSendPlanedTrackHeaderIndex:int=-1;

        internal var _currentTrackToLoad:core.route.Route;

        internal var _currentTrackToSend:core.route.Route;

        internal var _getNextLogDataTimeoutId:int=0;

        internal var _getNextLogDataTimeoutInterval:int=2000;

        internal var _getNextTrackTimeoutId:int=0;

        internal var _lapValuesLoadComplete:Boolean=false;

        internal var _lastDataSend:Array;

        internal var _lastWPDataToSend:Array;

        internal var _loadLogDataComplete:Boolean=false;

        internal var _loadTrackDataComplete:Boolean=false;

        internal var _loggingPauseValuesLoadComplete:Boolean=false;

        internal var _myUnit:core.units.UnitROX100;

        internal var _numberOfPlanedTracks:int=0;

        internal var _numberOfPlanedTracksCommandQueue:Array;

        internal var _numberOfTracks:int=0;

        internal var _numberOfTracksCommandQueue:Array;

        internal var _recordValuesLoadComplete:Boolean=false;

        internal var _resendFirstPackage:Boolean=false;

        internal var _sendTrackDataComplete:Boolean=false;

        internal var _sessionStart:Boolean=true;

        internal var _setNextTrackTimeoutId:int=0;

        internal var _setNextTrackTimeoutInterval:int=4000;

        internal var _setNextWaypointTimeoutId:int=0;

        internal var _setNextWaypointTimeoutInterval:int=1000;

        internal var _totalLapValuesToLoad:int=0;

        internal var _totalLoggingPauseValuesToLoad:int=0;

        internal var _totalRecordValuesToLoad:int=0;

        internal var _totalTrackValuesToSend:int=0;

        internal var currentFW:uint=0;

        internal var onGetNextTrackTimeoutCounter:uint=0;

        internal var _getNextTrackTimeoutInterval:int=1000;

        internal var _totalTrackValuesToLoad:int=0;
    }
}


